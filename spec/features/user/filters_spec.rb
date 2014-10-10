require 'spec_helper'

feature 'When a user submits an answered questionary' do
  attr_reader :category,
              :fund_for_women,
              :fund_for_rural,
              :fund_for_young,
              :fund_for_elderly,
              :fund_for_artisan,
              :fund_for_corner_store,
              :fund_for_college,
              :fund_for_export,
              :fund_for_manufacture,
              :fund_for_industrial_property,
              :fund_for_construction,
              :fund_for_turism,
              :fund_for_access_to_it,
              :fund_for_native,
              :fund_for_tic,
              :fund_for_two_filter

  before do
    user = FactoryGirl.create :user
    @category = 'necesidad-startup'

    # @fund_for_native = FactoryGirl.create :native_fund
    # @fund_for_women = FactoryGirl.create :women_fund
    # @fund_for_elderly = FactoryGirl.create :elderly_fund

    @fund_for_women = FactoryGirl.create :women_fund
    @fund_for_rural = FactoryGirl.create :rural_fund
    @fund_for_young = FactoryGirl.create :young_fund
    @fund_for_elderly = FactoryGirl.create :elderly_fund
    @fund_for_artisan = FactoryGirl.create :artisan_fund
    @fund_for_corner_store = FactoryGirl.create :corner_store_fund
    @fund_for_college = FactoryGirl.create :college_fund
    @fund_for_export = FactoryGirl.create :export_fund
    @fund_for_manufacture = FactoryGirl.create :manufacture_fund
    @fund_for_industrial_property = FactoryGirl.create :industrial_property_fund
    @fund_for_construction = FactoryGirl.create :construction_fund
    @fund_for_turism = FactoryGirl.create :turism_fund
    @fund_for_access_to_it = FactoryGirl.create :access_to_it_fund
    @fund_for_native = FactoryGirl.create :native_fund
    @fund_for_tic = FactoryGirl.create :tic_fund
    @fund_for_two_filter = FactoryGirl.create :two_filter_fund
  end

  scenario 'with all filters turned off it should return a fund' do
    expect(fetch_funds_with(filters_not_activated).length).to eq 0
  end

  scenario 'with all filters turned off it should return a fund' do
    expect(fetch_funds_with(filters_activated).length).to eq 16
  end

  scenario 'with only women filter activated' do
    expect(fetch_funds_with(only_women_filter_activated).length).to eq 1
  end

  scenario 'with only rural filter activated' do
    expect(fetch_funds_with(only_rural_filter_activated).length).to eq 1
  end

  scenario 'with only young filter activated' do
    expect(fetch_funds_with(only_young_filter_activated).length).to eq 1
  end

  scenario 'with only elderly filter activated' do
    expect(fetch_funds_with(only_elderly_filter_activated).length).to eq 1
  end

  scenario 'with only artisan filter activated' do
    expect(fetch_funds_with(only_artisan_filter_activated).length).to eq 1
  end

  scenario 'with only corner store filter activated' do
    expect(fetch_funds_with(only_corner_store_filter_activated).length).to eq 1
  end

  scenario 'with only college filter activated' do
    expect(fetch_funds_with(only_college_filter_activated).length).to eq 1
  end

  scenario 'with only export filter activated' do
    expect(fetch_funds_with(only_export_filter_activated).length).to eq 1
  end

  scenario 'with only manufacture filter activated' do
    expect(fetch_funds_with(only_manufacture_filter_activated).length).to eq 1
  end

  scenario 'with only native industrial property activated' do
    expect(fetch_funds_with(only_industrial_property_filter_activated).length).to eq 1
  end

  scenario 'with only construction filter activated' do
    expect(fetch_funds_with(only_construction_filter_activated).length).to eq 1
  end

  scenario 'with only turism filter activated' do
    expect(fetch_funds_with(only_turism_filter_activated).length).to eq 1
  end

  scenario 'with only access to it filter activated' do
    expect(fetch_funds_with(only_access_to_it_filter_activated).length).to eq 1
  end

  scenario 'with only native filter activated' do
    expect(fetch_funds_with(only_native_filter_activated).length).to eq 1
  end

  scenario 'with only tic filter activated' do
    expect(fetch_funds_with(only_tic_filter_activated).length).to eq 1
  end

  scenario 'with mixed filters activated' do
    expect(fetch_funds_with(mixed_filters_activated).length).to eq 3
  end

  scenario 'with mixed filters activated but there are no funds that fullfill this case' do
    expect(fetch_funds_with(mixed_filters_but_there_are_no_funds).length).to eq 2
  end

  # test helper methods

  def only_women_filter_activated
    fetch_new_filters_with_true_values("MUJ")
  end

  def only_rural_filter_activated
    fetch_new_filters_with_true_values("RUR")
  end

  def only_young_filter_activated
    fetch_new_filters_with_true_values("JOV")
  end

  def only_elderly_filter_activated
    fetch_new_filters_with_true_values("TER")
  end

  def only_artisan_filter_activated
    fetch_new_filters_with_true_values("ART")
  end

  def only_corner_store_filter_activated
    fetch_new_filters_with_true_values("TAB")
  end

  def only_college_filter_activated
    fetch_new_filters_with_true_values("BAC")
  end

  def only_export_filter_activated
    fetch_new_filters_with_true_values("EXP")
  end

  def only_manufacture_filter_activated
    fetch_new_filters_with_true_values("MAN")
  end

  def only_industrial_property_filter_activated
    fetch_new_filters_with_true_values("PIN")
  end

  def only_construction_filter_activated
    fetch_new_filters_with_true_values("CON")
  end

  def only_turism_filter_activated
    fetch_new_filters_with_true_values("TUR")
  end

  def only_access_to_it_filter_activated
    fetch_new_filters_with_true_values("ATI")
  end

  def only_native_filter_activated
    fetch_new_filters_with_true_values("IND")
  end

  def only_tic_filter_activated
    fetch_new_filters_with_true_values("TIC")
  end

  def mixed_filters_activated
    fetch_new_filters_with_true_values(["MUJ", "IND"])
  end

  def mixed_filters_but_there_are_no_funds
    fetch_new_filters_with_true_values(["TUR", "IND"])
  end

  # main helper methods

  def fetch_new_filters_with_true_values(filters)
    new_filters = filters_not_activated
    if filters.kind_of?(Array)
      filters.each { |f| new_filters[f] = true }
    else
      new_filters[filters] = true
    end
    new_filters
  end

  def fetch_funds_with(filters)
    Fund.search_with_profile_and_filters(category, filters, priority_params, delegation_params)
  end

  def filter_params
    submitted_questionary["filters"]
  end

  def priority_params
    submitted_questionary["priorities"]
  end

  def delegation_params
    submitted_questionary["delegations"]
  end

  def submitted_questionary
   {
     "answers"=>[
        {
           "identifier"=>"1.B Características Sociodemográficas",
           "next"=>"2.C.1",
           "help"=>"Contesta las siguientes preguntas sobre ti y selecciona la respuesta con la que más te identificas.",
           "grouped"=>true,
           "questions"=>[
              {
                 "id"=>"1.B.1",
                 "title"=>"Edad",
                 "type"=>"number",
                 "body"=>{
                    "minimumValue"=>1,
                    "value"=>35
                 }
              },
              {
                 "id"=>"1.B.2",
                 "title"=>"Sexo",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Hombre"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Mujer"
                       }
                    ]
                 }
              },
              {
                 "id"=>"1.B.3",
                 "title"=>"Nivel de estudios",
                 "type"=>"select",
                 "body"=>{
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Ninguno"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Primaria"
                       },
                       {
                          "value"=>"c",
                          "label"=>"Secundaria / Secundaria Técnica"
                       },
                       {
                          "value"=>"d",
                          "label"=>"Bachillerato / Preparatoria / Preparatoria Técnica"
                       },
                       {
                          "value"=>"e",
                          "label"=>"Licenciatura / Ingeniería"
                       },
                       {
                          "value"=>"f",
                          "label"=>"Maestría ó superior"
                       }
                    ],
                    "selected_value"=>{
                       "value"=>"a",
                       "label"=>"Ninguno"
                    }
                 }
              },
              {
                 "id"=>"1.B.4",
                 "title"=>"¿Resides en el D.F.?",
                 "type"=>"select",
                 "nested"=>true,
                 "body"=>{
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"No, vivo en otra entidad"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Sí, vivo en el D.F.",
                          "question"=>{
                             "title"=>"Delegación",
                             "help"=>"Selecciona uno de los valores",
                             "type"=>"select",
                             "body"=>{
                                "options"=>[
                                   {
                                      "value"=>"a",
                                      "label"=>"Álvaro Obregón"
                                   },
                                   {
                                      "value"=>"b",
                                      "label"=>"Azcapotzalco"
                                   },
                                   {
                                      "value"=>"c",
                                      "label"=>"Benito Juárez"
                                   },
                                   {
                                      "value"=>"d",
                                      "label"=>"Coyoacán"
                                   },
                                   {
                                      "value"=>"e",
                                      "label"=>"Cuajimalpa de Morelos"
                                   },
                                   {
                                      "value"=>"f",
                                      "label"=>"Cuauhtémoc"
                                   },
                                   {
                                      "value"=>"g",
                                      "label"=>"Gustavo A. Madero"
                                   },
                                   {
                                      "value"=>"h",
                                      "label"=>"Iztacalco"
                                   },
                                   {
                                      "value"=>"i",
                                      "label"=>"Iztapalapa"
                                   },
                                   {
                                      "value"=>"j",
                                      "label"=>"Magdalena Contreras"
                                   },
                                   {
                                      "value"=>"k",
                                      "label"=>"Miguel Hidalgo"
                                   },
                                   {
                                      "value"=>"l",
                                      "label"=>"Milpa Alta"
                                   },
                                   {
                                      "value"=>"m",
                                      "label"=>"Tláhuac"
                                   },
                                   {
                                      "value"=>"n",
                                      "label"=>"Tlalpan"
                                   },
                                   {
                                      "value"=>"o",
                                      "label"=>"Venustiano Carranza"
                                   },
                                   {
                                      "value"=>"p",
                                      "label"=>"Xochimilco"
                                   },
                                   {
                                      "value"=>"q",
                                      "label"=>"Fuera del DF"
                                   }
                                ]
                             }
                          }
                       }
                    ],
                    "selected_value"=>{
                       "value"=>"a",
                       "label"=>"No, vivo en otra entidad"
                    }
                 }
              },
              {
                 "id"=>"1.B.5",
                 "title"=>"¿El negocio ya está en operación?",
                 "type"=>"select",
                 "body"=>{
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"No, aún no está operando"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Sí, ya está en operación",
                          "question"=>{
                             "title"=>"Delegación",
                             "help"=>"Selecciona uno de los valores",
                             "type"=>"select",
                             "body"=>{
                                "options"=>[
                                   {
                                      "value"=>"a",
                                      "label"=>"Álvaro Obregón"
                                   },
                                   {
                                      "value"=>"b",
                                      "label"=>"Azcapotzalco"
                                   },
                                   {
                                      "value"=>"c",
                                      "label"=>"Benito Juárez"
                                   },
                                   {
                                      "value"=>"d",
                                      "label"=>"Coyoacán"
                                   },
                                   {
                                      "value"=>"e",
                                      "label"=>"Cuajimalpa de Morelos"
                                   },
                                   {
                                      "value"=>"f",
                                      "label"=>"Cuauhtémoc"
                                   },
                                   {
                                      "value"=>"g",
                                      "label"=>"Gustavo A. Madero"
                                   },
                                   {
                                      "value"=>"h",
                                      "label"=>"Iztacalco"
                                   },
                                   {
                                      "value"=>"i",
                                      "label"=>"Iztapalapa"
                                   },
                                   {
                                      "value"=>"j",
                                      "label"=>"Magdalena Contreras"
                                   },
                                   {
                                      "value"=>"k",
                                      "label"=>"Miguel Hidalgo"
                                   },
                                   {
                                      "value"=>"l",
                                      "label"=>"Milpa Alta"
                                   },
                                   {
                                      "value"=>"m",
                                      "label"=>"Tláhuac"
                                   },
                                   {
                                      "value"=>"n",
                                      "label"=>"Tlalpan"
                                   },
                                   {
                                      "value"=>"o",
                                      "label"=>"Venustiano Carranza"
                                   },
                                   {
                                      "value"=>"p",
                                      "label"=>"Xochimilco"
                                   },
                                   {
                                      "value"=>"q",
                                      "label"=>"Fuera del DF"
                                   }
                                ]
                             }
                          },
                          "change_path"=>"2.A.1"
                       }
                    ],
                    "selected_value"=>{
                       "value"=>"a",
                       "label"=>"No, aún no está operando"
                    }
                 }
              },
              {
                 "id"=>"1.B.6",
                 "title"=>"¿Hablas algún dialecto o lengua indígena?",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"No"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Sí"
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.2",
           "questions"=>[
              {
                 "id"=>"2.C.1",
                 "title"=>"La razón PRINCIPAL por la que quiero llevar a cabo este proyecto es porque...",
                 "help"=>"De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                 "type"=>"prioritize",
                 "body"=>{
                    "options"=>[
                       {
                          "priority"=>3,
                          "value"=>"a",
                          "label"=>"No hay suficientes oportunidades laborales para encontrar un empleo."
                       },
                       {
                          "priority"=>2,
                          "value"=>"b",
                          "label"=>"Prefiero emprender mi propio proyecto que ser empleado."
                       },
                       {
                          "priority"=>1,
                          "value"=>"c",
                          "label"=>"Quiero generar un impacto positivo en la sociedad y/o medio ambiente."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"d",
                          "label"=>"Quiero desarrollar mi creatividad."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"e",
                          "label"=>"Quiero trabajar en algo agradable y que me de tiempo libre."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"f",
                          "label"=>"Tengo una idea o proyecto muy innovador que será muy rentable y tendré grandes ganancias."
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.3",
           "questions"=>[
              {
                 "id"=>"2.C.2",
                 "title"=>"El PRINCIPAL objetivo de mi empresa será...",
                 "help"=>"De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                 "type"=>"prioritize",
                 "body"=>{
                    "options"=>[
                       {
                          "priority"=>3,
                          "value"=>"a",
                          "label"=>"Obtener ingresos para solventar los gastos básicos personales/familiares."
                       },
                       {
                          "priority"=>2,
                          "value"=>"b",
                          "label"=>"Tener mi propio negocio sin depender de un tercero."
                       },
                       {
                          "priority"=>1,
                          "value"=>"c",
                          "label"=>"Que yo sea independiente y tenga tiempo para mí."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"d",
                          "label"=>"Exponer un proyecto artístico."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"e",
                          "label"=>"Generar un impacto positivo en la población y/o el medio ambiente."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"f",
                          "label"=>"Realizar un proyecto empresarial muy innovador, exitoso y con grandes ganancias."
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.4",
           "questions"=>[
              {
                 "id"=>"2.C.3",
                 "title"=>"¿Cuál de las siguientes frases describe mejor tu situación laboral-empresarial actual?",
                 "help"=>"Selecciona la respuesta con la que más te identificas.",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"NO tengo empleo y NO tengo otro negocio."
                       },
                       {
                          "value"=>"b",
                          "label"=>"SÍ tengo empleo y NO tengo otro negocio."
                       },
                       {
                          "value"=>"c",
                          "label"=>"NO tengo empleo y SÍ tengo otro negocio."
                       },
                       {
                          "value"=>"d",
                          "label"=>"SÍ tengo empleo y SÍ tengo otro negocio."
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.5",
           "questions"=>[
              {
                 "id"=>"2.C.4",
                 "title"=>"Imagina que ya tienes tu negocio con el cual las ganancias son igual a 100, si te ofrecieran un empleo con un salario de 110 ¿qué preferirías?",
                 "help"=>"Selecciona la respuesta con la que más te identificas.",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Aceptar el empleo y dejar de trabajar en mi empresa."
                       },
                       {
                          "value"=>"b",
                          "label"=>"No aceptar el empleo y seguir con mi empresa."
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.6",
           "questions"=>[
              {
                 "id"=>"2.C.5",
                 "title"=>"¿Tu negocio pertenecerá a alguno de los siguientes sectores?",
                 "help"=>"Selecciona la respuesta con la que más te identificas de la lista desplegable del recuadro.",
                 "type"=>"select",
                 "body"=>{
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Industrias manufactureras"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Comercio"
                       },
                       {
                          "value"=>"c",
                          "label"=>"Preparación de alimentos y bebidas (restaurantes, puestos y similares) y hoteles"
                       },
                       {
                          "value"=>"d",
                          "label"=>"Servicios profesionales, técnicos, corporativos, financieros, inmobiliarios, educativos, médicos, de apoyo a negocios y manejo de desechos"
                       },
                       {
                          "value"=>"e",
                          "label"=>"Culturales y de esparcimiento, deportivos y recreativos"
                       },
                       {
                          "value"=>"f",
                          "label"=>"Organizaciones con fines altruistas y medio ambientales"
                       },
                       {
                          "value"=>"g",
                          "label"=>"Agricultura, ganadería, aprovechamiento forestal y pesca"
                       },
                       {
                          "value"=>"h",
                          "label"=>"Tecnologías de la información y la comunicación"
                       },
                       {
                          "value"=>"i",
                          "label"=>"Otros"
                       },
                       {
                          "value"=>"j",
                          "label"=>"No sé"
                       }
                    ],
                    "selected_value"=>{
                       "value"=>"a",
                       "label"=>"Industrias manufactureras"
                    }
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"2.C.7",
           "questions"=>[
              {
                 "id"=>"2.C.6",
                 "title"=>"¿El producto/servicio que se ofrecerá será?",
                 "help"=>"Selecciona la respuesta con la que más te identificas.",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Será muy nuevo y distinto a lo que ya existe y/o el proceso de elaboración será muy innovador."
                       },
                       {
                          "value"=>"b",
                          "label"=>"En algunas características será diferente a los de mi competencia o lo voy a ofrecer a personas que no lo conocen o que no tienen acceso a él."
                       },
                       {
                          "value"=>"c",
                          "label"=>"Ya existe y es ofrecido por otros."
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"2.C Perfiles",
           "grouped"=>false,
           "next"=>"4.C",
           "questions"=>[
              {
                 "id"=>"2.C.7",
                 "title"=>"¿Cuál es el nivel de respaldo que dará la tecnología en tu negocio?",
                 "help"=>"Selecciona la respuesta con la que más te identificas.",
                 "type"=>"radio",
                 "body"=>{
                    "selected_value"=>"a",
                    "options"=>[
                       {
                          "value"=>"a",
                          "label"=>"Ninguna, no se necesitará / no tengo recursos para eso"
                       },
                       {
                          "value"=>"b",
                          "label"=>"Servirá de apoyo para algunos procesos administrativos (procesamiento de nómina, costos, gastos, ventas, etc.)"
                       },
                       {
                          "value"=>"c",
                          "label"=>"Jugará un papel importante en la empresa (en el proceso de elaboración del producto o servicio que ofrece la empresa, además de apoyar la gestión y administración de la empresa)"
                       }
                    ]
                 }
              }
           ]
        },
        {
           "identifier"=>"4.C Prioridades / Problemas",
           "grouped"=>false,
           "questions"=>[
              {
                 "id"=>"4.C.1",
                 "title"=>"De la siguiente lista selecciona la (o las) prioridad(es) actual(es) que tenga tu empresa. Puedes escoger de 1 a 3 prioridades.",
                 "help"=>"De la siguiente lista selecciona y ordena las 3 prioridades con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                 "type"=>"prioritize",
                 "body"=>{
                    "options"=>[
                       {
                          "priority"=>3,
                          "value"=>"a",
                          "label"=>"Conseguir financiamiento / Acceder a instrumentos financieros."
                       },
                       {
                          "priority"=>2,
                          "value"=>"b",
                          "label"=>"Diseñar o mejorar mi plan de negocios."
                       },
                       {
                          "priority"=>1,
                          "value"=>"c",
                          "label"=>"Incrementar la productividad / Mejorar procesos."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"d",
                          "label"=>"Entrar a la formalidad."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"e",
                          "label"=>"Capacitar al personal de la empresa."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"f",
                          "label"=>"Expandir mi mercado."
                       },
                       {
                          "priority"=>nil,
                          "value"=>"g",
                          "label"=>"Incorporar tecnología e innovación."
                       }
                    ]
                 }
              }
           ]
        }
     ],

     "filters"=>{
        "MUJ"=>false,
        "RUR"=>false,
        "JOV"=>false,
        "TER"=>false,
        "ART"=>false,
        "TAB"=>false,
        "BAC"=>false,
        "EXP"=>false,
        "MAN"=>false,
        "PIN"=>false,
        "CON"=>false,
        "TUR"=>false,
        "ATI"=>false,
        "IND"=>false,
        "TIC"=>false
     },
     "priorities"=>[
        {
           "priority"=>3,
           "value"=>"a",
           "label"=>"Conseguir financiamiento / Acceder a instrumentos financieros."
        },
        {
           "priority"=>2,
           "value"=>"b",
           "label"=>"Diseñar o mejorar mi plan de negocios."
        },
        {
           "priority"=>1,
           "value"=>"c",
           "label"=>"Incrementar la productividad / Mejorar procesos."
        }
     ],
     "delegations"=>{
        "home"=>"",
        "business"=>""
     },
     "profile"=>{
        "answers"=>[
           {
              "identifier"=>"1.B Características Sociodemográficas",
              "next"=>"2.C.1",
              "help"=>"Contesta las siguientes preguntas sobre ti y selecciona la respuesta con la que más te identificas.",
              "grouped"=>true,
              "questions"=>[
                 {
                    "id"=>"1.B.1",
                    "title"=>"Edad",
                    "type"=>"number",
                    "body"=>{
                       "minimumValue"=>1,
                       "value"=>35
                    }
                 },
                 {
                    "id"=>"1.B.2",
                    "title"=>"Sexo",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Hombre"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Mujer"
                          }
                       ]
                    }
                 },
                 {
                    "id"=>"1.B.3",
                    "title"=>"Nivel de estudios",
                    "type"=>"select",
                    "body"=>{
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Ninguno"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Primaria"
                          },
                          {
                             "value"=>"c",
                             "label"=>"Secundaria / Secundaria Técnica"
                          },
                          {
                             "value"=>"d",
                             "label"=>"Bachillerato / Preparatoria / Preparatoria Técnica"
                          },
                          {
                             "value"=>"e",
                             "label"=>"Licenciatura / Ingeniería"
                          },
                          {
                             "value"=>"f",
                             "label"=>"Maestría ó superior"
                          }
                       ],
                       "selected_value"=>{
                          "value"=>"a",
                          "label"=>"Ninguno"
                       }
                    }
                 },
                 {
                    "id"=>"1.B.4",
                    "title"=>"¿Resides en el D.F.?",
                    "type"=>"select",
                    "nested"=>true,
                    "body"=>{
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"No, vivo en otra entidad"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Sí, vivo en el D.F.",
                             "question"=>{
                                "title"=>"Delegación",
                                "help"=>"Selecciona uno de los valores",
                                "type"=>"select",
                                "body"=>{
                                   "options"=>[
                                      {
                                         "value"=>"a",
                                         "label"=>"Álvaro Obregón"
                                      },
                                      {
                                         "value"=>"b",
                                         "label"=>"Azcapotzalco"
                                      },
                                      {
                                         "value"=>"c",
                                         "label"=>"Benito Juárez"
                                      },
                                      {
                                         "value"=>"d",
                                         "label"=>"Coyoacán"
                                      },
                                      {
                                         "value"=>"e",
                                         "label"=>"Cuajimalpa de Morelos"
                                      },
                                      {
                                         "value"=>"f",
                                         "label"=>"Cuauhtémoc"
                                      },
                                      {
                                         "value"=>"g",
                                         "label"=>"Gustavo A. Madero"
                                      },
                                      {
                                         "value"=>"h",
                                         "label"=>"Iztacalco"
                                      },
                                      {
                                         "value"=>"i",
                                         "label"=>"Iztapalapa"
                                      },
                                      {
                                         "value"=>"j",
                                         "label"=>"Magdalena Contreras"
                                      },
                                      {
                                         "value"=>"k",
                                         "label"=>"Miguel Hidalgo"
                                      },
                                      {
                                         "value"=>"l",
                                         "label"=>"Milpa Alta"
                                      },
                                      {
                                         "value"=>"m",
                                         "label"=>"Tláhuac"
                                      },
                                      {
                                         "value"=>"n",
                                         "label"=>"Tlalpan"
                                      },
                                      {
                                         "value"=>"o",
                                         "label"=>"Venustiano Carranza"
                                      },
                                      {
                                         "value"=>"p",
                                         "label"=>"Xochimilco"
                                      },
                                      {
                                         "value"=>"q",
                                         "label"=>"Fuera del DF"
                                      }
                                   ]
                                }
                             }
                          }
                       ],
                       "selected_value"=>{
                          "value"=>"a",
                          "label"=>"No, vivo en otra entidad"
                       }
                    }
                 },
                 {
                    "id"=>"1.B.5",
                    "title"=>"¿El negocio ya está en operación?",
                    "type"=>"select",
                    "body"=>{
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"No, aún no está operando"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Sí, ya está en operación",
                             "question"=>{
                                "title"=>"Delegación",
                                "help"=>"Selecciona uno de los valores",
                                "type"=>"select",
                                "body"=>{
                                   "options"=>[
                                      {
                                         "value"=>"a",
                                         "label"=>"Álvaro Obregón"
                                      },
                                      {
                                         "value"=>"b",
                                         "label"=>"Azcapotzalco"
                                      },
                                      {
                                         "value"=>"c",
                                         "label"=>"Benito Juárez"
                                      },
                                      {
                                         "value"=>"d",
                                         "label"=>"Coyoacán"
                                      },
                                      {
                                         "value"=>"e",
                                         "label"=>"Cuajimalpa de Morelos"
                                      },
                                      {
                                         "value"=>"f",
                                         "label"=>"Cuauhtémoc"
                                      },
                                      {
                                         "value"=>"g",
                                         "label"=>"Gustavo A. Madero"
                                      },
                                      {
                                         "value"=>"h",
                                         "label"=>"Iztacalco"
                                      },
                                      {
                                         "value"=>"i",
                                         "label"=>"Iztapalapa"
                                      },
                                      {
                                         "value"=>"j",
                                         "label"=>"Magdalena Contreras"
                                      },
                                      {
                                         "value"=>"k",
                                         "label"=>"Miguel Hidalgo"
                                      },
                                      {
                                         "value"=>"l",
                                         "label"=>"Milpa Alta"
                                      },
                                      {
                                         "value"=>"m",
                                         "label"=>"Tláhuac"
                                      },
                                      {
                                         "value"=>"n",
                                         "label"=>"Tlalpan"
                                      },
                                      {
                                         "value"=>"o",
                                         "label"=>"Venustiano Carranza"
                                      },
                                      {
                                         "value"=>"p",
                                         "label"=>"Xochimilco"
                                      },
                                      {
                                         "value"=>"q",
                                         "label"=>"Fuera del DF"
                                      }
                                   ]
                                }
                             },
                             "change_path"=>"2.A.1"
                          }
                       ],
                       "selected_value"=>{
                          "value"=>"a",
                          "label"=>"No, aún no está operando"
                       }
                    }
                 },
                 {
                    "id"=>"1.B.6",
                    "title"=>"¿Hablas algún dialecto o lengua indígena?",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"No"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Sí"
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.2",
              "questions"=>[
                 {
                    "id"=>"2.C.1",
                    "title"=>"La razón PRINCIPAL por la que quiero llevar a cabo este proyecto es porque...",
                    "help"=>"De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                    "type"=>"prioritize",
                    "body"=>{
                       "options"=>[
                          {
                             "priority"=>3,
                             "value"=>"a",
                             "label"=>"No hay suficientes oportunidades laborales para encontrar un empleo."
                          },
                          {
                             "priority"=>2,
                             "value"=>"b",
                             "label"=>"Prefiero emprender mi propio proyecto que ser empleado."
                          },
                          {
                             "priority"=>1,
                             "value"=>"c",
                             "label"=>"Quiero generar un impacto positivo en la sociedad y/o medio ambiente."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"d",
                             "label"=>"Quiero desarrollar mi creatividad."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"e",
                             "label"=>"Quiero trabajar en algo agradable y que me de tiempo libre."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"f",
                             "label"=>"Tengo una idea o proyecto muy innovador que será muy rentable y tendré grandes ganancias."
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.3",
              "questions"=>[
                 {
                    "id"=>"2.C.2",
                    "title"=>"El PRINCIPAL objetivo de mi empresa será...",
                    "help"=>"De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                    "type"=>"prioritize",
                    "body"=>{
                       "options"=>[
                          {
                             "priority"=>3,
                             "value"=>"a",
                             "label"=>"Obtener ingresos para solventar los gastos básicos personales/familiares."
                          },
                          {
                             "priority"=>2,
                             "value"=>"b",
                             "label"=>"Tener mi propio negocio sin depender de un tercero."
                          },
                          {
                             "priority"=>1,
                             "value"=>"c",
                             "label"=>"Que yo sea independiente y tenga tiempo para mí."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"d",
                             "label"=>"Exponer un proyecto artístico."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"e",
                             "label"=>"Generar un impacto positivo en la población y/o el medio ambiente."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"f",
                             "label"=>"Realizar un proyecto empresarial muy innovador, exitoso y con grandes ganancias."
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.4",
              "questions"=>[
                 {
                    "id"=>"2.C.3",
                    "title"=>"¿Cuál de las siguientes frases describe mejor tu situación laboral-empresarial actual?",
                    "help"=>"Selecciona la respuesta con la que más te identificas.",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"NO tengo empleo y NO tengo otro negocio."
                          },
                          {
                             "value"=>"b",
                             "label"=>"SÍ tengo empleo y NO tengo otro negocio."
                          },
                          {
                             "value"=>"c",
                             "label"=>"NO tengo empleo y SÍ tengo otro negocio."
                          },
                          {
                             "value"=>"d",
                             "label"=>"SÍ tengo empleo y SÍ tengo otro negocio."
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.5",
              "questions"=>[
                 {
                    "id"=>"2.C.4",
                    "title"=>"Imagina que ya tienes tu negocio con el cual las ganancias son igual a 100, si te ofrecieran un empleo con un salario de 110 ¿qué preferirías?",
                    "help"=>"Selecciona la respuesta con la que más te identificas.",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Aceptar el empleo y dejar de trabajar en mi empresa."
                          },
                          {
                             "value"=>"b",
                             "label"=>"No aceptar el empleo y seguir con mi empresa."
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.6",
              "questions"=>[
                 {
                    "id"=>"2.C.5",
                    "title"=>"¿Tu negocio pertenecerá a alguno de los siguientes sectores?",
                    "help"=>"Selecciona la respuesta con la que más te identificas de la lista desplegable del recuadro.",
                    "type"=>"select",
                    "body"=>{
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Industrias manufactureras"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Comercio"
                          },
                          {
                             "value"=>"c",
                             "label"=>"Preparación de alimentos y bebidas (restaurantes, puestos y similares) y hoteles"
                          },
                          {
                             "value"=>"d",
                             "label"=>"Servicios profesionales, técnicos, corporativos, financieros, inmobiliarios, educativos, médicos, de apoyo a negocios y manejo de desechos"
                          },
                          {
                             "value"=>"e",
                             "label"=>"Culturales y de esparcimiento, deportivos y recreativos"
                          },
                          {
                             "value"=>"f",
                             "label"=>"Organizaciones con fines altruistas y medio ambientales"
                          },
                          {
                             "value"=>"g",
                             "label"=>"Agricultura, ganadería, aprovechamiento forestal y pesca"
                          },
                          {
                             "value"=>"h",
                             "label"=>"Tecnologías de la información y la comunicación"
                          },
                          {
                             "value"=>"i",
                             "label"=>"Otros"
                          },
                          {
                             "value"=>"j",
                             "label"=>"No sé"
                          }
                       ],
                       "selected_value"=>{
                          "value"=>"a",
                          "label"=>"Industrias manufactureras"
                       }
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"2.C.7",
              "questions"=>[
                 {
                    "id"=>"2.C.6",
                    "title"=>"¿El producto/servicio que se ofrecerá será?",
                    "help"=>"Selecciona la respuesta con la que más te identificas.",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Será muy nuevo y distinto a lo que ya existe y/o el proceso de elaboración será muy innovador."
                          },
                          {
                             "value"=>"b",
                             "label"=>"En algunas características será diferente a los de mi competencia o lo voy a ofrecer a personas que no lo conocen o que no tienen acceso a él."
                          },
                          {
                             "value"=>"c",
                             "label"=>"Ya existe y es ofrecido por otros."
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"2.C Perfiles",
              "grouped"=>false,
              "next"=>"4.C",
              "questions"=>[
                 {
                    "id"=>"2.C.7",
                    "title"=>"¿Cuál es el nivel de respaldo que dará la tecnología en tu negocio?",
                    "help"=>"Selecciona la respuesta con la que más te identificas.",
                    "type"=>"radio",
                    "body"=>{
                       "selected_value"=>"a",
                       "options"=>[
                          {
                             "value"=>"a",
                             "label"=>"Ninguna, no se necesitará / no tengo recursos para eso"
                          },
                          {
                             "value"=>"b",
                             "label"=>"Servirá de apoyo para algunos procesos administrativos (procesamiento de nómina, costos, gastos, ventas, etc.)"
                          },
                          {
                             "value"=>"c",
                             "label"=>"Jugará un papel importante en la empresa (en el proceso de elaboración del producto o servicio que ofrece la empresa, además de apoyar la gestión y administración de la empresa)"
                          }
                       ]
                    }
                 }
              ]
           },
           {
              "identifier"=>"4.C Prioridades / Problemas",
              "grouped"=>false,
              "questions"=>[
                 {
                    "id"=>"4.C.1",
                    "title"=>"De la siguiente lista selecciona la (o las) prioridad(es) actual(es) que tenga tu empresa. Puedes escoger de 1 a 3 prioridades.",
                    "help"=>"De la siguiente lista selecciona y ordena las 3 prioridades con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.",
                    "type"=>"prioritize",
                    "body"=>{
                       "options"=>[
                          {
                             "priority"=>3,
                             "value"=>"a",
                             "label"=>"Conseguir financiamiento / Acceder a instrumentos financieros."
                          },
                          {
                             "priority"=>2,
                             "value"=>"b",
                             "label"=>"Diseñar o mejorar mi plan de negocios."
                          },
                          {
                             "priority"=>1,
                             "value"=>"c",
                             "label"=>"Incrementar la productividad / Mejorar procesos."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"d",
                             "label"=>"Entrar a la formalidad."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"e",
                             "label"=>"Capacitar al personal de la empresa."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"f",
                             "label"=>"Expandir mi mercado."
                          },
                          {
                             "priority"=>nil,
                             "value"=>"g",
                             "label"=>"Incorporar tecnología e innovación."
                          }
                       ]
                    }
                 }
              ]
           }
        ],
        "filters"=>{
           "MUJ"=>false,
           "RUR"=>false,
           "JOV"=>false,
           "TER"=>false,
           "ART"=>true,
           "TAB"=>false,
           "BAC"=>false,
           "EXP"=>false,
           "MAN"=>true,
           "PIN"=>true,
           "CON"=>false,
           "TUR"=>false,
           "ATI"=>false,
           "IND"=>false,
           "TIC"=>false
        },
        "priorities"=>[
           {
              "priority"=>3,
              "value"=>"a",
              "label"=>"Conseguir financiamiento / Acceder a instrumentos financieros."
           },
           {
              "priority"=>2,
              "value"=>"b",
              "label"=>"Diseñar o mejorar mi plan de negocios."
           },
           {
              "priority"=>1,
              "value"=>"c",
              "label"=>"Incrementar la productividad / Mejorar procesos."
           }
        ],
        "delegations"=>{
           "home"=>"",
           "business"=>""
        }
     }
    }
  end

  def filters_not_activated
    {
       "MUJ"=>false,
       "RUR"=>false,
       "JOV"=>false,
       "TER"=>false,
       "ART"=>false,
       "TAB"=>false,
       "BAC"=>false,
       "EXP"=>false,
       "MAN"=>false,
       "PIN"=>false,
       "CON"=>false,
       "TUR"=>false,
       "ATI"=>false,
       "IND"=>false,
       "TIC"=>false
    }
  end

  def filters_activated
    {
       "MUJ"=>true,
       "RUR"=>true,
       "JOV"=>true,
       "TER"=>true,
       "ART"=>true,
       "TAB"=>true,
       "BAC"=>true,
       "EXP"=>true,
       "MAN"=>true,
       "PIN"=>true,
       "CON"=>true,
       "TUR"=>true,
       "ATI"=>true,
       "IND"=>true,
       "TIC"=>true
    }
  end
end
