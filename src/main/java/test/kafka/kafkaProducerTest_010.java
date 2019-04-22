package test.kafka;

import main.ISubject;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.common.serialization.StringSerializer;
import util.FileUtil;

import java.util.List;
import java.util.Properties;

/**
 * kafka 生产测试
 */
/*public class kafkaProducerTest_010 implements ISubject {

    private static  KafkaProducer<String, String> createProducer(String bootstrapServers){
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());

        KafkaProducer<String, String>  producer = new KafkaProducer<String, String>(props);
        return producer;
    }

    @Override
    public void main(String... args) {
        if(args.length== 3){
            String bootstrapserver = args[0];
            String filePath = args[1];
            String topic=args[2];
            KafkaProducer<String, String> producer = createProducer(bootstrapserver);
            List<String> messages = FileUtil.readFileToLine(filePath);
            if(messages!=null && messages.size()>0){
                for(int i=0;i<messages.size();i++){
                    producer.send(new ProducerRecord<String, String>(topic,messages.get(i)));
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
}*/
