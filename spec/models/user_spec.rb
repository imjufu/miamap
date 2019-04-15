# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  describe '#profile' do
    it 'returns an instance of Profile' do
      expect(subject.profile).to be_a Profile
    end
  end
end
