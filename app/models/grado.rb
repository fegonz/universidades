class Grado < ApplicationRecord
  belongs_to :universidad
  has_many :asignaturas
end
