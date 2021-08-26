class Asignatura < ApplicationRecord
  belongs_to :grado

  ThinkingSphinx::Callbacks.append(
    self, :behaviours => [:sql]
  )

  def self.createAsignatura(item2)

    nombre = item2[:nombre]
    grado_g = item2[:grado]
    grado=grado_g.nombre
    universidad= grado_g.universidad.nombre
    asignaturas = Asignatura.where("nombre = ?", nombre).and(Asignatura.where("grado.nombre = ?",  grado)).and(Asignatura.where("grado.universidad.nombre = ?",  universidad))
    if asignaturas.count<1

    Asignatura.where(item2).create
                  
    end
  end
end
