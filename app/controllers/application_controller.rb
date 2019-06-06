# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller? && resource_name == :user
      'admin/layouts/application'
    else
      'application'
    end
  end
end
