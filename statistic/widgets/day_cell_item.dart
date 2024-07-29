import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/const/colors.dart';
import '../../../../../core/utils/date_util.dart';
import '../../../../../core/utils/store_util.dart';
import '../store/calendar_store.dart';
import '../store/child_statistic_course_view_store.dart';

class DayCellItemWidget extends StatelessWidget {
  final MonthCellDetails details;
  const DayCellItemWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {

    final store = GetIt.I.get<CalendarStore>();

    final isDayOff = details.date.weekday == 6 || details.date.weekday == 7;

    final statisticStore = StoreUtil.store<ChildStatisticCourseViewStore>();

    return Observer(
      builder: (context) {
        
        final currentMonth = store.currentMonth;

        final day = CustomDateUtils.getDate(details.date);

        final isActivity = statisticStore.activities.any(
          (e) => CustomDateUtils.getDate(e.date) == day,
        );

        final dateIsCurrentMonth = details.date.month == currentMonth;

        return Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: isActivity ?
              ProjectColors.main2.withOpacity(dateIsCurrentMonth ? 1 : 0.5) :
                null,
            shape: isActivity ? BoxShape.circle : BoxShape.rectangle,
          ),
          alignment: Alignment.center,
          child: Text(
            details.date.day.toString(),
            style: TextStyle(
              color: isActivity ? Colors.white :
              isDayOff ? 
                ProjectColors.red.withOpacity(dateIsCurrentMonth ? 1 : 0.5) : 
                  ProjectColors.gray1.withOpacity(dateIsCurrentMonth ? 1 : 0.5),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500, 
            ),
          ),
        );
      },
    );
  }
}
