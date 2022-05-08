class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def export
    values = %i[id name resource_type resource_id]
    data = {}
    values.each do |v|
      data[v] = self.send(v)
    end
    data
  end

end
