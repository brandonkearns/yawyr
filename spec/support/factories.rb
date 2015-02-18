FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Name Number #{n}" }
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"

    factory :admin, parent: :user do
      email "brandon.j.kearns@gmail.com"
      admin true
    end
  end

  factory :shelf do
    sequence(:name) { |n| "Shelf Number #{n}"}
    user
  end

  factory :book do
    sequence(:title) { |n| "Book Number #{n}" }
    sequence(:author) { |n| "Author Name #{n}" }
    thumbnail "book.jpg"
    page_count (1..500).to_a.sample
    pages_read (2..450).to_a.sample
    shelf
  end
end

#syntax in spec 

#let(:user) { FactoryGirl.create(:user) }