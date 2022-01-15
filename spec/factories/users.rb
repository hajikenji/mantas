FactoryBot.define do
  factory :user do
    name                  {'d'}
    email                 { Faker::Internet.email }
    password              {'dddd'}
    password_confirmation {'dddd'}
    admin                 { true }
  end

  factory :more_user, class: User do
    name                  { Faker::JapaneseMedia::StudioGhibli.movie }
    email                 { Faker::Internet.email }
    password              {'dddd'}
    password_confirmation {'dddd'}
    admin                 { false }
  end
end

# FactoryBot.define do
#   factory :more_user do
#     name                  { Faker::JapaneseMedia::StudioGhibli.movie }
#     email                 { Faker::Internet.email }
#     password              {'dddd'}
#     password_confirmation {'dddd'}
#     admin                 { false }
#   end
# end