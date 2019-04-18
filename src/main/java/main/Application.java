package main;

public class Application {
    public static void main(String[] args) {
        if(args.length == 0){
            System.out.println("Usage: java -jar jar包 包名.类名 [程序参数]");
            System.exit(-1);
        }
        try {
            ISubject subject= (ISubject)Class.forName(args[0]).newInstance();
            if(args.length >1){
                String[] programArgs = new String[args.length-1];
                for(int i=1;i<args.length;i++){
                    programArgs[i-1]=args[i];
                }
                subject.main(programArgs);
            }else{
                subject.main();
            }
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


    }
}
