# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject { FactoryBot.build(:subscription) }

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

  describe '#signed_by_the_producer?' do
    it 'returns false' do
      expect(subject.signed_by_the_producer?).to eq false
    end

    context 'when the member has signed the subscription' do
      before { subject.producer_accepted_at = Time.now.in_time_zone }

      it 'returns true' do
        expect(subject.signed_by_the_producer?).to eq true
      end
    end
  end
end
