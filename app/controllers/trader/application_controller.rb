# frozen_string_literal: true

# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Trader
  class ApplicationController < Administrate::ApplicationController
    include Administrate::Punditize
    before_action :authenticate_user!
    before_action :check_valid_profile
    rescue_from ActiveRecord::RecordNotFound, with: :user_not_authorized

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_back(fallback_location: trader_root_path)
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    def check_valid_profile
      controller_exceptions = %w[profiles static_pages admin sessions registrations]
  
      if user_signed_in? && current_user.profile.valid? == false && controller_exceptions.include?(controller_name) == false
        flash[:alert] = "You need to complete your profile."
        redirect_to(manage_profile_path)
      end
    end
  end

end
