# frozen_string_literal: true

def create_category(category, parent)
  node = Category.new(name: category[:name], display: category[:name], parent:)
  node.save!

  children = category[:children].collect { |child| create_category(child, node) }

  children.empty? ? node : [node] + children
end

def create_root
  root = Category.new(name: 'root', display: 'Categories')
  root.parent = root
  root.save(validate: false)
  root
end

def read_seed_file(path, file)
  JSON.parse(File.read("#{path}/#{file}.json"), symbolize_names: true)
end

def seed_categories(path)
  Item.destroy_all
  Category.all.reverse.each(&:destroy)
  categories = read_seed_file(path, :Categories)
  root = create_root

  categories.collect! { |category| create_category(category, root) }
  categories.flatten.each { |category| puts({ category:, children: category.children.size }) } unless ENV['output'] == 'false'
end

def attach_local_image(item, path, filename)
  item.image.attach(io: File.open("#{path}/#{filename}"), filename:)
end

def seed_items(seed_path, image_path)
  Item.destroy_all

  items = read_seed_file(seed_path, :Items)

  items.each do |item|
    puts item
    row = Item.new(name: item[:name], plural: item[:plural], category: Category.friendly.find(item[:category]))
    row.save!

    attach_local_image(row, image_path, "#{item[:name]}.jpg") if ENV['item-images'] == true
  end
end

def add_user_with_role(user, role)
  new_user = User.new(email: "#{user}@localhost", password: 'password')
  new_user.save!
  new_user.add_role(role)
  { user: new_user.email, roles: new_user.roles.collect(&:name) }
end

def seed_users
  Listing.destroy_all
  User.destroy_all

  puts add_user_with_role(:admin, :admin)
  puts add_user_with_role(:moderator, :moderator)
  puts add_user_with_role(:trader1, :trader)
  puts add_user_with_role(:trader2, :trader)
end

if ENV['full'] == 'true'
  public_image_path = Rails.root.join('public', 'images')
  seed_file_path = Rails.root.join('db', 'seeds')

  seed_categories(seed_file_path)
  seed_items(seed_file_path, public_image_path)
end

seed_users unless ENV['users'] == 'false'
