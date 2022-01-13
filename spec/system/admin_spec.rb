require 'rails_helper'

def to_task
  @user = FactoryBot.create(:user)
  @task = FactoryBot.build(:task)
  # @task[:user_id] = @user.id
  # @task.save

  visit new_session_path

  fill_in 'session[email]', with: @user.email
  fill_in 'session[password]', with: @user.password
  click_on 'commit'

  click_on 'タスクへ'
end

  def make_task
    @task = FactoryBot.build(:task)
    @task[:user_id] = @user.id
    @task.save
    @make_times += 1
    @make_tasks << @task
    
  end

def create_task
  
  click_on 'New Task'
  fill_in 'task_name', with: @task.name
  fill_in 'task_content', with: @task.content
  fill_in 'task_time', with: @task.time
  # fill_in 'task_priority', with: @task.priority
  a = rand(1..3)
  case a
  when 1
    select '未着手', from: 'task_status'
  when 2
    select '着手中', from: 'task_status'
  when 3
    select '完了', from: 'task_status'
  end
  a = rand(4..6)
  case a
  when 4
    select '高', from: 'task_priority'
  when 5
    select '中', from: 'task_priority'
  when 6
    select '低', from: 'task_priority'
  end

  click_on '登録する'
end

def many_make_tasks(num: 5)
  @make_times = 0 #make_task用変数
  @make_tasks = [] #make_task用変数
  num.times do
    make_task
  end
  visit tasks_path
end

RSpec.describe 'ユーザー関連機能', type: :system do
  describe '新規登録' do
    context '登録できるか、未ログインを弾けるか' do
      it '登録できる' do
        to_task
        expect(page).to have_content 'Tasks'
      end
      it '登録できない' do
        to_task
        expect(page).to_not have_content 'Tasks'
      end
    end
      
  end
end