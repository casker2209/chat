import 'dart:convert';

import 'package:chat/models/message.dart';
/// msg : "result"
/// id : "10"
/// result : {"messages":[{"data":1}]}

RocketMessageResponse rocketMessageResponseFromJson(String str) => RocketMessageResponse.fromJson(json.decode(str));
String rocketMessageResponseToJson(RocketMessageResponse data) => json.encode(data.toJson());
class RocketMessageResponse {
  RocketMessageResponse({
    String? msg,
    String? id,
    Result? result,
  }) {
    _msg = msg;
    _id = id;
    _result = result;
  }

  RocketMessageResponse.fromJson(dynamic json) {
    _msg = json['msg'];
    _id = json['id'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  String? _msg;
  String? _id;
  Result? _result;

  RocketMessageResponse copyWith({
    String? msg,
    String? id,
    Result? result,
  }) =>
      RocketMessageResponse(
        msg: msg ?? _msg,
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

/// messages : [{"data":1}]

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
    List<RocketMessage>? messages,
  }) {
    _messages = messages;
  }

  Result.fromJson(dynamic json) {
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(RocketMessage.fromMap(v));
      });
    }
  }
  List<RocketMessage>? _messages;
  Result copyWith({List<RocketMessage>? messages,}) => Result(messages: _messages,);
  List<RocketMessage>? get messages => _messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toMap()).toList();
    }
    return map;
  }
}
