import 'dart:convert';

import 'package:chat/models/message.dart';
/// msg : "result"
/// id : "13"
/// result : {"update":[{"_id":"GFQeqpM7fkchzQAGXvhGErfrLAW98bq6b6","t":"d","uids":["GFQeqpM7fkchzQAGX","vhGErfrLAW98bq6b6"],"lastMessage":{"msg":"[DETECT_MODE]10x100[DETECT_MODE]"}}]}

ListRoomResponse listRoomResponseFromJson(String str) => ListRoomResponse.fromJson(json.decode(str));
String listRoomResponseToJson(ListRoomResponse data) => json.encode(data.toJson());
class ListRoomResponse {
  ListRoomResponse({
      String? msg, 
      String? id, 
      Result? result,}){
    _msg = msg;
    _id = id;
    _result = result;
}

  ListRoomResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _id = json['id'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _msg;
  String? _id;
  Result? _result;
ListRoomResponse copyWith({  String? msg,
  String? id,
  Result? result,
}) => ListRoomResponse(  msg: msg ?? _msg,
  id: id ?? _id,
  result: result ?? _result,
);
  String? get msg => _msg;
  String? get id => _id;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['id'] = _id;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// update : [{"_id":"GFQeqpM7fkchzQAGXvhGErfrLAW98bq6b6","t":"d","uids":["GFQeqpM7fkchzQAGX","vhGErfrLAW98bq6b6"],"lastMessage":{"msg":"[DETECT_MODE]10x100[DETECT_MODE]"}}]

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<RoomInfo>? update,}){
    _update = update;
}

  Result.fromJson(dynamic json) {
    if (json['update'] != null) {
      _update = [];
      json['update'].forEach((v) {
        _update?.add(RoomInfo.fromJson(v));
      });
    }
  }
  List<RoomInfo>? _update;
Result copyWith({  List<RoomInfo>? update,
}) => Result(  update: update ?? _update,
);
  List<RoomInfo>? get update => _update;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_update != null) {
      map['update'] = _update?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "GFQeqpM7fkchzQAGXvhGErfrLAW98bq6b6"
/// t : "d"
/// uids : ["GFQeqpM7fkchzQAGX","vhGErfrLAW98bq6b6"]
/// lastMessage : {"msg":"[DETECT_MODE]10x100[DETECT_MODE]"}

RoomInfo updateFromJson(String str) => RoomInfo.fromJson(json.decode(str));
String updateToJson(RoomInfo data) => json.encode(data.toJson());
class RoomInfo {
  RoomInfo({
      String? id, 
      String? t, 
      List<String>? uids,
    RocketMessage? lastMessage,}){
    _id = id;
    _t = t;
    _uids = uids;
    _lastMessage = lastMessage;
}

  RoomInfo.fromJson(dynamic json) {
    _id = json['_id'];
    _t = json['t'];
    _uids = json['uids'] != null ? json['uids'].cast<String>() : [];
    _lastMessage = json['lastMessage'] != null ? RocketMessage.fromMap(json['lastMessage']) : null;
  }
  String? _id;
  String? _t;
  List<String>? _uids;
  RocketMessage? _lastMessage;
  int _unread = -1;

  RoomInfo copyWith({  String? id,
  String? t,
  List<String>? uids,
  RocketMessage? lastMessage,
}) => RoomInfo(  id: id ?? _id,
  t: t ?? _t,
  uids: uids ?? _uids,
  lastMessage: lastMessage ?? _lastMessage,
);
  String? get id => _id;
  String? get t => _t;
  List<String>? get uids => _uids;
  RocketMessage? get lastMessage => _lastMessage;
  int get unread => _unread;
  void setUnread(int countUnread){
    _unread = countUnread;
  }
  void setMsg(RocketMessage msg){
    _lastMessage = msg;
  }
  void setId(String id){
    _id = id;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['t'] = _t;
    map['uids'] = _uids;
    if (_lastMessage != null) {
      map['lastMessage'] = _lastMessage?.toMap();
    }
    return map;
  }

}

/// msg : "[DETECT_MODE]10x100[DETECT_MODE]"

