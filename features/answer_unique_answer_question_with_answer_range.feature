Feature: Answer unique answer question with answer range
  Scenario: 2.A.4 with 1
    Given an empty score
    When I answer the question "2.A.4" with the unique answer "1"
    Then my current score should be:
      | need-startup              | 1 |
      | traditional-startup       | 0 |
      | traditional-growing       |-1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         | 1 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          | 0 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            | 0 |
      | social-growing            |-1 |
      | social-consolidation      |-1 |
      | high_impact-startup       | 0 |
      | high_impact-growing       |-1 |
      | high_impact-consolidation |-1 |
