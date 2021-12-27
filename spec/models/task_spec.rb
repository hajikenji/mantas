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
        # task[:content] = ''
        expect(task).not_to be_valid
      end
    end
  end
end
