require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @consultation = FactoryBot.create(:consultation)
    @consultations_comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは相談詳細ページでコメント投稿できる' do
    # 相談1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @consultation.user.email
    fill_in 'パスワード', with: @consultation.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 相談投稿一覧ページに移動する
    visit consultations_path
    # 相談詳細ページに遷移する
    visit consultation_path(@consultation)
    # フォームに情報を入力する
    fill_in 'consultations_comment[comment_text]', with: @consultations_comment
    # コメントを送信すると、ConsultationsCommentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { ConsultationsComment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(consultation_path(@consultation))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @consultations_comment
  end
end