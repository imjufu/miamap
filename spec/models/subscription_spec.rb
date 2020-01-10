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

  describe '#producer_signature_data_uri=' do
    it 'sets the producer signature' do
      expect do
        subject.producer_signature_data_uri = File.read(
          Rails.root.join('spec/fixtures/foret.data_uri')
        )
      end.to change(subject, :producer_signature).from(nil).to(File.open(
        Rails.root.join('spec/fixtures/foret.png'), 'rb'
      ).read)
    end
  end

  describe '#producer_signature_data_uri' do
    before do
      subject.producer_signature = File.open(
        Rails.root.join('spec/fixtures/foret.png'), 'rb'
      ).read
    end

    it 'returns the base64 encoded signature' do
      expect(subject.producer_signature_data_uri).to eq(
        File.read(
          Rails.root.join('spec/fixtures/foret.data_uri')
        )
      )
    end
  end

  describe '#member_signature_data_uri=' do
    it 'sets the member signature' do
      expect do
        subject.member_signature_data_uri = File.read(
          Rails.root.join('spec/fixtures/foret.data_uri')
        )
      end.to change(subject, :member_signature).from(nil).to(File.open(
        Rails.root.join('spec/fixtures/foret.png'), 'rb'
      ).read)
    end
  end

  describe '#member_signature_data_uri' do
    before do
      subject.member_signature = File.open(
        Rails.root.join('spec/fixtures/foret.png'), 'rb'
      ).read
    end

    it 'returns the base64 encoded signature' do
      expect(subject.member_signature_data_uri).to eq(
        File.read(
          Rails.root.join('spec/fixtures/foret.data_uri')
        )
      )
    end
  end
end
