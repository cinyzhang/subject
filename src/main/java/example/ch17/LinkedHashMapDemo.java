package example.ch17;

import java.util.*;

public class LinkedHashMapDemo {
    public static void main(String[] args) {
        //LRU 算法
        LinkedHashMap<Integer,String> linkedMap = new LinkedHashMap<>(16,0.75f,true);
        linkedMap.put(2,"s2");
        linkedMap.put(3,"s3");
        linkedMap.put(4,"s3");
        linkedMap.put(0,"s0");
        linkedMap.put(1,"s1");
//        System.out.println(linkedMap);
//        linkedMap.get(3);
//        linkedMap.get(1);
//        System.out.println(linkedMap);
        Collection<String> cls= new ArrayList<>();
        Iterator<String> iterator = cls.iterator();
        cls.add("uuuu");
        try{
            iterator.next();
        }catch(ConcurrentModificationException e){
            System.out.println(e);
        }
    }
}
