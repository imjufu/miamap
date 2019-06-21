# frozen_string_literal: true

class MemberRegistrationRequest < ApplicationRecord
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :refused_by, class_name: 'User', optional: true
  belongs_to :member, optional: true

  before_validation :set_identifier

  validates :email, email: true
  validates :identifier, presence: true
  validates :first_name, :last_name, :date_of_birth,
            presence: true, if: proc { |m| (m.step || 0) > 1 }
  validates :address, :city, presence: true, if: proc { |m| (m.step || 0) > 2 }
  validates :postal_code, postal_code: { country: :fr }, if: proc { |m|
    (m.step || 0) > 2
  }
  validate :not_already_a_member

  scope :not_accepted_or_refused_yet, lambda {
    where(accepted_at: nil).where(refused_at: nil)
  }

  accepts_nested_attributes_for :member

  def full_name
    "#{first_name&.capitalize} #{last_name&.upcase}"
  end

  def accept(user:, accepted_at: Time.current)
    return false if already_accepted_or_refused?

    update(
      accepted_at: accepted_at, accepted_by: user,
      member_attributes: as_json(only:
        %i[first_name last_name date_of_birth email address postal_code city])
      .merge(password: SecureRandom.hex)
    )
  end

  def refuse(user:, refused_at: Time.current)
    return false if already_accepted_or_refused?

    update(refused_at: refused_at, refused_by: user)
  end

  def accepted?
    accepted_at.present?
  end

  def refused?
    refused_at.present?
  end

  def accepted_or_refused?
    accepted? || refused?
  end

  private

  def already_accepted_or_refused?
    if accepted?
      errors.add(:base, :already_accepted)
      return true
    end

    if refused?
      errors.add(:base, :already_refused)
      return true
    end

    false
  end

  def set_identifier
    self.identifier ||= SecureRandom.uuid
  end

  def not_already_a_member
    return if Member.find_by(email: email).blank?

    errors.add(:base, :already_a_member)
  end
end
