Feature: Generate test data for a ballot box
  In order to extract ballot box test data
  I want an ElectionConfiguration

Behavior: Generate data
  Requiring 'scope' is a positive number
  And 'upperBound' is greater than or equal to 'scope'
  And 'scenario' has a value
  Ensuring 'result' has a value

Feature: Find the Alloy solution
  I would like to to find the Alloy solution 
  for an electoral scenario

Behavior: Find solution
  Requiring 'scope' is a positive number
  And 'scenario' has a value

Behavior: Extract ballot
  Requiring 'scenario' has a value
  Ensuring 'result' has a value