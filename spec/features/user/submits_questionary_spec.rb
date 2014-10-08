require 'spec_helper'

feature 'When a user submits an answered questionary' do
  attr_reader :category, :fund_for_natives, :fund_for_women, :fund_for_elderly

  before do
    user = FactoryGirl.create :user
    @category = 'necesidad-startup'

    @fund_for_natives = FactoryGirl.create :native_fund
    @fund_for_women = FactoryGirl.create :women_fund
    @fund_for_elderly = FactoryGirl.create :elderly_fund
  end

  scenario 'with all filters turned off it should return a fund' do
    expect(Fund.search_with_profile_and_filters(category, filters_not_activated, priority_params, delegation_params).length).to eq 0
  end

  scenario 'with all filters turned off it should return a fund' do
    expect(Fund.search_with_profile_and_filters(category, filters_activated, priority_params, delegation_params).length).to eq 3
  end


  # def questionary_answers
  #   Fund.search_with_profile_and_filters(category, filters_not_activated, priority_params, delegation_params)
  # end

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
