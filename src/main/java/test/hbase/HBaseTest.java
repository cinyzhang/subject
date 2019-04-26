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
//		config.set("hbase.zookeeper.quorum", "10.1.1.1,10.1.1.2,10.1.1.3,10.1.1.6,10.1.1.7");// zookeeper地址
//		config.set("hbase.zookeeper.property.clientPort", "2181");// zookeeper端口
//        config.set("hbase.master","10.1.1.1");
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
				admin.disableTable(strTableName);
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
