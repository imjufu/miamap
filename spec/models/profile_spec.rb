# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { Profile.new profile }
  let(:profile) { }

  describe '#admin?' do
    it 'returns false' do
      expect(subject.admin?).to eq false
    end

    context 'when the profile is an admin' do
      let(:profile) { Profile::ADMIN }

      it 'returns true' do
        expect(subject.admin?).to eq true
      end
    end
  end

  describe '#level_0?' do
    it 'returns false' do
      expect(subject.level_0?).to eq false
    end

    context 'when the profile is a level 0' do
      let(:profile) { Profile::LEVEL_0 }

      it 'returns true' do
        expect(subject.level_0?).to eq true
      end
    end
  end
end
