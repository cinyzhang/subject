package example.ch20;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class UseCaseTracker {
    public static void trackUseCases(List<Integer> useCases,Class<?> clazz){
       for(Method method:clazz.getDeclaredMethods()){
           UseCase annotation = method.getAnnotation(UseCase.class);
           if(annotation!=null){
               System.out.println("id= "+annotation.id() +" ,description= "+annotation.description());
               useCases.remove(new Integer(annotation.id()));
           }
            for(int  i:useCases){
                System.out.println("Warning,Missing use case -"+i);
            }
       }
    }

    public static void main(String[] args) {
        List<Integer> useCases= new ArrayList<>();
        Collections.addAll(useCases,47,48,49,50);
        trackUseCases(useCases,PasswordUtils.class);
    }

}
