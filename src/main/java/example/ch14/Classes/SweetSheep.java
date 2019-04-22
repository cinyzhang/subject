package example.ch14.Classes;
class Gum{
    static{
        System.out.println("loading Gum");
    }
}
public class SweetSheep {
    public static void main(String[] args) {
        new Gum();
        /*try {
            Class.forName("example.ch14.Classes.Gum");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }*/
    }
}
