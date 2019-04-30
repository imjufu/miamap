# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  subject { FactoryBot.build(:member) }

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

  describe '#to_s_for_contract' do
    before do
      subject.first_name = 'luke'
      subject.last_name = 'skywalker'
      subject.address = '39 rue des étoiles'
      subject.postal_code = '69007'
      subject.city = 'Lyon'
    end

    it 'returns a string' do
      expect(subject.to_s_for_contract).to be_a String
    end

    it 'equals to the concat of the full name and the address' do
      expect(subject.to_s_for_contract).to eq(
        '<strong>Luke SKYWALKER</strong><address>39 rue des étoiles'\
        '<br>69007 Lyon</address>'
      )
    end
  end

  describe '#john_doe' do
    it 'returns a Member' do
      expect(subject.class.john_doe).to be_a Member
    end
  end
end
