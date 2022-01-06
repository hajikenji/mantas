FactoryBot.define do
  factory :task do
    name                 { Faker::JapaneseMedia::StudioGhibli.movie }
    content              { 'd' }
    time                 { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    priority             { 'dddd' }
    status               { rand(0..2) }
    # user_id              { '' }
  end
end
