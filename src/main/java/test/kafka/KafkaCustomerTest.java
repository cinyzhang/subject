package test.kafka;

import kafka.consumer.ConsumerConfig;
import kafka.consumer.ConsumerIterator;
import kafka.consumer.KafkaStream;
import kafka.javaapi.consumer.ConsumerConnector;
import kafka.serializer.StringDecoder;
import kafka.utils.VerifiableProperties;
import main.ISubject;

import java.util.*;

public class KafkaCustomerTest  implements ISubject{

    private ConsumerConnector createConsumer(String bootstrapserver) {
        Properties props = new Properties();
        props.put("zookeeper.connect", bootstrapserver);
        props.put("group.id", "group-1");

        //zk连接超时
        props.put("zookeeper.session.timeout.ms", "400");
        props.put("zookeeper.sync.time.ms", "200");
        props.put("auto.commit.interval.ms", "1000");
        props.put("auto.offset.reset", "smallest");
        //序列化类
        props.put("serializer.class", "kafka.serializer.StringDecoder");

        ConsumerConfig config = new ConsumerConfig(props);

        ConsumerConnector consumerConnector = kafka.consumer.Consumer.createJavaConsumerConnector(config);

        return consumerConnector;
    }

    @Override
    public void main(String... args) {
        if(args.length==2){
            String bootstrapServers=args[0];
            String topic = args[1];
            ConsumerConnector consumerConnector = createConsumer(bootstrapServers);
            Map<String, Integer> topicCountMap = new HashMap<String, Integer>();
            topicCountMap.put(topic, new Integer(1));

            StringDecoder keyDecoder = new StringDecoder(new VerifiableProperties());
            StringDecoder valueDecoder = new StringDecoder(new VerifiableProperties());

            Map<String, List<KafkaStream<String, String>>> consumerMap = consumerConnector.createMessageStreams(topicCountMap, keyDecoder, valueDecoder);
            while(true){
                List<KafkaStream<String, String>> streams = consumerMap.get(topic);
                for (final KafkaStream stream : streams) {
                    ConsumerIterator<String, String> it = stream.iterator();
                    while (it.hasNext()) {
                        System.out.println("this is kafka consumer : " +  it.next().message().toString() );
                    }
                    System.out.println("press `ctr-c` to break");
                }
            }

        }else{
            System.out.println("KafkaCustomerTest Usage: "+
                    "[zookeeper-connect]  [topic]"
            );
            System.exit(-3);
        }
    }
}
