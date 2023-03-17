require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here

    it 'should be created with a password and password_confirmation fields' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end

    it 'password and password_confirmation should match' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'wrong_password')
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'password and password_confirmation are required when creating a model' do
      user = User.new(email: 'test@example.com')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'emails must be unique (not case sensitive)' do
      user1 = User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      user2 = User.new(email: 'TEST@example.com', password: 'password', password_confirmation: 'password')
      expect(user2).to_not be_valid
      expect(user2.errors[:email]).to include('has already been taken')
    end

    it 'email should be required' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'password must have a minimum length of 6 characters' do
      user = User.new(email: 'test@example.com', password: 'short', password_confirmation: 'short')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe '.authenticate_with_credentials' do
    # Create a user for authentication tests
    let!(:user) { User.create(email: 'test@example.com', password: 'password', password_confirmation: 'password') }

    it 'should authenticate a user with valid email and password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should not authenticate a user with invalid email' do
      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    it 'should not authenticate a user with invalid password' do
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'should authenticate a user with spaces before and/or after their email address' do
      authenticated_user = User.authenticate_with_credentials('   test@example.com   ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should authenticate a user with the wrong case for their email' do
      authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
