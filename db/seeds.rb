# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do                            
    User.create!(
      last_name: Faker::Name.unique.last_name,
      first_name: Faker::Name.unique.first_name,
      email: Faker::Internet.unique.email,
      password: "12345678",
      password_confirmation: "12345678"
    )
  end
  
  8.times do |index|                    
    Spot.create!(
      user: User.offset(rand(User.count)).first,
      spot_name: "タイトル#{index}",
      address: "住所#{index}",
      comment: "コメント#{index}"
    )
  end

  Tag.create!([
  { content: '屋外' },
  { content: '屋内' },
  { content: '飲食可' },
  { content: '屋根' },
  { content: 'テーブル' },
  { content: '冷暖房' },
  { content: '自動販売機' },
  { content: 'トイレ' }
])
