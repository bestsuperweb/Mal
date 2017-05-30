# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

['guitar', 'bass guitar', 'piano', 'violin', 'drums'].each do |i|
  Instrument.where(name: i).first_or_create
end

['jazz', 'blues', 'pop', 'rock', 'classical', 'country'].each do |i|
  Genre.where(name: i).first_or_create
end

['beginner', 'intermediate', 'advanced'].each do |i|
  Level.where(name: i).first_or_create
end

s1 = SiteSetting.where(key: "credit_price").first_or_initialize
s1.value = 9.99
s1.save

s2 = SiteSetting.where(key: "credit_redeem_price").first_or_initialize
s2.value = 6.99
s2.save

s3 = SiteSetting.where(key: "3_credit_pack_price").first_or_initialize
s3.value = 20.99
s3.save

s4 = SiteSetting.where(key: "6_credit_pack_price").first_or_initialize
s4.value = 50.99
s4.save

s5 = SiteSetting.where(key: "12_credit_pack_price").first_or_initialize
s5.value = 99.99
s5.save

s6 = SiteSetting.where(key: "contact_email").first_or_create
s7 = SiteSetting.where(key: "paypal_login").first_or_create
s8 = SiteSetting.where(key: "paypal_password").first_or_create
s9 = SiteSetting.where(key: "paypal_signature").first_or_create
