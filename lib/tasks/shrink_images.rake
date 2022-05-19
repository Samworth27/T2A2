# frozen_string_literal: true

require 'image_processing/mini_magick'

namespace :images do
  desc 'Shrink Images'
  task shrink_images: :environment do
    Dir.glob(Rails.root.join('db', 'seeds', 'images', '*.jpg')).each do |image|
      processed = MiniMagick::Image.open(image)
      processed.resize '500x500'
      processed.format 'jpeg'
      puts Rails.root.join('app', 'assets', 'images', File.basename(image))
      processed.write(Rails.root.join('app', 'assets', 'images', File.basename(image)))
    end
  end
end
