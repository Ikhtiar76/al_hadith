// ignore_for_file: depend_on_referenced_packages

import 'dart:io' as io;
import 'dart:async';
import 'package:al_hadith/model.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "hadith_db.db");
    print("Database Path: $path");

    bool dbExist = await io.File(path).exists();
    print("Database Exists: $dbExist");

    if (!dbExist) {
      try {
        ByteData data = await rootBundle.load(join("assets", "hadith_db.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await io.File(path).writeAsBytes(bytes, flush: true);
        print("Database Copied from Assets");
      } catch (e) {
        print("Error copying database from assets: $e");
      }
    }

    try {
      var db = await openDatabase(path, version: 1);
      print("Database Opened Successfully");
      return db;
    } catch (e) {
      print("Error opening database: $e");
      return null;
    }
  }

  Future<List<Book>> getBooks() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM books");

    List<Book> books = [];
    for (var i = 0; i < list.length; i++) {
      books.add(Book(
          list[i]["id"],
          list[i]["title"],
          list[i]["title_ar"],
          list[i]["number_of_hadis"],
          list[i]["abvr_code"],
          list[i]["book_name"],
          list[i]["book_descr"]));
    }
    return books;
  }

  Future<List<Chapter>> getChapters() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM chapter");

    List<Chapter> chapters = [];
    for (var i = 0; i < list.length; i++) {
      chapters.add(Chapter(
        id: list[i]["id"],
        chapterId: list[i]["chapter_id"],
        bookId: list[i]["book_id"],
        title: list[i]["title"],
        number: list[i]["number"],
        hadisRange: list[i]["hadis_range"],
        bookName: list[i]["book_name"],
      ));
    }
    return chapters;
  }

  Future<List<Hadith>> getHadiths() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM hadith");

    List<Hadith> hadiths = [];
    for (var i = 0; i < list.length; i++) {
      hadiths.add(Hadith(
        hadithId: list[i]["hadith_id"],
        bookId: list[i]["book_id"],
        chapterId: list[i]["chapter_id"],
        sectionId: list[i]["section_id"],
        narrator: list[i]["narrator"],
        bn: list[i]["bn"],
        ar: list[i]["ar"],
        arDiacless: list[i]["ar_diacless"],
        note: list[i]["note"],
        gradeId: list[i]["grade_id"],
        grade: list[i]["grade"],
        gradeColor: list[i]["grade_color"],
      ));
    }
    return hadiths;
  }

  Future<List<Section>> getSections() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM section");

    List<Section> sections = [];
    for (var i = 0; i < list.length; i++) {
      sections.add(Section(
        id: list[i]["id"],
        bookId: list[i]["book_id"],
        chapterId: list[i]["chapter_id"],
        sectionId: list[i]["section_id"],
        title: list[i]["title"],
        preface: list[i]["preface"],
        number: list[i]["number"],
      ));
    }
    return sections;
  }
}
