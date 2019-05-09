# frozen_string_literal: true

class MembershipForm < ApplicationRecord
  acts_as_paranoid

  validates :title, :content, presence: true

  def real_content(member = Member.john_doe)
    content = self.content.gsub('{{member}}', member.to_s_for_contract)

    ActionController::Base.helpers.sanitize content,
                                            scrubber: ContractScrubber.new
  end
end
