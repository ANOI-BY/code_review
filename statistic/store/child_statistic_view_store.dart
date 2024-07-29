import 'package:mobx/mobx.dart';

import '../../../../../api/child_courses/dtos/course.dart';
import '../../../../../api/dtos/caller_type.dart';
import '../../../../../api/user/dtos/user_children.dart';
import '../../../../../router/config.dart';
import '../../../../../store/loading/loading_store.dart';
import '../../../../../utils/logger.dart';
import '../../../../../utils/repositories.dart';
import '../../domain/entities/course_child.dart';

part 'child_statistic_view_store.g.dart';

class ChildStatisticViewStore = _ChildStatisticViewStoreBase
  with _$ChildStatisticViewStore;

abstract class _ChildStatisticViewStoreBase with Store {
  final UserChildrenDto child;
  _ChildStatisticViewStoreBase(this.child){
    init();
  }

  final loadingStore = LoadingStore();

  @observable
  ObservableList<CourseDto> courses = ObservableList();

  @action
  void setCourses(List<CourseDto> value) => courses = value.asObservable();

  void openStatisticCourse(CourseDto course){
    router.push(
      '/parent-mode/statistic/child/course-view',
      extra: CourseChildEntity(
        course: course, child: child,
      ),
    );
  }

  Future<void> init() async {
    try{
      loadingStore.start();
      final response = await Repositories.childCoursesRepository
        .getChildBoughtCourses(
          child.id,
          CallerType.PARENT,
        );
      setCourses(response);
      loadingStore.stop();
    }
    catch(e, trace){
      logger.handle(e, trace);
    }
  }
}
