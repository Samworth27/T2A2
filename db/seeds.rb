# frozen_string_literal: true

# Common

def read_seed_file(path, file)
  JSON.parse(File.read("#{path}/#{file}.json"), symbolize_names: true)
end

# Categories

def create_category(category, parent = nil)
  node = if parent.nil?
           Category.create!(name: category[:name],
                            plural: category[:plural])
         else
           parent.children.create!(
             name: category[:name], plural: category[:plural]
           )
         end
  puts "Seeding category '#{node.slug}' successfull" unless ENV['output'] == 'false'
  category[:children].each do |child|
    create_category(child, node)
  end
end

def seed_categories(path)
  Category.destroy_all
  categories = read_seed_file(path, :Categories)
  categories.each do |category|
    create_category(category)
  end
end

# Items

def seed_items(seed_path, image_path)
  Item.destroy_all
  items = read_seed_file(seed_path, :Items)
  items.each do |item|
    row = Category.friendly.find(item[:category]).children.create!(name: item[:name], plural: item[:plural])
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
  Profile.destroy_all
  UserConversation.destroy_all
  Message.destroy_all
  Conversation.destroy_all
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
Message.delete_all
UserConversation.delete_all
Conversation.delete_all
Listing.delete_all
Profile.delete_all
User.delete_all

public_image_path = Rails.root.join('app', 'assets', 'images')
seed_files_path = Rails.root.join('db', 'seeds')

def attach_local_image(item, path, filename)
  item.image.attach(io: File.open("#{path}/#{filename}"), filename:)
end

seed_categories(seed_files_path)
seed_items(seed_files_path, public_image_path)

Category.all.each do |cat|
  attach_local_image(cat, public_image_path, "#{cat.slug}.jpg")
end

Conversation.destroy_all

seed_users unless ENV['users'] == 'false'

seed_measurements(seed_files_path)
