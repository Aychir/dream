/*
	Each of these functions change the native action of the form as they are rendered as needed.
*/

function changeUpvoteAction(post_id, vote_id){
	$("#the-upvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id);
}

function changeDownvoteAction(post_id, vote_id){
	$("#the-downvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id);
}

function changeToUpdateUpvote(post_id, vote_id){
	$("#the-upvote-form").attr("action", "/posts/" + post_id + "/votes/" + vote_id + "/update_to_upvote");
}