FactoryBot.define do
  # factory :user do

  factory :admin_user1, class: User do
    name_id { 'admintuser1' }
    name { 'アドミンユーザー1'}
    email { 'admin1@sample.com' }
    password { 'password' }
    introduction { 'アドミンユーザー1です。' }
    admin { true }
    state { true }
    indication { false }
  end

  factory :test_user1, class: User do
    name_id { 'testuser1' }
    name { 'テストユーザー1'}
    email { 'test1@sample.com' }
    password { 'password' }
    introduction { 'テストユーザー1です。' }
    admin { false }
    state { true }
    indication { false }
  end

  factory :test_user2, class: User do
    name_id { 'testuser2' }
    name { 'テストユーザー2'}
    email { 'test2@sample.com' }
    password { 'password' }
    introduction { 'テストユーザー2です。' }
    admin { false }
    state { true }
    indication { false }
  end

  factory :test_user3, class: User do
    name_id { 'testuser3' }
    name { 'テストユーザー3'}
    email { 'test3@sample.com' }
    password { 'password' }
    introduction { 'テストユーザー3です。' }
    admin { false }
    state { true }
    indication { false }
  end

  factory :test_user4, class: User do
    name_id { 'testuser4' }
    name { 'テストユーザー4'}
    email { 'test4@sample.com' }
    password { 'password' }
    introduction { 'テストユーザー4です。' }
    admin { false }
    state { true }
    indication { false }
  end

  factory :test_user5, class: User do
    name_id { 'testuser5' }
    name { 'テストユーザー5'}
    email { 'test5@sample.com' }
    password { 'password' }
    introduction { 'テストユーザー5です。' }
    admin { false }
    state { true }
    indication { false }
  end

end
