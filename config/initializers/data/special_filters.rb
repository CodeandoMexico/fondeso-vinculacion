SPECIAL_FILTERS = [
  "Sexo",
  "Rural",
  "Joven",
  "Tercera Edad",
  "Artesanos",
  "Tiendas de Abarrotes",
  "Bachillerato",
  "Exportación",
  "Manufactura",
  "Propiedad industrial",
  "Construcción",
  "Turismo",
  "Acceso a TICs",
  "Legal",
  "Seguridad",
  "Indígenas",
  "TIC"
]

FILTER_KEYS = [
  "MUJ",
  "RUR",
  "JOV",
  "TER",
  "ART",
  "TAB",
  "BAC",
  "EXP",
  "MAN",
  "PIN",
  "CON",
  "TUR",
  "ATI",
  "IND",
  "TIC"
]

LOOK_FOR_SHORT_NAME_OF_FILTER = {}

SPECIAL_FILTERS.each_with_index do |key, index|
    LOOK_FOR_SHORT_NAME_OF_FILTER[key] = FILTER_KEYS[index]
end
