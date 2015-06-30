class BamApplicationsController < ApplicationController
  def create
    respond_to do |format|
      if params_errors.any?
        format.json { render json: { errors: params_errors }, status: :unprocessable_entity }
      else
        BamApplicationMailer.email_team(bam_application_params).deliver
        format.json { render json: bam_application_params }
      end
    end
  end

  private

  def bam_application_params
    params.permit(:first_name, :last_name, :email, :phone, :name, :description,
      :tweet, :impact, :product)
  end

  def params_errors
    errors = []
    bam_application_params.each do |param, value|
      errors << "#{param} must be present." if value.empty?
    end

    errors
  end
end
