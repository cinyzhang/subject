package example.ch15;

public class GenericMethod {
    public static <T> void print(T x){
        System.out.println(x.getClass().getName());
    }

    public static void main(String[] args) {
        print(1);
        print(1.0f);
        print(new GenericMethod());
    }
}
