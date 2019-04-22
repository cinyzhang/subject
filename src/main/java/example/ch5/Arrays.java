package example.ch5;

public class Arrays {
    public static void main(String[] args) {
        int[][][] arr= new int[5][][];
        System.out.println(java.util.Arrays.toString(arr));
        //总结：Arrays.toString可以打印一维数组；
        //数组初始化时第一维必须指定长度，否则编译通不过；
    }
}
