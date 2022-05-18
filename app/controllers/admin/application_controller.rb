# frozen_string_literal: true

# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Pundit::Authorization
    include Administrate::Punditize
    before_action :authenticate_user!
    before_action :authorize_admin
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_back(fallback_location: root_path)
    end

    def authorize_admin
      authorize :static_page, :admin?
    end

    
    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
