class Universidad < ApplicationRecord
  validates :nombre, uniqueness: true
  validates :name, :url, :email, presence: true
  belongs_to :comunidad
  has_many :grados
  
end
