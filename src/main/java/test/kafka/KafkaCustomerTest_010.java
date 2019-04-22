package test.kafka;

import main.ISubject;
import org.apache.kafka.clients.consumer.*;

import java.util.Arrays;
import java.util.Properties;

/**
 * kafka 消费测试
 */
/*public class KafkaCustomerTest_010 implements ISubject {

    private static final String group = "group-1";

    private static Consumer<String, String> createCustomer(String bootstrapServers) {
        Properties props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        props.put(ConsumerConfig.GROUP_ID_CONFIG, group);
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");
        props.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "true"); // 自动commit
        props.put(ConsumerConfig.AUTO_COMMIT_INTERVAL_MS_CONFIG, "1000"); // 自动commit的间隔
        props.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, "30000");
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringDeserializer");
        Consumer<String, String> consumer = new KafkaConsumer<String, String>(props);
        return consumer;
    }


    @Override
    public void main(String... args) {
        if(args.length==2){
            String bootstrapServers=args[0];
            String topic = args[1];
            Consumer<String, String> customer = createCustomer(bootstrapServers);
            customer.subscribe(Arrays.asList(topic));
            System.out.println("press `ctr-c` to break");
            while(true){
                ConsumerRecords<String, String> records = customer.poll(1000);
                if(records != null && records.count()>0){
                    System.out.println("从kafka队列读取到消息:");
                    long start = System.currentTimeMillis();
                    for (ConsumerRecord<String, String> record : records) {
                        System.out.printf("%s \n",  record.value());
                    }
                    long end =System.currentTimeMillis();
                    System.out.println("共"+records.count()+" 条数据，总共耗时："+(end-start) +"ms");
                }
            }
        }else{
            System.out.println("KafkaCustomerTest_010 Usage: "+
                    "[bootstrap-server]  [topic]"
            );
            System.exit(-3);
        }
    }
}*/
