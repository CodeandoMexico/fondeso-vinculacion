'use strict';

angular.module('questionaryApp')
  .service('Questionary', ['$http', function Questionary($http) {

    var delegationQuestion = {
      title    : 'Delegación',
      help     : 'Selecciona uno de los valores',
      type     : 'select',
      body     : {
        options  : [
          {value: 'a', label: 'Álvaro Obregón' },
          {value: 'b', label: 'Azcapotzalco' },
          {value: 'c', label: 'Benito Juárez' },
          {value: 'd', label: 'Coyoacán' },
          {value: 'e', label: 'Cuajimalpa de Morelos' },
          {value: 'f', label: 'Cuauhtémoc' },
          {value: 'g', label: 'Gustavo A. Madero' },
          {value: 'h', label: 'Iztacalco' },
          {value: 'i', label: 'Iztapalapa' },
          {value: 'j', label: 'Magdalena Contreras' },
          {value: 'k', label: 'Miguel Hidalgo' },
          {value: 'l', label: 'Milpa Alta' },
          {value: 'm', label: 'Tláhuac' },
          {value: 'n', label: 'Tlalpan' },
          {value: 'o', label: 'Venustiano Carranza' },
          {value: 'p', label: 'Xochimilco' },
          {value: 'q', label: 'Fuera del DF'}
        ]
      }
    };

    // var baseUrl = 'http://localhost:3000/profile/';
    var baseUrl = 'http://fondeso.herokuapp.com/profile/';
    // var questionaryUrl = 'http://localhost:3000/questionary/';
    var questionaryUrl = 'http://fondeso.herokuapp.com/questionary/';

    var questionary = {
      walkedPath: [],
      walkedPathHasSection: function (lookId, path) {
        var questionarySection = this.sections[lookId];
        for(var sectionId=0; sectionId < path.length; sectionId++){
          if( angular.equals(path[sectionId], questionarySection) ) {
            return true;
          }
        }
        return false;
      },
      saveProgress: function(){
        console.log('guardando progreso');
        var url = questionaryUrl;
        var authenticity_token = angular.element("meta[name='csrf-token']").attr("content");
        var postData = {
          authenticity_token: authenticity_token,
          answers: this.walkedPath
        };

        // console.log(url);
        // console.log(this.walkedPath);
        return $http.post(url, angular.toJson(postData));
      },
      submit: function(answers, filters, priorities, delegations, profiles, tieAnswers) {
        var url = baseUrl + 'submit';

        var postData = {
          answers: answers,
          filters: filters,
          priorities: priorities,
          delegations: delegations,
          profiles: profiles,
          tie: tieAnswers
        };

        return $http.post(url, angular.toJson(postData));
      },
      sections: {
        '1.B': {
          identifier : '1.B Características Sociodemográficas',
          current    : '1.B',
          next       : '2.C.1',
          help       : 'Contesta las siguientes preguntas sobre ti y selecciona la respuesta con la que más te identificas.',
          grouped    : true,
          questions : [
            {
              id     : '1.B.1',
              title  : 'Edad',
              // help   : 'Escribe el valor de la respuesta',
              type   : 'number',
              body   : {
                minimumValue : 1,
                value  : 35,
              }
            },
            {
              id     : '1.B.2',
              title    : 'Sexo',
              // help     : 'Selecciona uno de los valores',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Hombre'},
                  { value: 'b', label: 'Mujer'}
                ]
              }
            },
            {
              id     : '1.B.3',
              title    : 'Nivel de estudios',
              type     : 'select',
              body     : {
                options  : [
                  { value: 'a', label: 'Ninguno' },
                  { value: 'b', label: 'Primaria' },
                  { value: 'c', label: 'Secundaria / Secundaria Técnica' },
                  { value: 'd', label: 'Bachillerato / Preparatoria / Preparatoria Técnica' },
                  { value: 'e', label: 'Licenciatura / Ingeniería' },
                  { value: 'f', label: 'Maestría ó superior' }
                ]
              }
            },
            {
              id     : '1.B.4',
              title    : '¿Resides en el D.F.?',
              // help     : 'Selecciona uno de los valores',
              type     : 'select',
              nested   : true,
              body     : {
                // selected_value    : null,
                options  : [
                  {value: 'a', label: 'No, vivo en otra entidad' },
                  // a question is going to be appended here, in the question property
                  {value: 'b', label: 'Sí, vivo en el D.F.', question: null },
                ]
              }
            },
            {
              id     : '1.B.5',
              title    : '¿El negocio ya está en operación?',
              // help     : 'Selecciona uno de los valores',
              type     : 'select',
              body     : {
                options  : [
                  {value: 'a', label: 'No, aún no está operando'},
                  {value: 'b', label: 'Sí, ya está en operación', question: null, change_path: '2.A.1' }
                ]
              }
            },
            {
              id     : '1.B.6',
              title    : '¿Hablas algún dialecto o lengua indígena?',
              // help     : 'Selecciona uno de los valores',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'No' },
                  { value: 'b', label: 'Sí' }
                ]
              }
            },
          ]
        },
        '2.A.1': {
          identifier : '2.A Perfiles',
          current    : '2.A.1',
          next       : '2.A.2',
          grouped    : false,
          questions : [
            {
              id     : '2.A.1',
              title  : 'La razón principal por la que llevo a cabo este proyecto es porque… ',
              help   : 'De la siguiente lista selecciona y ordena las 3 prioridades con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'No hay suficientes oportunidades laborales para encontrar un empleo.' },
                  { priority: null, value: 'b', label: 'Prefiero emprender mi propio proyecto que ser empleado.' },
                  { priority: null, value: 'c', label: 'Quiero generar un impacto positivo en la sociedad y/o medio ambiente.' },
                  { priority: null, value: 'd', label: 'Quiero desarrollar mi creatividad.' },
                  { priority: null, value: 'e', label: 'Quiero trabajar en algo agradable y que me de tiempo libre.' },
                  { priority: null, value: 'f', label: 'Tengo una idea o proyecto muy innovador que es (o será) muy rentable y tendré grandes ganancias.' },
                ]
              }
            },
          ],
        },
        '2.A.2': {
          identifier : '2.A Perfiles',
          current    : '2.A.2',
          next       : '2.A.3',
          grouped    : false,
          questions : [
            {
              id     : '2.A.2',
              title  : 'El principal objetivo de mi empresa es...',
              help   : 'De la siguiente lista selecciona y ordena las 3 prioridades con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'Obtener ingresos para solventar los gastos básicos personales / familiares.' },
                  { priority: null, value: 'b', label: 'Tener mi propio negocio sin depender de un tercero.' },
                  { priority: null, value: 'c', label: 'Que yo sea independiente y tenga tiempo para mí.' },
                  { priority: null, value: 'd', label: 'Exponer un proyecto artístico.' },
                  { priority: null, value: 'e', label: 'Generar un impacto positivo en la población y/o el medio ambiente.' },
                  { priority: null, value: 'f', label: 'Realizar un proyecto empresarial muy innovador, exitoso y con grandes ganancias.' },
                ]
              }
            },
          ],
        },
        '2.A.3': {
          identifier : '2.A Perfiles',
          current    : '2.A.3',
          next       : '2.A.4',
          grouped    : false,
          questions : [
            {
              id     : '2.A.3',
              title    : '¿Tu negocio pertenece a alguno de los siguientes sectores?',
              help     : 'Selecciona la respuesta con la que más te identificas de la lista desplegable del recuadro.',
              type     : 'select',
              body     : {
                options  : [
                  { value: 'a', label: 'Industrias manufactureras'  },
                  { value: 'b', label: 'Comercio' },
                  { value: 'c', label: 'Preparación de alimentos y bebidas (restaurantes, puestos y similares) y hoteles' },
                  { value: 'd', label: 'Servicios profesionales, técnicos, corporativos, financieros, inmobiliarios, educativos, médicos y de apoyo a negocios' },
                  { value: 'e', label: 'Culturales y de esparcimiento, deportivos y recreativos' },
                  { value: 'f', label: 'Organizaciones con fines altruistas y medio ambientales' },
                  { value: 'g', label: 'Agricultura, ganadería, aprovechamiento forestal y pesca' },
                  { value: 'h', label: 'Tecnologías de la información y la comunicación' },
                  { value: 'i', label: 'Otros' },
                  { value: 'j', label: 'No sé' }
                ]
              }
            },
          ],
        },
        '2.A.4': {
          identifier : '2.A Perfiles',
          current    : '2.A.4',
          next       : '2.A.5',
          grouped    : false,
          questions : [
            {
              id     : '2.A.4',
              title  : '¿Cuántas personas trabajan en la empresa (incluyendo a los dueños)?',
              help   : 'Escribe en el recuadro tu respuesta.',
              type   : 'number',
              body   : {
                minimumValue : 1,
                value  : 1,
              }
            },
          ],
        },
        '2.A.5': {
          identifier : '2.A Perfiles',
          current    : '2.A.5',
          next       : '2.A.6',
          grouped    : false,
          questions : [
            {
              id     : '2.A.5',
              title  : 'Del total de personas que trabajan en la empresa, ¿cuántos son familiares (padres, hijos, abuelos, hermanos, tíos, primos, sobrinos, cuñados) de los dueños? Incluye a los dueños en tu respuesta.',
              help   : 'Escribe en el recuadro tu respuesta.',
              type   : 'number',
              body   : {
                minimumValue : 0,
                value  : 0,
              }
            },
          ],
        },
        '2.A.6': {
          identifier : '2.A Perfiles',
          current    : '2.A.6',
          next       : '2.A.7',
          grouped    : false,
          questions : [
            {
              id     : '2.A.6',
              title    : '¿El producto/servicio que se ofrece es?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Es nuevo y distinto a lo que existe y/o el proceso de elaboración / comercialización es innovador.'},
                  { value: 'b', label: 'En algunas características son diferentes a los de mi competencia o lo ofrezco a personas que no lo tienen.'},
                  { value: 'c', label: 'Ya existe y es ofrecido por otros.'}
                ]
              }
            },
          ],
        },
        '2.A.7': {
          identifier : '2.A Perfiles',
          current    : '2.A.7',
          next       : '2.A.8',
          grouped    : false,
          questions : [
            {
              id     : '2.A.7',
              title    : 'Las siguientes frases describen maneras distintas de obtener ingresos, selecciona la frase con la que más te identificas',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Tengo un ingreso relativamente estable (no importa cuanto dinero) que se caracteriza por un flujo diario (o casi diario) de dinero.' },
                  { value: 'b', label: 'Tengo un ingreso inestable que se caracteriza por un flujo irregular de dinero (por proyecto/por evento/por servicio) con lapsos de tiempo sin ingreso amplios.' },
                ]
              }
            },
          ],
        },
        '2.A.8': {
          identifier : '2.A Perfiles',
          current    : '2.A.8',
          next       : '3.A.1',
          grouped    : false,
          questions : [
            {
              id     : '2.A.8',
              title    : 'Piensa en las ganancias que tiene tu empresa , imagina que ese monto vale 100, si te ofrecieran un empleo con un salario de 110 ¿qué preferirías?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Aceptar el empleo y dejar de trabajar en mi empresa.'},
                  { value: 'b', label: 'No aceptar el empleo y seguir con mi empresa.'}
                ]
              }
            },
          ],
        },
        '3.A.1': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.1',
          next       : '3.A.2',
          questions : [
            {
              id     : '3.A.1',
              title  : '¿Cuántos años lleva este proyecto/negocio en operación?',
              help   : 'Escribe el tiempo en años. Si lleva menos de un año, escribe 1.',
              type   : 'number',
              body   : {
                minimumValue : 1,
                value  : 1,
              }
            },
          ]
        },
        '3.A.2': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.2',
          next       : '3.A.3',
          questions : [
            {
              id     : '3.A.2',
              title  : 'Selecciona las frases que describen el o los lugares en donde vendes/ofreces tu producto y a quiénes va dirigido (puedes seleccionar varias opciones si concuerda con tu perfil)',
              help   : 'Selecciona cada una de las respuestas si te identificas con ellas.',
              type   : 'checkbox',
              body   : {
                options: [
                  { value: 'a', label: 'Se vende/ofrece en una cuadra o colonia de la Ciudad de México.', checked: false },
                  { value: 'b', label: 'Se vende/ofrece en varias colonias de la Ciudad de México.', checked: false },
                  { value: 'c', label: 'Se vende/ofrece fuera de la zona del DF y área metropolitana.', checked: false },
                  { value: 'd', label: 'Se exporta al extranjero.', checked: false },
                  { value: 'e', label: 'Se vende/ofrece o anuncia en internet.', checked: false },
                  { value: 'f', label: 'Se vende/ofrece al publico en general (al consumidor final).', checked: false },
                  { value: 'g', label: 'Se vende/ofrece a empresas que a su vez venden al público u otras empresas.', checked: false },
                  { value: 'h', label: 'Se vende/ofrece al menudeo.', checked: false },
                  { value: 'i', label: 'Se vende/ofrece al mayoreo.', checked: false },
                ]
              }
            },
          ]
        },
        '3.A.3': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.3',
          next       : '3.A.4',
          questions : [
            {
              id     : '3.A.3',
              title    : '¿Cuál de las siguientes frases describe mejor la manera en la que administro mi negocio?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label:  'Llevo personalmente todas las cuentas de mi negocio sin apuntar nada.'},
                  { value: 'b', label:  'Llevo las cuentas de mi negocio a mano, en una libreta en donde apunto los ingresos, gastos, etc.'},
                  { value: 'c', label:  'Llevo las cuentas de mi negocio en Excel o un programa similar.'},
                  { value: 'd', label:  'Hay uno o varios empleados especializados en, o contrato el servicio para, llevar a cabo la contabilidad de la empresa.'}
                ]
              }
            },
          ]
        },
        '3.A.4': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.4',
          next       : '3.A.5',
          questions : [
            {
              id     : '3.A.4',
              title    : '¿Cuál de las siguientes frases describe mejor la toma de decisiones en la empresa?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Todas las decisiones del día a día las toma el dueño(s) de la empresa.'},
                  { value: 'b', label: 'En la empresa, además del dueño(s), hay uno o dos empleados de confianza que toman decisiones sobre la operación del negocio.'},
                  { value: 'c', label: 'En la empresa, además del dueño(s), hay una estructura de decisión mayor a 3 personas.'}
                ]
              }
            },
          ]
        },
        '3.A.5': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.5',
          next       : '3.A.6',
          questions : [
            {
              id     : '3.A.5',
              title    : '¿El negocio tiene RFC (Registro Federal de Contribuyentes)?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Sí'},
                  { value: 'b', label: 'No'}
                ]
              }
            },
          ]
        },
        '3.A.6': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.6',
          next       : '3.A.7',
          questions : [
            {
              id     : '3.A.6',
              title    : '¿Cuál es el nivel de respaldo que da la tecnología en tu negocio?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Ninguna, no se necesita / no tengo recursos'},
                  { value: 'b', label: 'Sirve de apoyo para algunos procesos administrativos (procesamiento de nómina, costos, gastos, ventas, etc.)'},
                  { value: 'c', label: 'Juega un papel clave en el proceso de elaboración/comercialización del producto o servicio que ofrece mi empresa (además de apoyar la gestión y administración de la empresa).'}
                ]
              }
            },
          ]
        },
        '3.A.7': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.7',
          next       : '3.A.8',
          questions : [
            {
              id     : '3.A.7',
              title  : 'Selecciona los insumos con los que cuenta tu negocio o se utilizan para realizar el producto o servicio que ofrece la empresa',
              help   : 'Selecciona cada una de las respuestas si te identificas con ellas.',
              type   : 'checkbox',
              body   : {
                options: [
                  { value: 'a', label: 'Computadora / Laptop / tablet', checked: false },
                  { value: 'b', label: 'Acepta tarjetas de crédito, depósitos o transferencias bancarias como medios de pago u obtención de recursos', checked: false },
                  { value: 'c', label: 'Programa de cómputo especial para realizar el trabajo (diferente a Excel, Power-Point y Word)', checked: false },
                ]
              }
            },
          ]
        },
        '3.A.8': {
          identifier : '3.A Etapas',
          grouped    : false,
          current    : '3.A.8',
          next       : '4.A',
          questions : [
            {
              id     : '3.A.8',
              title    : '¿Alguna vez has obtenido un crédito para tu negocio de una institución bancaria o similar?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Sí'},
                  { value: 'b', label: 'No'}
                ]
              }
            },
          ]
        },
        '4.A': {
          identifier : '4.A Prioridades / Problemas',
          grouped    : false,
          current    : '4.A',
          // next       : '5.A.1',
          questions : [
            {
              id     : '4.A.1',
              title  : 'De la siguiente lista enumera las primeras 3 prioridades actuales que tenga tu empresa. Puedes escoger de 1 a 3 prioridades.',
              help   : 'Escribe el valor de la respuesta',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'Conseguir financiamiento / Acceder a instrumentos financieros.' },
                  { priority: null, value: 'b', label: 'Diseñar o mejorar mi plan de negocios.' },
                  { priority: null, value: 'c', label: 'Incrementar la productividad / Mejorar procesos.' },
                  { priority: null, value: 'd', label: 'Entrar a la formalidad.' },
                  { priority: null, value: 'e', label: 'Contratar personal.' },
                  { priority: null, value: 'f', label: 'Capacitar al personal de la empresa.' },
                  { priority: null, value: 'g', label: 'Expandir mi mercado.' },
                  { priority: null, value: 'h', label: 'Incorporar tecnología e innovación.' },

                ]
              }
            }
          ]
        },
        '2.C.1': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.1',
          next       : '2.C.2',
          questions : [
            {
              id     : '2.C.1',
              title  : 'La razón PRINCIPAL por la que quiero llevar a cabo este proyecto es porque...',
              help   : 'De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'No hay suficientes oportunidades laborales para encontrar un empleo.' },
                  { priority: null, value: 'b', label: 'Prefiero emprender mi propio proyecto que ser empleado.' },
                  { priority: null, value: 'c', label: 'Quiero generar un impacto positivo en la sociedad y/o medio ambiente.' },
                  { priority: null, value: 'd', label: 'Quiero desarrollar mi creatividad.' },
                  { priority: null, value: 'e', label: 'Quiero trabajar en algo agradable y que me de tiempo libre.' },
                  { priority: null, value: 'f', label: 'Tengo una idea o proyecto muy innovador que será muy rentable y tendré grandes ganancias.' },
                ]
              }
            },
          ]
        },
        '2.C.2': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.2',
          next: '2.C.3',
          questions : [
            {
              id     : '2.C.2',
              title  : 'El PRINCIPAL objetivo de mi empresa será...',
              help   : 'De la siguiente lista selecciona y ordena las 3 frases con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'Obtener ingresos para solventar los gastos básicos personales/familiares.' },
                  { priority: null, value: 'b', label: 'Tener mi propio negocio sin depender de un tercero.' },
                  { priority: null, value: 'c', label: 'Que yo sea independiente y tenga tiempo para mí.' },
                  { priority: null, value: 'd', label: 'Exponer un proyecto artístico.' },
                  { priority: null, value: 'e', label: 'Generar un impacto positivo en la población y/o el medio ambiente.' },
                  { priority: null, value: 'f', label: 'Realizar un proyecto empresarial muy innovador, exitoso y con grandes ganancias.' },
                ]
              }
            },
          ]
        },
        '2.C.3': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.3',
          next       : '2.C.4',
          questions : [
            {
              id     : '2.C.3',
              title    : '¿Cuál de las siguientes frases describe mejor tu situación laboral-empresarial actual?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'NO tengo empleo y NO tengo otro negocio.' },
                  { value: 'b', label: 'SÍ tengo empleo y NO tengo otro negocio.' },
                  { value: 'c', label: 'NO tengo empleo y SÍ tengo otro negocio.' },
                  { value: 'd', label: 'SÍ tengo empleo y SÍ tengo otro negocio.' }
                ]
              }
            },
          ]
        },
        '2.C.4': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.4',
          next: '2.C.5',
          questions : [
            {
              id     : '2.C.4',
              title    : 'Imagina que ya tienes tu negocio con el cual las ganancias son igual a 100, si te ofrecieran un empleo con un salario de 110 ¿qué preferirías?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Aceptar el empleo y dejar de trabajar en mi empresa.' },
                  { value: 'b', label: 'No aceptar el empleo y seguir con mi empresa.' }
                ]
              }
            },
          ]
        },
        '2.C.5': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.5',
          next: '2.C.6',
          questions : [
            {
              id     : '2.C.5',
              title    : '¿Tu negocio pertenecerá a alguno de los siguientes sectores?',
              help     : 'Selecciona la respuesta con la que más te identificas de la lista desplegable del recuadro.',
              type     : 'select',
              body     : {
                // selected_value    : 'Industrias manufactureras',
                options  : [
                  { value: 'a', label: 'Industrias manufactureras' },
                  { value: 'b', label: 'Comercio' },
                  { value: 'c', label: 'Preparación de alimentos y bebidas (restaurantes, puestos y similares) y hoteles' },
                  { value: 'd', label: 'Servicios profesionales, técnicos, corporativos, financieros, inmobiliarios, educativos, médicos, de apoyo a negocios y manejo de desechos' },
                  { value: 'e', label: 'Culturales y de esparcimiento, deportivos y recreativos' },
                  { value: 'f', label: 'Organizaciones con fines altruistas y medio ambientales' },
                  { value: 'g', label: 'Agricultura, ganadería, aprovechamiento forestal y pesca' },
                  { value: 'h', label: 'Tecnologías de la información y la comunicación' },
                  { value: 'i', label: 'Otros' },
                  { value: 'j', label: 'No sé' }
                ]
              }
            },
          ]
        },
        '2.C.6': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.6',
          next: '2.C.7',
          questions : [
            {
              id     : '2.C.6',
              title    : '¿El producto/servicio que se ofrecerá será?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value:'a', label: 'Será muy nuevo y distinto a lo que ya existe y/o el proceso de elaboración será muy innovador.' },
                  { value:'b', label: 'En algunas características será diferente a los de mi competencia o lo voy a ofrecer a personas que no lo conocen o que no tienen acceso a él.' },
                  { value:'c', label: 'Ya existe y es ofrecido por otros.' }
                ]
              }
            },
          ]
        },
        '2.C.7': {
          identifier : '2.C Perfiles',
          grouped    : false,
          current    : '2.C.7',
          next: '4.C',
          questions : [
            {
              id     : '2.C.7',
              title    : '¿Cuál es el nivel de respaldo que dará la tecnología en tu negocio?',
              help     : 'Selecciona la respuesta con la que más te identificas.',
              type     : 'radio',
              body     : {
                selected_value    : 'a',
                options  : [
                  { value: 'a', label: 'Ninguna, no se necesitará / no tengo recursos para eso' },
                  { value: 'b', label: 'Servirá de apoyo para algunos procesos administrativos (procesamiento de nómina, costos, gastos, ventas, etc.)' },
                  { value: 'c', label: 'Jugará un papel importante en la empresa (en el proceso de elaboración del producto o servicio que ofrece la empresa, además de apoyar la gestión y administración de la empresa)' }
                ]
              }
            },
          ]
        },
        '4.C': {
          identifier : '4.C Prioridades / Problemas',
          grouped    : false,
          current    : '4.C',
          // next: '5.C',
          questions : [
            {
              id     : '4.C.1',
              title  : 'De la siguiente lista selecciona la (o las) prioridad(es) actual(es) que tenga tu empresa. Puedes escoger de 1 a 3 prioridades.',
              help   : 'De la siguiente lista selecciona y ordena las 3 prioridades con las que más te identificas. Escoge 1 para la prioridad con la que más te identificas, 2 para la segunda y 3 para la tercera. No puedes repetir el mismo número.',
              type   : 'prioritize',
              body   : {
                options: [
                  { priority: null, value: 'a', label: 'Conseguir financiamiento / Acceder a instrumentos financieros.' },
                  { priority: null, value: 'b', label: 'Diseñar o mejorar mi plan de negocios.' },
                  { priority: null, value: 'c', label: 'Incrementar la productividad / Mejorar procesos.' },
                  { priority: null, value: 'd', label: 'Entrar a la formalidad.' },
                  { priority: null, value: 'e', label: 'Capacitar al personal de la empresa.' },
                  { priority: null, value: 'f', label: 'Expandir mi mercado.' },
                  { priority: null, value: 'g', label: 'Incorporar tecnología e innovación.' },
                ]
              }
            },
          ]
        }
      }
    };

    // appending nesting questions, for testing purposes
    questionary.sections['1.B'].questions[3].body.options[1].question = angular.copy(delegationQuestion);
    questionary.sections['1.B'].questions[4].body.options[1].question = angular.copy(delegationQuestion);

    return questionary;
  }]);
