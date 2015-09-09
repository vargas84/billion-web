class TransactionsController < ApplicationController
  DOLLAR_TO_POINT = 500

  rescue_from ActiveRecord::RecordInvalid, with: :render_error

  before_action :set_temp_user, only: [:create]

  def new
    @transaction = Transaction.new(recipient_id: params[:project_id])
  end

  def create
    @transaction = Transaction.new transaction_params

    @transaction.points = ((@transaction.amount || 0) * DOLLAR_TO_POINT).ceil
    @transaction.sender = @temp_user
    @transaction.competition = Competition.current_competition

    @transaction.save!

    render :create, status: :created
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :recipient_id)
      .merge(recipient_type: 'Project')
  end

  def set_temp_user
    transaction = params[:transaction]
    temp_user = transaction && transaction[:temp_user]
    email = temp_user && temp_user[:email]

    @temp_user = TempUser.find_or_create_by! email: email
  end

  def render_error(exception)
    flash[:error] = exception.record.errors.full_messages
    render :new, status: :ok
  end
end
