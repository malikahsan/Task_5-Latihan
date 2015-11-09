puts "========= Seeding Articles Data ========="

ActiveRecord::Base.connection.execute("TRUNCATE articles")

Article.create!([
  {
    # id: 1,
    title: "Seed Title One",
    content: "Content of article seed one",
    status: "active"
  },
  
  {
    # id: 2,
    title: "Seed Title Two",
    content: "Content of article seed two",
    status: "active"
  }
])

puts "========= Seeding Comments Data ========="

ActiveRecord::Base.connection.execute("TRUNCATE comments")

Comment.create!([
  {
    id: 1,
    article_id: 1,
    content: "First comment for article seed one",
    status: "active"
  },
  
  {
    id: 2,
    article_id: 2,
    content: "Second comment for article seed one",
    status: "active"
  }
])

# puts "========= Seeding Users Data ========="
# 
# ActiveRecord::Base.connection.execute("TRUNCATE users")
# 
# User.create!([
  # {
    # id: 1,
    # email: "sann.lix@gmail.com",
    # username: "ahsan",
    # password: "qwerty"
  # },
#   
  # {
    # id: 2,
    # email: "developror@gmail.com",
    # username: "develop",
    # password: "12345"
  # }
# ])
# 
# User.update_all(activation_token: "", activation_status: "active")






