FactoryBot.define do

  # factory :article do
  factory :top_page, class: Article do
    title { 'トップページ' }
    content { 'トップページのコンテンツです。'}
    permalink { 'top-page' }
    status { 1 }
    coedit_permit { 1 }
    garbage { false }
    # user
    association :user, factory: :admin_user1
  end

  # factory :article do
  factory :article_closed, class: Article do
    title { 'テスト記事1下書き' }
    content { 'テスト記事1下書きのコンテンツです。'}
    permalink { 'test-article1-closed' }
    status { 0 }
    coedit_permit { 0 }
    garbage { false }
    association :user, factory: :test_user1
  end

  factory :article_opened, class: Article do
    title { 'テスト記事2公開' }
    content { 'テスト記事2公開のコンテンツです。'}
    permalink { 'test-article2-opened' }
    status { 1 }
    coedit_permit { 0 }
    garbage { false }
    association :user, factory: :test_user2
  end

  factory :article_limited_user, class: Article do
    title { 'テスト記事3限定公開' }
    content { 'テスト記事3限定公開のコンテンツです。'}
    permalink { 'test-article3-limited' }
    status { 2 }
    coedit_permit { 0 }
    garbage { false }
    association :user, factory: :test_user3
  end



end
