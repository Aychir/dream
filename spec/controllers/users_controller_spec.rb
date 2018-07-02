require 'spec_helper'
require 'rails_helper'
require 'rspec/rails'
require 'users_controller'

#Must run tests in rails directory and call rspec spec/controllers/* or rspec spec/controllers/users_controller_spec.rb

describe UsersController do

	let(:user) { create :user }

	before do
		@user = FactoryGirl.create(:user)
	end

	it 'should not allow user to update email if unconfirmed' do
		sign_in @user
		get :change_email, params: {user_id: @user.id}
		response.should redirect_to(edit_user_path(@user))
	end

	it 'should not allow user to update username if unconfirmed' do
		sign_in @user
		get :change_username, params: {user_id: @user.id}
		response.should redirect_to(edit_user_path(@user))
	end

	it 'should not allow user to update password if unconfirmed' do
		sign_in @user
		get :change_password, params: {user_id: @user.id}
		response.should redirect_to(edit_user_path(@user))
	end

	it 'should not allow a user to edit another user' do
		sign_in @user
		get :edit, params: {id: 1}
		response.should redirect_to(users_path)
	end
end