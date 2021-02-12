import 'package:sqflite/sqflite.dart';

// Apenas exemplificando para que serve o migration
void createV2(Batch batch) {
  batch.execute('''
    create table teste(id integer)  
  ''');
}

void upgradeV2(Batch batch) {
  batch.execute('''
    create table teste(id integer)  
  ''');
}
