import 'package:al_hadith/db_helper.dart';
import 'package:al_hadith/model.dart';
import 'package:get/get.dart';

class HadithDetailsController extends GetxController {
  final dbHelper = DBHelper();
  final bookTitle = ''.obs;
  final chapterTitle = ''.obs;
  final sectionNum = ''.obs;
  final preface = ''.obs;
  final hadith = ''.obs;
  final sectionList = <Section>[].obs;
  final booksList = <Book>[].obs;
  final hadithList = <Hadith>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookTitle();
    fetchSection();
    fetchChapterTitle();
  }

  void fetchBookTitle() async {
    final books = await dbHelper.getBooks();
    if (books.isNotEmpty) {
      bookTitle.value =
          books.first.title!; // Assuming you want to use the first book's title
    }
  }

  void fetchChapterTitle() async {
    final chapter = await dbHelper.getChapters();
    if (chapter.isNotEmpty) {
      chapterTitle.value = chapter
          .first.title; // Assuming you want to use the first book's title
    }
  }

  void fetchSection() async {
    sectionList.value =
        await dbHelper.getSections(); // Fetch chapters from database
  }

  void fetchBoookList() async {
    booksList.value = await dbHelper.getBooks(); // Fetch chapters from database
  }

  void fetchHadithList() async {
    hadithList.value =
        await dbHelper.getHadiths(); // Fetch chapters from database
  }
}
