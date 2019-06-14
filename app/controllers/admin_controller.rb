# frozen_string_literal: true

class AdminController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action}"\
      " #{exception.subject.inspect}"
    raise
  end

  layout 'admin_room/layouts/application'
end
