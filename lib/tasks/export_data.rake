namespace :export do
  desc "Export users" 
  task :export_to_seeds => :environment do
    
    tables = [User, Role, UsersRole]

    tables.each do |table|
      data = []
      table.all.each do |user|
        data.append user.export
      end
      File.write(Rails.root.join('lib','seeds',"#{table}.json"), JSON.pretty_generate(data))
    end

  end
end
