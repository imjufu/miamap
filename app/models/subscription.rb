# frozen_string_literal: true

class Subscription < ApplicationRecord
  acts_as_paranoid

  belongs_to :member
  belongs_to :contract

  validates :member_accepted_at, date: true, allow_nil: true
  validates :producer_accepted_at, date: true, allow_nil: true
  validates :subscribed_at, date: true

  def signed_by_the_member?
    member_accepted_at.present?
  end

  def signed_by_the_producer?
    producer_accepted_at.present?
  end

  def producer_signature_data_uri=(data_uri)
    self.producer_signature = decode_data_uri(data_uri)
  end

  def producer_signature_data_uri
    encode_data(producer_signature)
  end

  def member_signature_data_uri=(data_uri)
    self.member_signature = decode_data_uri(data_uri)
  end

  def member_signature_data_uri
    encode_data(member_signature)
  end

  private

  def decode_data_uri(data_uri)
    encoded_image = data_uri.split(',')[1]
    return nil if encoded_image.blank?

    Base64.decode64(encoded_image)
  end

  def encode_data(data)
    "data:image/png;base64,#{Base64.encode64(data)}" if data.present?
  end
end
