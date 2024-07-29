import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../utils/logger.dart';
import '../../../../../widgets/filling_circle.dart';
import 'lesson_task_item.dart';


class LessonItemWidget extends StatelessWidget {
  final LessonDto lesson;
  final int? lessonNumber;
  const LessonItemWidget({
    super.key, required this.lesson, required this.lessonNumber,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 25.h),
            blurRadius: 37,
            color: ProjectColors.shadowInChildBlock.withOpacity(.15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${lessonNumber != null ? 'Урок $lessonNumber: ' : ''}'
            '${lesson.lectureTitle}',
            style: TextStyle(
              color: ProjectColors.gray2,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.h,),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FillingCircleWidget(
                  progress: lesson.totalPercent/100,
                  size: Size(54.w, 54.h),
                  color: ProjectColors.main2,
                  strokeWidth: 5.h,
                ),
              ),
              SizedBox(width: 30.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LessonTaskItemWidget(
                      title: 'Лекция',
                      isDone: lesson.lectureCompleted,
                    ),
                    SizedBox(height: 10.h,),
                    LessonTaskItemWidget(
                      title: 'Тест 1 (${lesson.practice1?.rightAmount ?? 0}'
                      '/${lesson.practice1?.total ?? 0})',
                      isDone: lesson.practice1?.completed ?? false,
                    ),
                    SizedBox(height: 10.h,),
                    LessonTaskItemWidget(
                      title: 'Тест 2 (${lesson.practice2?.rightAmount ?? 0}'
                      '/${lesson.practice2?.total ?? 0})',
                      isDone: lesson.practice2?.completed ?? false,
                    ),
                    SizedBox(height: 10.h,),
                    LessonTaskItemWidget(
                      title: 'Тест 3 (${lesson.practice3?.rightAmount ?? 0}'
                      '/${lesson.practice3?.total ?? 0})',
                      isDone: lesson.practice3?.completed ?? false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
