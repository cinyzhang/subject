package test.kafka;


import kafka.javaapi.producer.Producer;
import kafka.producer.KeyedMessage;
import kafka.producer.ProducerConfig;
import main.ISubject;
import util.FileUtil;

import java.util.List;
import java.util.Properties;

public class KafkaProducerTest implements ISubject {


    private Producer<String,String> createProducer(String bootstrapserver) {
        Properties props = new Properties();
        props.put("metadata.broker.list", bootstrapserver);
        props.put("serializer.class", "kafka.serializer.StringEncoder");
        ProducerConfig config = new ProducerConfig(props);
        Producer<String,String> producer = new Producer<>(config);
        return producer;
    }



    @Override
    public void main(String... args) {
        if(args.length== 3){

            String bootstrapserver = args[0];
            Producer<String, String> producer = createProducer(bootstrapserver);
            String filePath = args[1];
            String topic=args[2];
            List<String> messages = FileUtil.readFileToLine(filePath);
            if(messages!=null && messages.size()>0){
                for(int i=0;i<messages.size();i++){
                    producer.send(new KeyedMessage(topic,messages.get(i)));
                    System.out.println(messages.get(i));
                }
                producer.close();
            }
        }else{
            System.out.println("KafkaProducerTest Usage: "+
                    "[bootstrap-server] [filePath] [topic]"
            );
            System.exit(-2);
        }
    }
}
