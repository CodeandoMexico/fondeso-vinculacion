Feature: Answer multiple answer question
  Scenario: 3.A.2, example 1
    Given an empty score
    When I answer the multiple answer question "3.A.2" with:
      | A |   |
      | B |   |
      | C |   |
      | D | x |
      | E |   |
      | F |   |
      | G | x |
      | H | x |
      | I | x |
      | J |   |
    Then my current score should be:
      | need-startup              |-6 |
      | traditional-startup       |-6 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 1 |
      | lifestyle-startup         |-3 |
      | lifestyle-growing         |-3 |
      | lifestyle-consolidation   |-3 |
      | cultural-startup          |-5 |
      | cultural-growing          |-6 |
      | cultural-consolidation    |-3 |
      | social-startup            |-5 |
      | social-growing            |-6 |
      | social-consolidation      |-3 |
      | high_impact-startup       |-2 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 1 |
