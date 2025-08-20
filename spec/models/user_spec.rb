# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  # Devise modules
  describe 'Devise modules' do
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
  end

  # Associations
  describe 'associations' do
    it { should have_many(:recipes) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }

    context 'password complexity' do
      it 'requires minimum length' do
        user.password = 'short'
        expect(user).not_to be_valid
      end
    end
  end

  # Encryption
  describe 'phone number encryption' do
    let(:phone) { '+1234567890' }
    let(:user) { create(:user, phone_number: phone) }

    it 'stores encrypted value in database' do
      # Bypass model to get raw database value
      raw_value = User.connection.select_one(
        "SELECT phone_number FROM users WHERE id = #{user.id}"
      )["phone_number"]

      expect(raw_value).not_to eq(phone)
    end

    it 'decrypts when accessed through model' do
      expect(user.phone_number).to eq(phone)
      expect(User.find(user.id).phone_number).to eq(phone)
    end

    it 'does not leak plaintext in logs' do
      allow(Rails.logger).to receive(:info)
      user.update!(phone_number: '+1987654321')
      expect(Rails.logger).not_to have_received(:info).with(/\+1987654321/)
    end
  end

  # Devise authentication
  describe 'authentication' do
    let(:valid_user) { create(:user) }

    it 'authenticates with valid password' do
      expect(valid_user.valid_password?('password123')).to be true
    end

    it 'fails authentication with invalid password' do
      expect(valid_user.valid_password?('wrongpassword')).to be false
    end
  end
end
