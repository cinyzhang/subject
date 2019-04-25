use test;
drop table if exists wid_ufdr_http;
drop table if exists wid_streaming;
drop table if exists wid_ufdr_http_log;
-- 业务感知 HTTP话单
create table if not exists test.wid_ufdr_http(
Interface int comment '接口类型：1、S1_U 4、S11 6、S5/S8 7、S2a 13、Gn/Gp 14、L2TP（3/4G LAC__LNS）',
IMSI  string comment '用户的国际移动用户识别码',
MSISDN string comment '用户手机号码',
IMEISV string comment '移动台设备标识',
APN  string comment '网络接入标识',
DestinationIP  string comment '用户访问的目标IPv4或IPv6地址',
DestinationPort  int  comment '用户访问的目标端口号',
SourceIP  string comment '用户访问外部网络时使用的IPv4或IPv6地址',
SourcePort  int comment '用户访问外部网络时使用的端口号',
SGWIP  string comment 'SGW的IPv4或IPv6地址',
MMEIP  string comment 'MME的IPv4或IPv6地址',
PGWIP  string comment 'PGW的IPv4或IPv6地址',
ECGI   string comment '小区',
TAI   string comment '跟踪区标识',
VisitedPLMNId   string comment '拜访网络标识',
RATType  int comment '用户所接入的网络类型',
ProtocolID  int comment '协议类型，参见附录J',
ServiceType  string comment '业务应用',
StartTime   string comment '业务流开始时间，格式为yyyymmddhhmmss（24小时制），如果开启中间记录模式，每条记录都填写相同的开始时间',
EndTime  string comment '业务流结束时间，格式为yyyymmddhhmmss（24小时制），如果开启中间记录模式，只在最后一条记录填写结束时间',
Duration  int comment '持续时间，单位毫秒',
InputOctets  int comment '发给用户的业务字节数',
OutputOctets  int comment '用户发出的业务字节数',
InputPacket  int comment '发给用户的业务数据包数量',
OutputPacket  int comment '用户发出的业务数据包数量',
PDNConnectionId  string comment 'PDN连接的ID标识号',
BearerID  int comment '承载标识号',
BearerQoS  string comment '承载QoS',
RecordCloseCause  int comment '记录关闭原因,DPI设备自动生成，数字编号（0：session释放；1：业务应用结束；2：业务应用等待超时；3：用户位置（TAI）变化；4：用户接入方式变化）',
ENBIP  string comment 'ENB的IPv4或IPv6地址',
SGWPort  int comment '对于S1_U口，填写SGW端口',
eNBPort  int comment '对于S1_U口，填写eNB端口',
eNBGTP_TEID  int comment '对于S1_U口，填写该业务对应承载的eNB侧GTP_TEID',
SGWGTP_TEID  int comment '对于S1_U口，填写该业务对应承载的SGW侧GTP_TEID',
PGWPort int comment 'PGW port',
MMEUES1APID  int comment 'MME分配的S1AP ID ',
eNBUES1APID  int comment 'ENodeB分配的S1AP ID',
MMEGroupID  int comment 'MME Group ID',
MMECode  int comment 'MME Code',
eNBID  int  comment 'eNodeB id',
Home_Province  string comment '归属省份',
UserIP  string comment 'USER_IP',
UserPort   int comment 'User Port',
L4protocol  int comment 'L4协议类型：0：TCP 1：UDP',
AppServerIP  string comment '访问服务器的IPv4或IPv6地址，如无则填全F',
AppServerPort  int comment '访问的服务器的端口',
ULTCPReorderingPacket  int comment '上行TCP乱序报文数L4协议非TCP传输时，此字段填0',
DLTCPReorderingPacket  int comment '下行TCP乱序报文数',
ULTCPRetransPacket   int comment '上行TCP重传报文数',
DLTCPRetransPacket  int comment '下行TCP重传报文数',
TCPSetupResponseDelay  int comment 'TCP建链响应时延（ms）',
TCPSetupACKDelay   int comment 'TCP建链确认时延（ms）',
ULIPFragPacks  int comment '以内层IP包的分片为准',
DLIPFragPacks  int comment '以内层IP包的分片为准',
Delay_Setup_FirstTransaction   int comment 'TCP建链成功到第一条事务请求的时延（ms',
Delay_FirstTransaction_FirstResPackt   int  comment '第一条事务请求到其第一个响应包时延（ms',
WindowSize   int  comment '窗口大小',
MSSSize    int  comment 'MSS大小',
TCPSynNumber  int  comment 'TCP建链尝试次数',
TCPConnectState   int  comment 'TCP连接状态指示',
SessionStopFlag  int  comment '会话是否结束标志',
UEAMBRUL  int  comment '上行UE AMBR',
UEAMBRDL  int  comment '下行UE AMBR',
BearerQCI  int  comment '承载的QCI，取值范围从1到9',
UserAgent string comment 'User Agent信息',
DestinationURL string  comment '用户访问的目标网站的URL',
DomainName string  comment '外部网站的域名',
Host string comment '主机名',
ContentLen int comment '内容大小',
ContentType string comment '内容类型',
IfLink int comment '是否是链接访问，0=否，1=是',
Referer string comment '链接源信息',
HTTPAction int comment 'HTTP操作类型（5: Post, 6:Get）',
HTTPStatus int comment 'HTTP状态码，请参照附录A.1 HTTPSTATUS表',
RespDelay int comment '响应时延，单位毫秒',
BehaviorTarget  int comment '目标行为，0：会话是用户主动点击的页面；1：站点目标而产生的页面。',
SYNtime   int comment 'SYN时间戳',
SYNACKtime int comment 'SYN时间戳',
ACKtime int comment 'ACK时间戳',
ActionTime  int comment '首个HTTP请求的时间戳',
FirstPacketTime  int comment '第一个数据响应包的时间戳',
PageOpenTime  int comment '首页打开的时间戳',
Lastpacktime  int comment '最后一个数据包时间戳',
PageVolume  int comment '首页数据大小',
HttpVersion  int comment 'HTTP版本',
FirstResptime  int comment '第一个HTTP响应包时间戳',
LastAcktime   int comment '最后一个ACK确认包的时间戳',
Cookie    string comment '',
WtpFailType   int comment 'Wtp中断类型',
WtpFailCause   int  comment 'wtp中断原因',
title   string comment '',
keyword   string comment '',
WebBrowser   int comment '浏览工具',
FirstFinAckTime   int comment '第一个TCP FinAck包时间戳',
DNSQueryTime   int  comment 'DNS关联流的请求时间戳。无关联流，此字段填写0',
DNSResponseTime   int comment 'DNS关联流的应答时间戳。无关联流，此字段填写0',
DNSFlowID   int comment 'HTTP流与DNS流的关联ID。无关联流时，此字段填写0',
FirstScreenFinTime   int  comment '首屏完成时间戳，默认值0。',
HTTPResponse   string  comment 'HTTP 200响应码及消息头部分',
Transactions    int  comment '同一个流中的事务计数'
)
row format delimited
fields terminated by '|'
stored as inputformat
'org.apache.hadoop.mapred.TextInputFormat'
outputformat
'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
-- video
create table if not exists  test.wid_streaming(
Interface int comment '接口类型：1、S1_U 4、S11 6、S5/S8 7、S2a 13、Gn/Gp 14、L2TP（3/4G LAC__LNS）',
IMSI  string comment '用户的国际移动用户识别码',
MSISDN string comment '用户手机号码',
IMEISV string comment '移动台设备标识',
APN  string comment '网络接入标识',
DestinationIP  string comment '用户访问的目标IPv4或IPv6地址',
DestinationPort  int  comment '用户访问的目标端口号',
SourceIP  string comment '用户访问外部网络时使用的IPv4或IPv6地址',
SourcePort  int comment '用户访问外部网络时使用的端口号',
SGWIP  string comment 'SGW的IPv4或IPv6地址',
MMEIP  string comment 'MME的IPv4或IPv6地址',
PGWIP  string comment 'PGW的IPv4或IPv6地址',
ECGI   string comment '小区',
TAI   string comment '跟踪区标识',
VisitedPLMNId   string comment '拜访网络标识',
RATType  int comment '用户所接入的网络类型',
ProtocolID  int comment '协议类型，参见附录J',
ServiceType  string comment '业务应用',
StartTime   string comment '业务流开始时间，格式为yyyymmddhhmmss（24小时制），如果开启中间记录模式，每条记录都填写相同的开始时间',
EndTime  string comment '业务流结束时间，格式为yyyymmddhhmmss（24小时制），如果开启中间记录模式，只在最后一条记录填写结束时间',
Duration  int comment '持续时间，单位毫秒',
InputOctets  int comment '发给用户的业务字节数',
OutputOctets  int comment '用户发出的业务字节数',
InputPacket  int comment '发给用户的业务数据包数量',
OutputPacket  int comment '用户发出的业务数据包数量',
PDNConnectionId  string comment 'PDN连接的ID标识号',
BearerID  int comment '承载标识号',
BearerQoS  string comment '承载QoS',
RecordCloseCause  int comment '记录关闭原因,DPI设备自动生成，数字编号（0：session释放；1：业务应用结束；2：业务应用等待超时；3：用户位置（TAI）变化；4：用户接入方式变化）',
ENBIP  string comment 'ENB的IPv4或IPv6地址',
SGWPort  int comment '对于S1_U口，填写SGW端口',
eNBPort  int comment '对于S1_U口，填写eNB端口',
eNBGTP_TEID  int comment '对于S1_U口，填写该业务对应承载的eNB侧GTP_TEID',
SGWGTP_TEID  int comment '对于S1_U口，填写该业务对应承载的SGW侧GTP_TEID',
PGWPort int comment 'PGW port',
MMEUES1APID  int comment 'MME分配的S1AP ID ',
eNBUES1APID  int comment 'ENodeB分配的S1AP ID',
MMEGroupID  int comment 'MME Group ID',
MMECode  int comment 'MME Code',
eNBID  int  comment 'eNodeB id',
Home_Province  string comment '归属省份',
UserIP  string comment 'USER_IP',
UserPort   int comment 'User Port',
L4protocol  int comment 'L4协议类型：0：TCP 1：UDP',
AppServerIP  string comment '访问服务器的IPv4或IPv6地址，如无则填全F',
AppServerPort  int comment '访问的服务器的端口',
ULTCPReorderingPacket  int comment '上行TCP乱序报文数L4协议非TCP传输时，此字段填0',
DLTCPReorderingPacket  int comment '下行TCP乱序报文数',
ULTCPRetransPacket   int comment '上行TCP重传报文数',
DLTCPRetransPacket  int comment '下行TCP重传报文数',
TCPSetupResponseDelay  int comment 'TCP建链响应时延（ms）',
TCPSetupACKDelay   int comment 'TCP建链确认时延（ms）',
ULIPFragPacks  int comment '以内层IP包的分片为准',
DLIPFragPacks  int comment '以内层IP包的分片为准',
Delay_Setup_FirstTransaction   int comment 'TCP建链成功到第一条事务请求的时延（ms',
Delay_FirstTransaction_FirstResPackt   int  comment '第一条事务请求到其第一个响应包时延（ms',
WindowSize   int  comment '窗口大小',
MSSSize    int  comment 'MSS大小',
TCPSynNumber  int  comment 'TCP建链尝试次数',
TCPConnectState   int  comment 'TCP连接状态指示',
SessionStopFlag  int  comment '会话是否结束标志',
UEAMBRUL  int  comment '上行UE AMBR',
UEAMBRDL  int  comment '下行UE AMBR',
BearerQCI  int  comment '承载的QCI，取值范围从1到9',
VideoPlaySuccess int comment '视频成功播放的标识',
VideoPlayWaitTime int comment '视频播放等待时长',
VideoPlayHaltCount int comment '视频播放卡顿次数',
VideoRecoverTime int comment '视频卡顿时长',
FirstDataPkgTime  int comment '视频下行第一个有效数据包时间戳',
LastDataPkgTime int comment '视频下行最后一个有效数据包时间戳',
VideoApp string comment '视频网站名称',
VideoSize  int comment '视频文件大小',
VideoThroughput  int comment '视频下载速率',
VideoType  int comment '视频文件格式',
VideoBitRate  int comment '视频码率',
VideoCacheThroughput  int comment '视频缓冲段下载速率',
DestinationURL  string comment '用户访问的目标视频网站的URL',
Host  string comment '主机名',
CachedVideoSize  int comment '缓冲段视频大小',
CachedVideoDuration  int comment '缓冲段视频下载时长'
)
row format delimited
fields terminated by '|'
stored as inputformat
'org.apache.hadoop.mapred.TextInputFormat'
outputformat
'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
-- 上网日志http话单
create table if not exists  test.wid_ufdr_http_log(
IMSI string comment '用户的国际移动用户识别码',
MSISDN string comment '用户手机号码',
IMEI string comment '移动台设备标识',
APN  string comment '网络接入标识，用户的帐号，标识用户名和归属网络，',
DestinationIP  string comment '用户访问的目标IPv4或IPv6地址',
DestinationPort  int comment '用户访问的目标端口号',
SourceIP  string comment '用户访问外部网络时使用的IPv4或IPv6地址',
SourcePort  int comment '用户访问外部网络时使用的端口号',
SGWIP  string comment '用户访问外部网络时使用的端口号',
MMEIP  string comment 'MME的IPv4或IPv6地址',
PGWIP  string comment 'PGW的IPv4或IPv6地址',
ECGI_BSID   string comment 'ECGI:E_UTRAN 小区全局标识符，MCC+MNC+CELLID；BSID:eHRPD基站标识，SID（4octets）+NID（4octets）+CI（4octets）。CI的高12比特为小区标识，低4比特为扇区标识',
TAI  string comment '跟踪区标识',
VisitedPLMNId  string comment '拜访网络标识',
RATType int comment '用户所接入的网络类型',
ProtocolID  int comment '协议类型，参见附录J',
ServiceType  string comment '业务应用',
StartTime string comment '业务流开始时间，格式为yyyymmddhhmmss',
EndTime  string comment '业务流结束时间，格式为yyyymmddhhmmss',
Duration  int comment '持续时间，单位毫秒',
InputOctets  int comment '发给用户的业务字节数',
OutputOctets  int comment '用户发出的业务字节数',
InputPacket  int comment '发给用户的业务数据包数量',
OutputPacket  int comment '用户发出的业务数据包数量',
PDNConnectionId  string comment 'PDN连接的ID标识号',
BearerID  int comment '承载标识号',
BearerQoS  string comment '承载QoS',
RecordCloseCause  int comment '记录关闭原因',
UserAgent string comment 'User Agent信息',
DestinationURL string  comment '用户访问的目标网站的URL',
DomainName string  comment '外部网站的域名',
Host string comment '主机名',
ContentLen int comment '内容大小',
ContentType string comment '内容类型',
IfLink int comment '是否是链接访问，0=否，1=是',
Referer string comment '链接源信息',
HTTPAction int comment 'HTTP操作类型（5: Post, 6:Get）',
HTTPStatus int comment 'HTTP状态码，请参照附录A.1 HTTPSTATUS表',
RespDelay int comment '响应时延，单位毫秒',
BehaviorTarget  int comment '目标行为，0：会话是用户主动点击的页面；1：站点目标而产生的页面。',
SYNtime   int comment 'SYN时间戳',
SYNACKtime int comment 'SYN时间戳',
ACKtime int comment 'ACK时间戳',
ActionTime  int comment '首个HTTP请求的时间戳',
FirstPacketTime  int comment '第一个数据响应包的时间戳',
PageOpenTime  int comment '首页打开的时间戳',
Lastpacktime  int comment '最后一个数据包时间戳',
LastVideoPacketTime int comment '最后一个视频数据包时间戳',
PageVolume int comment '首页数据大小',
VideoVolume  int comment '视频流大小',
Cookie string comment 'Cookie信息',
HTTPResponse string comment 'HTTP 200响应码及消息头部分'
)
row format delimited
fields terminated by '|'
stored as inputformat
'org.apache.hadoop.mapred.TextInputFormat'
outputformat
'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
-- 加载数据到hive 
hadoop fs -mkdir -p /testdata/http;
hadoop fs -mkdir  /testdata/log;
hadoop fs -mkdir  /testdata/video;
hadoop fs -put /home/hdfs/http/http-01.txt /testdata/http
hadoop fs -put /home/hdfs/http/http-02.txt /testdata/http
>hive
>load data inpath '/testdata/http/http-01.txt' into table wid_ufdr_http;
>load data inpath '/testdata/http/http-02.txt' into table wid_ufdr_http; 
-- count
select  count(*) from  wid_ufdr_http ;
-- join
select a.MSISDN from wid_ufdr_http  a ,wid_ufdr_http b where a.MSISDN = b.MSISDN and a.MSISDN like '1770009999%'
-- group by
select MSISDN,count(DISTINCT UserIP) from wid_ufdr_http group by MSISDN;
-- order by
select MSISDN from wid_ufdr_http order by  MSISDN;
--substr
select substr(MSISDN,1,3),Interface,IMSI from wid_ufdr_http;
--insert
insert into wid_ufdr_http select * from  wid_ufdr_http where MSISDN = 17700099999
-- 空载测试
select * from  wid_ufdr_http;
-- 负载测试
load data inpath '/testdata/http/S1uhttp-GuangDong-20190401092212-20190401092217-00000000.txt.gz' into table  wid_ufdr_http;
package test.hbase;

import main.ISubject;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.*;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp;
import org.apache.hadoop.hbase.filter.FilterList;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.util.Bytes;
import util.FileUtil;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

/**
 * HBase 读写测试
 */
public class HBaseTest implements ISubject {

	/**
	 * 配置
	 */
	static Configuration config = null;
	static {
		config = HBaseConfiguration.create();// 配置
		//config.set("hbase.zookeeper.quorum", "master1ha,master2,master2ha");// zookeeper地址
		//config.set("hbase.zookeeper.property.clientPort", "2181");// zookeeper端口
	}

	/**
	 * 创建一个表，这个表没有任何region
	 * HBaseAdmin创建表的后两个函数是创建表的时候帮你分配好指定数量的region（提前分配region的好处
	 * ，了解HBase的人都清楚，为了减少Split，这样能节省不少时间）
	 * 
	 * @param strTableName
	 * @param families
	 */
	public void createTable(String strTableName, String[] families) {
		HBaseAdmin admin = null;
		try {
			admin = new HBaseAdmin(config); // hbase表管理
			if (admin.tableExists(strTableName)) { // 表是否存在
				System.out.println(strTableName + "表已经存在！");
                deleteTable(strTableName);
			}
            TableName tableName = TableName.valueOf(strTableName); // 表名称
            HTableDescriptor desc = new HTableDescriptor(tableName);
            for (int i = 0; i < families.length; i++) {
                HColumnDescriptor family = new HColumnDescriptor(
                        families[i]); // 列族
                desc.addFamily(family);
            }
            admin.createTable(desc); // 创建表
            System.out.println("创建表 \'" + tableName + "\' 成功!");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (admin != null) {
					admin.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 删除表
	 * 
	 * @param strTableName
	 */
	@SuppressWarnings("deprecation")
	public void deleteTable(String strTableName) {
		HBaseAdmin admin = null;
		try {
			admin = new HBaseAdmin(config);
			if (!admin.tableExists(strTableName)) {
				System.out.println(strTableName + "表不存在！");
			} else {
				//admin.disableTable(strTableName);
				admin.deleteTable(strTableName);
				System.out.println(strTableName + "表删除成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (admin != null) {
					admin.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 插入数据
	 * 
	 * @param strTableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param value
	 */
	public void insertData(String strTableName, String rowKey, String family,
			String qualifier, String value) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Put put = new Put(Bytes.toBytes(rowKey)); // 获取put，用于插入
			put.add(Bytes.toBytes(family), Bytes.toBytes(qualifier),
					Bytes.toBytes(value)); // 封装信息
			table.put(put); // 添加记录
			/*
			 * // 批量插入 List<Put> list = new ArrayList<Put>(); Put put = new
			 * Put(Bytes.toBytes(rowKey));//获取put，用于插入
			 * put.add(Bytes.toBytes(family),
			 * Bytes.toBytes(qualifier),Bytes.toBytes(value));//封装信息
			 * list.add(put); table.put(list);//添加记录
			 */
			System.out.println("插入记录成功！");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 更新表中某一行某一列
	 * 
	 * @param strTableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param newValue
	 */
	public void updateTable(String strTableName, String rowKey, String family,
			String qualifier, String newValue) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Put put = new Put(Bytes.toBytes(rowKey));
			// 仍然是插入操作(已知列族，已知列，新值)
			put.add(Bytes.toBytes(family), Bytes.toBytes(qualifier),
					Bytes.toBytes(newValue));
			table.put(put);
			System.out.println("更新成功！");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 删除数据：整行
	 * 
	 * @param strTableName
	 * @param rowKey
	 */
	@SuppressWarnings("deprecation")
	public void deleteData(String strTableName, String rowKey) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); // 获取表
			Delete del = new Delete(Bytes.toBytes(rowKey)); // 创建delete
			table.delete(del); // 删除
			System.out.println("删除记录成功！");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public void deleteColumn(String strTableName, String rowKey, String family,
			String qualifier) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Delete del = new Delete(Bytes.toBytes(rowKey));
			table.delete(del);
			System.out.println("行：" + rowKey + "，列族：" + family + "，列："
					+ qualifier + "，删除完毕！");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 通过rowkey查询数据
	 * 
	 * @param strTableName
	 * @param rowKey
	 */
	public void queryByRowKey(String strTableName, String rowKey) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Get get = new Get(rowKey.getBytes()); // 创建行记录
			Result row = table.get(get); // 获取行记录
			// row.getValue(family, qualifier); // 分别获取cell信息
			for (Cell cell : row.rawCells()) { // 循环指定行、全部列族的全部列
				System.out.println("列族："
						+ Bytes.toString(CellUtil.cloneFamily(cell)));
				System.out.println("列名： "
						+ Bytes.toString(CellUtil.cloneQualifier(cell)));
				System.out.println("列值： "
						+ Bytes.toString(CellUtil.cloneValue(cell)));
				System.out.println("行名： "
						+ Bytes.toString(CellUtil.cloneRow(cell)));
				System.out.println("时间戳： " + cell.getTimestamp());
				System.out.println("-----------------------------");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public void queryColumn(String strTableName, String rowKey, String family,
			String qualifier) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Get get = new Get(Bytes.toBytes(rowKey));
			get.addColumn(Bytes.toBytes(family), Bytes.toBytes(qualifier));
			Result result = table.get(get);
			for (Cell cell : result.rawCells()) {
				System.out.println("列族："
						+ Bytes.toString(CellUtil.cloneFamily(cell)));
				System.out.println("列名： "
						+ Bytes.toString(CellUtil.cloneQualifier(cell)));
				System.out.println("列值： "
						+ Bytes.toString(CellUtil.cloneValue(cell)));
				System.out.println("行名： "
						+ Bytes.toString(CellUtil.cloneRow(cell)));
				System.out.println("时间戳： " + cell.getTimestamp());
				System.out.println("-----------------------------");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 查询表中全部数据，即hbase shell：scan 'tableName'
	 * 
	 * @param strTableName
	 */
	public void queryAll(String strTableName) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Scan scan = new Scan(); // 创建scan
			// scan.setStartRow("r0".getBytes()); // 添加开始rowkey
			// scan.setStopRow("r5".getBytes()); // 结束rowkey，不包括r5
			ResultScanner resultScanner = table.getScanner(scan);
			// 两种方式：
			// 1、
			for (Result row : resultScanner) {
				for (Cell cell : row.rawCells()) { // 循环指定行、全部列族的全部列
                    System.out.print("行名： "
                            + Bytes.toString(CellUtil.cloneRow(cell)));
					System.out.print(",列名： "
							+ Bytes.toString(CellUtil.cloneQualifier(cell)));
					System.out.print(",列值： "
							+ Bytes.toString(CellUtil.cloneValue(cell)));
					System.out.println("时间戳： " + cell.getTimestamp());
					System.out.println("-----------------------------");
				}
			}
			// 2、
			Iterator<Result> results = resultScanner.iterator();
			while (results.hasNext()) {
				Result result = results.next();
				List<Cell> cells = result.listCells();
				for (Cell cell : cells) {
                    System.out.print("行名： "
                            + Bytes.toString(CellUtil.cloneRow(cell)));
                    System.out.print(",列名： "
                            + Bytes.toString(CellUtil.cloneQualifier(cell)));
                    System.out.print(",列值： "
                            + Bytes.toString(CellUtil.cloneValue(cell)));
                    System.out.println("时间戳： " + cell.getTimestamp());
                    System.out.println("-----------------------------");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 过滤器查询
	 * 
	 * @param strTableName
	 * @param arr
	 */
	public void selectByFilter(String strTableName, List<String> arr) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			FilterList filterList = new FilterList(
					FilterList.Operator.MUST_PASS_ONE); // 各条件是or的关系，默认是and
			Scan scan = new Scan();
			for (String v : arr) {
				String[] s = v.split(",");
				filterList.addFilter(new SingleColumnValueFilter(Bytes
						.toBytes(s[0]), Bytes.toBytes(s[1]), CompareOp.EQUAL,
						Bytes.toBytes(s[2])));
				// 添加下面这一行后，则只返回指定的cell，同一行中的其他cell不返回
				// scan.addColumn(Bytes.toBytes(s[0]), Bytes.toBytes(s[1])); //
				// 这里貌似有问题
			}
			scan.setFilter(filterList);

			// SingleColumnValueFilter 用于测试列值相等 (CompareOp.EQUAL ),
			// 不等(CompareOp.NOT_EQUAL),或范围 (e.g., CompareOp.GREATER).
			// 下面示例检查列值和字符串'values' 相等...
			// SingleColumnValueFilter f = new
			// SingleColumnValueFilter(Bytes.toBytes("cFamily"),
			// Bytes.toBytes("column"), CompareFilter.CompareOp.EQUAL,
			// Bytes.toBytes("values"));
			// SingleColumnValueFilter f = new
			// SingleColumnValueFilter(Bytes.toBytes("cFamily"),
			// Bytes.toBytes("column"), CompareFilter.CompareOp.EQUAL,new
			// SubstringComparator("values"));
			// scan.setFilter(f);
			// ColumnPrefixFilter 用于指定列名前缀值相等
			// ColumnPrefixFilter f = new
			// ColumnPrefixFilter(Bytes.toBytes("values"));
			// scan.setFilter(f);
			// MultipleColumnPrefixFilter 和 ColumnPrefixFilter 行为差不多，但可以指定多个前缀
			// byte[][] prefixes = new byte[][] {Bytes.toBytes("value1"),
			// Bytes.toBytes("value2")};
			// Filter f = new MultipleColumnPrefixFilter(prefixes);
			// scan.setFilter(f);
			// QualifierFilter 是基于列名的过滤器。
			// Filter f = new QualifierFilter(CompareFilter.CompareOp.EQUAL, new
			// BinaryComparator(Bytes.toBytes("col5")));
			// scan.setFilter(f);
			// RowFilter是rowkey过滤器，通常根据rowkey来指定范围时，使用scan扫描器的StartRow和StopRow方法比较好。Rowkey也可以使用。
			// Filter f = new
			// RowFilter(CompareFilter.CompareOp.GREATER_OR_EQUAL, new
			// RegexStringComparator(".*5$"));//正则获取结尾为5的行
			// scan.setFilter(f);

			ResultScanner rs = table.getScanner(scan);
			for (Result result : rs) {
				for (Cell cell : result.rawCells()) {
					System.out.println("列族："
							+ Bytes.toString(CellUtil.cloneFamily(cell)));
					System.out.println("列名： "
							+ Bytes.toString(CellUtil.cloneQualifier(cell)));
					System.out.println("列值： "
							+ Bytes.toString(CellUtil.cloneValue(cell)));
					System.out.println("行名： "
							+ Bytes.toString(CellUtil.cloneRow(cell)));
					System.out.println("时间戳： " + cell.getTimestamp());
					System.out.println("-----------------------------");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (connection != null) {
					connection.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 将文件存入HBase表中，文件为二进制数组
	 * 
	 * @param strTableName
	 * @param rowKey
	 * @param family
	 * @param qualifier
	 * @param file
	 */
	public void saveFile(String strTableName, String rowKey, String family,
			String qualifier, byte[] file) {
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Put put = new Put(Bytes.toBytes(rowKey));
			put.add(Bytes.toBytes(family), Bytes.toBytes(qualifier), file);
			table.put(put);
			System.out.println("文件存储成功！");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 将文件从HBase表中取出，并存入path路径
	 * 
	 * @param strTableName
	 * @param rowKey
	 * @param path
	 */
	public void queryFile(String strTableName, String rowKey, String family,
			String qualifier, String path) {
		BufferedOutputStream bos = null;
		FileOutputStream fos = null;
		File file = null;
		Connection connection = null;
		Table table = null;
		try {
			connection = ConnectionFactory.createConnection(config);
			table = connection.getTable(TableName.valueOf(strTableName)); 
			Get get = new Get(Bytes.toBytes(rowKey));
			get.addColumn(Bytes.toBytes(family), Bytes.toBytes(qualifier));
			Result result = table.get(get);
			for (Cell cell : result.rawCells()) {
				byte[] buffer = CellUtil.cloneValue(cell);
				file = new File(path);
				fos = new FileOutputStream(file);
				bos = new BufferedOutputStream(fos);
				bos.write(buffer);
				System.out.println(path + "文件获取成功！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (table != null) {
					table.close();
				}
				if (bos != null) {
					bos.close();
				}
				if (fos != null) {
					fos.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}


    @Override
    public void main(String... args) {
       if(args.length < 2){
           System.out.println("HBaseTest Usage:\r\n"+
                   "读测试：read [表名] \r\n"+
                   "写测试：write [表名] [文件路径]"
                   );
           System.exit(-4);
       }
       if(args.length ==2 && "read".equalsIgnoreCase(args[0])){
           String tableName=args[1];
           long start=System.currentTimeMillis();
           queryAll(tableName);
           long end = System.currentTimeMillis();
           System.out.println("HBase读测试结束，总共耗时："+(end-start)+"ms");
       }
       if(args.length ==3 && "write".equalsIgnoreCase(args[0])){
           String tableName=args[1];
           String filePath=args[2];
           List<String> messages = FileUtil.readFileToLine(filePath);
           long start = System.currentTimeMillis();
           System.out.println("正在进行写测试，start time："+start);
           createTable(tableName,new String[]{"test"});
           for(int i=0;i<messages.size();i++){
                insertData(tableName,"r"+i,"test","q"+i,messages.get(i));
           }
           long end = System.currentTimeMillis();
           System.out.println("总共写入 "+messages.size()+"条数据，总共耗时："+(end-start)+"ms");
       }
    }
}


