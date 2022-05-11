# frozen_string_literal: true

def create_children(parent, children)
  children.each do |child|
    node = Category.create!(name: child[:name], display: child[:name], parent: parent)
    create_children(node, child[:children])
    p node
  end
end

Category.delete_all
categories = JSON.parse(File.read(Rails.root.join('lib', 'seeds', 'Categories.json')), symbolize_names: true)
root = Category.new(name: 'root', display: 'Categories')
root.parent = root
root.save(validate: false)
categories.each do |category|
  node = Category.new(name: category[:name], display: category[:name], parent: root)
  node.save!
  create_children(node, category[:children])
  p node
end
