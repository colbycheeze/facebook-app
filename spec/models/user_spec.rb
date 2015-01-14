# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string
#  uid                    :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#

require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end
end

describe User, '#full_name' do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  it "returns first and last name combined" do
    first = @user.first_name
    last = @user.last_name
    expect(@user.full_name).to eq (first + " " + last)
  end
end

describe User, '#send_request' do
  before :each do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end

  it "sets relationship status to pending and sent" do
    @user.send_request(@user2)
    expect(@user.relationships.first.status).to eq "sent"
    expect(@user2.relationships.first.status).to eq "pending"
  end

  it "doesn't create a new request if one already exists" do
    @user.send_request(@user2)
    @user.send_request(@user2)
    expect(@user.relationships.count).to eq 1
  end
end

describe User, '#accept_request' do
   before :each do
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end

  it "sets relationship status to 'accepted'" do
    @user.send_request(@user2)
    @user2.accept_request(@user)
    expect(@user2.relationships.first.status).to eq "accepted"
    expect(@user.relationships.first.status).to eq "accepted"
  end

  it "users now show up on each others friends list" do
    @user.send_request(@user2)
    @user2.accept_request(@user)
    expect(@user2.friends.first).to eq @user
    expect(@user.friends.first).to eq @user2
  end

  it "shouldn't be allowed to accept a user as friend unless a request is pending" do
    @user.send_request(@user2)
    @user.accept_request(@user2)
    expect(@user.friends.count).to be 0
  end
end

# describe User, '#posts' do
#   before :each do
#     @user = FactoryGirl.create(:user)
#     @post = @user.posts.build(body: "This is a post")
#   end

#   it "should be valid" do
#     expect(@post).to be_valid
#   end

#   it "should contain a user_id" do
#     @post.user_id = nil
#     expect(@post).not_to be_valid
#   end

#   it "should not be empty" do
#     @post.body = "  "
#     expect(@post).not_to be_valid
#   end
# end

