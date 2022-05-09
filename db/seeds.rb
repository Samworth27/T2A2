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

# Dir.glob(Rails.root.join('lib','seeds','*.json')).each do |file|
# object = file.match(/^\/(.+\/)*(.+)\.(.+)$/)[2].constantize

# Manually defining the files to import allows you to specify the order in which the files
# are imported
[User, Role, UsersRole, ActiveStorageBlob, ActiveStorageAttachment].each do |table|
  path = File.join('lib', 'seeds', "#{table}.json")
  data = JSON.parse(File.read(path))

  # Array to build a terminal output string
  results = ["Creation of #{table}s: ["]

  data.each { |row| results.append import_row(row, table) }

  puts results.append(']').join(' ')
end