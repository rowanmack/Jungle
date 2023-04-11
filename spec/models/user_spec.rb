require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Validations' do

    it 'should save a new user with all values entered' do
      user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")
      expect(user).to be_valid
    end

    it 'should not be valid if passwords do not match' do
      user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "456456")
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not accept an empty password' do
      user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: nil, password_confirmation: "456456")
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not accept an empty confirmation pw' do
      user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: nil)
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not be valid if password is below minimum length' do
      user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123", password_confirmation: "123")
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'should not accept an empty email' do
      user = User.create(name: "Rowan Mackenzie", email: nil, password: "123123", password_confirmation: "123123")
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not accept an empty name' do
      user = User.create(name: nil, email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")
      expect(user).to_not be_valid

      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not validate if the email already exists' do
      @user1 == user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      @user2 = user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      expect(@user2).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    it "should be valid with space before email" do
      @user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      @authenticated_user = User.authenticate_with_credentials('   row.mackenzie@gmail.com   ', "123123")
      expect(@authenticated_user).to_not be_nil
    end

    it "should be valid regardless of case" do
      @user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      @authenticated_user = User.authenticate_with_credentials('rOw.MaCkEnzIe@gmail.Com', "123123")
      expect(@authenticated_user).to_not be_nil
    end

    it 'should return nil if password is incorrect' do
      @user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      @authenticated_user = User.authenticate_with_credentials("row.mackenzie@gmail.com", "456456")
      expect(@authenticated_user).to be_nil
    end

    it "should return nil if email and password do not match" do
      @user = User.create(name: "Rowan Mackenzie", email: "row.mackenzie@gmail.com", password: "123123", password_confirmation: "123123")

      @authenticated_user = User.authenticate_with_credentials('sample@samp.com', "password")
      expect(@authenticated_user).to be_nil
    end
  end
end
