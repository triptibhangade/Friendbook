class User < ApplicationRecord
  has_secure_password
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  def all_friends
    self.friends.where("status = 'accept'")+self.inverse_friends.where("status = 'accept'")
  end
  def sent_request
    self.friends.where("status = 'pending'")
  end
  def received_request
    self.inverse_friends.where("status = 'pending'")
  end

end