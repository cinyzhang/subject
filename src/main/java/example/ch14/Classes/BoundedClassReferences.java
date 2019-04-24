package example.ch14.Classes;

public class BoundedClassReferences {
    public static void main(String[] args) {
        //目的是为了提供编译期类型检查
        Class<? extends Number> bouned = int.class;
        bouned =double.class;
        bouned =Number.class;
        // or anything else derived from Number
    }
}
