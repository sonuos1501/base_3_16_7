// ignore_for_file: file_names, cascade_invocations

enum SqliteDataType {
  int,
  real,
  text,
}

class SqliteColumn {

  SqliteColumn({
    required this.columnName,
    this.defaultValue,
    this.dataType = SqliteDataType.text,
    this.primaryKey = false,
    this.autoincrement = false,
  });
  final String columnName;
  final SqliteDataType dataType;
  final bool primaryKey;
  final String? defaultValue;
  final bool autoincrement;

  String get dataTypeString {
    switch (dataType) {
      case SqliteDataType.text:
        return 'TEXT';
      case SqliteDataType.real:
        return 'REAL';
      case SqliteDataType.int:
        return 'INTEGER';
    }
  }

  String get toLine {
    return '$columnName ';
  }

  static String generateCrateTable(String tableName, List<SqliteColumn> listColumn) {
    var query = 'CREATE TABLE if not exists $tableName (';
    final arrayStringValue = <String>[];
    for (final cl in listColumn) {
      final list = <String>[];
      list.add(cl.columnName);
      list.add(cl.dataTypeString);
      if (cl.primaryKey) {
        list.add('primary key');
      }
      if (cl.autoincrement) {
        list.add('autoincrement');
      }
      arrayStringValue.add(list.join(' '));
    }
    query += arrayStringValue.join(',\n');
    query += ');';
    return query;
  }

  static List<String> generateListColumn(List<SqliteColumn> listColumn) {
    final list = <String>[];
    for (final cl in listColumn) {
      list.add(cl.columnName);
    }
    return list;
  }
}
