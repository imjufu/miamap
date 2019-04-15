# frozen_string_literal: true

module RemoveBlankPasswordConcern
  extend ActiveSupport::Concern

  def remove_blank_password_for(account_type)
    return if params[account_type][:password].present?

    params[account_type].delete(:password)
  end
end
