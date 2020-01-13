# frozen_string_literal: true

class MemberRoomController < ApplicationController
  before_action :authenticate_member!
  alias current_user current_member

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action}"\
      " #{exception.subject.inspect}"
    raise
  end

  layout 'member_room/layouts/application'
end
