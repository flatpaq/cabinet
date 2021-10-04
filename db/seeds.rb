# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(
  name_id: "administrator",
  name: "管理者",
  email: "admin1@sample.com",
  password: "Xdoe95kLEFdio38Z",
  password_confirmation: "Xdoe95kLEFdio38Z",
  introduction: "管理者",
  admin: true,
  state: true,
  indication: false
)

11.times do |n|
  User.create!(
    name_id: "admin#{n + 2}",
    name: "ユーザー#{n + 2}",
    email: "user#{n + 2}@sample.com",
    password: "password",
    password_confirmation: "password",
    introduction: "ユーザ#{n + 2}です",
    admin: false,
    state: true,
    indication: false
  )
end

Article.create!(

  [
    {
      # ウェルカムページをちゃんと書く
      user_id: 1,
      title: "ようこそ",
      content: "",
      status: 1,
      coedit_permit: 1,
      garbage: false
    },


    {
      # 通常のページ
      user_id: 2,
      title: "",
      content: "",
      status: 1,
      coedit_permit: 0,
      garbage: false
    }


  ]

)

# User.all.each_with_index do |user, n|
#   user.articles.create!(
#     user_id: user.id,
#     title: "タイトル#{n+1}",
#     content: "テキスト#{n + 1}",
#     status: 1,
#     coedit_permit: 0,
#     garbage: false
#   )
# end


# Tag.create!(

#   [

#     {
#       slug: "tag#{n+1}",
#       label: "タグその#{n + 1}",
#       edit_permit: 0,
#       user_id: n + 1
#     }

#   ]

# )

# 10.times do |n|
#   Tag.create!(
#     slug: "tag#{n+1}",
#     label: "タグその#{n + 1}",
#     edit_permit: 0,
#     user_id: n + 1
#   )
# end

# TagAssignment.create!(
#   [
#     {
#       article_id: 1, 
#       tag_id: 1
#     },
#     {
#       article_id: 2, 
#       tag_id: 2
#     },
#     {
#       article_id: 3, 
#       tag_id: 3
#     },
    
#   ]
# )
