// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CalendarStore on _CalendarStoreBase, Store {
  late final _$currentMonthAtom =
      Atom(name: '_CalendarStoreBase.currentMonth', context: context);

  @override
  int get currentMonth {
    _$currentMonthAtom.reportRead();
    return super.currentMonth;
  }

  @override
  set currentMonth(int value) {
    _$currentMonthAtom.reportWrite(value, super.currentMonth, () {
      super.currentMonth = value;
    });
  }

  late final _$_CalendarStoreBaseActionController =
      ActionController(name: '_CalendarStoreBase', context: context);

  @override
  void setCurrentMonth(int month) {
    final _$actionInfo = _$_CalendarStoreBaseActionController.startAction(
        name: '_CalendarStoreBase.setCurrentMonth');
    try {
      return super.setCurrentMonth(month);
    } finally {
      _$_CalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentMonth: ${currentMonth}
    ''';
  }
}
