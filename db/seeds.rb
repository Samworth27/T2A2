# frozen_string_literal: true

def create_children(parent, children)
  children.each do |child|
    node = Category.create!(name: child[:name], display: child[:name], parent: parent)
    create_children(node, child[:children])
    p node
  end
end

Item.destroy_all
Category.all.reverse.each(&:destroy)

categories = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'Categories.json')), symbolize_names: true)
root = Category.new(name: 'root', display: 'Categories')
root.parent = root
root.save(validate: false)
categories.each do |category|
  node = Category.new(name: category[:name], display: category[:name], parent: root)
  node.save!
  create_children(node, category[:children])
  p node
end

items = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'Items.json')), symbolize_names: true)
items.each do |item|
  puts item
  row = Item.new(name: item[:name], plural: item[:plural], category: Category.friendly.find(item[:category]))
  row.save!
  row.image.attach(io: File.open(Rails.root.join('public', 'images', "#{item[:name]}.jpg")), filename: "#{item[:name]}.jpg")
end
