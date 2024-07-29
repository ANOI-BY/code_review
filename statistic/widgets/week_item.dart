import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../gen/assets.gen.dart';

class WeekItemWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  const WeekItemWidget({
    super.key, this.isSelected = false,
    required this.title,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: isSelected ? ProjectColors.main2 : null,
            borderRadius: BorderRadius.circular(100.r),
            border: Border.all(
              color: ProjectColors.main2,
              width: 1.h,
            ),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0,
            child: Align(
              child: Assets.images.mark.image(
                width: 18.w,
                height: 18.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h,),
        Text(
          title,
          style: TextStyle(
            color: ProjectColors.main2,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
