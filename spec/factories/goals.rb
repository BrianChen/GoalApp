FactoryGirl.define do
  factory :goal do
    title { Faker::Lorem.word }
    visible false
    user_id 1
  end
end
