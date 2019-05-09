# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :subscription

  monetize :amount_cents

  validates :means, presence: true
  validates :payed_at, date: true
end
