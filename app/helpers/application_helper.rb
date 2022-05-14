# frozen_string_literal: true

require 'sidebar'
# Helpers for the entire application

module ApplicationHelper
  include Sidebar
  def active_class(path)
    if request.path == path
      'active'
    else
      ''
    end
  end

  def active_namespace(path)
    request.path.starts_with?(path) ? 'active' : ''
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end



  def flash_class(level)
    { notice: 'alert alert-info',
      success: 'alert alert-success',
      error: 'alert alert-danger',
      alert: 'alert alert-warning' }[level.to_sym]
  end
end
