Feature: Number of candidate identifiers
  In order to count the amount of identifiers candidates
  As a dumb programmer
  I want a number of the candidate identifiers
  
Invariant: Number of candidate identifiers
  Ensuring that the 'number of candidate identifiers' is always less then or equal to the 'number of candidates'
  And the 'number of candidate identifiers' is always less than or equal to the length of the 'candidate identifier' list

###########
  
Feature: Extract preferences
  In order to extract preferences
  As a dumb programmer
  I want to extract preferences from a data structure

Behavior: Extract preferences
  Requiring that the 'data structure' has a value

#############
  
Feature: Update candidate identifiers
  In order to update the candidate identifiers
  As Batman
  I want to be able to update the candidate identifiers with a candidate identifiers
  
Behavior: Update candidate identifiers
  Ensuring that 'the number of candidate identifiers' is less than or equal to the 'number of candidates'

--------------

rule update_candidateIds 'the number of candidate identifiers' is less than or equal to the 'number of candidates'
    expr 'numberOfCandidateIDs <= numberOfCandidates'
end

behaviour: Update candidate identifiers
    class 'ElectionConfiguration'
    signature 'protected final void updateCandidateIDs(final int candidateID)'
end

##############
  
Behavior: Get constituency
  Ensuring that getting the constituency has no side effects
  
##############
  
Behavior: Set the number of winners
  Requiring that the 'number of winners' is greater than 0
  Ensuring that the 'Election Configurations number of winners' is the 'number of winners'
  
##############
  
Behavior: Set number of seats
  Requiring that the 'Election Configurations number of winners' is less than or equal to the 'number of seats'
  Ensuring that the 'Election Configurations number of seats' is the 'number of seats'

--------------

rule set_seats1 the 'Election Configurations number of winners' is less than or equal to the 'number of seats'
    expr 'this.numberOfWinners <= theNumberOfSeats'
end

rule set_seats2 the 'Election Configurations number of seats' is the 'number of seats'
    expr 'this.numberOfSeats == numberOfSeats'
end

behaviour: Set number of seats
    class 'ElectionConfiguration'
    signature 'public void setNumberOfSeats(final int theNumberOfSeats)'
end

##############
  
Behavior: Set number of candidates
  Requiring that the 'number of candidates' is greater than 0
  Ensuring that the 'Election Configurations number of candidates' is the 'number of candidates'

--------------

rule set_no_candidates the 'number of candidates' is greater than 0
    expr 'theNumberOfCandidates > 0'
end

rule set_no_candidates2 the 'Election Configurations number of candidates' is the 'number of candidates'
    expr 'numberOfCandidates == theNumberOfCandidates'
end

behaviour: Set number of candidates
    class 'ElectionConfiguration'
    signature 'public void setNumberOfCandidates(final int theNumberOfCandidates)'
end  
  
##############
  
Behavior: Get scenario
  Ensuring the result is the 'Election Configurations scenario'
  And getting the scenario has no side effect

--------------

rule get_scenario the result is the 'Election Configurations scenario'
    expr '\result == scenario'
end

behaviour: Get scenario
    class 'ElectionConfiguration'
    signature 'public/*@ pure @*/ElectoralScenario getScenario()'
end  
  
##############
  
Behavior: Get the candidate identifiers
  Ensuring that every identifier in the result is in the 'Election Configurations candidate identifiers'

--------------

rule get_candidate_ids every identifier in the result is in the 'Election Configurations candidate identifiers'
    expr 'ensures (\forall int i; 0 <= i && i < this.candidateIDs.length; \result[i] == this.candidatesIDs[i]);'
end

behaviour: Get candidate identifiers
    class 'ElectionConfiguration'
    signature 'public int[] getCandidateIDs()'
end  
  
##############
  
Behavior: Set the candidate identifiers
  Ensuring that every identifier in 'candidate identifiers' will be in 'Election Configurations candidate identifiers'

--------------
  
rule set_candidate_ids every identifier in 'candidate identifiers' will be in 'Election Configurations candidate identifiers'
    expr '(\forall int i; 0 <= i && i < theCandidateIDs.length; this.candidateIDs[i] == theCandidateIDs[i])'
end
  
behaviour: set_candidate_ids 
    class 'ElectionConfiguration'
    signature 'public void setCandidateIDs(final int[] theCandidateIDs)'    
end
  
##############
  
Behaviour: Prune empty ballots and candidate identifiers from the data
  Ensures that trimming the data has no side effects
  
Behavior: Export
  Ensuring that exporting the data has no side effects