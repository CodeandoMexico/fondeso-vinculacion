FONDESO_PROFILES = [
  { name: "need-startup", profile_id: "n1" },
  { name: "traditional-startup", profile_id: "t1" },
  { name: "traditional-growing", profile_id: "t2" },
  { name: "traditional-consolidation", profile_id: "t3" },
  { name: "lifestyle-startup", profile_id: "l1" },
  { name: "lifestyle-growing", profile_id: "l2" },
  { name: "lifestyle-consolidation", profile_id: "l3" },
  { name: "cultural-startup", profile_id: "c1" },
  { name: "cultural-growing", profile_id: "c2" },
  { name: "cultural-consolidation", profile_id: "c3" },
  { name: "social-startup", profile_id: "s1" },
  { name: "social-growing", profile_id: "s2" },
  { name: "social-consolidation", profile_id: "s3" },
  { name: "high_impact-startup", profile_id: "h1" },
  { name: "high_impact-growing", profile_id: "h2" },
  { name: "high_impact-consolidation", profile_id: "h3" }
]

FONDESO_QUESTIONS = [
  {
    'question_id' => '2.A.1',
    'type' => 'ordinal',
    'associations' => {
      'positive' => {
        'A' => ['n1'],
        'B' => ['t1', 't2', 't3'],
        'C' => ['s1', 's2', 's3'],
        'D' => ['c1', 'c2', 'c3'],
        'E' => ['l1', 'l2', 'l3'],
        'F' => ['h1', 'h2', 'h3']
      }
    }
  },
  {
    'question_id' => '2.A.2',
    'type' => 'ordinal',
    'associations' => {
      'positive' => {
        'A' => ['n1'],
        'B' => ['t1', 't2', 't3'],
        'C' => ['l1', 'l2', 'l3'],
        'D' => ['c1', 'c2', 'c3'],
        'E' => ['s1', 's2', 's3'],
        'F' => ['h1', 'h2', 'h3']
      }
    }
  },

  {
    'question_id' => '2.A.3',
    'type' => 'unique',
    'associations' => {
      'positive' => {
        'E' => ['c1', 'c2', 'c3'],
        'F' => ['s1', 's2', 's3'],
        'H' => ['h1', 'h2', 'h3']
      },
      'negative' => {
        'A' => ['n1', 'l1', 'l2', 'l3', 'c1', 'c2', 'c3'],
        'B' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
        'C' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
        'D' => ['n1'],
        'E' => ['n1', 't1', 't2', 't3'],
        'F' => ['n1', 't1', 't2', 't3', 'l1', 'l2', 'l3'],
        'G' => ['l1', 'l2', 'l3', 'c1', 'c2', 'c3'],
        'H' => ['n1', 't1', 't2', 't3', 'c1', 'c2', 's1', 's2', 's3']
      }
    }
  },

  {
    'question_id' => '2.A.4',
    'type' => 'unique_with_range_and_sector',
    'associations' => {
      'positive' => {
        { 'range' => 1 } => ['n1', 'l1'],
        { 'range' => 2 } => ['t1', 'l1'],
        { 'range' => 3..5 } => ['t1'],
        { 'range' => 6..10 } => ['t1'],
        { 'range' => 11..30,  'sector' => 'B' } => ['t2'],
        { 'range' => 31..100, 'sector' => 'B' } => ['t2'],
        { 'range' => 11..50,  'except_sector' => 'B' } => ['t2'],
        { 'range' => 51..100, 'except_sector' => 'B' } => ['t2'],
        { 'range' => 100..Float::INFINITY } => ['t3', 'h3']
      },
      'negative' => {
        { 'range' => 1 } => ['t2', 't3', 'l2', 'l3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
        { 'range' => 2 } => ['t2', 't3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
        { 'range' => 3..5 } => ['n1', 't2', 't3', 'c3', 's3', 'h2', 'h3'],
        { 'range' => 6..10 } => ['n1', 't3', 'l1', 'c3', 's3', 'h3'],
        { 'range' => 11..30,  'sector' => 'B' } => ['n1', 't3', 'l1', 'l2', 'l3', 'c1', 's1', 'h1', 'h3'],
        { 'range' => 31..100, 'sector' => 'B' } => ['n1', 't1', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1'],
        { 'range' => 11..50,  'except_sector' => 'B' } => ['n1', 't3', 'l1', 'c1', 's1', 'h1', 'h3'],
        { 'range' => 51..100, 'except_sector' => 'B' } => ['n1', 't1', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1'],
        { 'range' => 100..Float::INFINITY } => ['n1', 't1', 't2', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1', 'h2']
      }
    }
  },

  {
    'question_id' => '2.A.5',
    'type' => 'unique_informative'
  },

  {
    'question_id' => '2.A.6',
    'type' => 'relatives_in_business',
    'associations' => {
      'positive' => {
        0..0.25    => [],
        0.25..0.50 => [],
        0.50..0.75 => [],
        0.75..1    => ['n1', 't1']
      },
      'negative' => {
        0..0.25    => ['n1', 't1', 'l1'],
        0.25..0.50 => ['t3', 'c3', 's3', 'h3'],
        0.50..0.75 => ['t2', 't3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
        0.75..1    => ['t2', 't3', 'c2', 'c3', 's2', 's3', 'h2', 'h3']
      }
    }
  }
]

FONDESO_SECTORS = [
  { 'sector_id' => 'A', 'display' => 'Industrias manufactureras' },
  { 'sector_id' => 'B', 'display' => 'Comercio' },
  { 'sector_id' => 'C', 'display' => 'Preparación de alimentos y hoteles' },
  { 'sector_id' => 'D', 'display' => 'Servicios varios' },
  { 'sector_id' => 'E', 'display' => 'Culturales y de esparcimiento, deportivos y recreativos' },
  { 'sector_id' => 'F', 'display' => 'Organizaciones con fines de altruistas y medio ambiente' },
  { 'sector_id' => 'G', 'display' => 'Agricultura, ganadería, aprovechamiento forestal' },
  { 'sector_id' => 'H', 'display' => 'Tecnologías de la información y la comunicación' },
  { 'sector_id' => 'I', 'display' => 'Otros' },
  { 'sector_id' => 'J', 'display' => 'No sé' },
]
