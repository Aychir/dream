FactoryGirl.define do
  sequence :email do |n|
  	n = User.count + 1;
    "email#{n}@factory.com"
  end

  sequence :username do |n|
  	n = User.count + 1;
  	"user#{n}"
  end

  sequence :id do |n|
    n = User.count + 1;
    "#{n}"
  end

  factory :user do
  	username
    email
    id
    password "111111"
    password_confirmation "111111"
  end
end