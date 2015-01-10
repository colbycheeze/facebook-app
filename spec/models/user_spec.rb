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

describe User, '#send_request' do
  it "sets relationship status to pending and sent" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user.send_request(user2)
    expect(user.relationships.first.status).to eq "sent"
    expect(user2.relationships.first.status).to eq "pending"
  end

  it "doesn't create a new request if one already exists" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user.send_request(user2)
    user.send_request(user2)
    expect(user.relationships.count).to eq 1
  end
end

describe User, '#accept_request' do
  it "sets relationship status to 'accepted'" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user.send_request(user2)
    user2.accept_request(user)
    expect(user2.relationships.first.status).to eq "accepted"
    expect(user.relationships.first.status).to eq "accepted"
  end

  it "users now show up on each others friends list" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user.send_request(user2)
    user2.accept_request(user)
    expect(user2.friends.first).to eq user
    expect(user.friends.first).to eq user2
  end


end

