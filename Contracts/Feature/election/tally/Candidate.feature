Invariant: Candidate ID
    Ensuring 'candidateID' is greater than or equal to 0
    
Constraint: Canidate ID
    old 'candidateID' different from 'NO_CANDIDATE' implies 'candidateID' is the same as old 'candidateID'

Invariant: Number of votes added at each count
    all members of 'votesAdded' are greater than 0
    
Invariant: Number of votes added at each count
    Ensuring that initially all members of 'votesAdded' are 0
    
Invariant: Numer of votes added at each count
    Ensuring the length of 'votesAdded' is less than or equal to 'CountConfiguration.MAXCOUNT'
    
Invariant: Votes added in relation to votes removed
    Ensuring 'votesAdded' and 'votesRemoved' are different
    
Invariant: Last count
    Ensuring 'lastCountNumber' is 0
    
Constraint: Last count
    Ensuring old 'lastCountNumber' is less than or equal to 'lastCountNumber'
    
Constraint: Last count
    Ensuring 'lastCountNumber' is less than 'CountConfiguration.MAXCOUNT'
    
Constraint: Last count
    Ensuring 'lastCountNumber' is less than the length of 'votesAdded'

Constraint: Last count
    Ensuring 'lastCountNumber' is less than the length of 'votesRemoved'
    
 

package election.tally;

import java.io.Serializable;

/**
 * The Candidate object records the number of votes received during each round
 * of counting. Votes can only be added to the candidate's stack while the
 * candidate has a status of <code>CONTINUING</code>.
 * 
 * @see <a href="http://www.cev.ie/htm/tenders/pdf/1_2.pdf"> Department of
 *      Environment and Local Government, Count Requirements and Commentary on
 *      Count Rules, section 3-14</a>
 * @author Dermot Cochran
 */

public class Candidate extends CandidateStatus implements Serializable {
  
  private static final long serialVersionUID = 3435036225909047966L;

  /**
   * Maximum expected number of candidates in any one constituency.
   * 
   * @see <a
   *      href="http://en.wikipedia.org/wiki/List_of_political_parties_in_the_Republic_of_Ireland">List
   *      of political parties in Ireland</a> The average number of candidates
   *      could be much less.
   */
  public static final int MAX_CANDIDATES = 50;
  
  /**
   * Identifier for the candidate. The data should be loaded in such a way that
   * the assignment of candidate IDs is fair and unbiased.
   */
  /*@ public invariant 0 <= candidateID;
    @ public constraint \old(candidateID) != NO_CANDIDATE
    @   ==> candidateID == \old(candidateID);
    @*/
  protected transient/*@ spec_public @*/int candidateID;
  
  /** Number of votes added at each count */
  /*@ public invariant (\forall int i; 0 < i && i < votesAdded.length;
    @   0 <= votesAdded[i]);
    @ public initially (\forall int i; 0 < i && i < votesAdded.length;
    @   votesAdded[i] == 0);
    @ public invariant votesAdded.length <= CountConfiguration.MAXCOUNT;
    @*/
  protected/*@ spec_public non_null @*/int[] votesAdded =
      new int[CountConfiguration.MAXCOUNT];
  
  /** Number of votes removed at each count */
  /*@ public invariant (\forall int i; 0 <= i && i < votesRemoved.length;
    @                                  0 <= votesRemoved[i]);
    @ public initially (\forall int i; 0 <= i && i < votesRemoved.length;
    @                                  votesRemoved[i] == 0);
    @ public invariant votesRemoved.length <= CountConfiguration.MAXCOUNT;
    @*/
  protected/*@ spec_public non_null @*/int[] votesRemoved =
      new int[CountConfiguration.MAXCOUNT];
  
  //@ public invariant votesAdded != votesRemoved;
  //@ public invariant votesRemoved != votesAdded;
  
  /** The number of rounds of counting so far */
  //@ public invariant 0 <= lastCountNumber;
  //@ public initially lastCountNumber == 0;
  //@ public constraint \old(lastCountNumber) <= lastCountNumber;
  //@ public invariant lastCountNumber < CountConfiguration.MAXCOUNT;
  //@ public invariant lastCountNumber < votesAdded.length;
  //@ public invariant lastCountNumber < votesRemoved.length;
  protected /*@ spec_public @*/ int lastCountNumber = 0;

  
Constraint: Total vote
    Ensuring initially 'totalVote' is 0

Constraint: Total vote
    Ensuring old 'totalVote' is less than or equal to 'totalVote'
  
  //@ protected initially totalVote == 0;
  //@ protected constraint \old(totalVote) <= totalVote;
  protected /*@ spec_public @*/ int totalVote = 0;

Constraint: Removed vote
    Ensuring initially 'removedVote' is 0

Invariant: Removed vote
    Ensuring 'removedVote' is less than or equal to 'totalVote'
    
Constraint: Removed vote
    Ensuring old 'removedVote' is less than or equal to 'removedVote'
    
Invariant: State
    Ensuring 'state' equal to 'CONTINUING' implies that 'removedVote' is 0
    

  
  /** Number of ballots transferred to another candidate*/
  /*@ protected initially removedVote == 0;
    @ protected invariant removedVote <= totalVote;
    @ protected constraint \old(removedVote) <= removedVote;
    @ protected invariant (state == CONTINUING) ==> removedVote == 0;
    @*/
  protected /*@ spec_public*/ int removedVote = 0;
    
  public static final int NO_CANDIDATE = Ballot.NONTRANSFERABLE;
  
Invariant: Next Candidate ID
    Ensuring old 'nextCandidateID' is less than or equal to 'nextCandidateID'
  
  /**
   * Next available value for candidate ID number.
   */
  //@ private constraint \old(nextCandidateID) <= nextCandidateID;
  private /*@ spec_public @*/ static int nextCandidateID = MAX_CANDIDATES + 1;
  
Feature: Number of votes
    In order to get the number of votes
    I compute number that was added or removed in this round of counting
Behavior: Added or removed
    Requiring 'count' is greater than or equal to 0
    And the length of 'votesAdded' is greater than 'count'
    And the length of 'votesRemoved' is greater than 'count'
    Ensuring the index 'count' of 'votesAdded' minus the index 'count' of 'votesRemoved' is 'result'
  
  /**
   * Gets number of votes added or removed in this round of counting.
   * 
   * @param count
   *          This count number
   * @return A positive number if the candidate received transfers or a negative
   *         number if the candidate's surplus was distributed or the candidate
   *         was eliminated and votes transfered to another.
   */
  /*@ protected normal_behavior
    @   requires 0 <= count;
    @   requires count < votesAdded.length;
    @   requires count < votesRemoved.length;
    @   ensures \result == votesAdded[count] - votesRemoved[count];
    @*/
  protected/*@ pure spec_public @*/int getVoteAtCount(final int count) {
    return (votesAdded[count] - votesRemoved[count]);
  }
  
  /**
   * Total number of votes received by or added to this candidate.
   * 
   * @return Gross total of votes received
   */
  //@ ensures \result == totalVote;
  public/*@ pure @*/int getTotalVote() {
    
    return totalVote;
  }
  
  /**
   * Get status at the current round of counting; {@link #ELECTED},
   * {@link #ELIMINATED} or {@link #CONTINUING}
   * 
   * @return State value for this candidate
   */
  /*@ public normal_behavior
    @   ensures \result == state;
    @*/
  public/*@ pure @*/byte getStatus() {
    return state;
  }
  
  /**
   * Get the unique ID of this candidate.
   * 
   * @return The candidate ID number
   */
  /*@ public normal_behavior
    @   ensures \result == candidateID;
    @*/
  public/*@ pure @*/int getCandidateID() {
    return candidateID;
  }
  
Feature: Candidate
    When I set up a Candidate the following holds
Behavior: Set up candidate
    Requiring 'theCandidateID' is greater than 0
    Ensuring my 'candidateID' equals 'theCandidateID'
  
  /**
   * Create a <code>candidate</code> where the identifier is already known
   * 
   * @param theCandidateID
   */
  /*@ requires 0 < theCandidateID;
    @ assignable candidateID, votesAdded, votesRemoved;
    @ ensures this.candidateID == theCandidateID;
    @ ensures (\forall int i; 0 <= i && i < CountConfiguration.MAXCOUNT;
    @   getTotalAtCount() == 0);
    @*/
  public Candidate(final int theCandidateID) {
    super();
    this.candidateID = theCandidateID;
    
    //@ loop_invariant (0 < i) ==> getVoteAtCount(i-1) == 0;
    for (int i = 0; i < CountConfiguration.MAXCOUNT; i++) {
      this.votesAdded[i] = 0;
      this.votesRemoved[i] = 0;
    }
  }
  
Feature: Add vote
    In order to ..
    I add a vote to a ballot card
Behavior: Add vote to ballot card
    Requiring 'state' equals 'CONTINUING'
    And 'lastCountNumber' is smaller than or equal to 'count'
    And 'count' is greater than 0
    And the length of 'votesAdded' is greater than 'count'
    And 'numberOfVotes' is greater than or equal to 0
    Ensuring the old value of the index 'count' of 'votesAdded' plus 'numberOfVotes' equals 
            the index 'count' of 'votesAdded'
    And the old value of 'totalVote' plus 'numberOfVotes' equals the index 'count' of 'votesAdded'
    And 'count' equals 'lastCountNumber'
  
  /**
   * Add a number of votes to the candidate's ballot pile.
   * 
   * @design This method cannot be called twice for the same candidate in the
   *         same round of counting.
   * @param numberOfVotes
   *          Number of votes to add
   * @param count
   *          The round of counting at which the votes were added
   */
  /*@ public normal_behavior
    @   requires state == CONTINUING;
    @   requires lastCountNumber <= count;
    @   requires 0 <= count;
    @   requires count < votesAdded.length;
    @   requires 0 <= numberOfVotes;
    @   assignable lastCountNumber, votesAdded[count], totalVote;
    @   ensures \old(votesAdded[count]) + numberOfVotes == votesAdded[count];
    @   ensures \old(totalVote) + numberOfVotes == totalVote;
    @   ensures count == lastCountNumber;
    @*/
  public void addVote(final int numberOfVotes, final int count) {
    votesAdded[count] += numberOfVotes;
    totalVote += numberOfVotes;
    updateCountNumber(count);
  }
  
Feature: Update count number
    Update the last count number for this candidate
Behavior: Update
    Requiring 'CountConfiguration.MAXCOUNT' is greater than 'count'
    And the length of 'votesAdded' is greater than 'count'
    And the length of 'votesRemoved' is greater than 'count'
    And 'count' is greater than or equal to 'lastCountNumber'
    And 'count' equals 'lastCountNumber'
  
  /**
   * Update the last count number for this Candidate
   * 
   * @param count
   *          The number of the most recent count
   */
  /*@ protected normal_behavior
    @   requires count < CountConfiguration.MAXCOUNT;
    @   requires count < votesAdded.length;
    @   requires count < votesRemoved.length;
    @   requires lastCountNumber <= count;
    @   assignable lastCountNumber;
    @   ensures lastCountNumber == count;
    @*/
  protected void updateCountNumber(final int count) {
    lastCountNumber = count;
  }
  
Feature: Remove votes from ballot stack
    In order to..
    I remove a number of votes from a canidates ballot stack
Behaviour: Remove votes
    Requiring 'state' equals 'ELIMINATED' or 'state' equals 'ELECTED'
    And 'count' is greater than or equal to 'lastCountNumber'
    And 'count' is greater than or equal to 0
    And the length of 'votesRemoved' is greater than 'count'
    And the length of 'votesAdded' is greater than 'count'
    And 'CountConfiguration.MAXCOUNT' is greater than 'count'
    And 'numberOfVotes' is greater than or equal to 0
    And the result of 'getTotalAtCount()' is greater than or equal to 'numberOfVotes'
    Ensuring the old value of the index 'count' of 'votesRemoved' plus 'numberOfVotes' equals the index 'count' og 'votesRemoved'
    And the old value of 'removedVote' plus 'numberOfVotes' equals 'removedVote'
    And 'count' equals 'lastCountNumber'
    
  
  /**
   * Removes a number of votes from a candidates ballot stack.
   * 
   * @design This method cannot be called twice for the same candidate in the
   *         same round of counting.
   * @param numberOfVotes
   *          Number of votes to remove from this candidate
   * @param count
   *          The round of counting at which the votes were removed
   */
  /*@ public normal_behavior
    @   requires state == ELIMINATED || state == ELECTED;
    @   requires lastCountNumber <= count;
    @   requires 0 <= count;
    @   requires count < votesRemoved.length;
    @   requires count < votesAdded.length;
    @   requires count < CountConfiguration.MAXCOUNT;
    @   requires 0 <= numberOfVotes;
    @   requires numberOfVotes <= getTotalAtCount();
    @   assignable lastCountNumber, votesRemoved[count], removedVote;
    @   ensures \old(votesRemoved[count]) + numberOfVotes == votesRemoved[count];
    @   ensures \old(removedVote) + numberOfVotes == removedVote;
    @   ensures count == lastCountNumber;
    @*/
  public void removeVote(final int numberOfVotes, final int count) {
    votesRemoved[count] += numberOfVotes;
    removedVote += numberOfVotes;
    updateCountNumber(count);
  }
  
Feature: Declare elected
    In order to elect a candidate
    I declare him elected
Behaviour: Declare elected
    Requiring my 'state' equals 'CONTINUING'
    And 'countNumber' is greater than or equal to my 'lastCountNumber'
    And 'countNumber' is greater than or equal to 0
    And 'CountConfiguration.MAXCOUNT' is greater than 'countNumber'
    And the length of 'votesAdded' is greater than 'countNumber'
    And the length of 'votesRemoved' is greater than 'countNumber'
    Ensuring 'state' equals 'ELECTED'
  
  /** Declares the candidate to be elected */
  /*@ public normal_behavior
    @   requires this.state == CONTINUING;
    @   requires this.lastCountNumber <= countNumber;
    @   requires 0 <= countNumber && countNumber < CountConfiguration.MAXCOUNT;
    @   requires countNumber < votesAdded.length;
    @   requires countNumber < votesRemoved.length;
    @   assignable state, lastCountNumber;
    @   ensures state == ELECTED;
    @*/
  public void declareElected(final int countNumber) {
    updateCountNumber(countNumber);
    state = ELECTED;
  }
  
Feature: Declare eliminated
    In order to eliminate a candidate
    I declare him eliminated
Behavior: Eliminate candidate
    Requiring 'countNumber' is greater than or equal to 0
    And 'CountConfiguration.MAXCOUNT' is greater than 'countNumber'
    And the length of 'votesAdded' is greater than 'countNumber'
    And the length of 'votesRemoved' is greater than 'countNumber'
    And my 'state' equals 'CONTINUING'
    Ensuring 'state' equals 'ELIMINATED'
  
  /** Declares the candidate to be eliminated */
  /*@ public normal_behavior
    @   requires 0 <= countNumber && countNumber < CountConfiguration.MAXCOUNT;
    @   requires countNumber < votesAdded.length;
    @   requires countNumber < votesRemoved.length;
    @   requires this.lastCountNumber <= countNumber;
    @   requires this.state == CONTINUING;
    @   assignable state, lastCountNumber;
    @   ensures state == ELIMINATED;
    @*/
  public void declareEliminated(final int countNumber) {
    updateCountNumber(countNumber);
    state = ELIMINATED;
  }
  
Feature: Determine ordering
    Determines the relative ordering
    of the candidate in the event of a tie
Behaviour: Determine ordering of candidates
    Ensuring the result equals true implies my 'candidateID' is greater than 'other.candidateID'
    And my 'candidateID' is greather than 'other.candidateID' implies the result equals true
  
  /**
   * Determines the relative ordering of the candidate in the event of a tie.
   * 
   * @param other
   *          The other candidate to compare with this candidate
   * @return <code>true</true> if other candidate is not selected
   */
  /*@ 
    @ public normal_behavior
    @   ensures (\result == true) <==> (this.candidateID > other.candidateID);
    @*/
  public/*@ pure @*/boolean isAfter(final/*@ non_null @*/Candidate other) {
    return (this.candidateID > other.candidateID);
  }
  
  /**
   * Is this the same candidate?
   * 
   * @param other
   *          The candidate to be compared
   * @return <code>true</code> if this is the same candidate
   */
  /*@ public normal_behavior
    @   ensures \result <==> ((other != null) &&
    @     (other.candidateID == candidateID));
    @
    @ public model pure boolean sameAs (non_null Candidate other) {
    @   return (other.candidateID == this.candidateID);
    @ }
    @*/
  
  /**
   * How many votes have been received by this round of counting?
   * 
   * @return The total number of votes received so far
   */
  /*@ ensures \result == totalVote - removedVote;
    @ public model pure int getTotalAtCount() {
    @   return totalVote - removedVote;
    @}
    @*/
  
Feature: Test candidate
    In order to check if a candidate has been elected
    I check its state
Behavior: Check candidate state
    Ensuring the result is true implies 'state' equals 'ELECTED'
    And 'state' equals 'ELECTED' implies the result equals true
  
  /**
   * Has this candidate been elected?
   * 
   * @return <code>true</code> if elected
   */
  //@ ensures (\result == true) <==> (state == ELECTED);
  public/*@ pure*/boolean isElected() {
    return state == ELECTED;
  }
  
  /**
   * Summary of candidate information, excluding transfers
   */
  public/*@ non_null pure*/String toString() {
    final StringBuffer stringBuffer = new StringBuffer(60);
    stringBuffer.append("Candidate");
    stringBuffer.append(Integer.toString(candidateID));
    if (isElected()) {
      stringBuffer.append(" elected");
    }
    else {
      stringBuffer.append(" lost");
    }
    stringBuffer.append(" with ");
    stringBuffer.append(Integer.toString(getTotalVote()));
    stringBuffer.append(" votes");

    return stringBuffer.toString();
  }
  
Feature: Test for elimination
    In order to check if a candidate has been eliminated
    I check the state of the candidate
Behaviour: Test candidate state
    Ensuring 'state' equals 'ELIMINATED'
  
  //@ ensures \result <==> (state == ELIMINATED);
  public/*@ pure*/boolean isEliminated() {
    return state == ELIMINATED;
  }
}