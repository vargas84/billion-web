class BamApplicationMailer < ApplicationMailer
  def email_team(form_data)
    @form_data = form_data
    mail to: ENV['bam_application_email_to'], from: form_data[:email],
         subject: "New BAM submitted: #{form_data[:name]}"
  end
end
