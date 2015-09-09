class TransactionsController < ApplicationController
  def new
    @transaction = Transaction.new(recipient_id: params[:project_id])
  end

  def create
    @transaction = Transaction.new(transaction_params.except(:temp_user))
    render :new
  end

  private

  def transaction_params
    params.require(:transaction)
      .permit(:amount, :recipient_id, temp_user: [:email])
      .merge(recipient_type: 'Project')
  end
end
