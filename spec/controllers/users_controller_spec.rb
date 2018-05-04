require 'spec_helper'
#require 'rspec/rails'
#require 'users_controller'

#Must run tests in rails directory and call rspec spec/controllers/* or rspec spec/controllers/users_controller_spec.rb

describe UsersController, '#index' do
	it 'should list all users in the database' do
		@users = User.all
		@users.each do |user|
			puts "hello"
			expect(user).to be_valid
		end
	end
end