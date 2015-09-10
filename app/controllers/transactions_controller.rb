class TransactionsController < ApplicationController
  DOLLAR_TO_POINT = 500

  rescue_from Payment::RecordInvalid, with: :render_payment_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_error

  before_action :clean_amount, only: [:create]
  before_action :set_competition, only: [:create]

  def new
    @transaction = Transaction.new(recipient_id: params[:project_id])
  end

  def create
    accept_payment

    ActiveRecord::Base.transaction do
      set_temp_user
      purchase_points
      allocate_points
    end

    render :create, status: :created
  end

  private

  def clean_amount
    params.tap do |p|
      amount = p[:transaction] && p[:transaction][:amount]
      p[:transaction][:amount] = amount.gsub(/[$,]/, '') if amount.present?
    end
  end

  def set_temp_user
    transaction = params[:transaction]
    temp_user = transaction && transaction[:temp_user]
    email = temp_user && temp_user[:email]

    @temp_user = TempUser.find_or_create_by! email: email
  end

  def set_competition
    @competition = Competition.current_competition
  end

  def purchase_params
    params.require(:transaction).permit(:amount).merge(
      recipient_type: @temp_user.class.name,
      recipient_id: @temp_user.id,
      competition_id: @competition.id
    )
  end

  def transaction_params
    params.require(:transaction).permit(:recipient_id).merge(
      recipient_type: 'Project',
      sender_type: @temp_user.class.name,
      sender_id: @temp_user.id,
     competition_id: @competition.id
    )
  end

  def accept_payment
    nonce = params[:payment_method_nonce]
    amount = params[:transaction] && params[:transaction][:amount]
    payment = Payment.new nonce, amount

    payment.pay!
  end

  def purchase_points
    @purchase = Transaction.new purchase_params
    @purchase.points = ((@purchase.amount || 0) * DOLLAR_TO_POINT).ceil
    @purchase.save!
  end

  def allocate_points
    @transaction = Transaction.new transaction_params
    @transaction.points = @purchase.points
    @transaction.save!
  end

  def render_payment_error(exception)
    flash[:error] = exception.record.errors
    render :new, status: :ok
  end

  def render_error(exception)
    flash[:error] = exception.record.errors.full_messages
    render :new, status: :ok
  end
end
