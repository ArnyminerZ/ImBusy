import 'busy_dates.dart';
import 'member_data.dart';

class EventData {
  EventData(
      {required this.name, this.members = const [], this.busyDates = const []});

  String name;

  List<MemberData> members;

  List<BusyDates> busyDates;
}
