//books

class Book {
  int? id;
  String? title;
  String? titleArabic;
  int? numberOfHadith;
  String? abbreviationCode;
  String? bookName;
  String? bookDescription;

  Book(
    this.id,
    this.title,
    this.titleArabic,
    this.numberOfHadith,
    this.abbreviationCode,
    this.bookName,
    this.bookDescription,
  );
}

// chapter_model.dart
class Chapter {
  int id;
  int chapterId;
  int bookId;
  String title;
  int number;
  String hadisRange;
  String bookName;

  Chapter({
    required this.id,
    required this.chapterId,
    required this.bookId,
    required this.title,
    required this.number,
    required this.hadisRange,
    required this.bookName,
  });
}

// hadith_model.dart
class Hadith {
  int hadithId;
  int bookId;
  int chapterId;
  int sectionId;
  String narrator;
  String bn;
  String ar;
  String arDiacless;
  String note;
  int gradeId;
  String grade;
  String gradeColor;

  Hadith({
    required this.hadithId,
    required this.bookId,
    required this.chapterId,
    required this.sectionId,
    required this.narrator,
    required this.bn,
    required this.ar,
    required this.arDiacless,
    required this.note,
    required this.gradeId,
    required this.grade,
    required this.gradeColor,
  });
}

// section_model.dart
class Section {
  int id;
  int bookId;
  int chapterId;
  int sectionId;
  String title;
  String preface;
  String number;

  Section({
    required this.id,
    required this.bookId,
    required this.chapterId,
    required this.sectionId,
    required this.title,
    required this.preface,
    required this.number,
  });
}
