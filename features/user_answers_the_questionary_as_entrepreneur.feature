Feature: User answers the questionary as entrepreneur
  Scenario: Example 1
    Given an empty score
    When I answer the ordinal question "2.C.1" with:
      | A |   |
      | B |   |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then the partial score for the question "2.C.1" should be:
      | need-startup              |-1 |
      | traditional-startup       |-1 |
      | lifestyle-startup         | 1 |
      | cultural-startup          |-1 |
      | social-startup            |-1 |
      | high_impact-startup       |-1 |
    When I answer the ordinal question "2.C.2" with:
      | A |   |
      | B | 3 |
      | C |   |
      | D |   |
      | E | 1 |
      | F |   |
    Then the partial score for the question "2.C.2" should be:
      | need-startup              |-1    |
      | traditional-startup       | 0.33 |
      | lifestyle-startup         |-1    |
      | cultural-startup          |-1    |
      | social-startup            | 1    |
      | high_impact-startup       |-1    |
