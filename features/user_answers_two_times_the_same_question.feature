Feature: User answers two times the same question
  Scenario: 2.A.3 with A and the B
    Given an empty score
    When I answer the question "2.A.3" with the unique answer "A"
    When I answer the question "2.A.3" with the unique answer "B"
    Then my current score should be:
      | need-startup              | 0 |
      | traditional-startup       | 0 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         | 0 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          |-1 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            |-1 |
      | social-growing            |-1 |
      | social-consolidation      |-1 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
