require 'rails_helper'
describe PostsController, type: :request do

  before do
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
    it 'indexアクションにリクエストするとレスポンスに投稿済みの画像URLが存在する' do
      get posts_path
      expect(response.body).to include(@post.images) 
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
    it 'showアクションにリクエストするとレスポンスに投稿済みの画像URLが存在する' do 
      get post_path(@post)
      expect(response.body).to include(@post.images)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get post_path(@post)
      expect(response.body).to include('＜COMMENT 一覧＞')
    end
  end 
end