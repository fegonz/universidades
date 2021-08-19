class StaticPagesController < ApplicationController
  def index
    @grados = Grado.all
    @gradosCo=@grados.count
    @universidads = Universidad.all
    @asignaturas = Asignatura.all
  end
end
