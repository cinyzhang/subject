package example.ch16;

public class Arrays {
    public static void main(String[] args) {
//        char[] cs= new char[5];
//        System.out.println(java.util.Arrays.toString(cs));
//        Boolean[][] bs = new Boolean[5][];
//        System.out.println(java.util.Arrays.deepToString(bs));

        //sort
        //binarySearch 用于在已经排序的数组中查找元素
        //asList
        //fill
        //equals 数组个数相等，并且对应的位置元素相同
        int[] i= new int[7];
        int[] j = new int[10];
        java.util.Arrays.fill(i,47);
        java.util.Arrays.fill(j,99);
        System.out.println("i= "+java.util.Arrays.toString(i));
        System.out.println("j= "+java.util.Arrays.toString(j));
        System.arraycopy(i,0,j,2,i.length);
        System.out.println("j= "+java.util.Arrays.toString(j));
        String[] s1 = new String[4];
        java.util.Arrays.fill(s1,"hi");
        String[] s2 ={"hi","hi","hi","hi"};
        System.out.println(java.util.Arrays.equals(s1,s2));
    }
}
