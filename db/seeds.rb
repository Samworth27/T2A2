# frozen_string_literal: true

# Common

def read_seed_file(path, file)
  JSON.parse(File.read("#{path}/#{file}.json"), symbolize_names: true)
end

# Categories

def create_root
  root = Category.new(name: 'root', display: 'Categories')
  root.parent = root
  root.save(validate: false)
  root
end

def create_category(category, parent)
  node = Category.new(name: category[:name], display: category[:name], parent:)
  node.save!
  children = category[:children].collect { |child| create_category(child, node) }
  children.empty? ? node : [node] + children
end

def seed_categories(path)
  Item.destroy_all
  Category.all.reverse.each(&:destroy)
  categories = read_seed_file(path, :Categories)
  categories.collect! { |category| create_category(category, create_root) }
  return unless ENV['output'] == 'false'

  categories.flatten.each do |category|
    # puts({ category:, children: category.children.size })
    puts "Seeding category '#{category}' successfull"
  end
end

# Items

def attach_local_image(item, path, filename)
  item.image.attach(io: File.open("#{path}/#{filename}"), filename:) if ENV['item-images'] == true
end

def seed_items(seed_path, image_path)
  Item.destroy_all
  items = read_seed_file(seed_path, :Items)
  items.each do |item|
    row = Item.new(name: item[:name], plural: item[:plural], category: Category.friendly.find(item[:category]))
    row.save!
    attach_local_image(row, image_path, "#{item[:name]}.jpg")
    next if ENV['output'] == 'false'

    puts "Seeding Item '#{row.name}' successfull"
  end
end

# Users

def add_user_with_role(user, role)
  new_user = User.new(email: "#{user}@localhost", password: 'password')
  new_user.save!
  new_user.add_role(role)
  Profile.new(user: new_user).save(validate: false)
  return if ENV['output'] == 'false'

  puts "Seeding User '#{new_user.email}' with role/s '#{new_user.roles.collect(&:name).join(',')}' successfull"
end

def seed_users
  Listing.destroy_all
  User.destroy_all

  add_user_with_role(:admin, :admin)
  add_user_with_role(:moderator, :moderator)
  add_user_with_role(:trader1, :trader)
  add_user_with_role(:trader2, :trader)
end

# Measurements

def seed_measurements(path)
  Measurement.destroy_all
  measurements = read_seed_file(path, :Measurements)
  measurements.each do |measurement|
    prefixes = measurement.delete(:prefixes)
    row = Measurement.new(measurement)
    row.save!
    next if prefixes.empty?
    prefixes.each do |prefix|
      p_row = Measurement.new(measurement)
      p_row.unit = prefix[:name] + p_row.unit.downcase
      p_row.abbreviation = prefix[:symbol] + p_row.abbreviation
      p_row.power = prefix[:power]
      p_row.save!
      puts p_row.unit, p_row.abbreviation, p_row.power
    end
  end
end
# Main Program

public_image_path = Rails.root.join('public', 'images')
seed_files_path = Rails.root.join('db', 'seeds')

if ENV['full'] == 'true'
  seed_categories(seed_files_path)
  seed_items(seed_files_path, public_image_path)
end

seed_users unless ENV['users'] == 'false'

seed_measurements(seed_files_path)