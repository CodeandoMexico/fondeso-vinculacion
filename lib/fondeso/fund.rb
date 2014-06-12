require 'csv'
module Fondeso
  class Fund
    attr_reader :funds

    def initialize
      @funds = Array.new
      # parse the csv
      CSV.foreach('lib/fondeso/funds/programas.csv',:headers => true) do |csv_obj|
        new_fund = csv_obj.to_hash
        # let's rename the fields
        mappings = {
          "Nombre del Programa" => "nombre",
          "Nombre de la modalidad/Categoría (si aplica) " => "categoria",
          "Institución a cargo" => "institucion",
          "Características del apoyo" => "caracteristicas",
          "Entrega del apoyo" => "entrega",
          "Descripción del programa" => "descripcion",
          "Dato de contacto para pedir informes" => "informes",
          "Clasificación por prioridad" => "prioridad",
          "Profesionista" => "profesionista",
          "Necesidad" => "necesidad",
          "Tradicional" => "tradicional",
          "Lifestyle" => "lifestyle",
          "Cultural" => "cultural",
          "Emp Social" => "social",
          "Alto impacto" => "altoimpacto",
          "Aún no existe" => "noexiste",
          "Start up" => "startup",
          "Crecimiento" => "crecimiento",
          "Consolidación" => "consolidacion",
        }
        # mappings = { "Nombre del Programa" => "nombre"}
        new_fund = Hash[new_fund.map {|k, v| [mappings[k] || k, v] }]
        funds.push new_fund # push the row hash into an array
      end
      # puts funds[0]
    end

    def all
      funds
    end

    def find(name)
      funds.map.select { |f| f[name] == '1'}
    end
  end

end
