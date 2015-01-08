# == Schema Information
#
# Table name: relationships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  friend_id  :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"
  belongs_to :sent_request, class_name: "User", foreign_key: "friend_id"
  belongs_to :pending_request, class_name: "User", foreign_key: "friend_id"

end
