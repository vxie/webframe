MySQLURL:   jdbc:mysql://192.168.0.101:3306/devdb

连接报错: (Access denied for user 'root'@'xiechengqun' (using password: YES))
解决办法：
grant all on *.* to root@"%" Identified by "123456";
