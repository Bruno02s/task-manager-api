require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  
  #Testa as validações do model principal
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('brunolourenco02s@gmail.com').for(:email) }
  it { is_expected.to validate_confirmation_of(:password) }
end