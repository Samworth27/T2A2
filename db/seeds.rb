Dir.glob(Rails.root.join('lib','seeds','*.json')).each do |file|
  object = file.match(/^\/(.+\/)*(.+)\.(.+)$/)[2].constantize
  data = JSON.parse(File.read(file))
  results = ["Creation of #{object}s: ["]
  data.each do |row|
    record = object.new
    if object == User
      record.password = 'thisisnotapassword'
      record.email = 'temp@localhost'
      puts "User: #{record.save!}"
    end
    row.each do |key, value|
      record[key] = value
    end
    results.append(record.save!)
  end
  results.append ']'
  puts results.join(" ")
end