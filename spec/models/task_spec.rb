require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーションテスト' do
    context 'タスク名が空' do
      it '引っかかる' do
        task = FactoryBot.build(:task)
        task[:name] = ""

        expect(task).not_to be_valid
      end
    end
    context 'タスク詳細が空' do
      it '引っかかる' do
        task = FactoryBot.build(:task)
        task[:content] = ''
        expect(task).not_to be_valid
      end
    end
    context 'timeが空' do
      it '引っかかる' do
        task = FactoryBot.build(:task)
        task[:time] = ''
        expect(task).not_to be_valid
      end
    end
    context 'priorityが空' do
      it '引っかかる' do
        task = FactoryBot.build(:task)
        task[:priority] = ''
        expect(task).not_to be_valid
      end
    end
    context 'statusが空' do
      it '引っかかる' do
        task = FactoryBot.build(:task)
        task[:status] = ''
        expect(task).not_to be_valid
      end
    end
    context '全項目が有る' do
      it '通る' do
        task = FactoryBot.build(:task)
        user = FactoryBot.create(:user)
        task[:user_id] = user.id
        task.save
        expect(task).to be_valid
      end
    end
  end
end

RSpec.describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user, status: "0") }
    let!(:second_task) { FactoryBot.create(
                            :task, user: user, name: "s", status: "s" ) 
    }

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        
        # title_seachはscopeで提示したタイトル検索用メソッド,メソッド名は任意で構わない。
        search_name = task[:name].slice(1)
        # Task.all[0].destroy
        # binding.pry
        expect(Task.search_ambiguous(search_name)).to include(task)
        expect(Task.search_ambiguous(search_name)).not_to include(second_task)

        expect(Task.search_ambiguous(search_name).size).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_index("0")).to include(task)
        expect(Task.status_index("0")).not_to include(second_task)

        expect(Task.status_index("0").size).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに内容を記載する
        search_name = task[:name].slice(1)
        fact = Task.search_ambiguous(search_name) && Task.status_index("0")

        expect(fact).to include(task)
        expect(fact).not_to include(second_task)
        expect(fact.size).to eq 1
      end
    end
  end
end
