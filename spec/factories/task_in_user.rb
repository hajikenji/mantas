# FactoryBot.define do
#   factory :user do
#     name                  {'d'}
#     email                 {'d@d.com'}
#     password              {'dddd'}
#     password_confirmation {'dddd'}
#   end
# end

# FactoryBot.define do
#   factory :task do
#     name                 { Faker::JapaneseMedia::StudioGhibli.movie }
#     content              { 'd' }
#     time                 { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
#     priority             { 'dddd' }
#     status               { rand(0..2) }
#     # user_id              { '' }
#   end
# end


# FactoryBot.define do
#   factory :task_in_user do
#     @user = FactoryBot.create(:user)
#     @task = FactoryBot.build(:task)
#     @task[:user_id] = @user.id
#     @task.save
#   end
# end

