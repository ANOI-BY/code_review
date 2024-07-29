import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inkbutton/inkbutton.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../core/utils/date_util.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../utils/utils.dart';
import '../store/child_statistic_course_view_store.dart';
import 'week_item.dart';


class WeekBlockWidget extends StatelessWidget {
  final ChildStatisticCourseViewStore store;
  const WeekBlockWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {

    final currentWeek = CustomDateUtils.getWeekDays(DateTime.now());

    return InkButton(
      onClick: store.showCalendar,
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 16.h),
          blurRadius: 37,
          color: ProjectColors.shadowInChildBlock.withOpacity(.15),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Дни занятий',
                    style: TextStyle(
                      color: ProjectColors.main2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Assets.images.arrowRight.image(
                  width: 18.w,
                  height: 18.h,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, bottom: 18.h),
              child: Text(
                'Отслеживайте активность ученика в течение недели',
                style: TextStyle(
                  color: ProjectColors.gray4,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Observer(
              builder: (context) {

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < Utils.weekDays.length; i++)
                      WeekItemWidget(
                        title: Utils.weekDays[i],
                        isSelected: store.activities.any(
                          (e) => e.date == currentWeek[i],
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
