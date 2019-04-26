package example.ch21;

import java.util.ArrayList;
import java.util.concurrent.*;

public class TaskWithResult implements Callable<String> {
    private int id;
    public TaskWithResult(int id){
        this.id = id;
    }
    @Override
    public String call() throws Exception {
        return "Result of TaskWithResult: "+id;
    }

    public static void main(String[] args) {
        ExecutorService es = Executors.newFixedThreadPool(5);
        ArrayList<Future<String>> results = new ArrayList<>();
        for(int i=0;i<10;i++){
            results.add(es.submit(new TaskWithResult(i)));
        }
        for(Future<String> f:results){
            try {
                //get() blocks until completion
                System.out.println(f.get());
            } catch (InterruptedException e) {
                System.out.println(e);
                return;
            } catch (ExecutionException e) {
                e.printStackTrace();
                return;
            }
        }
        es.shutdown();
    }
}
