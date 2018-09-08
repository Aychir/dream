module VotesHelper
	def has_voted_for(user_id, post_id)
		relationship = Vote.find_by(user_id: user_id, post_id: post_id)
    	return true if relationship
	end

	def voted_relationship_id(user_id, post_id)
		return Vote.find_by(user_id: user_id, post_id: post_id).id
	end
end
