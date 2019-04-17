package util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    public static List<String> readFileToLine(String filePath){
        ArrayList<String>  messages = new ArrayList<>();
        File file = new File(filePath);
        if(file.isDirectory()){
            File[] files = file.listFiles();
            for(File file1 : files){
                List<String> lines = com.xiaoleilu.hutool.io.FileUtil.readLines(file1, "utf-8");
                for(String line:lines){
                    messages.add(line);
                }
            }
        }else{
            List<String> lines = com.xiaoleilu.hutool.io.FileUtil.readLines(file, "utf-8");
            for(String line:lines){
                messages.add(line);
            }
        }
        return messages;
    }
}
