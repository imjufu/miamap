# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  subject { FactoryBot.build(:membership) }

  describe '#signed_by_the_member?' do
    it 'returns false' do
      expect(subject.signed_by_the_member?).to eq false
    end

    context 'when the member has signed the subscription' do
      before { subject.member_accepted_at = Time.now.in_time_zone }

      it 'returns true' do
        expect(subject.signed_by_the_member?).to eq true
      end
    end
  end
end
