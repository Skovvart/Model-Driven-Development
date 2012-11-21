/**
 * @author Dermot Cochran, 2010, IT University of Copenhagen
 */

package ie.votail.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import election.tally.BallotCounting;
import election.tally.Candidate;

/**
 * A combination of possible election outcomes for each candidate.
 */

public class ElectoralScenario implements Serializable {
  
  /**
   * 
   */
  private static final long serialVersionUID = -5582137662901839518L;
  
  // Refinement from Alloy Analyser axioms to JML invariants
  /**
   * <Alloy>
   * fact validTieBreaker {
   * all l: Candidate | some w: Candidate |
   * (l.outcome = TiedLoser or l.outcome = TiedSoreLoser or
   * l.outcome = TiedEarlyLoser) implies
   * w.outcome = TiedWinner
   * }
   * </Alloy>
   */
  /*@ public invariant AXIOM_FOR_VALID_TIE_BREAKER <==>
        (\forall Outcome tl; outcomes.contains(tl) &&
        (tl == Outcomes.TiedLoser || tl == outcomes.TiedEarlyLoser || 
        tl == outcomes.tiedSoreLoser);
        (\exists Outcome tw; outcomes.contains(tw) 
          && tw == Outcomes.TIED_WINNER));
   */
  public static final boolean AXIOM_FOR_VALID_TIE_BREAKER = true;
  
  /**
   * <Alloy>
   * fact validTieBreaker {
   * all l: Candidate | some w: Candidate |
   * (l.outcome = TiedLoser or l.outcome = TiedSoreLoser or
   * l.outcome = TiedEarlyLoser) implies
   * w.outcome = TiedWinner
   * }
   * </Alloy>
   */
  /*@ public invariant AXIOM_FOR_TIE_BREAKER <==>
        (\forall Outcome tw; outcomes.contains(tw) && 
          tw == Outcomes.TIED_WINNER;
        (\exists Outcome tl; outcomes.contains(tl) &&
        (tl == Outcomes.TiedLoser || tl == outcomes.TiedEarlyLoser || 
        tl == outcomes.tiedSoreLoser)));
   */
  public static final boolean AXIOM_FOR_TIE_BREAKER = true;
  
  /**
   * <Alloy>
   * fact typeOfTiedLoser {
   * no disj a,b: Candidate | a.outcome = TiedSoreLoser and
   * (b.outcome = TiedLoser or b.outcome = TiedEarlyLoser or
   * b.outcome=Loser or b.outcome=EarlyLoser)
   * }
   * </Alloy>
   */
  /*@ public invariant AXIOM_FOR_TYPE_OF_TIED_LOSER <==>
        (\forall Outcome a, b; outcomes.contains (a) && outcomes.contains (b);
        (a == Outcome.TiedSoreLoser) ==> 
        (b != Outcome.TiedLoser && b != Outcome.TiedEarlyLoser && 
         b != Outcome.Loser && b != Outcome.EarlyLoser));
   */
  public static final boolean AXIOM_FOR_TYPE_OF_TIED_LOSER = true;
  
  // Location of generated test data
  public static final String TESTDATA_LOCATION = "testdata/";
  public static final String PREFIX = "BallotBox";
  public static final String SUFFIX = ".data";
  
  protected OutcomeList listOfOutcomes;
  protected Method method;
  
  protected transient boolean byeElection;
  
  /**
   * Create an empty scenario
   */
  public ElectoralScenario() {
    super();
  }
  
  /**
   * Create a new model scenario.
   * 
   * @param method
   * @param byeElection
   */
  public ElectoralScenario(final Method method, final boolean byeElection) {
    super();
    listOfOutcomes = new OutcomeList();
    this.method = method;
    this.byeElection = byeElection;
  }
  
  /**
   * Textual representation of a model election scenario.
   */
  public/*@ pure @*/String toString() {
    final Iterator<Outcome> iterator = listOfOutcomes.getOutcomes().iterator();
    final StringBuffer stringBuffer =
        new StringBuffer(10 * getNumberOfCandidates() + 15);
    stringBuffer.append(Integer.toString(getNumberOfCandidates()));
    stringBuffer.append(" candidates (");
    if (iterator.hasNext()) {
      stringBuffer.append(iterator.next().toString());
    }
    while (iterator.hasNext()) {
      stringBuffer.append(",");
      stringBuffer.append(iterator.next().toString());
    }
    stringBuffer.append(")");
    return stringBuffer.toString();
  }
  
  /**
   * Add a candidate outcome to this scenario.
   * 
   * @param outcome
   *          The candidate outcome to be added to this scenario
   */
  /*@ ensures 1 + \old(getNumberOfCandidates()) == getNumberOfCandidates();
    @ ensures outcomes.contains(outcome);
    @*/
  public void addOutcome(/*@ non_null*/final Outcome outcome) {
    listOfOutcomes.add(outcome);
  }
  
  /**
   * Create an <a href="http://alloy.mit.edu">Alloy</a> predicate expression
   * for this scenario, for example:
   * <p>
   * some disj c0,c1,c2,c3,c4,c5,c6,c7,c8: Candidate |
   * <li>c0.outcome = Winner and</li>
   * <li>c1.outcome = QuotaWinner and</li>
   * <li>c2.outcome = CompromiseWinner and</li>
   * <li>c3.outcome = Loser and</li>
   * <li>c4.outcome = EarlyLoser and</li>
   * <li>c5.outcome = SoreLoser and</li>
   * <li>c6.outcome = TiedWinner and</li>
   * <li>c7.outcome = TiedLoser and</li>
   * <li>c8.outcome = TiedEarlyLoser</li>
   * </p>
   * 
   * @return The <code>Alloy</code> predicate as a string
   */
  //@ requires 0 < outcomes.size();
  public/*@ pure*/String toPredicate() {
    final Iterator<Outcome> iterator = listOfOutcomes.getOutcomes().iterator();
    final StringBuffer stringBuffer = new StringBuffer("some disj ");
    for (int i = 0; i < listOfOutcomes.getOutcomes().size(); i++) {
      if (i > 0) {
        stringBuffer.append(",");
      }
      stringBuffer.append("c" + i);
    }
    stringBuffer.append(": Candidate | ");
    int indexi = 0;
    while (iterator.hasNext()) {
      if (indexi > 0) {
        stringBuffer.append(" and ");
      }
      stringBuffer.append("c" + indexi + ".outcome = "
          + iterator.next().toString());
      indexi++;
    }
    stringBuffer.append(" and Election.method = " + method);
    stringBuffer.append(" and #Candidate = " + this.getNumberOfCandidates());
    
    return stringBuffer.toString();
  }
  
  /**
   * Sort the candidate outcomes events into a canonical order
   * 
   * @return The equivalent scenario with the candidate outcomes in canonical
   *         order
   */
  //@ ensures this.outcomes.size() == \result.outcomes.size();
  public ElectoralScenario canonical() {
    final ElectoralScenario sorted =
        new ElectoralScenario(this.method, this.byeElection);
    // Extract each type of outcome in canonical order
    for (Outcome outcome : Outcome.values()) {
      final Iterator<Outcome> iterator = this.getOutcomes().iterator();
      while (iterator.hasNext()) {
        if (outcome.equals(iterator.next())) {
          sorted.addOutcome(outcome);
        }
      }
    }
    return sorted;
  }
  
  /**
   * Compare two scenarios for the same multiset of outcomes
   * 
   * @param other
   *          The other scenario
   * @return Two scenarios are equivalent of they contain the same quantity of
   *         each kind of outcome
   */
  //@ ensures \result <==> this.canonical().equals(other.canonical());
  public/*@ pure*/boolean equivalentTo(final ElectoralScenario other) {
    if (other == null) {
      return false;
    }
    
    if (this.getNumberOfCandidates() != other.getNumberOfCandidates()) {
      return false;
    }
    final Iterator<Outcome> it1 = this.canonical().getOutcomes().iterator();
    final Iterator<Outcome> it2 = other.canonical().getOutcomes().iterator();
    while (it1.hasNext() && it2.hasNext()) {
      if (!it1.next().equals(it2.next())) {
        return false;
      }
    }
    return true;
  }
  
  protected/*@ pure @*/List<Outcome> getOutcomes() {
    if (listOfOutcomes == null) {
      listOfOutcomes = new OutcomeList();
    }
    return listOfOutcomes.getOutcomes();
  }
  
  /**
   * Append an outcome to this scenario.
   * 
   * @param outcome
   *          The outcome to be appended
   * @return The scenario with the outcome appended
   */
  /*@
   * ensures 1 + this.size() == \result.size();
   * ensures \result.contains (outcome);
   * ensures \result.equivalentTo (this.addOutcome(outcome));
   */
  public/*@ pure*/ElectoralScenario append(final/*@ non_null*/Outcome outcome) {
    final ElectoralScenario result = this.copy();
    result.addOutcome(outcome);
    return result;
  }
  
  /**
   * Create a scenario with an equivalent set of outcomes
   * 
   * @return An equivalent scenario
   */
  //@ ensures \result.equals(this);
  protected /*@ pure @*/ ElectoralScenario copy() {
    final ElectoralScenario clone =
        new ElectoralScenario(this.method, this.byeElection);
    Iterator<Outcome> iterator = this.listOfOutcomes.getOutcomes().iterator();
    while (iterator.hasNext()) {
      clone.addOutcome(iterator.next());
    }
    return clone;
  }
  
  /**
   * Check if this scenario involves a tie between equal candidates
   * 
   * @return True if any tied outcomes exist
   */
  public/*@ pure*/boolean isTied() {
    Iterator<Outcome> iterator = this.listOfOutcomes.getOutcomes().iterator();
    while (iterator.hasNext()) {
      Outcome outcome = iterator.next();
      if (outcome.isTied()) {
        return true;
      }
    }
    return false;
  }
  
  /**
   * Check if this scenario includes a specific outcome
   * 
   * @return True if there is at least outcome of that kind
   */
  //@ ensures \result ==> isTied();
  public/*@ pure @*/boolean hasOutcome(final Outcome theOutcome) {
    Iterator<Outcome> iterator = this.listOfOutcomes.getOutcomes().iterator();
    while (iterator.hasNext()) {
      Outcome outcome = iterator.next();
      if (outcome.equals(theOutcome)) {
        return true;
      }
    }
    return false;
  }
  
  /**
   * Count the number of winners in this scenario.
   * <p>
   * There is at least one winner and one loser in each valid scenario
   * </p>
   * 
   * @return The number of winners
   */
  /*@
   * ensures 0 < \result;
   * ensures \result < this.outcomes.size();
   */
  public/*@ pure @*/int numberOfWinners() {
    int count = 0;
    Iterator<Outcome> iterator = this.listOfOutcomes.getOutcomes().iterator();
    while (iterator.hasNext()) {
      Outcome outcome = iterator.next();
      if (outcome == Outcome.CompromiseWinner || outcome == Outcome.TiedWinner
          || outcome == Outcome.QuotaWinner || outcome == Outcome.Winner) {
        count++;
      }
    }
    return count;
  }
  
  /**
   * Calculate the maximum number
   * of distinct scenarios when the number of winners and losers is known,
   * adjusted by restricting invalid combinations of tied outcomes
   * 
   * @param winners
   *          The number of winners
   * @param losers
   *          The number of losers
   * @return The number of distinct scenarios
   */
  /*@
   * requires 0 < winners;
   * requires 0 < losers;
   * ensures 4 <= \result;
   */
  public static int numberOfScenarios(final int winners, final int losers) {
    if (winners == 1) {
      if (losers == 1) {
        return 4;
      }
      // Although there are six kinds of loser outcome, a Tied Sore Loser can
      // only be combined with an existing Tied Sore Loser
      return 5 * numberOfScenarios(winners, losers - 1);
    }
    return 4 * numberOfScenarios(winners - 1, losers);
  }
  
  /**
   * Estimate the number of distinct scenarios when the number of candidates is
   * known.
   * 
   * @param numberOfOutcomes
   *          The number of candidate outcomes
   * @return The total number of distinct outcomes
   */
  /*@ requires 1 < numberOfOutcomes
    @ ensures \result == (\sum int i; 1 <= i && i < numberOfOutcomes;
    @   numberOfScenarios (i, numberOfOutcomes - i));
   */
  public static /*@ pure @*/ int totalNumberOfScenarios(
      final int numberOfOutcomes) {
    int result = 0;
    for (int numberOfWinners = 1; numberOfWinners < numberOfOutcomes; numberOfWinners++) {
      result +=
          numberOfScenarios(numberOfWinners, numberOfOutcomes - numberOfWinners);
    }
    return result;
  }
  
  //@ ensures \result == this.listOfOutcomes.outcomes.size();
  public/*@ pure @*/int getNumberOfCandidates() {
    if (this.listOfOutcomes == null) {
      this.listOfOutcomes = new OutcomeList();
      return 0;
    }
    if (this.listOfOutcomes.outcomes == null) {
      listOfOutcomes.outcomes = new ArrayList<Outcome>();
      return 0;
    }
    
    return this.listOfOutcomes.outcomes.size();
  }
  
  /**
   * Does this scenario match the election result?
   * 
   * @param ballotCounting
   *          The results of the election count
   * @return True if this scenario matches this election result
   */
  //@ requires ballotCounting.isFinished();
  public boolean check(final BallotCounting ballotCounting) {
    
    final int threshold = ballotCounting.getDepositSavingThreshold();
    final int numberOfCandidates = ballotCounting.getTotalNumberOfCandidates();
    final int quota = ballotCounting.getQuota();
    
    for (Outcome outcome : this.listOfOutcomes.getOutcomes()) {
      boolean matched = false;
      
      for (int i = 0; i < numberOfCandidates; i++) {
        
        final Candidate candidate = ballotCounting.getCandidate(i);
        if (outcome.check(candidate, threshold, quota)) {
          matched = true;
          break;
        }
      }
      if (!matched) {
        return false;
      }
    }
    
    return true;
  }
  
  //@ ensures \result == byeElection;
  public/*@ pure @*/boolean isByeElection() {
    return byeElection;
  }
  
  /**
   * Does the expected scenario match the actual election result?
   * 
   * @return
   */
  public boolean matchesResult(final ElectionResult result) {
    
    final int numberOfCandidates = this.getNumberOfCandidates();
    
    for (Outcome outcome : listOfOutcomes.getOutcomes()) {
      // Find a result to match each expected outcome
      
      boolean matched = false;
      final int threshold = result.getThreshold();
      final int quota = result.getQuota();
      
      if (result.full()) { // Exact matching for Votail implementation
        for (int i = 0; i < numberOfCandidates; i++) {
          if (outcome.check(result.getCandidate(i), threshold, quota)) {
            matched = true;
          }
          
          if (matched == false) {
            return false;
          }
        }
      }
      else {
        // TODO partial matching for third party implementations
      }
      
    }
    
    return true;
  }
  
  /**
   * Get the Voting Scheme used in this Electoral Scenario.
   * 
   * @return The Voting Scheme
   */
  public/*@ pure @*/Method getMethod() {
    return method;
  }
}
