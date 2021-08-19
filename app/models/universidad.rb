class Universidad < ApplicationRecord
  belongs_to :comunidad
  has_many :grados
end
