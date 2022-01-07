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
  (num).times do
    @list << all(place)[loop_num].find(target).text
    loop_num += 1
  end
end

def many_make_tasks(num: 5)
  @make_times = 0 #make_task用変数
  @make_tasks = [] #make_task用変数
  num.times do
    make_task
  end
  visit tasks_path
end



RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        to_task
        create_task
        expect(page).to have_content 'd'
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
        click_on '更新日時'
        sleep(1)
        expect(page.all('tbody tr')[0].find('.update_time').text).to eq @list[@list.size - 1]
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
        (@make_times).times do #to_taskで初回作成分があるため0でなく1
          p num
          expect_list << all('tbody tr')[num].find('.time').text
          num += 1
        end
        @make_tasks.sort
        expect_list.sort.reverse
        @list.sort.reverse

        expect(expect_list.sort.reverse).to eq @list.sort.reverse
      end

      it '通らない(reverseしないので昇順 == 降順になるため)' do
        to_task
        confirm_task_index('tbody tr', '.time')
        click_on 'TimeLimit'
        sleep(1)
        expect_list = []
        num = 0
        (@make_times).times do 
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
        # click_link 'Show', href: task_path(@task.id)
        click_on 'Show'
        expect(page).to have_content @task.name
      end
      it 'わざと間違える' do
        to_task
        create_task
        click_on 'タスクへ'
        all('tbody tr')[0].click_link 'Show'
        expect(page).not_to have_content '間違えerr'
      end
    end
  end
end

describe 'タスク管理機能', type: :system do
  describe '検索機能' do
    # before do
    #   # 必要に応じて、テストデータの内容を変更して構わない
    #   FactoryBot.create(:task, title: "task")
    #   FactoryBot.create(:second_task, title: "sample")
    # end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        to_task
        create_task
        click_on 'タスクへ'

        fill_in 'search_name', with: @task.name.slice(1)
        click_on '保存する'
        expect(page).to have_content @task.name
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        to_task
        sleep(0.1)
        many_make_tasks
        click_on 'タスクへ'
        expect_list = []
 
        select '未着手', from: 'status' #何個でてくるかをリストに入れる
        click_on '保存する'
        expect_list << all('tbody tr').size
 
        select '着手中', from: 'status'
        click_on '保存する'
        expect_list << all('tbody tr').size
  
        select '完了', from: 'status'
        click_on '保存する'
        expect_list << all('tbody tr').size

        list = []
        @make_tasks.each do #作成した時のやつで各々のタスクのstatusを集計
          |d| list << d[:status]
        end
        expect(expect_list[0]).to eq list.count("1") #未着手が出てきた数が合えば通る

      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        to_task
        sleep(0.1)
        
        many_make_tasks(num: 120)
                
        click_on 'タスクへ'

        select '未着手', from: 'status' #何行でてくるかをリストに入れる
        fill_in 'search_name', with: @make_tasks[0][:name].slice(1)
        click_on '保存する'

        expect_num = all('tbody tr').size

        list = []
        @make_tasks.each do |d| 
          if d[:name].include?(@make_tasks[0][:name].slice(1)) && d[:status] == "1"
          list << d
          end  
        end
        
        expect(expect_num).to eq list.size #検索で出てきた数が合えば通る
      end
    end
    context '優先順位でソートする' do
      it '高い→低いの順で並ぶ' do
        to_task
        sleep(0.1)
        
        many_make_tasks(num: 15)
        # @many_tasks = @make_tasks.order(priority: 'ASC')

        click_on 'タスクへ'
        click_on 'Priority'
        sleep(0.1)

        expect_fact = all('tbody tr')[0].find('.priority').text
        expect(expect_fact).to eq "高"
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
