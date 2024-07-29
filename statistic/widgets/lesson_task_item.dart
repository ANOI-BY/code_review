import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../gen/assets.gen.dart';

class LessonTaskItemWidget extends StatelessWidget {
  final String title;
  final bool isDone;
  const LessonTaskItemWidget({
    super.key, required this.title, required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: ProjectColors.main2,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: ProjectColors.main2,
              width: 2.h,
            ),
            color: isDone ? ProjectColors.main2 : null,
          ),
          child: Align(
            child: Assets.images.mark.image(
              width: 12.w,
              height: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
