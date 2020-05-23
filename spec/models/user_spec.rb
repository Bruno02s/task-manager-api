require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  #Tests the validations of the main model
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('brunolourenco02s@gmail.com').for(:email) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email, created_at and Token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abcdtoken')

      expect(user.info).to eq("#{ user.email } - #{ user.created_at } - Token: #{ Devise.friendly_token }")
    end
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abcdtoken')
      user.generate_authentication_token!

      expect(user.auth_token).to eq("abcdtoken")
    end

    it 'generates another auth token when the current auth token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abcdtoken123', 'abcdtoken123', 'abcdtoken123456')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end

end