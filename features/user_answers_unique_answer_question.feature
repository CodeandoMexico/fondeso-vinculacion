Feature: Answer unique answer question
  Scenario: 2.A.3 with A
    Given an empty score
    When I answer the question "2.A.3" with the unique answer "A"
    Then my current score should be:
      | need-startup              |-1 |
      | traditional-startup       | 0 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-1 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |

  Scenario: 2.A.3 with B
    Given an empty score
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

  Scenario: 2.A.3 with E
    Given an empty score
    When I answer the question "2.A.3" with the unique answer "E"
    Then my current score should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       |-1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         | 0 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          | 1 |
      | cultural-growing          | 1 |
      | cultural-consolidation    | 1 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
