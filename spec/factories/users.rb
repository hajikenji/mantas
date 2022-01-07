FactoryBot.define do
  factory :user do
    name                  {'d'}
    email                 { Faker::Internet.email }
    password              {'dddd'}
    password_confirmation {'dddd'}
  end
end