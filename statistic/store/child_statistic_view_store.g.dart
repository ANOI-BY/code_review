// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_statistic_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChildStatisticViewStore on _ChildStatisticViewStoreBase, Store {
  late final _$coursesAtom =
      Atom(name: '_ChildStatisticViewStoreBase.courses', context: context);

  @override
  ObservableList<CourseDto> get courses {
    _$coursesAtom.reportRead();
    return super.courses;
  }

  @override
  set courses(ObservableList<CourseDto> value) {
    _$coursesAtom.reportWrite(value, super.courses, () {
      super.courses = value;
    });
  }

  late final _$_ChildStatisticViewStoreBaseActionController =
      ActionController(name: '_ChildStatisticViewStoreBase', context: context);

  @override
  void setCourses(List<CourseDto> value) {
    final _$actionInfo = _$_ChildStatisticViewStoreBaseActionController
        .startAction(name: '_ChildStatisticViewStoreBase.setCourses');
    try {
      return super.setCourses(value);
    } finally {
      _$_ChildStatisticViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
courses: ${courses}
    ''';
  }
}
