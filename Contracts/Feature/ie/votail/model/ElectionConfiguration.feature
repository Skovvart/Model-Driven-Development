Feature: Number of candidate identifiers
  In order to count the amount of identifiers candidates
  As a dumb programmer
  I want a number of the candidate identifiers
  
Invariant: Number of candidate identifiers
  Ensuring that the 'number of candidate identifiers' is always less then or equal to the 'number of candidates'
  And the 'number of candidate identifiers' is always less than or equal to the length of the 'candidate identifier' list

Feature: Extract preferences
  In order to extract preferences
  As a dumb programmer
  I want to extract preferences from a data structure

Behavior: Extract preferences
  Requiring that the 'data structure' has a value

Feature: Update candidate identifiers
  In order to update the candidate identifiers
  As Batman
  I want to be able to update the candidate identifiers with a candidate identifiers
  
Behavior: Update candidate identifiers
  Ensuring that 'the number of candidate identifiers' is less than or equal to the 'number of candidates'

Behavior: Get constituency
  Ensuring that getting the constituency has no side effects

Behavior: Set the number of winners
  Requiring that the 'number of winners' is greater than 0
  Ensuring that the 'Election Configurations number of winners' is the 'number of winners'
  
Behavior: Set number of seats
  Requiring that the 'Election Configurations number of winners' is less than or equal to the 'number of seats'
  Ensuring that the 'Election Configurations number of seats' is the 'number of seats'

Behavior: Set number of candidates
  Requiring that the 'number of candidates' is greater than 0
  Ensuring that the 'Election Configurations number of candidates' is the 'number of candidates'

Behavior: Get scenario
  Ensuring the result is the 'Election Configurations scenario'
  And getting the scenario has no side effect

Behavior: Get the candidate identifiers
  Ensuring that every identifier in the result is in the 'Election Configurations candidate identifiers'

Behavior: Set the candidate identifiers
  Ensuring that every identifier in 'candidate identifiers' will be in 'Election Configurations candidate identifiers'

Behavior: Prune empty ballots and candidate identifiers from the data
  Ensures that trimming the data has no side effects

Behavior: Export
  Ensuring that exporting the data has no side effects