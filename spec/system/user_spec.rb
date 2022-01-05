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

  def make_task
    @task = FactoryBot.build(:task)
    @task[:user_id] = @user.id
    @task.save
    @make_times += 1
    @make_tasks << @task
    sleep(0.5)
  end

def create_task
  click_on 'New Task'
  fill_in 'task_name', with: @task.name
  fill_in 'task_content', with: @task.content
  fill_in 'task_time', with: @task.time
  fill_in 'task_priority', with: @task.priority
  
  find('#task_status').find("option[value=#{a}]")
  click_on '登録する'
end

def confirm_task_index(place, target)
  num = 5
  @make_times = 0 #make_task用変数
  @make_tasks = [] #make_task用変数
  num.times do
    make_task
  end
  visit tasks_path
  # binding.pry
  @list = []
  loop_num = 0
  (num + 1).times do #to_taskで初回作成分があるため0でなく1
    @list << all(place)[loop_num].find(target).text
    loop_num += 1
  end
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
        confirm_task_index('tbody tr', '.update_time')
        expect(page.all('tbody tr')[0].find('.update_time').text).to be >= @list[@list.size - 1]
      end
    end

    context '押せば期限順に並ぶ' do
      it '通る' do
        to_task
        confirm_task_index('tbody tr', '.time')
        click_on 'TimeLimit'
        sleep(1)
        expect_list = []
        num = 0
        (@make_times + 1).times do #to_taskで初回作成分があるため0でなく1
          p num
          expect_list << all('tbody tr')[num].find('.time').text
          num += 1
        end
        @make_tasks.sort
        expect_list.sort.reverse
        @list.sort.reverse
        p expect_list

        expect(expect_list.sort.reverse).to eq @list.sort.reverse
      end
      it '通らない(reverseしないので昇順 == 降順になるため)' do
        to_task
        confirm_task_index('tbody tr', '.time')
        click_on 'TimeLimit'
        sleep(1)
        expect_list = []
        num = 0
        (@make_times + 1).times do #to_taskで初回作成分があるため0でなく1
          expect_list << all('tbody tr')[num].find('.time').text
          num += 1
        end
        @make_tasks.sort
        expect_list.sort.reverse
        @list.sort.reverse
        expect(expect_list).to_not eq @list.sort.reverse
      end
    end

  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        to_task
        create_task
        click_on 'タスクへ'
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
