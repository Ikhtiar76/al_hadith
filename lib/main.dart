// ignore_for_file: unnecessary_import

import 'package:al_hadith/controller.dart';
import 'package:al_hadith/db_helper.dart';
import 'package:al_hadith/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void main() {
  runApp(const HadithDetailsPage());
}

class HadithDetailsPage extends StatefulWidget {
  const HadithDetailsPage({super.key});

  @override
  State<HadithDetailsPage> createState() => _HadithDetailsPageState();
}

class _HadithDetailsPageState extends State<HadithDetailsPage> {
  final controller = Get.put(HadithDetailsController());
  bool _stretch = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color(0xfff4f4f4),
            body: GetBuilder<HadithDetailsController>(
              initState: (_) {
                controller.fetchBookTitle();
                controller.fetchSection();
                controller.fetchBoookList();
                controller.fetchHadithList();
                controller.fetchChapterTitle();
              },
              builder: (controller) => CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    actions: const [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.format_list_bulleted_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                    expandedHeight: 100,
                    backgroundColor: const Color(0xff118c6f),
                    leading:
                        const Icon(Icons.arrow_back_ios, color: Colors.white),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: [
                          Obx(() => Text(
                                controller.bookTitle.value,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 23),
                              )),
                          Obx(() => Text(
                                controller.chapterTitle.value,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final section = controller.sectionList[index];

                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                height: 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            ' ${section.number}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff118c6f),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            section.title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff64676e)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(
                                      height: 2,
                                      color: Color(0xff64676e),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      section.preface,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final hadith =
                                          controller.hadithList[index];
                                      return Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(() => Text(
                                                  controller.bookTitle.value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                )),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(hadith.ar),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        height: 0.5,
                                        color: Colors.black38,
                                      );
                                    },
                                    itemCount: controller.hadithList.length),
                              )
                            ],
                          ),
                        );
                      },
                      childCount: controller.sectionList
                          .length, // Set childCount to the length of the list
                    ),
                  ),
                ],
              ),
            )));
  }
}

class CustomCornerClipPath extends CustomClipper<Path> {
  final double cornerR;
  const CustomCornerClipPath({this.cornerR = 16.0});

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width, 0)
    ..lineTo(
      size.width,
      size.height - cornerR,
    )
    ..arcToPoint(
      Offset(
        size.width - cornerR,
        size.height,
      ),
      radius: Radius.circular(cornerR),
      clockwise: false,
    )
    ..lineTo(0, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
