module VotesHelper
	def has_upvoted_for(user_id, post_id)
		relationship = Vote.find_by(user_id: user_id, post_id: post_id, vote_type: "upvote")
    	return true if relationship
	end

	def has_downvoted_for(user_id, post_id)
		relationship = Vote.find_by(user_id: user_id, post_id: post_id, vote_type: "downvote")
    	return true if relationship
	end

	def voted_relationship_id(user_id, post_id)
		return Vote.find_by(user_id: user_id, post_id: post_id).id
	end
end
