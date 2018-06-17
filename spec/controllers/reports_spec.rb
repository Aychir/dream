require 'spec_helper'
require 'rails_helper'
require 'rspec/rails'
require 'reports_controller'
require 'users_helper'
require 'follow'
require "capybara/rails"
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

	it 'should render report options' do
		sign_in @user
		get :new, params: {format: 1}
		expect(response).to render_template 'reports/new'
	end

	it 'should report with a given message' do
		sign_in @user
		render_template 'reports/_form'
		post :create, params: {report: {user_id: @user.id, report_message: "This user has posted inappropriate content.", reported_id: 1, reported_type: "User"}}
		response.should redirect_to(users_path)
	end

	it 'should not report yourself' do
		sign_in @user
		get :new, params: {format: @user.id}
		response.should have_http_status(302)
	end

	it 'should not re-report a user' do
		sign_in @user
		render_template 'reports/_form'
		post :create, params: {report: {user_id: @user.id, report_message: "This user has posted inappropriate content.", reported_id: 1, reported_type: "User"}}
		get :new, params: {format: 1}
		response.should have_http_status(302)
	end

end