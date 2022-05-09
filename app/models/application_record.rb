# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def export(values = %i[])
    data = {}
    values.each do |v|
      data[v] = send(v)
    end
    data
  end
end
