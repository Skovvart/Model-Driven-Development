Invariant: Outcomes for valid tie breakers
  Ensuring that 'axiom for valid tie breaker' implies that for every 'outcome' in Outcomes is contained in 'outcomes'
  And that 'axiom for valid tie breaker' implies that for every 'outcome' in Outcomes, 'outcome' is either TiedLoser or TiedEarlyLoser or TiedSoreLoser
  And that 'axiom for valid tie breaker' implies there exists an 'outcome' in 'outcomes' where 'outcome' is TiedWinner

Invariant: Outcomes for tie breakers
  Ensuring that 'axiom for tie breaker' implies that for every 'outcome' in Outcomes is contained in 'outcomes'
  And that 'axiom for tie breaker' implies that for every 'outcome' in Outcomes, 'outcome' is TiedWinner
  And that 'axiom for tie breaker' implies that there exists an 'outcome' in 'outcomes' and 'outcome' is either TiedLoser or TiedEarlyLoser or TiedSoreLoser

Invariant: Outcomes for tied loser
  Ensuring that 'axiom for type of tied loser' implies that for all 'outcome1' and 'outcome2' in Outcomes, 'outcomes' contains 'outcome1' and 'outcome2' and 'outcome1' being TiedSoreLoser implies that 'outcome2' is not TiedLoser nor TiedSoreLoser nor TiedEarlyLoser nor Loser nor EarlyLoser

Behavior: Get a textual representation of a model election scenario
  Ensuring that getting the textual representation has no side effects

Behavior: Add outcome
  Requiring that 'outcome' has a value
  Ensuring that the number of candidates is increased by 1
  And 'outcomes' contains 'outcome'

Behavior: Convert scenario to predicate
  Requiring that the size of 'outcomes' is greater than 0
  Ensuring that converting a scenario to a predicate has no side effects

Behavior: Sort canonically
  Ensuring the size of the result is the same as the size of 'outcomes'

Behavior: Check whether scenarios are the same
  Ensuring that comparing scenarios has no side effect
  And the result is whether this scenario canonically sorted is the same as the 'other' scenario canonically sorted

Behavior: Get outcomes
  Ensuring that getting the outcomes has no side effects

Behavior: Append scenario
  Requiring that 'outcome' has a value
  Ensuring that appending a scenario has no side effects
  And the size of the result is the size of this scenario plus 1
  And the result contains the 'outcome'
  And that the the outcome of checking whether the result and the result of adding 'outcome' to this scenario is true

Behavior: Copy a scenario
  Ensuring that copying a scenario has no side effects
  And the result is the same as this scenario

Behavior: Check whether there is a tie between candidates in this scenario
  Ensuring: Checking whether there is a tie in this scenario has no side effects

Behavior: Check if this scenario has an outcome
  Ensuring that checking if this scenario has an outcome has no side effect
  And if the result is true, then there should be a tie

Behavior: Get the number of winners
  Ensuring that getting the number of winners has no side effects
  And the result is greater than 0
  And the result is smaller than the size of 'outcomes'

Behavior: Get the number of scenarios
  Requiring that the number of 'winners' is greater than 0
  And the number of 'losers' are greater than 0
  Ensuring that the result is greater than or equal to 4

Behavior: Get the total number of scenarios
  Requiring that the 'number of outcomes' is greater than 1
  Ensuring that getting the total number of scenarios has no side effects
  And that the result is the sum of the total number of scenarios for values smaller than 'number of outcomes'

Behavior: Get the number of candidates
  Ensuring that getting the number of candidates has no side effects
  And that the result is the size of outcomes

Behavior: Check whether a scenario matches the election result
  Requiring that the ballot counting is finished

Behavior: Check whether this scenario is a bye election
  Ensuring that checking whether this scenario is a bye election has no side effects
  And the result is the same as 'bye election'

Behavior: Get the voting scheme
  Ensuring that getting the voting scheme has no side effects