Feature: Answer ordinal question
  Scenario: 2.A.1, example 1
    Given an empty score
    When I answer the ordinal question "2.A.1" with:
      | A | 1 |
      | B | 2 |
      | C | 3 |
      | D | 4 |
      | E | 5 |
      | F | 6 |
    Then my current score should be:
      | need-startup              | 1    |
      | traditional-startup       | 0.5  |
      | traditional-growing       | 0.5  |
      | traditional-consolidation | 0.5  |
      | lifestyle-startup         | -1   |
      | lifestyle-growing         | -1   |
      | lifestyle-consolidation   | -1   |
      | cultural-startup          | -1   |
      | cultural-growing          | -1   |
      | cultural-consolidation    | -1   |
      | social-startup            | 0.33 |
      | social-growing            | 0.33 |
      | social-consolidation      | 0.33 |
      | high_impact-startup       | -1   |
      | high_impact-growing       | -1   |
      | high_impact-consolidation | -1   |

  Scenario: 2.A.1, example 2
    Given an empty score
    When I answer the ordinal question "2.A.1" with:
      | A |   |
      | B |   |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then my current score should be:
      | need-startup              | -1   |
      | traditional-startup       | -1   |
      | traditional-growing       | -1   |
      | traditional-consolidation | -1   |
      | lifestyle-startup         |  1   |
      | lifestyle-growing         |  1   |
      | lifestyle-consolidation   |  1   |
      | cultural-startup          | -1   |
      | cultural-growing          | -1   |
      | cultural-consolidation    | -1   |
      | social-startup            | -1   |
      | social-growing            | -1   |
      | social-consolidation      | -1   |
      | high_impact-startup       | -1   |
      | high_impact-growing       | -1   |
      | high_impact-consolidation | -1   |

  Scenario: 2.A.2
    Given an empty score
    When I answer the ordinal question "2.A.2" with:
      | A |   |
      | B | 3 |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then my current score should be:
      | need-startup              | -1   |
      | traditional-startup       | 0.33 |
      | traditional-growing       | 0.33 |
      | traditional-consolidation | 0.33 |
      | lifestyle-startup         | -1   |
      | lifestyle-growing         | -1   |
      | lifestyle-consolidation   | -1   |
      | cultural-startup          | -1   |
      | cultural-growing          | -1   |
      | cultural-consolidation    | -1   |
      | social-startup            |  1   |
      | social-growing            |  1   |
      | social-consolidation      |  1   |
      | high_impact-startup       | -1   |
      | high_impact-growing       | -1   |
      | high_impact-consolidation | -1   |
