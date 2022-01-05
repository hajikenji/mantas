FactoryBot.define do
  factory :task do
    name                 { 'd' }
    content              { 'd' }
    time                 { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    priority             { 'dddd' }
    # user_id              { '' }
  end
end
