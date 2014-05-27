Feature: Answer question of relatives in business
  Scenario: 2.A.5, example 1
    Given an empty score
    When I answer the sector question with "A - Industrias Manufactureras"
    When I answer the question "2.A.4" with the unique answer "10"
    When I answer the question "2.A.5" with the unique answer "7"
    Then my current score should be:
      | need-startup              |-2 |
      | traditional-startup       | 1 |
      | traditional-growing       |-1 |
      | traditional-consolidation |-2 |
      | lifestyle-startup         |-2 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-1 |
      | cultural-growing          |-2 |
      | cultural-consolidation    |-3 |
      | social-startup            | 0 |
      | social-growing            |-1 |
      | social-consolidation      |-2 |
      | high_impact-startup       | 0 |
      | high_impact-growing       |-1 |
      | high_impact-consolidation |-2 |

  Scenario: 2.A.5, example 2
    Given an empty score
    When I answer the sector question with "A - Industrias Manufactureras"
    When I answer the question "2.A.4" with the unique answer "10"
    When I answer the question "2.A.5" with the unique answer "4"
    Then my current score should be:
      | need-startup              |-2 |
      | traditional-startup       | 1 |
      | traditional-growing       | 0 |
      | traditional-consolidation |-2 |
      | lifestyle-startup         |-2 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-1 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-3 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      |-2 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation |-2 |
