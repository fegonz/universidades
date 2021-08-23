require 'nokogiri'
require 'open-uri'


class UceuSpider < Kimurai::Base
    @name = 'uceu_spider'
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
    
     todos_cursos = response2.xpath("//div[@class='cover-acordeon']")
      curso2= todos_cursos.xpath("//div[@class='acordeon-box padding-left']")

      nombre_grado= response2.xpath("//h1[@class='title']/small/text()")
      nombre_grado=nombre_grado.to_s
      grado.update(nombre: nombre_grado)
      curso2.xpath("//div[@class='acordeon']").each do |curso|

        curso_numero= curso.at("h4[@class='tag upper']/text()").to_s

          if curso_numero.to_s.include? "CURSO"


            curso.xpath("//div[@class='table table-item noheight']").each do |asignatura|
                  
        
          numero=1
          nombre_asignatura="definir"
         ects="por definir"
         tipo="poa"
           asignatura.css("div[@class='table-cell']").each do |asignatura2|


  
              if numero == 1
                nombre_asignatura = asignatura2.css('span[@class="description"]/text()')

                
                
              end

              if numero == 2

                ects= asignatura2.at('span[@class="description"]/text()')
                

              end

              if numero == 3
                 tipo= asignatura2.at('span[@class="description"]/text()')
                 

              end
          
              numero = numero +1
            
        end

        if tipo.to_s.exclude? "Fin de"

        item = data2
                      
                      item[:grado]      = grado
                
                      #item[:curso]      = curso_numero.to_s
                      item[:nombre]      = nombre_asignatura.to_s
                      item[:creditos] = ects.to_s
                      item[:tipo]      = tipo.to_s
                     Asignatura.where(item).create
        end
      end


        end
    end
              





    

  end
  

  def parse(response, universidad, url, data: {})
 
    data = {}
    
    data_asignatura={}

   urlUceu ="https://www.uspceu.com/"
      paga = `curl --user-agent "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" https://www.uspceu.com/oferta/grado`
       
       response = Nokogiri::HTML(paga)

 
    
      lista = response.xpath("//div[@id='resultados']")



      lista.css("a").each do |table|

         urlgrado= table.css("@href")
         
         urlgrado= urlUceu+urlgrado.to_s
         
         item = data

         item[:url] = urlgrado.to_s
         
         item[:universidad] = universidad
                        
         grado = Grado.where(item).create
                        
         parse_url(urlgrado,grado,data_asignatura)
        

      end
        
        

    
 
end

end

