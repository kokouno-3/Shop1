# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'kokou3@gmail.com',
   password: 'kokou3'
)

Genre.create!(name: "ケーキ")
Genre.create!(name: "プリン")
Genre.create!(name: "焼き菓子")
Genre.create!(name: "キャンディ")

Item.create!(
  [
   genre_id: '1',
   name: 'チーズケーキ',
   explanation: 'ああああああ',
   price: '1200',
   image_id: '',
   is_status: '販売中',
  ]
)
Item.create!(
   genre_id: '3',
   name: 'たいやき',
   explanation: 'ああああああ',
   price: '400',
   image_id: '',
   is_status: '販売中',
)
Item.create!(
   genre_id: '4',
   name: 'べっこうあめ',
   explanation: 'ああああああ',
   price: '600',
   image_id: '',
   is_status: '販売中',
)