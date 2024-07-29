import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:inkbutton/inkbutton.dart';

import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../core/common/widgets/store_widget.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../widgets/progress_line/progress_line.dart';
import '../store/child_statistic_view_store.dart';


class CourseViewWidget extends StatelessWidget {
  final CourseDto course;
  const CourseViewWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {

    final store = StoreWidget.of<ChildStatisticViewStore>(context)!.store;

    return InkButton(
      onClick: () => store.openStatisticCourse(course),
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 25.h),
          color: ProjectColors.main2.withOpacity(.15),
          blurRadius: 37,
        ),
      ],
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h)
            .copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ProjectColors.gray2,
                ),
              ),
              Text(
                course.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ProjectColors.gray4,
                ),
              ),
              SizedBox(height: 5.h,),
              ProgressLineHookedWidget(progress: course.totalPercent),
            ],
          ),
        ),
      ),
    );
  }
}
