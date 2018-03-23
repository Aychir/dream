class Follow < ApplicationRecord
	belongs_to :follower, foreign_key: 'follower_id', class_name: 'User'
  	belongs_to :following, foreign_key: 'following_id', class_name: 'User'
  	#This is a join table where it references one model to another, in this case the follower and following of the USER model
  	#We specify the user model for the foreign keys that are associated with Follow
end
