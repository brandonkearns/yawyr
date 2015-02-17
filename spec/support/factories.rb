FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Name Number #{n}" }
    name "Brandon Kearns"
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"
  end

  factory

end

#syntax in spec 

#let(:user) { FactoryGirl.create(:user) }