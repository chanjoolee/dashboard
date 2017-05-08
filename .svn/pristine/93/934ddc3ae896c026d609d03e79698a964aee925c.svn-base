/*
 * @(#) EfAuthException.java
 */
package dashboard.exception;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * 
 * <pre>
 *  권한체크시 Exception 정의
 * </pre>
 * 
 * @version 0.1
 * @author scs / scs@envalue.biz / 작성일 : 2011. 10. 28 <br>
 *
 */
public class DashAuthException extends Exception {

    private static final long serialVersionUID = -4825029922667886462L;


    public DashAuthException(String s) {
        super(s);
    }

    public DashAuthException(String s, Throwable t) {
        super(s, t);
    }

    public DashAuthException(Throwable t) {
        super(t.getMessage(), t);
    }

    public Throwable getRootCause() {
        Throwable t;
        for (t = getCause(); t != null; t = t.getCause())
            if (t.getCause() == null) {
                break;
            }
        return t;
    }
    
    public String getStringStackTrace()  {
        
//      ByteArrayOutputStream bos = new ByteArrayOutputStream();
//      PrintWriter pw = new PrintWriter(bos);
//      super.printStackTrace(pw);
//      pw.flush();
//      return bos.toString();
        
        StringWriter sw = new StringWriter();
        super.printStackTrace(new PrintWriter(sw));
        return sw.toString();
    }

    public void printStackTrace(PrintWriter pw) {
        pw.println(getStackTrace());
    }
}
