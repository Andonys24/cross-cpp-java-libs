public class HelloJNI {
    static {
        System.loadLibrary("myLibJNI_CPP");
    }

    private native void sayHello();

    public static void main(String[] args) {
        new HelloJNI().sayHello();
    }
}
