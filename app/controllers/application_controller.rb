# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? && resource_name == :user
      'admin_room/layouts/application'
    elsif devise_controller? && resource_name == :member
      'member_room/layouts/application'
    else
      'application'
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :user
      new_user_session_path
    elsif resource == :member
      new_member_session_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a? User
      admin_room_root_path
    elsif resource.is_a? Member
      member_room_root_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[first_name last_name date_of_birth address postal_code city]
    )
  end
end
