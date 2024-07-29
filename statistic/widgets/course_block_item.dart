import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inkbutton/inkbutton.dart';

import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../core/common/widgets/store_widget.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/progress_line/progress_line.dart';
import '../store/child_statistic_course_view_store.dart';

class CourseBlockItemWidget extends StatelessWidget {
  final CourseBlockDto block;
  const CourseBlockItemWidget({super.key, required this.block});

  @override
  Widget build(BuildContext context) {

    final allLessons = block.lessons.length;
    final globalPercent = block.lessons.map((e) => e.totalPercent)
      .fold<double>(0, (prev, e) => e+prev);
    final completedLessons = block.lessons
      .where((e) => e.totalPercent >= 50).length;
    final newPercent = globalPercent/allLessons;

    final store = StoreWidget.of<ChildStatisticCourseViewStore>(context)!.store;

    return InkButton(
      onClick: () => store.showLessonsInBlock(block),
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 25.h),
          color: ProjectColors.main2.withOpacity(.15),
          blurRadius: 37,
        ),
      ],
      child: SizedBox(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      block.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: ProjectColors.gray2,
                      ),
                    ),
                    Text(
                      'Уроков: $completedLessons/$allLessons',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ProjectColors.gray4,
                      ),
                    ),
                  ],
                ).expanded(),
                Assets.images.arrowRight.image(
                  width: 18,
                  height: 18,
                ),
              ],
            ),
            SizedBox(height: 5.h,),
            ProgressLineHookedWidget(progress: newPercent),
          ],
        )
          .paddingSymmetric(horizontal: 20, vertical: 15),
      ),
    );
  }
}
