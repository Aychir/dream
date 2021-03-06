module UsersHelper
  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end

   def current_user_is_blocking(current_user_id, blocked_user_id)
    block_relationship = Block.find_by(blocker_id: current_user_id, blocking_id: blocked_user_id)
    return true if block_relationship
  end

  def current_user_has_reported(user_id, reported_id)
  	reported_relationship = Report.find_by(user_id: user_id, reported_id: reported_id)
  	return true if reported_relationship
  end
end
