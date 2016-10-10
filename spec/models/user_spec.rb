require 'rails_helper'

# associations, validations, class methods, error messages

RSpec.describe User, :type => :model do

  # debugger

  it {should have_many(:goals)}
  it {should have_many(:comments)}
  it {should validate_uniqueness_of :username}

  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6) }

  describe "::find_by_credentials" do
    user1 = User.create(username: "Bob", password: "bob123")
    it "valid user" do
      expect(User.find_by_credentials("Bob", "bob123").username).to eq(user1.username)
    end
    it "invalid user" do
      expect(User.find_by_credentials("Bob", "bob456")).to be_nil
    end
  end

  describe '#reset_session_token!' do
    user1 = User.create(username: "Bob", password: "bob123")
    it 'reset the session_token' do
      old_session_token = user1.session_token
      new_session_token = user1.reset_session_token!
      expect(new_session_token).to_not eq(old_session_token)
    end
  end

  describe "#is_password?" do
    user1 = User.create(username: "Bob", password: "bob123")
    it "checks if it is the correct password" do
      expect(user1.is_password?("bob123")).to be true
    end
    it "returns false if the password is incorrect" do
      expect(user1.is_password?("bofdsb3")).to be false
    end
  end

  describe "#password=" do
    user1 = User.create(username: "Bob", password: "bob123")
    it "sets instance variable @password" do
      expect(user1.password).to eq("bob123")
    end
    it "creates password_digest for that password" do
      expect(user1.password_digest).to_not be_nil
    end
  end

  it "set session_token after initilization" do
    user1 = User.create(username: "Bob", password: "bob123")
    expect(user1.session_token).to_not be_nil
  end
end
