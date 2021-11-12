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
  factory :artilce1, class: Article do
    title { 'テスト記事1' }
    content { 'テスト記事1のコンテンツです。'}
    permalink { 'test-article1' }
    status { 1 }
    coedit_permit { 0 }
    garbage { false }
    # user
    association :user, factory: :test_user1
  end

end
