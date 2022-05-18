# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :check_valid_profile

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  def check_valid_profile
    controller_exceptions = %w[profiles static_pages admin sessions registrations]

    if user_signed_in? && current_user.profile.valid? == false && controller_exceptions.include?(controller_name) == false
      flash[:alert] = "You need to complete your profile."
      redirect_to(manage_profile_path)
    end
  end
end
