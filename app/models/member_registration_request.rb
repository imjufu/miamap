# frozen_string_literal: true

class MemberRegistrationRequest < ApplicationRecord
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :refused_by, class_name: 'User', optional: true

  before_create :set_identifier

  validates :email, email: true
  validates :first_name, :last_name, :date_of_birth,
            presence: true, if: proc { |m| m.step > 1 }
  validates :address, :city, presence: true, if: proc { |m| m.step > 2 }
  validates :postal_code, postal_code: { country: :fr }, if: proc { |m|
    m.step > 2
  }
  validate :not_already_a_member

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end

  def not_already_a_member
    return if Member.find_by(email: email).blank?

    errors.add(:base, :already_a_member)
  end
end
