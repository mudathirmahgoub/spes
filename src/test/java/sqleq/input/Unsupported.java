package sqleq.input;

/**
 * A pair this reader does not hand to the prover, and why. Every refusal here is a refusal to
 * guess: the alternative to throwing is to translate something whose meaning the reader does not
 * know, and a prover then proves a theorem about a different pair than the one it was asked about.
 */
public final class Unsupported extends Exception {
  public Unsupported(String why) {
    super(why);
  }
}
