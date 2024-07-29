import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:inkbutton/inkbutton.dart';

import '../../../../../api/user/dtos/user_children.dart';
import '../../../../../core/const/colors.dart';
import '../../../../../gen/assets.gen.dart';


class ChildViewWidget extends StatelessWidget {
  final UserChildrenDto child;
  const ChildViewWidget({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkButton(
      onClick: () => context.push(
        '/parent-mode/statistic/child', extra: child,
      ),
      borderRadius: BorderRadius.circular(15.r),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 25.h),
          color: ProjectColors.shadowInChildBlock.withOpacity(.15),
          blurRadius: 37,
        ),
      ],
      child: SizedBox(
        height: 90.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          child.name,
                          style: TextStyle(
                            color: ProjectColors.gray2,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Text(
                        //   'Курсы отсутствуют',
                        //   style: TextStyle(
                        //     color: ProjectColors.gray4,
                        //     fontSize: 16.sp,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Assets.images.arrowRight.image(
                    width: 24.w,
                    height: 24.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
