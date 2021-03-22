require 'rails_helper'
describe PostsController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get posts_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get posts_path
      expect(response.body).to include(@post.name)
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの画像が存在する' do
      get posts_path
      expect(response.body).to include("item-box-img")
    end
    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get posts_path
      expect(response.body).to include('')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get post_path(@post)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのテキストが存在する' do
      get post_path(@post)
      expect(response.body).to include(@post.name) 
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの画像が存在する' do 
      get post_path(@post)
      expect(response.body).to include("item-box-img")
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get post_path(@post)
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
    it 'createアクションにリクエストするとDBに投稿済みのテキストが保存されてる' do
    end
    it 'createアクションにリクエストするとDBに投稿済みの画像が保存されてる' do 
    end
  end 

  describe 'GET #edit' do
    it 'editアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みのテキストが表示されている状態で存在する' do
    end
    it 'editアクションにリクエストするとレスポンスに投稿済みの画像が表示されている状態で存在する' do 
    end
  end 

  describe 'PATCH #update' do
    it 'updateアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'updateアクションにリクエストするとDBに更新されたテキストが保存される' do
    end
    it 'updateアクションにリクエストするとDBに更新された画像が保存される' do 
    end
  end 

  describe 'DELETE #destroy' do
    it 'destroyアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'destroyアクションにリクエストするとレスポンスに投稿済みのテキストが存在しない' do
    end
    it 'destroyアクションにリクエストするとレスポンスに投稿済みの画像が存在しない' do 
    end
  end 
end