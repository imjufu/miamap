# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Producer, type: :model do
  subject { FactoryBot.build(:producer) }

  describe '#to_s_for_contract' do
    before do
      subject.name = 'leia'
      subject.address = '39 rue de la galaxie'
      subject.postal_code = '69007'
      subject.city = 'Lyon'
    end

    it 'returns a string' do
      expect(subject.to_s_for_contract).to be_a String
    end

    it 'equals to the concat of the full name and the address' do
      expect(subject.to_s_for_contract).to eq(
        '<strong>leia</strong><address>39 rue de la galaxie<br>'\
        '69007 Lyon</address>'
      )
    end
  end
end
