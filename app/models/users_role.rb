class UsersRole < ApplicationRecord

  def export
    values = %i[user_id role_id]
    data = {}
    values.each do |v|
      data[v] = self.send(v)
    end
    data
  end
end
