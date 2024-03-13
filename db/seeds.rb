# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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
