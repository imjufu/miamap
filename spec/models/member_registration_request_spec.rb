# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberRegistrationRequest, type: :model do
  subject { FactoryBot.build(:member_registration_request) }

  describe '#full_name' do
    before do
      subject.first_name = 'luke'
      subject.last_name = 'skywalker'
    end

    it 'returns a string' do
      expect(subject.full_name).to be_a String
    end

    it 'equals to the concat of the first name and the last name' do
      expect(subject.full_name).to eq('Luke SKYWALKER')
    end
  end

  describe '#set_identifier' do
    let(:uuid) { 'c92de2bf-58ec-45d4-ad32-60d2feb4ea12' }

    before { allow(SecureRandom).to receive(:uuid) { uuid } }

    it 'sets an identifier before creating the request' do
      expect { subject.save }.to change(subject, :identifier).from(nil).to(uuid)
    end
  end
end
