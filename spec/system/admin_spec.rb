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

def many_make_users(num: 5)
  num.times do
    @user = FactoryBot.create(:more_user)
  end
end

RSpec.describe 'ユーザー関連機能', type: :system do
  describe '新規登録' do
    context '登録できログインできるか、未ログインを弾けるか' do
      it '登録できログインできる' do
        to_task
        expect(page).to have_content 'Tasks'
      end

      it '未ログインを弾ける' do
        visit tasks_path
        expect(page).not_to have_content 'Tasks'
      end
    end
      
    context 'セッションテスト' do
      before do
        to_task
      end
      it '自分のマイページに飛べるか' do
        click_on 'プロフィール'
        expect(page).to have_content 'Name:'
      end

      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移' do
        many_make_users
        visit "users/#{@user.id}"
        expect(page).not_to have_content 'Name:'
      end
      it 'ログアウトができること' do
        click_on 'ログアウト'
        expect(page).not_to have_content 'Mantas'
      end
    end

    context '管理画面' do
      before do
        to_task
        @user = FactoryBot.create(:more_user)
        click_on '管理者画面へ'
      end

      it '管理者が管理画面に入れる' do
        expect(page).to have_content 'Users 管理'
      end

      it '一般ユーザーが管理画面に入れない' do
        click_on 'ログアウト'
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on 'commit'
        # binding.pry
        click_on '管理者画面へ'
        expect(page).to have_content 'Tasks'
      end

      it '管理ユーザはユーザの新規登録ができる' do
        click_on 'New User'
        @user = FactoryBot.build(:more_user)
        fill_in 'user[name]', with: @user.name
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        fill_in 'user[password_confirmation]', with: @user.password
        select '不許可', from: 'user_admin'
        click_on '登録する'
        expect(page).to have_content 'successfully created'
      end

      it '管理ユーザはユーザの詳細画面にアクセスできる' do
        click_link 'Show', href: admin_user_path(@user.id)
        expect(page).to have_content "#{@user.name}"
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できる' do
        click_link 'Edit', href: edit_admin_user_path(@user.id)
        fill_in 'user[name]', with: 'tiger_mask'
        click_on '更新する'
        click_link 'Show', href: admin_user_path(@user.id)
        expect(page).to have_content "tiger_mask"
      end

      it '管理ユーザはユーザの削除をできること' do
        click_link 'Destroy', href: admin_user_path(@user.id)
        page.accept_confirm

        expect(page).to have_content "ユーザを削除しました。"
      end
    end

  end
end