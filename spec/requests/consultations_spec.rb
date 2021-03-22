require 'rails_helper'
describe ConsultationsController, type: :request do

  before do
    @consultation = FactoryBot.create(:consultation)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get consultations_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get consultations_path
      expect(response.body).to include(@consultation.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get consultations_path
      expect(response.body).to include('') 
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get consultation_path(@consultation)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get consultation_path(@consultation)
      expect(response.body).to include(@consultation.name) 
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get consultation_path(@consultation)
      expect(response.body).to include('＜COMMENT 一覧＞')
    end
  end 

  describe 'GET #new' do
    it 'ログインしているユーザーがnewアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'ログインしていないユーザーがnewアクションにリクエストするとログインページに遷移する' do 
    end
    it 'newアクションにリクエストするとレスポンスに新規投稿ページが表示される' do
    end
  end 

  describe 'POST #create' do
    it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'createアクションにリクエストするとDBに投稿済みの相談名が保存されてる' do
    end
    it 'createアクションにリクエストするとDBに投稿済みの相談内容が保存されてる' do 
    end
  end 

  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの相談名が表示されている状態で存在する' do
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの相談内容が表示されている状態で存在する' do 
    end
  end 

  describe 'PATCH #update' do
    it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'updateアクションにリクエストするとDBに更新された相談名が保存される' do
    end
    it 'updateアクションにリクエストするとDBに更新された相談内容が保存される' do 
    end
  end 

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'destroyアクションにリクエストするとレスポンスに投稿済みの相談名が存在しない' do
    end
    it 'destroyアクションにリクエストするとレスポンスに投稿済みの相談内容が存在しない' do 
    end
  end 
end