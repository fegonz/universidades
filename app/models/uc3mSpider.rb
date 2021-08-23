require 'nokogiri'
require 'open-uri'


class Uc3mSpider < Kimurai::Base
@name = 'uc3m_spider'
@engine = :mechanize

def self.process(url,universidad)

@start_urls = [url]

url=universidad.url


cosas = {}

self.parse!(:parse, url,universidad, cosas)



end


def parse_url(urlGrado,grado,data2)

    zanzo = `curl --user-agent "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" #{urlGrado}`

 response2 = Nokogiri::HTML(zanzo)
  
  nombre =response2.xpath("//div[@class='contTitulo row']")
  nombre_grado = nombre.css("h1/text()")
  nombre_grado=nombre_grado.to_s
  grado.update(nombre: nombre_grado)
  response2.xpath("//div[@class='col span_12']").each do |tabla|
  
  curso=tabla.css('h2').text
  
  tabla.css("table").each do |proba|
  
  perro=proba.css("td[1]/a/text()")
    proba.css("tr").each do |asignatura|
    

        nombre_asignatura   = asignatura.css("td[1]/a/text()").to_s
        ects = asignatura.css("td[2]/text()").to_s



        if nombre_asignatura != "Trabajo Fin de Grado" && nombre_asignatura != "Optativas: Recomendado elegir 12 créditos" && nombre_asignatura.length > 1 
          
              if ects.length>0 
               
                  item2 = data2
                  
                  
                  item2[:nombre]      = nombre_asignatura 
                  item2[:creditos] = ects
                  tipo_asignatura      = asignatura.css("td[3]/text()").to_s

                  case tipo_asignatura
                  when  "O"
                       item2[:tipo]="Obligatoria"
                
                  when "FB"
                       item2[:tipo]="Formación básica"
                  when "P"
                       item2[:tipo]="Optativa"

                  when "O-P"
                        item2[:tipo]="Optativa Obligatoria"

                  end
                  item2[:grado]=grado
                   asignatura=Asignatura.where(item2).create!
                  

                   
                 
                end
             

        end
  end
   
  
   end
  
  
end

end


def parse(response, universidad, url, data: {})
 
 data = {}
 
 data_asignatura={}
 
 urlUc3m ="https://www.uc3m.es"
 
 paga = `curl --user-agent "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" https://www.uc3m.es/grado/estudios`
  
 response = Nokogiri::HTML(paga)
   
 response.xpath("//div[@class='row marcoLiso conborde categoriaGrado']").each do |lista|
  
  
 
          lista.css("li/a/@href").each do |url2|
                    urlUc3mAux=urlUc3m
                    
                    urlUc3mAux=urlUc3mAux+url2
                    
                    item = data

                    item[:url] = urlUc3mAux.to_s
                    
                    item[:universidad] = universidad
                                   
                    grado = Grado.where(item).create
                                   
                    
                    
                    parse_url(urlUc3mAux,grado,data_asignatura)
          


          end

end
end

end




