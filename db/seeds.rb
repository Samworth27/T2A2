Dir.glob(Rails.root.join('lib','seeds','*.json')).each do |file|

  object = file.match(/^\/(.+\/)*(.+)\.(.+)$/)[2].constantize
  data = JSON.parse(File.read(file))
  
  # Array to build a terminal output string
  results = ["Creation of #{object}s: ["]

  data.each do |row|
    record = object.new

    # Edge case for User. The `passwords` field requires an entry to save the user.
    # This creates a default User that will then be overwritten
    if object == User
      record.password = 'thisisnotapassword'
      record.email = 'temp@localhost'
      puts "User: #{record.save!}"
    end

    # assign each key pair in the row to the new record
    row.each do |key, value|
      record[key] = value
    end

    # Store if the record was saved successfully
    results.append(record.save!)
  end
  results.append ']'
  puts results.join(' ')
end
