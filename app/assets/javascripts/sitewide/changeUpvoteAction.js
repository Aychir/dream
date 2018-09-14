function changeUpvoteAction(post_id, vote_id){
	$("#the-upvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id);
}