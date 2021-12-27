require 'rails_helper'

def to_task
  @user = FactoryBot.create(:user)
  @task = FactoryBot.build(:task)
  @task[:user_id] = @user.id
  @task.save

  visit new_session_path
  # fill_in 'user_name', with: @user.name
  # fill_in 'user_email', with: @user.email
  # fill_in 'user_password', with: @user.password
  # fill_in 'user_password_confirmation', with: @user.password_confirmation
  # click_on 'Create User'

  fill_in 'session[email]', with: @user.email
  fill_in 'session[password]', with: @user.password
  click_on 'commit'

  click_on 'タスクへ'
end

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        to_task
        click_on 'New Task'
        fill_in 'task_name', with: @task.name
        fill_in 'task_content', with: @task.content
        fill_in 'task_time', with: @task.time
        fill_in 'task_priority', with: @task.priority
        fill_in 'task_status', with: @task.status
        click_on 'Create Task'
        expect(page).to have_content 'dddd'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        to_task
        click_on 'New Task'
        fill_in 'task_name', with: @task.name
        fill_in 'task_content', with: @task.content
        fill_in 'task_time', with: @task.time
        fill_in 'task_priority', with: @task.priority
        fill_in 'task_status', with: @task.status
        click_on 'Create Task'
        click_on 'タスクへ'
        expect(page).to have_content 'Tasks'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        to_task
        click_on 'New Task'
        fill_in 'task_name', with: @task.name
        fill_in 'task_content', with: @task.content
        fill_in 'task_time', with: @task.time
        fill_in 'task_priority', with: @task.priority
        fill_in 'task_status', with: @task.status
        click_on 'Create Task'
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
        expect(page).not_to have_content "間違えerr"
      end
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @task = FactoryBot.build(:task)
  end
  describe 'ユーザー登録'do
    it '画面に到達できるか' do
      visit new_user_path
      expect(page).to have_content 'New User'
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
end

# RSpec.describe 'タスク', type: :system do
#   before do
#     @user 
#   end
# end