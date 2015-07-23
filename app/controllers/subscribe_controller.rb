class SubscribeController < ApplicationController
  def create
    email = params[:email]

    if EmailValidator.valid? email
      mailchimp = Mailchimp::API.new ENV['mailchimp_api_key']
      mailchimp.lists.subscribe ENV['mailchimp_list_id'], 'email' => email

      render json: { message: 'success' }.to_json, status: :ok
    else
      render json: { message: 'The email is not valid.' }.to_json, status: :bad_request
    end
  end
end
