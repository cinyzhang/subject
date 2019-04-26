package example.ch21;

public class LiftOff implements Runnable {
    protected int countDown=10;
    private static int taskCount=0;
    private final int id= taskCount++;
    public LiftOff(){ }
    public LiftOff(int countDown){this.countDown=countDown;}
    public String status(){
        return "#"+id+"("
                + (countDown>0?countDown:"liftoff!") +").";
    }
    @Override
    public void run() {
        while(countDown-- >0){
            System.out.println(status());
            Thread.yield();
        }
    }

    public static void main(String[] args) {
        for(int i=0;i<5;i++){
          Thread thread=  new Thread(new LiftOff());
          thread.start();
        }
        System.out.println("main over");
    }
}
