FactoryBot.define do
  factory :task do
    name                 { Faker::JapaneseMedia::StudioGhibli.movie }
    content              { 'd' }
    time                 { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    priority             { rand(4..6) }
    status               { rand(1..3) }
    # user_id              { '' }
  end
end
