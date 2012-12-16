Feature: Find scenario lists
  In order to find a scenario list
  As a dumb programmer
  I want to be able to find a scenario list based on some parameters
  
Behavior: Find scenario list
  Requiring the 'number_of_seats' is greater than or equal to 1
  And the 'number_of_outcomes' is greater than or equal to 2
  And 'method' has a value
  Ensuring that if the number of outcomes is 2 then the result list contains 8 elements
  And if the number of outcomes is greater than 2 then the result list contains less than or equal to 15 times the outcome of the operation with number of outcomes being 1 smaller

Behavior: Find base scenario
  Requiring 'method' has a value
  And 'scenarios' has a value
  Ensuring the length of scenarios is 4