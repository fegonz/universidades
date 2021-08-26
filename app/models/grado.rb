class Grado < ApplicationRecord
  belongs_to :universidad
  has_many :asignaturas

  def self.compruebaGrado(item2)

  end

    
end
