require 'spec_helper'
require 'rails_helper'
require 'rspec/rails'
require 'relationships_controller'
require 'users_helper'
require 'follow'
require 'user'

#Must run tests in rails directory and call rspec spec/controllers/* or rspec spec/controllers/users_controller_spec.rb

#Could be test of user model instead, relationships controller doesn't count here

describe RelationshipsController do

	let(:user) { create :user }

	it 'unauthenticated user should not follow without being authenticated' do
		@userBefore = FactoryGirl.create(:user)
		post :follow_user, params: {user: @userBefore.id}
		response.should redirect_to(new_user_session_path)
	end

	it 'unauthenticated user should not unfollow without being authenticated' do
		@userBefore = FactoryGirl.create(:user)
		post :unfollow_user, params: {user: @userBefore.id}
		response.should redirect_to(new_user_session_path)
	end

	it 'should not refollow someone that a user already follows' do
		@userRefollow = FactoryGirl.create(:user)
		sign_in @userRefollow
		post :follow_user, params: {user: 1}
		post :follow_user, params: {user: 1}
		response.should have_http_status(302)
	end

	it 'should not unfollow someone that a user has no relationship with' do
		@userUnfollow = FactoryGirl.create(:user)
		sign_in @userUnfollow
		post :unfollow_user, params: {user: 1}
		response.should have_http_status(302)
	end

	before do
		@user = FactoryGirl.create(:user)
		@user2 = FactoryGirl.create(:user)
	end

	it 'should make user follow user2' do
		@user.follow(@user2.id)
		expect(Follow.find_by(follower_id: @user.id, following_id: @user2.id)).to_not eq nil
	end

	it 'should destroy an existing relationship' do
		@user.follow(@user2.id)
		@user.unfollow(@user2.id)
		expect(Follow.find_by(follower_id: @user.id, following_id: @user2.id)).to eq nil
	end

	it 'should not allow current user to follow current user' do
		sign_in @user
		post :follow_user, params: {user: @user.id}
		response.should have_http_status(302)
	end

	it 'should not allow current user to unfollow current user' do
		sign_in @user
		post :unfollow_user, params: {user: @user.id}
		response.should have_http_status(302)
	end

	#NOTE: I am not testing unauthentciated users being redirected because this is Devise generated code?


	it 'should block a user' do
		@user.block(@user2.id)
		expect(Block.find_by(blocker_id: @user.id, blocking_id: @user2.id)).to_not eq nil
	end

	it 'should unblock a user' do
		@user.block(@user2.id)
		@user.unblock(@user2.id)
		expect(Block.find_by(blocker_id: @user.id, blocking_id: @user2.id)).to eq nil
	end

	it 'should not block yourself' do
		@user.follow(@user.id)
		expect(Block.find_by(blocker_id: @user.id, blocking_id: @user2.id)).to eq nil
	end

	it 'should not allow you to unblock yourself' do
		sign_in @user
		post :unblock_user, params: {user: @user.id}
		response.should have_http_status(302)
	end

	it 'should not reblock someone that a user already blocks' do
		@userRefollow = FactoryGirl.create(:user)
		sign_in @userRefollow
		post :block_user, params: {user: 1}
		post :block_user, params: {user: 1}
		response.should have_http_status(302)
	end

	it 'should not unblock someone that a user has no relationship with' do
		@userRefollow = FactoryGirl.create(:user)
		sign_in @userRefollow
		post :unblock_user, params: {user: 1}
		response.should have_http_status(302)
	end

	it 'unauthenticated user should not block without being authenticated' do
		@userBefore = FactoryGirl.create(:user)
		post :block_user, params: {user: @userBefore.id}
		response.should redirect_to(new_user_session_path)
	end

	it 'unauthenticated user should not unblock without being authenticated' do
		@userBefore = FactoryGirl.create(:user)
		post :unblock_user, params: {user: @userBefore.id}
		response.should redirect_to(new_user_session_path)
	end

end