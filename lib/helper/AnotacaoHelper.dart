import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../model/Anotacao.dart';

class AnotacaoHelper {
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  late Database _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal();

  get db async {
    // ignore: unnecessary_null_comparison
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    /*

    id titulo descricao data
    01 teste  teste     02/10/2020

    * */

    String sql = "CREATE TABLE anotacao ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "titulo VARCHAR,"
        "descricao TEXT,"
        "data DATETIME)";
    await db.execute(sql);
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados =
        join(caminhoBancoDados, "banco_minhas_anotacoes.db");
    var db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }

  salvarAnotacao(Anotacao anotacao) {}
}

/*

class Normal {
  Normal(){
  }
}

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  	factory Singleton(){
      print("Singleton");
      return _singleton;
    }
    Singleton._internal(){
    	print("_internal");
  	}
}

void main() {
  var i1 = Singleton();
  print("***");
  var i2 = Singleton();
  print( i1 == i2 );
}
* */