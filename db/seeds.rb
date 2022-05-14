# frozen_string_literal: true

def create_children(parent, children)
  children.each do |child|
    puts "{name: #{child[:name]}, children: #{child[:children].size} }"
    node = Category.create!(name: child[:name], display: child[:name], parent:)
    create_children(node, child[:children])
  end
end

Listing.destroy_all
User.destroy_all
Item.destroy_all
Category.all.reverse.each(&:destroy)

categories = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'Categories.json')), symbolize_names: true)
root = Category.new(name: 'root', display: 'Categories')
root.parent = root
root.save(validate: false)

categories.each do |category|
  puts "{name: #{category[:name]}, children: #{category[:children].size} }"
  node = Category.new(name: category[:name], display: category[:name], parent: root)
  node.save!
  create_children(node, category[:children])
end if false

items = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'Items.json')), symbolize_names: true)
items.each do |item|
  puts item
  row = Item.new(name: item[:name], plural: item[:plural], category: Category.friendly.find(item[:category]))
  row.save!
  row.image.attach(io: File.open(Rails.root.join('public', 'images', "#{item[:name]}.jpg")),
                   filename: "#{item[:name]}.jpg")
end if false

admin_user = User.new(email: 'admin@localhost', password: 'password')
admin_user.save!
admin_user.add_role(:admin)

moderator_user = User.new(email: 'moderator@localhost', password: 'password')
moderator_user.save!
moderator_user.add_role(:moderator)

trader_user = User.new(email: 'trader@localhost', password: 'password')
trader_user.save!
trader_user.add_role(:trader)

parent = root
5.times do |i|
  5.times do |j|
    node = Category.new(name: "level-#{i}:#{j}", display: "level-#{i}:#{j}", parent:)
    node.save!
  end
  parent = Category.last
end
