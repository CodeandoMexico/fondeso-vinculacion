Feature: User answers the questionary
  Scenario: Example 1
    Given an empty score
    When I answer the ordinal question "2.A.1" with:
      | A |   |
      | B |   |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then the partial score for the question "2.A.1" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       |-1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         | 1 |
      | lifestyle-growing         | 1 |
      | lifestyle-consolidation   | 1 |
      | cultural-startup          |-1 |
      | cultural-growing          |-1 |
      | cultural-consolidation    |-1 |
      | social-startup            |-1 |
      | social-growing            |-1 |
      | social-consolidation      |-1 |
      | high_impact-startup       |-1 |
      | high_impact-growing       |-1 |
      | high_impact-consolidation |-1 |
    When I answer the ordinal question "2.A.2" with:
      | A |   |
      | B | 3 |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then the partial score for the question "2.A.2" should be:
      | need-startup              |-1    |
      | traditional-startup       | 0.33 |
      | traditional-growing       | 0.33 |
      | traditional-consolidation | 0.33 |
      | lifestyle-startup         |-1    |
      | lifestyle-growing         |-1    |
      | lifestyle-consolidation   |-1    |
      | cultural-startup          |-1    |
      | cultural-growing          |-1    |
      | cultural-consolidation    |-1    |
      | social-startup            | 1    |
      | social-growing            | 1    |
      | social-consolidation      | 1    |
      | high_impact-startup       |-1    |
      | high_impact-growing       |-1    |
      | high_impact-consolidation |-1    |
    When I answer the question "2.A.3" with the unique answer "D"
    Then the partial score for the question "2.A.3" should be:
      | need-startup              |-1 |
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
    When I answer the question "2.A.4" with the unique answer "25"
    Then the partial score for the question "2.A.4" should be:
      | need-startup              |-1 |
      | traditional-startup       | 0 |
      | traditional-growing       | 1 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          |-1 |
      | cultural-growing          | 0 |
      | cultural-consolidation    | 0 |
      | social-startup            |-1 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       |-1 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation |-1 |
    When I answer the question "2.A.5" with the unique answer "0"
    Then the partial score for the question "2.A.5" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          | 0 |
      | cultural-growing          | 0 |
      | cultural-consolidation    | 0 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
    When I answer the question "2.A.6" with the unique answer "B"
    Then the partial score for the question "2.A.6" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         | 1 |
      | lifestyle-growing         | 1 |
      | lifestyle-consolidation   | 1 |
      | cultural-startup          | 0 |
      | cultural-growing          | 0 |
      | cultural-consolidation    | 0 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      | 0 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
    When I answer the question "2.A.7" with the unique answer "B"
    Then the partial score for the question "2.A.7" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 0 |
      | lifestyle-startup         | 0 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          | 1 |
      | cultural-growing          | 1 |
      | cultural-consolidation    | 1 |
      | social-startup            | 1 |
      | social-growing            | 1 |
      | social-consolidation      | 1 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
    When I answer the question "2.A.8" with the unique answer "B"
    Then the partial score for the question "2.A.8" should be:
      | need-startup              |-1 |
      | traditional-startup       | 0 |
      | traditional-growing       | 1 |
      | traditional-consolidation | 1 |
      | lifestyle-startup         | 1 |
      | lifestyle-growing         | 1 |
      | lifestyle-consolidation   | 1 |
      | cultural-startup          | 1 |
      | cultural-growing          | 1 |
      | cultural-consolidation    | 1 |
      | social-startup            | 1 |
      | social-growing            | 1 |
      | social-consolidation      | 1 |
      | high_impact-startup       | 1 |
      | high_impact-growing       | 1 |
      | high_impact-consolidation | 1 |
    When I answer the question "3.A.1" with the unique answer "3"
    Then the partial score for the question "3.A.1" should be:
      | need-startup              | 0 |
      | traditional-startup       | 0 |
      | traditional-growing       | 0 |
      | traditional-consolidation |-1 |
      | lifestyle-startup         | 0 |
      | lifestyle-growing         | 0 |
      | lifestyle-consolidation   | 0 |
      | cultural-startup          | 0 |
      | cultural-growing          | 0 |
      | cultural-consolidation    |-1 |
      | social-startup            | 0 |
      | social-growing            | 0 |
      | social-consolidation      |-1 |
      | high_impact-startup       |-1 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 0 |
    When I answer the multiple answer question "3.A.2" with:
      | A |   |
      | B |   |
      | C | x |
      | D | x |
      | E |   |
      | F |   |
      | G | x |
      | H | x |
      | I | x |
      | J |   |
    Then the partial score for the question "3.A.2" should be:
      | need-startup              |-7 |
      | traditional-startup       |-7 |
      | traditional-growing       |-1 |
      | traditional-consolidation | 2 |
      | lifestyle-startup         |-4 |
      | lifestyle-growing         |-3 |
      | lifestyle-consolidation   |-3 |
      | cultural-startup          |-6 |
      | cultural-growing          |-6 |
      | cultural-consolidation    |-2 |
      | social-startup            |-6 |
      | social-growing            |-6 |
      | social-consolidation      |-2 |
      | high_impact-startup       |-3 |
      | high_impact-growing       | 0 |
      | high_impact-consolidation | 2 |
    When I answer the question "3.A.3" with the unique answer "D"
    Then the partial score for the question "3.A.3" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | traditional-growing       | 0 |
      | traditional-consolidation | 1 |
      | lifestyle-startup         |-1 |
      | lifestyle-growing         | 1 |
      | lifestyle-consolidation   | 1 |
      | cultural-startup          |-1 |
      | cultural-growing          | 0 |
      | cultural-consolidation    | 1 |
      | social-startup            |-1 |
      | social-growing            | 0 |
      | social-consolidation      | 1 |
      | high_impact-startup       | 0 |
      | high_impact-growing       | 1 |
      | high_impact-consolidation | 1 |
