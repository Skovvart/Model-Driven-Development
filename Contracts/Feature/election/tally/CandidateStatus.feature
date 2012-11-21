Invariant: Candidate state
  Ensuring 'state' is initially CONTINUING and eventually either ELECTED or ELIMINATED or CONTINUING

Contraint: Candidate state
  Ensuring that if the old value of 'state' was ELECTED then the new 'state' is ELECTED
  And that if the old value of 'state' was ELIMINATED then the new 'state' is ELIMINATED