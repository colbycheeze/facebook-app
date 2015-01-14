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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]


  has_many :relationships, dependent: :destroy
  has_many :friends, -> { where "status = 'accepted'" }, through: :relationships
  has_many :sent_requests, -> { where "status = 'sent'" }, through: :relationships, foreign_key: "friend_id"
  has_many :pending_requests, -> { where "status = 'pending'" }, through: :relationships, foreign_key: "friend_id"
  has_many :posts

  def full_name
    [first_name, last_name].join(" ")
  end

  def send_request(to_user)
    return if relationships.exists?(friend_id: to_user.id)
    relationships.create!(friend_id: to_user.id, status: 'sent')
    to_user.relationships.create!(friend_id: id, status: 'pending')
  end

  def accept_request(from_user)
    request = relationships.find_by(friend_id: from_user.id)
    return if request.status != 'pending'
    request.update!(status: 'accepted')
    from_user.relationships.find_by(friend_id: id).update!(status: 'accepted')
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
