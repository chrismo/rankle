Feature: Get position
  In order to inspect a ranking
  As a developer
  I want to retrieve an element's position

  Scenario: Default ranking
    Given an apple
      And an orange
     Then the apple is in position 0
      And the orange is in position 1
      And the ranked fruit array is [apple, orange]

  Scenario: Custom ranking
    Given an apple
      And an orange
     When I assign the apple's position to 1
     Then the apple is in position 1
      And the orange is in position 0
      And the ranked fruit array is [orange, apple]
