package election.tally;

public abstract class AbstractCountStatus {
  
  // Internal states within the ballot counting machine
  public static final int READY_TO_COUNT = 1;
  public static final int NO_SEATS_FILLED_YET = 2;
  public static final int CANDIDATES_HAVE_QUOTA = 3;
  public static final int CANDIDATE_ELECTED = 4;
  public static final int NO_SURPLUS_AVAILABLE = 5;
  public static final int SURPLUS_AVAILABLE = 6;
  public static final int READY_TO_ALLOCATE_SURPLUS = 7;
  public static final int READY_TO_MOVE_BALLOTS = 8;
  public static final int CANDIDATE_EXCLUDED = 9;
  public static final int READY_FOR_NEXT_ROUND_OF_COUNTING = 10;
  public static final int LAST_SEAT_BEING_FILLED = 11;
  public static final int MORE_CONTINUING_CANDIDATES_THAN_REMAINING_SEATS = 12;
  public static final int ONE_OR_MORE_SEATS_REMAINING = 13;
  public static final int ONE_CONTINUING_CANDIDATE_PER_REMAINING_SEAT = 14;
  public static final int ALL_SEATS_FILLED = 15;
  public static final int END_OF_COUNT = 16;
  
  /**
   * Get the current stage of counting.
   */
  /*@ ensures \result == substate;
    @ public model pure int getState() {
    @   return substate;
    @ }
    @*/

  /**
   * Move to the next stage of counting.
   * 
   * @param newState
   *          The next stage of counting.
   */
  //@ requires isPossibleState (newState);
  //@ requires isTransition (getState(), newState);
  //@ assignable substate;
  //@ ensures getState() == newState;
  public abstract void changeState(int newState);
  
  protected/*@ spec_public @*/int substate;
  
  /**
   * Confirm that this value is a valid stage of counting.
   * 
   * @param value
   *          The stage in the counting process.
   */
  /*@ ensures \result <==> 
    @   ((READY_TO_COUNT == value) ||
    @   (NO_SEATS_FILLED_YET == value) ||
    @   (CANDIDATES_HAVE_QUOTA == value) ||
    @   (CANDIDATE_ELECTED == value) ||
    @   (NO_SURPLUS_AVAILABLE == value) ||
    @   (SURPLUS_AVAILABLE == value) ||
    @   (READY_TO_ALLOCATE_SURPLUS == value) ||
    @   (READY_TO_MOVE_BALLOTS == value) ||
    @   (CANDIDATE_EXCLUDED == value) ||
    @   (READY_FOR_NEXT_ROUND_OF_COUNTING == value) ||
    @   (LAST_SEAT_BEING_FILLED == value) ||
    @   (MORE_CONTINUING_CANDIDATES_THAN_REMAINING_SEATS == value) ||
    @   (ONE_OR_MORE_SEATS_REMAINING == value) ||
    @   (ALL_SEATS_FILLED == value) ||
    @   (END_OF_COUNT == value) ||
    @   (ONE_CONTINUING_CANDIDATE_PER_REMAINING_SEAT == value));
    @
    @  public model pure boolean isPossibleState(int value) {
    @     return ((READY_TO_COUNT == value) || (NO_SEATS_FILLED_YET == value)
    @      || (CANDIDATES_HAVE_QUOTA == value) || (CANDIDATE_ELECTED == value)
    @      || (NO_SURPLUS_AVAILABLE == value) || (SURPLUS_AVAILABLE == value)
    @      || (READY_TO_ALLOCATE_SURPLUS == value)
    @      || (READY_TO_MOVE_BALLOTS == value) || (CANDIDATE_EXCLUDED == value)
    @      || (READY_FOR_NEXT_ROUND_OF_COUNTING == value)
    @      || (LAST_SEAT_BEING_FILLED == value)
    @      || (MORE_CONTINUING_CANDIDATES_THAN_REMAINING_SEATS == value)
    @      || (ONE_OR_MORE_SEATS_REMAINING == value)
    @      || (ALL_SEATS_FILLED == value) || (END_OF_COUNT == value) || (ONE_CONTINUING_CANDIDATE_PER_REMAINING_SEAT == value));
    @ }
    @*/
  
  /**
   * Confirm that this is a valid transition from one stage of counting to another.
   * 
   * @param fromState The current stage of counting.
   * @param toState The next stage if counting.
   */
  /*@ requires isPossibleState(fromState);
    @ requires isPossibleState(toState);
    @
    @ public model pure boolean isTransition (int fromState, int toState) {
    @
    @   // Self transitions are allowed
    @   if (toState == fromState) {
    @     return true;
    @   }
    @
    @   // No transitions into the initial state
    @   else if (READY_TO_COUNT == toState) {
    @     return false;
    @   }
    @
    @   // No transitions away from final state
    @   else if (END_OF_COUNT == fromState) {
    @     return false;
    @   }
    @
    @   // Transition: Calculate Quota
    @   else if ((READY_TO_COUNT == fromState) && (NO_SEATS_FILLED_YET == toState)) {
    @     return true;
    @   }
    @
    @   // Transition: Find Highest Continuing Candidate with Quota
    @   else if (((NO_SEATS_FILLED_YET == fromState) || 
    @           (CANDIDATES_HAVE_QUOTA == fromState) ||
    @     (MORE_CONTINUING_CANDIDATES_THAN_REMAINING_SEATS == fromState)) &&
    @     ((CANDIDATE_ELECTED == toState) ||  
    @     (NO_SURPLUS_AVAILABLE == toState))) {
    @     return true;
    @   }
    @
    @  // Transition: Calculate Surplus
    @ else if ((CANDIDATE_ELECTED == fromState) &&
    @         ((CANDIDATES_HAVE_QUOTA == toState) || 
    @       (SURPLUS_AVAILABLE == toState) ||
    @       (NO_SURPLUS_AVAILABLE == toState))) {
    @     return true;
    @   }
    @
    @ // Transition: Calculate Number of Votes to Transfer
    @ else if ((SURPLUS_AVAILABLE == fromState) && 
    @    (READY_TO_ALLOCATE_SURPLUS == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Calculate Transfers from Surplus
    @ else if ((READY_TO_ALLOCATE_SURPLUS == fromState) &&
    @    (READY_TO_MOVE_BALLOTS == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Calculate Transfers from Excluded Candidate
    @ else if ((CANDIDATE_EXCLUDED == fromState) &&
    @    (READY_TO_MOVE_BALLOTS == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Move the Ballots
    @ else if ((READY_TO_MOVE_BALLOTS == fromState) && 
    @    (READY_FOR_NEXT_ROUND_OF_COUNTING == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Select Lowest Continuing Candidates for Exclusion
    @ else if ((NO_SURPLUS_AVAILABLE == fromState) ||
    @    (CANDIDATE_EXCLUDED == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Count Continuing Candidates
    @ else if ((ONE_OR_MORE_SEATS_REMAINING == fromState) &&
    @    ((LAST_SEAT_BEING_FILLED == toState) || 
    @    (MORE_CONTINUING_CANDIDATES_THAN_REMAINING_SEATS == toState) ||
    @    (ONE_CONTINUING_CANDIDATE_PER_REMAINING_SEAT == toState))) {
    @  return true;
    @ }
    @
    @ // Transition: Check Remaining Seats
    @ else if ((READY_FOR_NEXT_ROUND_OF_COUNTING == fromState) &&
    @     ((ONE_OR_MORE_SEATS_REMAINING == toState) ||
    @    (ALL_SEATS_FILLED == toState))) {
    @  return true;
    @ }
    @
    @ // Transition: Declare Remaining Candidates Elected
    @ else if ((ONE_CONTINUING_CANDIDATE_PER_REMAINING_SEAT == fromState) &&
    @    (ALL_SEATS_FILLED == toState)) {
    @  return true;
    @ }
    @
    @ // Transition: Close the Count
    @ else if ((ALL_SEATS_FILLED == fromState) &&
    @    (END_OF_COUNT == toState)) {
    @  return true;
    @ }
    @
    @ // No other state transitions are possible
    @ return false;
    @ }
    @*/

}