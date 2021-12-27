FactoryBot.define do
  factory :task do
    name                 { 'd' }
    content              { 'd' }
    time                 { 'd' }
    priority             { 'dddd' }
    status               { 'd' }
    # user_id              { '' }
  end
end
