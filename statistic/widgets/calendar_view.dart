import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../../core/const/colors.dart';
import '../store/calendar_store.dart';
import 'day_cell_item.dart';

class CalendarViewWidget extends HookWidget {
  const CalendarViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final store = useMemoized(CalendarStore.new);

    useEffect((){
      if (GetIt.I.isRegistered<CalendarStore>()){
        GetIt.I.unregister<CalendarStore>();
      }

      GetIt.I.registerSingleton<CalendarStore>(store);

      return () => GetIt.I.unregister<CalendarStore>();
    });

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.r),
      ),
      child: SizedBox(
        height: 500.h,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                child: Container(
                  width: 34.w,
                  height: 3.h,
                  margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  decoration: BoxDecoration(
                    color: ProjectColors.gray3,
                    borderRadius: BorderRadius.circular(9.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SfCalendar(
                    firstDayOfWeek: 1,
                    controller: store.controller,
                    view: CalendarView.month,
                    cellBorderColor: Colors.transparent,
                    monthCellBuilder: (context, details) => 
                      DayCellItemWidget(details: details),
                    viewHeaderStyle: ViewHeaderStyle(
                      backgroundColor: Colors.transparent,
                      dayTextStyle: TextStyle(
                        color: ProjectColors.gray1,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    headerStyle: CalendarHeaderStyle(
                      backgroundColor: Colors.transparent,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                        color: ProjectColors.gray1,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h,),
            ],
          ),
        ),
      ),
    );
  }
}
