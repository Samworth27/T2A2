# frozen_string_literal: true

json.extract! scaffold, :id, :created_at, :updated_at
json.url scaffold_url(scaffold, format: :json)
