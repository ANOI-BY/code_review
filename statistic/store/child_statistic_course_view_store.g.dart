// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_statistic_course_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChildStatisticCourseViewStore
    on _ChildStatisticCourseViewStoreBase, Store {
  late final _$courseDtoAtom = Atom(
      name: '_ChildStatisticCourseViewStoreBase.courseDto', context: context);

  @override
  CourseDto get courseDto {
    _$courseDtoAtom.reportRead();
    return super.courseDto;
  }

  bool _courseDtoIsInitialized = false;

  @override
  set courseDto(CourseDto value) {
    _$courseDtoAtom.reportWrite(
        value, _courseDtoIsInitialized ? super.courseDto : null, () {
      super.courseDto = value;
      _courseDtoIsInitialized = true;
    });
  }

  late final _$activitiesAtom = Atom(
      name: '_ChildStatisticCourseViewStoreBase.activities', context: context);

  @override
  ObservableList<ActivityDto> get activities {
    _$activitiesAtom.reportRead();
    return super.activities;
  }

  @override
  set activities(ObservableList<ActivityDto> value) {
    _$activitiesAtom.reportWrite(value, super.activities, () {
      super.activities = value;
    });
  }

  late final _$_ChildStatisticCourseViewStoreBaseActionController =
      ActionController(
          name: '_ChildStatisticCourseViewStoreBase', context: context);

  @override
  void setActivities(List<ActivityDto> value) {
    final _$actionInfo = _$_ChildStatisticCourseViewStoreBaseActionController
        .startAction(name: '_ChildStatisticCourseViewStoreBase.setActivities');
    try {
      return super.setActivities(value);
    } finally {
      _$_ChildStatisticCourseViewStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setCourse(CourseDto value) {
    final _$actionInfo = _$_ChildStatisticCourseViewStoreBaseActionController
        .startAction(name: '_ChildStatisticCourseViewStoreBase.setCourse');
    try {
      return super.setCourse(value);
    } finally {
      _$_ChildStatisticCourseViewStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courseDto: ${courseDto},
activities: ${activities}
    ''';
  }
}
