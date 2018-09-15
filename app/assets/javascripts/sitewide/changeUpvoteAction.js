function changeUpvoteAction(post_id, vote_id){
	$("#the-upvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id);
}

function changeDownvoteAction(post_id, vote_id){
	$("#the-downvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id);
}