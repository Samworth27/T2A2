class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable#, :confirmable


  def export
    values = %i[email encrypted_password]
    data = {}
    values.each do |v|
      data[v] = self.send(v)
    end
    data
  end
end
