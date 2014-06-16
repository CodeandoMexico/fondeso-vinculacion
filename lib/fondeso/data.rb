module Fondeso
  module Data
    PROFILES = [
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

    QUESTIONS = [
      { 'question_id' => '1.B.1', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.2', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.3', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.4', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.4.2', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.5', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.5.2', 'type' => 'unique_informative' },
      { 'question_id' => '1.B.6', 'type' => 'unique_informative' },

      {
        'question_id' => '2.A.1',
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
            'A' => [],
            'B' => [],
            'C' => [],
            'D' => [],
            'E' => ['c1', 'c2', 'c3'],
            'F' => ['s1', 's2', 's3'],
            'G' => [],
            'H' => ['h1', 'h2', 'h3']
          },
          'negative' => {
            'A' => ['n1', 'l1', 'l2', 'l3', 'c1', 'c2', 'c3'],
            'B' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
            'C' => ['c1', 'c2', 'c3', 's1', 's2', 's3'],
            'D' => ['n1', 'c1', 'c2', 'c3', 's1', 's2', 's3'],
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
            { 'range' => 11..50,  'except_sector' => 'B' } => ['t2'],
            { 'range' => 31..100, 'sector' => 'B' } => ['t2'],
            { 'range' => 51..100, 'except_sector' => 'B' } => ['t2'],
            { 'range' => 100..Float::INFINITY } => ['t3', 'h3']
          },
          'negative' => {
            { 'range' => 1 } => ['t2', 't3', 'l2', 'l3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
            { 'range' => 2 } => ['t2', 't3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
            { 'range' => 3..5 } => ['n1', 't2', 't3', 'c3', 's3', 'h2', 'h3'],
            { 'range' => 6..10 } => ['n1', 't3', 'l1', 'c3', 's3', 'h3'],
            { 'range' => 11..30,  'sector' => 'B' } => ['n1', 't3', 'l1', 'l2', 'l3', 'c1', 's1', 'h1', 'h3'],
            { 'range' => 11..50,  'except_sector' => 'B' } => ['n1', 't3', 'l1', 'c1', 's1', 'h1', 'h3'],
            { 'range' => 31..100, 'sector' => 'B' } => ['n1', 't1', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1'],
            { 'range' => 51..100, 'except_sector' => 'B' } => ['n1', 't1', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1'],
            { 'range' => 100..Float::INFINITY } => ['n1', 't1', 't2', 'l1', 'l2', 'l3', 'c1', 'c2', 's1', 's2', 'h1', 'h2']
          }
        }
      },

      {
        'question_id' => '2.A.5',
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
            0.50..0.75 => ['t2', 't3', 'l2', 'l3', 'c2', 'c3', 's2', 's3', 'h2', 'h3'],
            0.75..1    => ['t2', 't3', 'l2', 'l3', 'c2', 'c3', 's2', 's3', 'h2', 'h3']
          }
        }
      },

      {
        'question_id' => '2.A.6',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(c1 c2 c3 h1 h2 h3),
            'B' => %w(l1 l2 l3),
            'C' => %w(n1 t1 t2 t3)
          },
          'negative' => {
            'A' => %w(n1 t1 t2 t3),
            'B' => %w(n1 t1),
            'C' => %w(l1 c1 c2 c3 s1 s2 s3 h1 h2 h3)
          }
        }
      },

      {
        'question_id' => '2.A.7',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1 t1),
            'B' => %w(c1 c2 c3 s1 s2 s3)
          },
          'negative' => {
            'A' => %w(c1 c2 c3 s1 s2 s3),
            'B' => %w(n1 t1)
          }
        }
      },

      {
        'question_id' => '2.A.8',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1),
            'B' => %w(t2 t3 l1 l2 l3 c1 c2 c3 s1 s2 s3 h1 h2 h3)
          },
          'negative' => {
            'A' => %w(t2 t3 l1 l2 l3 c1 c2 c3 s1 s2 s3 h1 h2 h3),
            'B' => %w(n1)
          }
        }
      },

      {
        'question_id' => '3.A.1',
        'type' => 'unique_with_range',
        'associations' => {
          'positive' => {
            1..2 => %w(n1 t1 l1 c1 s1 h1),
            3..4 => [],
            5..6 => %w(t2 l2 l3 c2 s2 h2),
            7..8 => %w(h3),
            9..Float::INFINITY => %w(t3 l2 l3 c3 s3 h3)
          },
          'negative' => {
            1..2 => %w(t2 t3 l2 l3 c2 c3 s2 s3 h3),
            3..4 => %w(t3 c3 s3 h1),
            5..6 => %w(n1 t1 t3 l1 c1 c3 s1 s3 h1),
            7..8 => %w(n1 t1 l1 c1 s1 h1),
            9..Float::INFINITY => %w(n1 t1 l1 c1 s1 h1)
          }
        }
      },

      {
        'question_id' => '3.A.2',
        'type' => 'multiple',
        'associations' => {
          'positive' => {
            { 'A' => true } => %w(n1 t1),
            { 'B' => true } => [],
            { 'C' => true } => [],
            { 'D' => true } => [],
            { 'E' => true } => %w(t3 l1 l2 l3 c1 c2 c3 s1 s2 s3 h1 h2 h3),
            { 'C' => true, 'D' => true } => %w(t3 c3 s3 h3),
            { 'F' => true } => [],
            { 'G' => true } => [],
            { 'H' => true } => [],
            { 'I' => true } => %w(t3 h3),
            { 'F' => true, 'G' => true } => %w(t3 h1 h2 h3),
            { 'H' => true, 'I' => true } => %w(t3 h2 h3),

            { 'A' => false } => [],
            { 'B' => false } => [],
            { 'C' => false } => [],
            { 'D' => false } => [],
            { 'E' => false } => [],
            { 'C' => false, 'D' => false } => [],
            { 'F' => false } => [],
            { 'G' => false } => [],
            { 'H' => false } => [],
            { 'I' => false } => [],
            { 'F' => false, 'G' => false } => %w(c1 c2 c3 s1 s2 s3),
            { 'H' => false, 'I' => false } => %w(c1 c2 c3 s1 s2 s3)
          },
          'negative' => {
            { 'A' => true } => [],
            { 'B' => true } => %w(n1 t1),
            { 'C' => true } => %w(n1 t1 t2 l1 c1 s1 h1),
            { 'D' => true } => %w(n1 t1 l1 c1 c2 s1 s2 h1),
            { 'E' => true } => %w(n1 t1),
            { 'C' => true, 'D' => true } => [],
            { 'F' => true } => [],
            { 'G' => true } => %w(n1 t1 c1 c2 c3 s1 s2 s3),
            { 'H' => true } => [],
            { 'I' => true } => %w(n1 t1 l1 l2 l3 c1 c2 s1 s2),
            { 'F' => true, 'G' => true } => %w(n1 t1 l1 l2 l3 c1 c2 s1 s2),
            { 'H' => true, 'I' => true } => %w(n1 t1 l1 l2 l3 c1 c2 s1 s2),

            { 'A' => false } => %w(n1 t1),
            { 'B' => false } => [],
            { 'C' => false } => [],
            { 'D' => false } => [],
            { 'E' => false } => %w(t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            { 'C' => false, 'D' => false } => %w(t3 c3 s3 h1 h2 h3),
            { 'F' => false } => %w(n1 t1 c1 c2 c3 s1 s2 s3),
            { 'G' => false } => [],
            { 'H' => false } => %w(n1 t1),
            { 'I' => false } => [],
            { 'F' => false, 'G' => false } => [],
            { 'H' => false, 'I' => false } => []
          }
        }
      },

      {
        'question_id' => '3.A.3',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1 t1),
            'B' => [],
            'C' => [],
            'D' => %w(t3 l2 l3 c3 s3 h2 h3)
          },
          'negative' => {
            'A' => %w(t2 t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            'B' => %w(t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            'C' => %w(n1 t1 t3 c3 s3 h2 h3),
            'D' => %w(n1 t1 l1 c1 s1)
          }
        }
      },

      {
        'question_id' => '3.A.4',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1 t1 l1 c1 s1 h1),
            'B' => %w(t2 l2 l3 c2 s2 h2),
            'C' => %w(t3 c3 s3 h3)
          },
          'negative' => {
            'A' => %w(t3 c3 s3 h3),
            'B' => %w(n1 t3 h3),
            'C' => %w(n1 t1 l1 c1 s1 h1)
          }
        }
      },

      {
        'question_id' => '3.A.5',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(t2 t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            'B' => %w(n1)
          },
          'negative' => {
            'A' => %w(n1),
            'B' => %w(t2 t3 l2 l3 c2 c3 s2 s3 h1 h2 h3)
          }
        }
      },

      {
        'question_id' => '3.A.6',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1 t1),
            'B' => %w(t2 t3 l2 l3),
            'C' => %w(c3 s3 h1 h2 h3)
          },
          'negative' => {
            'A' => %w(t2 t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            'B' => %w(n1 t1 c3 s3 h1 h2 h3),
            'C' => %w(n1 t1)
          }
        }
      },

      {
        'question_id' => '3.A.7',
        'type' => 'multiple',
        'associations' => {
          'positive' => {
            { 'A' => true } => %w(t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            { 'B' => true } => %w(t3 l1 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            { 'C' => true } => %w(t3 l2 l3 c3 s3 h1 h2 h3),

            { 'A' => false } => %w(n1 t1),
            { 'B' => false } => %w(n1 t1),
            { 'C' => false } => %w(n1)
          },
          'negative' => {
            { 'A' => true } => %w(n1 t1),
            { 'B' => true } => %w(n1 t1),
            { 'C' => true } => %w(n1),

            { 'A' => false } => %w(t3 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            { 'B' => false } => %w(t3 l1 l2 l3 c2 c3 s2 s3 h1 h2 h3),
            { 'C' => false } => %w(t3 l2 l3 c3 s3 h1 h2 h3)
          }
        }
      },

      {
        'question_id' => '3.A.8',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(t2 t3 l2 l3 h1 h2 h3),
            'B' => %w(n1 t1 c1 s1 s2 s3)
          },
          'negative' => {
            'A' => %w(n1 t1 c1 s1 s2 s3),
            'B' => %w(t3 c3 h3)
          }
        }
      },

      {
        'question_id' => '4.A.1',
        'type' => 'ordinal_as_multiple',
        'associations' => {
          'positive' => {
            { 'A' => true } => %w(n1 t1 l1 c1 s1 h1),
            { 'B' => true } => %w(n1 t1 l1 c1 s1 h1),
            { 'C' => true } => %w(t2 t3 l2 l3 c2 c3 s2 s3 h2 h3),
            { 'D' => true } => %w(n1 t1 t2 c1 s1),
            { 'E' => true } => %w(t2 l2 l3 c2 s2 h2),
            { 'F' => true } => %w(t2 t3 l2 l3 c2 c3 s2 s3 h2 h3),
            { 'G' => true } => %w(t2 t3 c2 c3 s2 s3 h2 h3),
            { 'H' => true } => %w(t2 t3 l2 l3 c2 c3 s2 s3 h2 h3)
          },
          'negative' => {
            { 'A' => true } => [],
            { 'B' => true } => %w(t3 c3 s3 h3),
            { 'C' => true } => [],
            { 'D' => true } => %w(t3 c2 c3 s2 s3 h2 h3),
            { 'E' => true } => %w(n1),
            { 'F' => true } => %w(n1),
            { 'G' => true } => [],
            { 'H' => true } => %w(n1)
          }
        }
      },

      {
        'question_id' => '2.C.1',
        'type' => 'ordinal',
        'associations' => {
          'positive' => {
            'A' => ['n1'],
            'B' => ['t1'],
            'C' => ['s1'],
            'D' => ['c1'],
            'E' => ['l1'],
            'F' => ['h1']
          }
        }
      },

      {
        'question_id' => '2.C.2',
        'type' => 'ordinal',
        'associations' => {
          'positive' => {
            'A' => ['n1'],
            'B' => ['t1'],
            'C' => ['l1'],
            'D' => ['c1'],
            'E' => ['s1'],
            'F' => ['h1']
          }
        }
      },

      {
        'question_id' => '2.C.3',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => ['n1'],
            'B' => ['t1'],
            'C' => ['t1'],
            'D' => ['t1']
          },
          'negative' => {
            'A' => [],
            'B' => ['n1'],
            'C' => ['n1'],
            'D' => ['n1']
          }
        }
      },

      {
        'question_id' => '2.C.4',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => ['n1'],
            'B' => ['l1', 'c1', 's1', 'h1']
          },
          'negative' => {
            'A' => ['l1', 'c1', 's1', 'h1'],
            'B' => ['n1']
          }
        }
      },

      {
        'question_id' => '2.C.5',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => [],
            'B' => [],
            'C' => [],
            'D' => [],
            'E' => %w(c1),
            'F' => %w(s1),
            'G' => [],
            'H' => %w(h1),
            'I' => [],
            'J' => []
          },
          'negative' => {
            'A' => %w(n1 l1 c1),
            'B' => %w(c1 s1),
            'C' => %w(c1 s1),
            'D' => %w(n1),
            'E' => %w(n1 t1),
            'F' => %w(n1 t1 l1),
            'G' => %w(l1 c1),
            'H' => %w(n1 t1 c1 s1),
            'I' => [],
            'J' => []
          }
        }
      },

      {
        'question_id' => '2.C.6',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(c1 h1),
            'B' => %w(l1 s1),
            'C' => %w(n1 t1)
          },
          'negative' => {
            'A' => %w(n1 t1),
            'B' => %w(n1 t1),
            'C' => %w(l1 c1 s1 h1)
          }
        }
      },

      {
        'question_id' => '2.C.7',
        'type' => 'unique',
        'associations' => {
          'positive' => {
            'A' => %w(n1 t1),
            'B' => [],
            'C' => %w(h1)
          },
          'negative' => {
            'A' => %w(h1),
            'B' => %w(n1 t1 h1),
            'C' => %w(n1 t1)
          }
        }
      },

      {
        'question_id' => '4.C.1',
        'type' => 'ordinal_as_multiple',
        'associations' => {
          'positive' => {
            { 'A' => true } => %w(n1 t1 l1 c1 s1 h1),
            { 'B' => true } => %w(n1 t1 l1 c1 s1 h1),
            { 'C' => true } => [],
            { 'D' => true } => %w(n1 t1 c1 s1),
            { 'E' => true } => [],
            { 'F' => true } => [],
            { 'G' => true } => []
          },
          'negative' => {
            { 'A' => true } => [],
            { 'B' => true } => [],
            { 'C' => true } => [],
            { 'D' => true } => [],
            { 'E' => true } => %w(n1),
            { 'F' => true } => [],
            { 'G' => true } => %w(n1)
          }
        }
      }
    ]

    SECTORS = [
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
  end
end
