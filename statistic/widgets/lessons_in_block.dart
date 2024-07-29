import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../core/const/colors.dart';
import 'lesson_item.dart';

class LessonsInBlockBottomSheetWidget extends StatelessWidget {
  final CourseBlockDto block;
  const LessonsInBlockBottomSheetWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ProjectColors.gray4,
            ),
            child: const SizedBox(
              height: 2,
              width: 30,
            ),
          )
            .toCenter(),
          Text(
            block.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: ProjectColors.gray2,
            ),
          )
            .paddingOnly(top: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) => LessonItemWidget(
                lesson: block.lessons[index],
                lessonNumber: index + 1,
              ), 
              separatorBuilder: (_, __) => 20.heightBox, 
              itemCount: block.lessons.length,
            ),
          ),
        ],
      )
        .paddingSymmetric(horizontal: 20, vertical: 15),
    );
  }
}
