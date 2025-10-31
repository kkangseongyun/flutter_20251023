import 'package:sqflite/sqflite.dart';

//우리는 한곳에서만 dbms하지만.. 실전에서 여러곳에서 dbms 가 필요하다..
//데이터베이스 초기화를 singleton 객체로..
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper(){
    return _instance;
  }
  DatabaseHelper._internal();

  Future<Database> get database async {
    if(_database != null) return _database!;
    _database = await _initDatabase();//초기에 한번만.. db를 위한 초기화 작업을 하기 위해서..
    return _database!;
  }

  //앱이 실행되면서 초기 한번..
  Future<Database> _initDatabase() async {
    return await openDatabase(
      'my_db.db',//db file명.. table 이 이 파일에 저장.. 파일 db 이다..
      version: 1,
      //이 함수는 앱 인스톨 후에 한번만 실행..
      onCreate: (Database db, int version) async {
        //테이블 준비..
        await db.execute('CREATE TABLE TB_MYINFO (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, phone TEXT, photo TEXT)');
      }
    );
  }

  //어디선가.. 데이터 저장을 위해서 호출..
  Future<int> insertMyInfo(Map<String, dynamic> data) async {
    final db = await database;
    await db.delete('TB_MYINFO');//과거 데이터 삭제하고 신규 데이터 저장..
    return await db.insert('TB_MYINFO', data);
  }

  //어디선가 데이터 획득을 위해서 호출..
  Future<List<Map<String, dynamic>>> getMyInfo() async {
    final db = await database;
    return await db.query('TB_MYINFO');
  }
}
