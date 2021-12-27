require 'rails_helper'

def to_task
  @user = FactoryBot.create(:user)
  @task = FactoryBot.build(:task)
  @task[:user_id] = @user.id
  @task.save

  visit new_session_path

  fill_in 'session[email]', with: @user.email
  fill_in 'session[password]', with: @user.password
  click_on 'commit'

  click_on 'タスクへ'
end

def create_task
  click_on 'New Task'
  fill_in 'task_name', with: @task.name
  fill_in 'task_content', with: @task.content
  fill_in 'task_time', with: @task.time
  fill_in 'task_priority', with: @task.priority
  fill_in 'task_status', with: @task.status
  click_on 'Create Task'
end

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        to_task
        create_task
        expect(page).to have_content 'dddd'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        to_task
        create_task
        click_on 'タスクへ'
        expect(page).to have_content 'Tasks'
      end
    end

    context 'タスクが作成日時の降順に並ぶ' do
      it '通る' do
        to_task
        num = 3
        num.times do
          create_task
          click_on 'タスクへ'
        end
        # binding.pry
        list = []
        loop_num = 0
        num.times do
          list << all('tbody tr')[loop_num].find('.update_time').text
          loop_num += 1
        end
        expect(page.all('tbody tr')[0].find('.update_time').text).to be >= list[loop_num - 1]
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        to_task
        create_task
        click_on 'タスクへ'
        p @task
        p @task.id
        # all('tbody tr')[1].click_link 'Show'
        click_link 'Show', href: task_path(@task.id)
        expect(page).to have_content @task.name
      end
      it 'わざと間違える' do
        to_task
        all('tbody tr')[0].click_link 'Show'
        expect(page).not_to have_content '間違えerr'
      end
    end
  end
end

# describe 'ユーザー登録' do
#   it 'サインアップできるか' do
#     visit new_user_path
#     fill_in 'user_name', with: @user.name
#     fill_in 'user_email', with: @user.email
#     fill_in 'user_password', with: @user.password
#     fill_in 'user_password_confirmation', with: @user.password_confirmation
#     click_on 'Create User'
#     expect(page).to have_content 'User was successfully created.'
#   end
# end

# RSpec.describe 'タスク', type: :system do
#   before do
#     @user
#   end
# end
