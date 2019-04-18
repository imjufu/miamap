# frozen_string_literal: true

class Contract < ApplicationRecord
  acts_as_paranoid

  belongs_to :producer
  has_many :subscriptions, dependent: :destroy

  validates :title, :content, presence: true
end
