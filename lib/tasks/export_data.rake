# frozen_string_literal: true

namespace :export do
  desc 'Export users' 
  task export_to_seeds: :environment do
    # Define tables to export
    tables = [User, Role, UsersRole]

    tables.each do |table|
      data = []
      table.all.each { |user| data.append user.export }
      File.write(Rails.root.join('lib', 'seeds', "#{table}.json"), JSON.pretty_generate(data))
    end
  end
end
