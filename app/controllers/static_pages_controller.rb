class StaticPagesController < ApplicationController
  def index

    @asignaturas= Asignatura.search :conditions => {:nombre => "marketing"}
    
    
  end
end
