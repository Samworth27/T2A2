# frozen_string_literal: true

def dump_table(table, export_path)
  data = []
  table.all.each { |row| data.append row.export }
  File.write(Rails.root.join(export_path, "#{table}.json"), JSON.pretty_generate(data))
end

def import_row(row, object)
  record = object.new
  # Edge case for User. The `passwords` field requires an entry to save the user.
  # This creates a default User that will then be overwritten
  if object == User
    record.password = 'thisisnotapassword'
    record.email = 'temp@localhost'
    # puts "User: #{record.save!}"
  end

  # assign each key pair in the row to the new record
  row.each do |key, value|
    record[key] = value
  end

  # Store if the record was saved successfully
  record.save!
end

namespace :export do
  desc 'Export Database'
  task export_to_seeds: :environment do
    [User, Role, UsersRole, ActiveStorageAttachment, ActiveStorageBlob].each { |table| dump_table(table, 'lib/seeds') }
  end
end

namespace :import do
  desc 'Import Database'
  task import_from_seeds: :environment do
    [User, Role, UsersRole, ActiveStorageBlob, ActiveStorageAttachment].each do |table|
      path = File.join('lib', 'seeds', "#{table}.json")
      data = JSON.parse(File.read(path))
      # Array to build a terminal output string
      results = ["Creation of #{table}s: ["]
      data.each { |row| results.append import_row(row, table) }
      puts results.append(']').join(' ')
    end
  end
end