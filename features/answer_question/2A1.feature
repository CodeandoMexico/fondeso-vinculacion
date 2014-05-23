Feature: Answer question 2.A.1
  Scenario: example 1
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
      | lifestyle-startup         | 0.2  |
      | lifestyle-growing         | 0.2  |
      | lifestyle-consolidation   | 0.2  |
      | cultural-startup          | 0.25 |
      | cultural-growing          | 0.25 |
      | cultural-consolidation    | 0.25 |
      | social-startup            | 0.33 |
      | social-growing            | 0.33 |
      | social-consolidation      | 0.33 |
      | high_impact-startup       | 0.16 |
      | high_impact-growing       | 0.16 |
      | high_impact-consolidation | 0.16 |

  Scenario: example 2
    Given an empty score
    When I answer the ordinal question "2.A.1" with:
      | A | 6 |
      | B | 5 |
      | C | 4 |
      | D | 3 |
      | E | 2 |
      | F | 1 |
    Then my current score should be:
      | need-startup              | 0.16 |
      | traditional-startup       | 0.2  |
      | traditional-growing       | 0.2  |
      | traditional-consolidation | 0.2  |
      | lifestyle-startup         | 0.5  |
      | lifestyle-growing         | 0.5  |
      | lifestyle-consolidation   | 0.5  |
      | cultural-startup          | 0.33 |
      | cultural-growing          | 0.33 |
      | cultural-consolidation    | 0.33 |
      | social-startup            | 0.25 |
      | social-growing            | 0.25 |
      | social-consolidation      | 0.25 |
      | high_impact-startup       | 1    |
      | high_impact-growing       | 1    |
      | high_impact-consolidation | 1    |
