module VotesHelper
	#Function to determine if the user has upvoted or not
	def has_upvoted_for(user_id, post_id)
		relationship = Vote.find_by(user_id: user_id, post_id: post_id, vote_type: "upvote")
    	return true if relationship
	end

	#Function to determine if the user has downvoted or not
	def has_downvoted_for(user_id, post_id)
		relationship = Vote.find_by(user_id: user_id, post_id: post_id, vote_type: "downvote")
    	return true if relationship
	end

	#Function to receive the vote id for the post between a user and a post
	def voted_relationship_id(user_id, post_id)
		return Vote.find_by(user_id: user_id, post_id: post_id).id
	end
end
