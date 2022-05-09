# frozen_string_literal: true

def dump_table(table, export_path)
  data = []
  table.all.each { |row| data.append row.export }
  File.write(Rails.root.join(export_path, "#{table}.json"), JSON.pretty_generate(data))
end

namespace :export do
  desc 'Export users'
  task export_to_seeds: :environment do
    [User, Role, UsersRole, ActiveStorageAttachment, ActiveStorageBlob].each { |table| dump_table(table, 'lib/seeds') }
  end
end
