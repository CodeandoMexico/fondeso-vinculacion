Feature: Answer unique answer question with answer range and sector
  Scenario: 2.A.4 with 1, after select the Industial sector
    Given an empty score
    When I answer the sector question with "A - Industrias Manufactureras"
    And I answer the question "2.A.4" with the unique answer "1"
    Then my current score should be:
      | need-startup              | 0 |
      | traditional-startup       | 0 |
      | traditional-growing       |-1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         | 0 |
      | lifestyle-growing         |-2 |
      | lifestyle-consolidation   |-2 |
      | cultural-startup          |-1 |
      | cultural-growing          |-2 |
      | cultural-consolidation    |-2 |
      | social-startup            | 0 |
      | social-growing            |-1 |
      | social-consolidation      |-1 |
      | high_impact-startup       | 0 |
      | high_impact-growing       |-1 |
      | high_impact-consolidation |-1 |

  Scenario: 2.A.4 with 10, after select the Industrial sector
    Given an empty score
    When I answer the sector question with "A - Industrias Manufactureras"
    And I answer the question "2.A.4" with the unique answer "20"
    Then my current score should be:
      | need-startup              |-2 |
      | traditional-startup       | 0 |
      | traditional-growing       | 1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         |-2 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-2 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            |-1 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       |-1 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation |-1 |

  Scenario: 2.A.4 with 20, after select the comercial sector
    Given an empty score
    When I answer the sector question with "B - Comercio"
    And I answer the question "2.A.4" with the unique answer "20"
    Then my current score should be:
      | need-startup              |-1 |
      | traditional-startup       | 0 |
      | traditional-growing       | 1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-2 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            |-2 |
      | social-growing            |-1 |
      | social-consolidation      |-1 |
      | high_impact-startup       |-1 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation |-1 |

  Scenario: 2.A.4 with 100, after select the Industrial sector
    Given an empty score
    When I answer the sector question with "A - Industrias Manufactureras"
    And I answer the question "2.A.4" with the unique answer "100"
    Then my current score should be:
      | need-startup              |-2 |
      | traditional-startup       |-1 |
      | traditional-growing       | 1 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         |-2 |
      | lifestyle-growing         |-2 |
      | lifestyle-consolidation   |-2 |
      | cultural-startup          |-2 |
      | cultural-growing          |-2 |
      | cultural-consolidation    |-1 |
      | social-startup            |-1 |
      | social-growing            |-1 |
      | social-consolidation      | 0 |
      | high_impact-startup       |-1 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |

  Scenario: 2.A.4 with 101, after select the Industrial sector
    Given an empty score
    And I answer the question "2.A.4" with the unique answer "101"
    Then my current score should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       |-1 |
      | traditional-consolidation | 1 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         |-1 |
      | lifestyle-consolidation   |-1 |
      | cultural-startup          |-1 |
      | cultural-growing          |-1 |
      | cultural-consolidation    | 0 |
      | social-startup            |-1 |
      | social-growing            |-1 |
      | social-consolidation      | 0 |
      | high_impact-startup       |-1 |
      | high_impact-growing       |-1 |
      | high_impact-consolidation | 1 |
