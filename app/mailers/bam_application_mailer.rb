class BamApplicationMailer < ApplicationMailer
  def email_team(form_data)
    @form_data = form_data
    mail to: ENV['admin_email'], from: form_data[:email],
         subject: "New BAM submitted: #{form_data[:name]}"
  end
end
