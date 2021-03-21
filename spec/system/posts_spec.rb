require 'rails_helper'

RSpec.describe '写真テキスト投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_name = Faker::Lorem.sentence
    # @post_images = fixture_file_upload('app/public/test_image.png')
  end
  # context '写真テキスト投稿ができるとき'do
  #   it 'ログインしたユーザーは新規投稿できる' do
  #     # トップページに移動する
  #     visit root_path
  #     # トップページにログインページへ遷移するボタンがあることを確認する
  #     expect(page).to have_content('LOGIN')
  #     # ログインページへ遷移する
  #     visit new_user_session_path
  #     # 正しいユーザー情報を入力する
  #     fill_in 'Eメール', with: @user.email
  #     fill_in 'パスワード', with: @user.password
  #     # ログインボタンを押す
  #     find('input[name="commit"]').click
  #     # トップページへ遷移することを確認する
  #     expect(current_path).to eq(root_path)
  #     # 写真投稿一覧ページに移動する
  #     visit posts_path
  #     # 新規投稿ページへのリンクがあることを確認する
  #     expect(page).to have_content('PUSH 投稿')
  #     # 投稿ページに移動する
  #     visit new_post_path
  #     # フォームに情報を入力する
  #     binding.pry
  #     fill_in 'images', with: @post_images
  #     fill_in 'post[name]', with: @post_name
  #     # 送信するとPostモデルのカウントが1上がることを確認する
  #     expect{
  #       find('input[name="commit"]').click
  #     }.to change { Post.count }.by(1)
  #     # 写真投稿一覧ページに移動する
  #     visit posts_path
  #     # 写真投稿一覧ページには先ほど投稿した内容の写真テキストが存在することを確認する（画像）
  #     expect(page).to have_selector ".item-box-img[style='background-image: url(#{@post_images});']"
  #     # 写真投稿一覧ぺージには先ほど投稿した内容の写真テキストが存在することを確認する（テキスト）
  #     expect(page).to have_content(@post_name)
  #   end
  # end
  context '写真投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # 写真投稿一覧ページに移動する
      visit posts_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('nPUSH 投稿')
    end
  end
end

RSpec.describe '写真テキスト編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  # context '写真テキスト編集ができるとき' do
  #   it 'ログインしたユーザーは自分が投稿した写真テキストの編集ができる' do
  #     # ポスト1を投稿したユーザーでログインする
  #     visit new_user_session_path
  #     fill_in 'Eメール', with: @post1.user.email
  #     fill_in 'パスワード', with: @post1.user.password
  #     find('input[name="commit"]').click
  #     expect(current_path).to eq(root_path)
  #     # 写真投稿一覧ページに移動する
  #     visit posts_path
  #     # ポスト1を投稿した写真投稿詳細ページに移動する
  #     visit post_path(@post1)
  #     # ポスト1に「編集」ボタンがあることを確認する
  #     expect(page).to have_link '編集', href: edit_post_path(@post1)
  #     # 編集ページへ遷移する
  #     visit edit_post_path(@post1)
  #     # すでに投稿済みの内容がフォームに入っていることを確認する
  #     expect(
  #       find('#images').value
  #     ).to eq(@post1.images)
  #     expect(
  #       find('#item_name').value
  #     ).to eq(@post1.post_text)
  #     # 投稿内容を編集する
  #     fill_in 'images', with: "#{@post1.item-image}+編集した画像URL"
  #     fill_in 'post_text', with: "#{@post1.item_name}+編集したテキスト"
  #     # 編集してもPostモデルのカウントは変わらないことを確認する
  #     expect{
  #       find('input[name="commit"]').click
  #     }.to change { Post.count }.by(0)
  #     # 編集完了がしたらポスト詳細ページに遷移したことを確認する
  #     visit post_path(@post1)
  #     # 投稿写真一覧ページに遷移する
  #     visit posts_path
  #     # 投稿写真一覧ページには先ほど変更した内容の写真テキストが存在することを確認する（画像）
  #     expect(page).to have_selector ".content_post[style='background-image: url(#{@post1.images}+編集した画像URL);']"
  #     # 投稿写真一覧トページには先ほど変更した内容の写真テキストが存在することを確認する（テキスト）
  #     expect(page).to have_content("#{@post1.post_text}+編集したテキスト")
  #   end
  # end
  context '写真テキスト編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した写真テキストの編集画面には遷移できない' do
      # ポスト1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 写真投稿一覧ページに移動する
      visit posts_path
      # ポスト2を投稿した写真投稿詳細ページに移動する
      visit post_path(@post2)
      # ポスト2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
    it 'ログインしていないと写真テキストの編集画面には遷移できない' do
      # ポスト1の投稿写真詳細ページにいる
      visit post_path(@post1)
      # ポスト1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post1)
      # ポスト2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@post2)
    end
  end
end

RSpec.describe '写真テキスト削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  # context '写真テキスト削除ができるとき' do
  #   it 'ログインしたユーザーは自らが投稿した写真テキスト削除ができる' do
  #     # ポスト1を投稿したユーザーでログインする
  #     visit new_user_session_path
  #     fill_in 'Eメール', with: @post1.user.email
  #     fill_in 'パスワード', with: @post1.user.password
  #     find('input[name="commit"]').click
  #     expect(current_path).to eq(root_path)
  #     # 写真投稿一覧ページに移動する
  #     visit posts_path
  #     # ポスト1を投稿した写真投稿詳細ページに移動する
  #     visit post_path(@post1)
  #     # ポスト1に「削除」ボタンがあることを確認する
  #     expect(page).to have_link '削除', href: post_path(@post1)
  #     # 投稿を削除するとレコードの数が1減ることを確認する
  #     expect{
  #       all('.btn-shine')[1].find_link('削除', href: post_path(@post1)).click
  #     }.to change { Post.count }.by(-1)
  #     # 投稿写真一覧ページに遷移する
  #     visit posts_path
  #     # 投稿写真一覧ページにはポスト1の内容が存在しないことを確認する（画像
  #     expect(page).to have_no_selector ".content_post[style='background-image: url(#{@post1.images});']"
  #     # 投稿写真一覧ページにはポスト1の内容が存在しないことを確認する（テキスト）
  #     expect(page).to have_no_content("#{@post1.post_text}")
  #   end
  # end
  context '写真テキスト削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した写真テキストの削除ができない' do
      # ポスト1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 写真投稿一覧ページに移動する
      visit posts_path
      # ポスト2を投稿した写真投稿詳細ページに移動する
      visit post_path(@post2)
      # ポスト2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
    it 'ログインしていないと写真テキストの削除ボタンがない' do
      # ポスト1の投稿写真詳細ページにいる
      visit post_path(@post1)
      # ポスト1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post1)
      # ポスト2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: post_path(@post2)
    end
  end
end

RSpec.describe '写真テキスト詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end
  it 'ログインしたユーザーは写真テキスト詳細ページに遷移してコメント投稿欄が表示される' do
    # ポスト1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @post.user.email
    fill_in 'パスワード', with: @post.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 写真投稿一覧ページに移動する
    visit posts_path
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページに写真テキストの内容が含まれている
    # expect(page).to have_selector ".content_post[style='background-image: url(#{@post.images});']"
    # expect(page).to have_content("#{@post.post_text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で写真テキスト詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 写真投稿一覧ページに移動する
    visit posts_path
    # 詳細ページに遷移する
    visit post_path(@post)
    # 詳細ページに写真テキストの内容が含まれている
    # expect(page).to have_selector ".content_post[style='background-image: url(#{@post.images});']"
    # expect(page).to have_content("#{@post.post_text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「※※※ コメントの投稿には新規登録/ログインが必要です ※※※」が表示されていることを確認する
    expect(page).to have_content '※※※ コメントの投稿には新規登録/ログインが必要です ※※※'
  end
end