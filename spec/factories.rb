FactoryGirl.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
    # director "default_director"
    rating "R"
    description "default_description"
    release_date { 10.years.ago }
  end
end