package SimpleQueryTests;
import io.github.cvc5.*;

public class Cvc5Test
{  
  public static void main(String[] args) throws CVC5ApiException
  {    
    TermManager tm = new TermManager();
    Solver solver = new Solver(tm);
    solver.setLogic("ALL");     
    solver.setOption("produce-models", "true");       
    Term x = tm.mkVar(tm.getIntegerSort(), "x");
    Term xList = tm.mkTerm(Kind.VARIABLE_LIST, new Term[] {x});
    Term gt = tm.mkTerm(Kind.GT, x, tm.mkInteger(1));
    Term witness = tm.mkTerm(Kind.WITNESS, xList, gt);         
    Term y = tm.mkVar(tm.getIntegerSort(), "y");
    Term equal = y.eqTerm(witness);
    solver.assertFormula(equal);
    Result result = solver.checkSat();
    System.out.println(result);
  }
}
