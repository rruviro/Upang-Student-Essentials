import 'package:mysql_client/mysql_client.dart';

final pool =  MySQLConnectionPool(
  host: 'localhost',
  port: 3306,
  userName: 'root',
  password: '',
  maxConnections: 10,
  databaseName: 'testing',
);
