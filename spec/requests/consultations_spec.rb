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
end