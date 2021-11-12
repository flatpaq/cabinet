require 'rails_helper'

describe '記事管理機能', type: :system do
  describe '一覧表示機能' do

    before do
      # アドミンユーザー1を作成しておく
      user_a = FactoryBot.create(:admin_user1)
      # アドミンユーザー1がトップページを作成
      FactoryBot.create(:top_page, user: user_a)

    end

    context 'アドミンユーザーがログインしている時' do
      before do
        # アドミンユーザー1でログインする
        visit login_path
        fill_in 'session[email]', with: 'admin1@sample.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
      end

      it 'アドミンユーザーが作成した記事が表示される' do
        # 作成済みの記事の名称が画面上に表示されていることを確認
        expect(page).to have_content 'トップページのコンテンツです。'
      end
    end


  end

end