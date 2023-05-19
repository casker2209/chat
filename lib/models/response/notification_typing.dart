class NotificationTyping {
  NotificationTyping({
      required this.msg,
      required this.collection,
      required this.id,
      required this.fields});

  NotificationTyping.fromJson(dynamic json) {
    msg = json['msg'] ?? "";
    collection = json['collection'] ?? "";
    id = json['id'] ?? "";
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : Fields();
  }
  late String msg;
  late String collection;
  late String id;
  late Fields fields;
NotificationTyping copyWith({  String? msg,
  String? collection,
  String? id,
  Fields? fields,
}) => NotificationTyping(  msg: msg ?? this.msg,
  collection: collection ?? this.collection,
  id: id ?? this.id,
  fields: fields ?? this.fields,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    map['collection'] = collection;
    map['id'] = id;
    if (fields != null) {
      map['fields'] = fields.toJson();
    }
    return map;
  }

}

class Fields {
  Fields({
      this.eventName = "",
      this.args = const []});

  Fields.fromJson(dynamic json) {
    eventName = json['eventName'];
    args = json['args'] ?? [];
  }
  String eventName = "";
  List<dynamic> args = [];
Fields copyWith({  String? eventName,
  List<String>? args,
}) => Fields(  eventName: eventName ?? this.eventName,
  args: args ?? this.args,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventName'] = eventName;
    map['args'] = args;
    return map;
  }

}