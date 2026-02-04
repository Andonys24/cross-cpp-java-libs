import com.sun.jna.Library;
import com.sun.jna.Native;

public class HelloJNA {
    public interface MyLib extends Library {
        MyLib INSTANCE = Native.load("myLibJNA_CPP", MyLib.class);
        void sayHelloJNA();
    }

    public static void main(String[] args) {
        HelloJNA.MyLib.INSTANCE.sayHelloJNA();
    }
}
