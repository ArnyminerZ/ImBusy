import 'member_data.dart';

class EventData {
  EventData({required this.name, this.members = const []});

  String name;

  List<MemberData> members;
}
