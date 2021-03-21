require 'rails_helper'

RSpec.describe '相談投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation_name = Faker::Lorem.sentence
    @consultation_text = Faker::Lorem.sentence
  end
  context '相談投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('LOGIN')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談投稿ページへのリンクがあることを確認する
      expect(page).to have_content('PUSH 相談')
      # 相談投稿ボタンを押す
      find('.btn-shine').click
      # 投稿ページに移動する
      visit new_consultation_path
      # フォームに情報を入力する
      fill_in 'consultation[name]', with: @consultation_name
      fill_in 'consultation[post_text]', with: @consultation_text
      # 送信するとConsultationモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Consultation.count }.by(1)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談投稿一覧ページには先ほど投稿した内容の相談が存在することを確認する（相談名）
      expect(page).to have_content(@consultation_name)
      # 相談投稿一覧ぺージには先ほど投稿した内容の相談が存在することを確認する（相談内容）
      expect(page).to have_content(@consultation_text)
    end
  end
  context '相談ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('nPUSH 投稿')
    end
  end
end

RSpec.describe '相談編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation1 = FactoryBot.create(:consultation)
    @consultation2 = FactoryBot.create(:consultation)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した相談の編集ができる' do
      # 相談1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @consultation1.user.email
      fill_in 'パスワード', with: @consultation1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談1を投稿した相談投稿詳細ページに移動する
      visit consultation_path(@consultation1)
      # 相談1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_consultation_path(@consultation1)
      # 編集ページへ遷移する
      visit edit_consultation_path(@consultation1)
      # 投稿内容を編集する
      fill_in 'consultation[name]', with: "#{@consultation1.consultations_comments}+編集した相談名"
      fill_in 'consultation[post_text]', with: "#{@consultation1.consultations_comments}+編集した相談内容"
      # 編集してもConsultationモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Consultation.count }.by(0)
      # 編集完了がしたら相談詳細ページに遷移したことを確認する
      visit consultation_path(@consultation1)
      # 相談投稿一覧ページに遷移する
      visit consultations_path
      # 相談投稿一覧ページには先ほど変更した内容の相談が存在することを確認する（相談名）
      expect(page).to have_content("#{@consultation1.consultations_comments}+編集した相談名")
      # 相談投稿一覧トページには先ほど変更した内容の相談が存在することを確認する（相談内容）
      expect(page).to have_content("#{@consultation1.consultations_comments}+編集した相談内容")
    end
  end
  context '相談編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した相談の編集画面には遷移できない' do
      # 相談1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @consultation1.user.email
      fill_in 'パスワード', with: @consultation1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談2を投稿した相談投稿詳細ページに移動する
      visit consultation_path(@consultation2)
      # 相談2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@consultation2)
    end
    it 'ログインしていないと相談の編集画面には遷移できない' do
      # 相談1の相談投稿詳細ページにいる
      visit consultation_path(@consultation1)
      # 相談1に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@consultation1)
      # 相談2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_post_path(@consultation2)
    end
  end
end

RSpec.describe '相談削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation1 = FactoryBot.create(:consultation)
    @consultation2 = FactoryBot.create(:consultation)
  end
  context '相談削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した相談削除ができる' do
      # 相談1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @consultation1.user.email
      fill_in 'パスワード', with: @consultation1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談1を投稿した相談投稿詳細ページに移動する
      visit consultation_path(@consultation1)
      # 相談1に「削除」ボタンがあることを確認する
      expect(page).to have_link '削除', href: consultation_path(@consultation1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: consultation_path(@consultation1)).click
      }.to change { Consultation.count }.by(-1)
      # 相談投稿一覧ページに遷移する
      visit consultations_path
      # 相談投稿一覧ページには相談1の内容が存在しないことを確認する（相談名）
      expect(page).to have_no_content("#{@consultation1.consultations_comments}")
      # 相談投稿一覧ページには相談1の内容が存在しないことを確認する（相談内容）
      expect(page).to have_no_content("#{@consultation1.consultations_comments}")
    end
  end
  context '相談削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した相談の削除ができない' do
      # 相談1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @consultation1.user.email
      fill_in 'パスワード', with: @consultation1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 相談投稿一覧ページに移動する
      visit consultations_path
      # 相談2を投稿した相談投稿詳細ページに移動する
      visit consultation_path(@consultation2)
      # 相談2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: consultation_path(@consultation2)
    end
    it 'ログインしていないと相談の削除ボタンがない' do
      # 相談1の相談投稿詳細ページにいる
      visit consultation_path(@consultation1)
      # 相談1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: consultation_path(@consultation1)
      # 相談2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: consultation_path(@consultation2)
    end
  end
end

RSpec.describe '相談詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @consultation = FactoryBot.create(:consultation)
  end
  it 'ログインしたユーザーは相談詳細ページに遷移してコメント投稿欄が表示される' do
    # 相談1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @consultation.user.email
    fill_in 'パスワード', with: @consultation.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 相談投稿一覧ページに移動する
    visit consultations_path
    # 詳細ページに遷移する
    visit consultation_path(@consultation)
    # 詳細ページに相談の内容が含まれている
    expect(page).to have_content("#{@consultation.name}")
    expect(page).to have_content("#{@consultation.post_text}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で相談詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 相談投稿一覧ページに移動する
    visit consultations_path
    # 詳細ページに遷移する
    visit consultation_path(@consultation)
    # 詳細ページに相談の内容が含まれている
    expect(page).to have_content("#{@consultation.name}")
    expect(page).to have_content("#{@consultation.post_text}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「※※※ コメントの投稿には新規登録/ログインが必要です ※※※」が表示されていることを確認する
    expect(page).to have_content '※※※ コメントの投稿には新規登録/ログインが必要です ※※※'
  end
end