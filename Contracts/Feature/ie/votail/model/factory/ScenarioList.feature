Behavior: Scenario list
  Ensuring the number of partitions is 'MAX_PARTITIONS'
  And the bucket size is '0'
  And the size is '0'

Behavior: Has scenario
  Requiring 'scenario' has a value
    
Behavior: Include scenario
  Requiring 'scenario' has a value
  Ensuring 'scenario' is member of the scenario list

Behavior: Get scenario count
  Requires 'numberOfWinners' is a positive number
  And result is greater than or equal to '0'