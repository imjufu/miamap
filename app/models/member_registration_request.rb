# frozen_string_literal: true

class MemberRegistrationRequest < ApplicationRecord
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :refused_by, class_name: 'User', optional: true

  before_validation :set_identifier

  validates :email, email: true
  validates :identifier, presence: true
  validates :first_name, :last_name, :date_of_birth,
            presence: true, if: proc { |m| m.step > 1 }
  validates :address, :city, presence: true, if: proc { |m| m.step > 2 }
  validates :postal_code, postal_code: { country: :fr }, if: proc { |m|
    m.step > 2
  }
  validate :not_already_a_member

  def full_name
    "#{first_name&.capitalize} #{last_name&.upcase}"
  end

  def accept!(user:, accepted_at: Time.current)
    transaction do
      update(accepted_at: accepted_at, accepted_by: user)

      Member.create!(
        as_json(
          only: %i[
            first_name last_name date_of_birth email address postal_code city
          ]
        ).merge(password: SecureRandom.hex)
      )
    end
  end

  def refuse!(user:, refused_at: Time.current)
    update(refused_at: refused_at, refused_by: user)
  end

  private

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end

  def not_already_a_member
    return if Member.find_by(email: email).blank?

    errors.add(:base, :already_a_member)
  end
end
