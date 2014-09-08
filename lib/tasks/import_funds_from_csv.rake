require 'csv'

task import_funds_from_csv: :environment do
  extract_funds_from_csv
end

def extract_funds_from_csv(file_name='lib/fondeso/funds/programas.csv')
  funds = []
  saved = 0
  completely_saved = 0
  not_saved = 0

  CSV.foreach(file_name, :headers => true) do |csv_obj|
    raw_data = csv_obj.to_hash
    # let's rename the fields
    new_fund = Hash[raw_data.map {|k, v| [mappings[k] || k, v] }]

    # get the data to necessary to create a new fund
    f = Fund.new

    f.name = new_fund["nombre"]
    f.institution = new_fund["institucion"]
    f.description = new_fund["descripcion"]

    begin
      f.save!
      saved = saved + 1
    rescue
      puts "#{f.name} #{f.institution} #{f.description}"
      not_saved = not_saved + 1
      next
    end

    f.clasification = get_valid_classifications_from(new_fund)
    f.characteristics = validate_data(new_fund["caracteristicas"], CHARACTERISTICS)
    f.deliver_method = validate_data(new_fund["entrega"], DELIVER_METHODS)

    begin
      f.save!
      completely_saved = completely_saved + 1
    rescue
      puts "#{f.clasification} #{f.characteristics} #{f.deliver_method}"
      f.errors.full_messages.each do |message|
        puts message
      end
      puts "-----------------------------------------------------------------"
    end
  end

  # let's wrap up
  puts "\n#{saved} programa(s) dados de alta correctamente."
  puts "#{completely_saved} programa(s) guardados completos correctamente."
  puts "#{not_saved} programa(s) fallaron al ser guardados.\n"
end

def fetch_array_from(str)
  return nil unless str.present?
  str.split("\n")
end

def mappings
  {
    "ID" => "id",
    "Nombre del Programa" => "nombre",
    "Nombre de la modalidad/Categoría (si aplica) " => "categoria",
    "Institución a cargo" => "institucion",
    "Características del apoyo" => "caracteristicas",
    "Mecanismo de entrega" => "entrega",
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

def get_valid_classifications_from(fund)
  classification = [""]

  return classification unless classification_values_are_correct?(fund)

  if activated?(fund["profesionista"], fund["noexiste"], fund)
    classification << "Profesionista - Aún no existe"
  end

  if activated?(fund["necesidad"], fund["noexiste"], fund)
    classification << "Necesidad - Aún no existe"
  end
  if activated?(fund["necesidad"], fund["startup"], fund)
    classification << "Necesidad - Startup"
  end

  if activated?(fund["tradicional"], fund["startup"], fund)
    classification << "Tradicional - Startup"
  end
  if activated?(fund["tradicional"], fund["crecimiento"], fund)
    classification << "Tradicional - Crecimiento"
  end
  if activated?(fund["tradicional"], fund["consolidacion"], fund)
    classification << "Tradicional - Consolidación"
  end

  if activated?(fund["lifestyle"], fund["startup"], fund)
    classification << "Lifestyle - Startup"
  end
  if activated?(fund["lifestyle"], fund["crecimiento"], fund)
    classification << "Lifestyle - Crecimiento"
  end
  if activated?(fund["lifestyle"], fund["consolidacion"], fund)
    classification << "Lifestyle - Consolidación"
  end

  if activated?(fund["cultural"], fund["startup"], fund)
    classification << "Cultural - Startup"
  end
  if activated?(fund["cultural"], fund["crecimiento"], fund)
    classification << "Cultural - Crecimiento"
  end
  if activated?(fund["cultural"], fund["consolidacion"], fund)
    classification << "Cultural - Consolidación"
  end

  if activated?(fund["social"], fund["startup"], fund)
    classification << "Social - Startup"
  end
  if activated?(fund["social"], fund["crecimiento"], fund)
    classification << "Social - Crecimiento"
  end
  if activated?(fund["social"], fund["consolidacion"], fund)
    classification << "Social - Consolidación"
  end

  if activated?(fund["altoimpacto"], fund["startup"], fund)
    classification << "Alto impacto - Startup"
  end
  if activated?(fund["altoimpacto"], fund["crecimiento"], fund)
    classification << "Alto impacto - Crecimiento"
  end
  if activated?(fund["altoimpacto"], fund["consolidacion"], fund)
    classification << "Alto impacto - Consolidación"
  end
  classification
end

def activated?(value1, value2, fund)
  value1 = Integer(value1)
  value2 = Integer(value2)
  return true if value1 == 1 && value1 == value2
end

def classification_values_are_correct?(fund)
  # false if we've got values like "1c", etc
  if fund["profesionista"].length > 1 ||
     fund["necesidad"].length > 1 ||
     fund["tradicional"].length > 1 ||
     fund["lifestyle"].length > 1 ||
     fund["cultural"].length > 1 ||
     fund["social"].length > 1 ||
     fund["altoimpacto"].length > 1 ||
     fund["noexiste"].length > 1 ||
     fund["startup"].length > 1 ||
     fund["crecimiento"].length > 1 ||
     fund["consolidacion"].length > 1

    puts "El siguiente programa no tiene clasificación válida (ej.1d): #{fund["nombre"]}"
    return false
  end
  true
end

def validate_data(fund, model_data)
  # fetch the csv data, validate the it, and append "" at the beginning of the array ('cause of the multiple select)
  characteristics = fetch_array_from(fund)
  characteristics = characteristics.select { |c| model_data.include? c }
  characteristics.unshift("")
end
