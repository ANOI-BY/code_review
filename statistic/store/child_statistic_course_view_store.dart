import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../api/child_courses/dtos/activity.dart';
import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../api/dtos/caller_type.dart';
import '../../../../../core/store_interface/main_store.dart';
import '../../../../../store/loading/loading_store.dart';
import '../../../../../utils/logger.dart';
import '../../../../../utils/repositories.dart';
import '../../../../../utils/utils.dart';
import '../../domain/entities/course_child.dart';
import '../widgets/calendar_view.dart';
import '../widgets/lessons_in_block.dart';

part 'child_statistic_course_view_store.g.dart';

class ChildStatisticCourseViewStore = _ChildStatisticCourseViewStoreBase
  with _$ChildStatisticCourseViewStore;

abstract class _ChildStatisticCourseViewStoreBase extends MobxStore with Store {
  final CourseChildEntity entity;
  _ChildStatisticCourseViewStoreBase(this.entity){
    init();
  }

  final loading = LoadingStore();

  @observable
  late CourseDto courseDto;

  @observable
  ObservableList<ActivityDto> activities = ObservableList.of([]);

  @action
  void setActivities(List<ActivityDto> value) => 
    activities = ObservableList.of(value);

  @action
  void setCourse(CourseDto value) => courseDto = value;

  void showCalendar(){
    showMaterialModalBottomSheet(
      context: Utils.context, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (_) => const CalendarViewWidget(),
    );
  }

  Future<void> init() async {

    loading.start();
    try {
      final course = await Repositories.childCoursesRepository.getCourse(
        courseId: entity.course.id, 
        childId: entity.child.id, 
        callerType: CallerType.PARENT,
      );
      setCourse(course);
      final activities = await Repositories.childCoursesRepository
        .getCourseActivity(
          childId: entity.child.id, 
          courseId: entity.course.id,
        );
      setActivities(activities);
    } 
    catch (e,s) {
      logger.handle(e,s);
    }
    finally {
      loading.stop();
    }
  }

  Future<void> showLessonsInBlock(CourseBlockDto block) async {
    await showMaterialModalBottomSheet(
      context: Utils.context, 
      elevation: 10,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (_) => LessonsInBlockBottomSheetWidget(block: block,),
    );
  }

}
