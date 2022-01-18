require 'rails_helper'

def to_task
  @user = FactoryBot.create(:user)
  @task = FactoryBot.build(:task)

  visit new_session_path

  fill_in 'session[email]', with: @user.email
  fill_in 'session[password]', with: @user.password
  click_on 'commit'

  click_on 'タスクへ'
end

def create_task
  Label.create(label_name: "a")
  Label.create(label_name: "b")

  
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
  # binding.pry
  # check 'task[label_ids][]'
  check "task_label_ids_#{Label.first[:id]}"
  click_on '登録する'
end


RSpec.describe 'ラベル機能', type: :system do
  describe 'ラベル関連' do
    before do
    to_task
  end
    context 'ラベルをつけられる' do
      it '登録してshow画面にちゃんと出るか' do
        create_task
        click_on 'タスクへ'
        click_on 'Show'
        expect(page).to have_content 'a'
      end
      it '絞り込み検索' do
        create_task
        click_on 'タスクへ'
        list = []
        select 'b', from: 'labels'
        click_on '保存する'
        list << all('tbody tr').size
        select 'a', from: 'labels'
        click_on '保存する'
        list << all('tbody tr').size
        expect([0,1]).to eq list
      end
    end
  end
end