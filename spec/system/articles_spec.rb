require 'rails_helper'

# bundle exec rspec spec/system/articles_spec.rb

describe '記事管理機能', type: :system do

  # ユーザーの作成
  let(:user_a) { FactoryBot.create(:admin_user1) }
  let(:test_user1) { FactoryBot.create(:test_user1) }
  let(:test_user2) { FactoryBot.create(:test_user2) }
  let(:test_user3) { FactoryBot.create(:test_user3) }
  let(:test_user4) { FactoryBot.create(:test_user4) }
  let(:test_user5) { FactoryBot.create(:test_user5) }

  # 記事の作成
  # アドミンユーザー1がトップページを作成
  let!(:top_page) { FactoryBot.create(:top_page, user: user_a) }
  # テストユーザー1がstatus下書きの記事を作成
  let!(:article_closed) { FactoryBot.create(:article_closed, user: test_user1) }
  # テストユーザー2がstatus公開の記事を作成
  let!(:article_opened) { FactoryBot.create(:article_opened, user: test_user2) }

  # テストユーザー3がstatus限定公開の記事を作成
  # テストユーザー4、5に閲覧権限を与えられた記事
  let!(:article_limited_user) { FactoryBot.create(:article_limited_user, user: test_user3, readable_article_users: [test_user4, test_user5]) }

  before do

    # アドミンユーザー1がトップページを作成
    # FactoryBot.create(:top_page, user: user_a)
    # テストユーザー1がstatus下書きの記事を作成
    # FactoryBot.create(:article_closed, user: test_user1)
    # テストユーザー2がstatus公開の記事を作成
    # FactoryBot.create(:article_opened, user: test_user2)
    # ログイン
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'

    # ログイン
    # visit login_path
    # fill_in 'session[email]', with: 'admin1@sample.com'
    # fill_in 'session[password]', with: 'password'
    # click_button 'ログイン'

  end

  describe '一覧表示機能' do

    context 'アドミンユーザーがログインしている時' do
      let(:login_user) { user_a }
      it 'アドミンユーザーが作成した記事が表示される' do
        expect(page).to have_content 'トップページのコンテンツです。'
      end
    end

    context 'テストユーザー1が下書き記事を書き、テストユーザー2がログインしている時' do
      before do
        visit "/articles/"
      end
      let(:login_user) { test_user2 }
      it 'テストユーザー1が作成した記事が表示されない' do
        expect(page).to have_no_content 'テスト記事1下書き'
      end
    end

    context 'テストユーザー2が公開記事を書き、テストユーザー1がログインしている時' do
      before do
        visit "/articles/"
      end
      let(:login_user) { test_user1 }
      it 'テストユーザー2が作成した公開記事が表示される' do
        expect(page).to have_content 'テスト記事2公開'
      end
    end

    context 'テストユーザー3が限定公開記事を書き、テストユーザー4がログインしている時' do 
      before do
        visit "/articles/"
      end
      let(:login_user) { test_user4 }
      it 'テストユーザー3が作成したユーザー4, 5のみ閲覧限定の記事が表示される' do
        expect(page).to have_content 'テスト記事3限定公開'
      end
    end

    context 'テストユーザー3が限定公開記事を書き、テストユーザー2がログインしている時' do 
      before do
        visit "/articles/"
      end
      let(:login_user) { test_user2 }
      it 'テストユーザー3が作成したユーザー4, 5のみ閲覧限定の記事が表示されない' do
        expect(page).to have_no_content 'テスト記事3限定公開'
      end
    end







  end

  describe '詳細表示機能' do

    context 'テストユーザー1がログインしている時' do
      let(:login_user) { test_user1 }
      before do
        visit article_path(article_opened)
      end
      it 'テストユーザー2が作成した記事が表示される' do
        expect(find('.article-content').text).to have_content 'テスト記事2公開のコンテンツです。'
      end
    end

  end


  describe '新規記事作成機能' do
    let(:login_user) { test_user1 }

    before do
      visit new_article_path
      fill_in 'article[title]', with: article_name
      click_button '登録する'
    end

    context '新規記事作成画面でタイトルを入力した時' do
      let(:article_name) { '新規作成のテストを書く' }
      it '正常に登録される' do
        expect(page).to have_selector '.notice', text: '新規作成のテストを書くを作成しました。'
      end
    end

    context '新規記事作成画面でタイトルを入力しなかった時' do
      let(:article_name) { '' }
      it '題名なし記事が作成される' do
        within '.flash' do
          expect(page).to have_selector '.notice', text: '題名なしを作成しました。'
        end
      end
    end

  end

end