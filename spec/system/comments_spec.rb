require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @tweet = FactoryBot.create(:tweet)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    #ログインする
    sign_in(@tweet.user)
    #ツイート詳細ページに遷移する
    visit tweet_path(@tweet)
    #フォームに情報を入力する
    fill_in 'comment_text',with: @comment
    #コメントを送信すると、Commentモデルのカウントが１上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    #詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq (tweet_path(@tweet))
    #詳細ページ上に先程のコメント内容が含まれていることを確認する
    expect(page).to have_selector @comment
  end
end
