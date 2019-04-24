package example.ch14.Classes;


import java.util.Random;

class Initable{
    static final int STATIC_FINAL = 47;
    static final int STATIC_FINAL2= ClassInitilization.rand.nextInt(1000);
    static{
        System.out.println("initializing Initiable");
    }
}
class Initable2{
    static  int STATIC_NON_FINAL = 147;
    static{
        System.out.println("initializing Initiable2");
    }
}
public class ClassInitilization {
    public static Random rand = new Random(47);
    public static void main(String[] args) {
       Class initiable= Initable.class;
        System.out.println("after creating initable ref");

        //DOES NOT TRIGGER INITIALIZE
        System.out.println(Initable.STATIC_FINAL);
        //DOES  TRIGGER INITIALIZE
        System.out.println(Initable.STATIC_FINAL2);
        System.out.println(Initable2.STATIC_NON_FINAL);

    }
}
