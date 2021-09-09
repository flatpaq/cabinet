# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  User.create!(
    name_id: "admin#{n+1}",
    name: "アドミンユーザ#{n + 1}",
    email: "admin#{n + 1}@sample.com",
    password: "password",
    password_confirmation: "password",
    introduction: "テスト用ユーザ#{n + 1}です",
    admin: true,
    state: true,
    indication: false
  )

end

10.times do |n|
  Tag.create!(
    slug: "tag#{n+1}",
    label: "タグその#{n + 1}",
    edit_permit: 0,
    user_id: n + 1
  )
end


User.all.each_with_index do |user, n|
  user.articles.create!(
    user_id: user.id,
    title: "タイトル#{n+1}",
    content: "テキスト#{n + 1}",
    status: 1,
    coedit_permit: 0,
    garbage: false
  )
end

TagAssignment.create!(
  article_id: 1, 
  tag_id: 1
)
