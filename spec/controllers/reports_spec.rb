require 'spec_helper'
require 'rspec/rails'
require 'reports_controller'
require 'users_helper'
require 'follow'
require 'user'

#Must run tests in rails directory and call rspec spec/controllers/* or rspec spec/controllers/users_controller_spec.rb

#Could be test of user model instead, relationships controller doesn't count here

describe ReportsController do

	let(:user) { create :user }

	before do
		@user = FactoryGirl.create(:user)
		@user2 = FactoryGirl.create(:user)
	end

	let(:report) {@user.reports.create()}

	it 'should make user report user2' do
		@user.follow(@user2.id)
		expect(Follow.find_by(follower_id: @user.id, following_id: @user2.id)).to_not eq nil
	end

	it 'should destroy an existing relationship' do
		@user.follow(@user2.id)
		@user.unfollow(@user2.id)
		expect(Follow.find_by(follower_id: @user.id, following_id: @user2.id)).to eq nil
	end

	it 'should block a user' do
		@user.block(@user2.id)
		expect(Block.find_by(blocker_id: @user.id, blocking_id: @user2.id)).to_not eq nil
	end

	it 'should unblock a user' do
		@user.block(@user2.id)
		@user.unblock(@user2.id)
		expect(Block.find_by(blocker_id: @user.id, blocking_id: @user2.id)).to eq nil
	end

end