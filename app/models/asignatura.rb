class Asignatura < ApplicationRecord
  belongs_to :grado

  ThinkingSphinx::Callbacks.append(
    self, :behaviours => [:sql]
  )
end
