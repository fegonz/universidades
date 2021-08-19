class Comunidad < ApplicationRecord
    has_many :universidads
    validates :nombre, uniqueness: true
end
