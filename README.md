本项目目的是为了检查kafka和hbase的读写性能测试
# kafka 读测试
`java -jar subject-1.0.jar test.kafka.KafkaCustomerTest [zookeeper-connect]  [topic]`
###### 参数说明： zookeeper-connect以，分割 

# kafka 写测试
`java -jar subject-1.0.jar test.kafka.kafkaProducerTest [bootstrap-server] [filePath] [topic] `
###### 参数说明: bootstrap-server以，分割

# hbase 写测试
`java -jar subject-1.0.jar test.hbase.HBaseTest [write] [表名] [文件路径]`
###### 参数说明: write-指写操作

# hbase 读测试
`java -jar subject-1.0.jar test.hbase.HBaseTest [read] [表名]`
###### 参数说明: read-指读操作 



