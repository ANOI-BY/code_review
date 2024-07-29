import 'package:mobx/mobx.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

part 'calendar_store.g.dart';

class CalendarStore = _CalendarStoreBase with _$CalendarStore;

abstract class _CalendarStoreBase with Store {
  
  _CalendarStoreBase(){
    init();
  }

  final controller = CalendarController();

  void init(){
    controller
      ..notifyPropertyChangedListeners('displayDate')
      ..addPropertyChangedListener(
        (property) {
          if (property == 'displayDate'){
            setCurrentMonth(controller.displayDate!.month);
          }
        },
      );
  }

  @observable
  int currentMonth = DateTime.now().month;

  @action
  void setCurrentMonth(int month){
    currentMonth = month;
  }
}
