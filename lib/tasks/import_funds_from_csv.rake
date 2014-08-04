require 'csv'

task import_funds_from_csv: :environment do
  extract_funds_from_csv
end

def extract_funds_from_csv(file_name='lib/fondeso/funds/programas.csv')
  funds = Array.new
  Fund.transaction do
    CSV.foreach(file_name, :headers => true) do |csv_obj|
      raw_data = csv_obj.to_hash
      # let's rename the fields
      new_fund = Hash[raw_data.map {|k, v| [mappings[k] || k, v] }]
      # puts new_fund
      f = Fund.new
      f.name = new_fund["nombre"]
      f.institution = new_fund["institucion"]
      f.characteristics = fetch_array_from new_fund["caracteristicas"]
      puts f.characteristics.inspect
      f.description = new_fund["descripcion"]
      # f.deliver_method = array_from_deliver_method new_fund[:entrega]
      # f.clasification = hashify_categories_from new_fund
      # f.special_filters = hashify_categories_from new_fund
      f.save!
      print '.'
    end
  end
  puts ''
end

def fetch_array_from(str)
  return nil unless str.present?
  # puts str.split("\n").inspect if str.split.length > 1
  str.split("\n")
end

def mappings
  {
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
end

def category

end
