# frozen_string_literal: true

class Contract < ApplicationRecord
  acts_as_paranoid

  belongs_to :producer
  has_many :subscriptions, dependent: :destroy

  validates :title, :content, presence: true

  def real_content(member = Member.john_doe)
    content = self.content.gsub('{{producer}}', producer.to_s_for_contract)
    content.gsub!('{{member}}', member.to_s_for_contract)

    ActionController::Base.helpers.sanitize content,
                                            scrubber: ContractScrubber.new
  end
end
