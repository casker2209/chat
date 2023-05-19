import 'dart:convert';
/// msg : "result"
/// id : "42"
/// result : [{"_id":"hiPKWRhjkAQcz23r3","rid":"xtWL2acbD62m6igrR","u":{"_id":"YbWWv3ojjGErsqwwW","username":"0888111111"},"_updatedAt":{"$date":1679309361791},"alert":false,"fname":"Admin Hoa, HAI","groupMentions":0,"name":"0999111111,vudinhhai","open":true,"t":"d","unread":0,"userMentions":0,"ls":{"$date":1679309361791}}]

UnreadMessageRespons unreadMessageResponsFromJson(String str) => UnreadMessageRespons.fromJson(json.decode(str));
String unreadMessageResponsToJson(UnreadMessageRespons data) => json.encode(data.toJson());
class UnreadMessageRespons {
  UnreadMessageRespons({
      String? msg, 
      String? id, 
      List<Result>? result,}){
    _msg = msg;
    _id = id;
    _result = result;
}

  UnreadMessageRespons.fromJson(dynamic json) {
    _msg = json['msg'];
    _id = json['id'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _msg;
  String? _id;
  List<Result>? _result;
UnreadMessageRespons copyWith({  String? msg,
  String? id,
  List<Result>? result,
}) => UnreadMessageRespons(  msg: msg ?? _msg,
  id: id ?? _id,
  result: result ?? _result,
);
  String? get msg => _msg;
  String? get id => _id;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['id'] = _id;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "hiPKWRhjkAQcz23r3"
/// rid : "xtWL2acbD62m6igrR"
/// u : {"_id":"YbWWv3ojjGErsqwwW","username":"0888111111"}
/// _updatedAt : {"$date":1679309361791}
/// alert : false
/// fname : "Admin Hoa, HAI"
/// groupMentions : 0
/// name : "0999111111,vudinhhai"
/// open : true
/// t : "d"
/// unread : 0
/// userMentions : 0
/// ls : {"$date":1679309361791}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? id, 
      String? rid, 
      U? u, 
      UpdatedAt? updatedAt, 
      bool? alert, 
      String? fname, 
      num? groupMentions, 
      String? name, 
      bool? open, 
      String? t, 
      int? unread,
      num? userMentions, 
      Ls? ls,}){
    _id = id;
    _rid = rid;
    _u = u;
    _updatedAt = updatedAt;
    _alert = alert;
    _fname = fname;
    _groupMentions = groupMentions;
    _name = name;
    _open = open;
    _t = t;
    _unread = unread;
    _userMentions = userMentions;
    _ls = ls;
}

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _rid = json['rid'];
    _u = json['u'] != null ? U.fromJson(json['u']) : null;
    _updatedAt = json['_updatedAt'] != null ? UpdatedAt.fromJson(json['_updatedAt']) : null;
    _alert = json['alert'];
    _fname = json['fname'];
    _groupMentions = json['groupMentions'];
    _name = json['name'];
    _open = json['open'];
    _t = json['t'];
    _unread = json['unread'];
    _userMentions = json['userMentions'];
    _ls = json['ls'] != null ? Ls.fromJson(json['ls']) : null;
  }
  String? _id;
  String? _rid;
  U? _u;
  UpdatedAt? _updatedAt;
  bool? _alert;
  String? _fname;
  num? _groupMentions;
  String? _name;
  bool? _open;
  String? _t;
  int? _unread;
  num? _userMentions;
  Ls? _ls;
Result copyWith({  String? id,
  String? rid,
  U? u,
  UpdatedAt? updatedAt,
  bool? alert,
  String? fname,
  num? groupMentions,
  String? name,
  bool? open,
  String? t,
  int? unread,
  num? userMentions,
  Ls? ls,
}) => Result(  id: id ?? _id,
  rid: rid ?? _rid,
  u: u ?? _u,
  updatedAt: updatedAt ?? _updatedAt,
  alert: alert ?? _alert,
  fname: fname ?? _fname,
  groupMentions: groupMentions ?? _groupMentions,
  name: name ?? _name,
  open: open ?? _open,
  t: t ?? _t,
  unread: unread ?? _unread,
  userMentions: userMentions ?? _userMentions,
  ls: ls ?? _ls,
);
  String? get id => _id;
  String? get rid => _rid;
  U? get u => _u;
  UpdatedAt? get updatedAt => _updatedAt;
  bool? get alert => _alert;
  String? get fname => _fname;
  num? get groupMentions => _groupMentions;
  String? get name => _name;
  bool? get open => _open;
  String? get t => _t;
  int? get unread => _unread;
  num? get userMentions => _userMentions;
  Ls? get ls => _ls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['rid'] = _rid;
    if (_u != null) {
      map['u'] = _u?.toJson();
    }
    if (_updatedAt != null) {
      map['_updatedAt'] = _updatedAt?.toJson();
    }
    map['alert'] = _alert;
    map['fname'] = _fname;
    map['groupMentions'] = _groupMentions;
    map['name'] = _name;
    map['open'] = _open;
    map['t'] = _t;
    map['unread'] = _unread;
    map['userMentions'] = _userMentions;
    if (_ls != null) {
      map['ls'] = _ls?.toJson();
    }
    return map;
  }

}

/// $date : 1679309361791

Ls lsFromJson(String str) => Ls.fromJson(json.decode(str));
String lsToJson(Ls data) => json.encode(data.toJson());
class Ls {
  Ls({
      num? date,}){
    _date = date;
}

  Ls.fromJson(dynamic json) {
    _date = json['$date'];
  }
  num? _date;
Ls copyWith({  num? date,
}) => Ls(  date: date ?? _date,
);
  num? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$date'] = _date;
    return map;
  }

}

/// $date : 1679309361791

UpdatedAt updatedAtFromJson(String str) => UpdatedAt.fromJson(json.decode(str));
String updatedAtToJson(UpdatedAt data) => json.encode(data.toJson());
class UpdatedAt {
  UpdatedAt({
      num? date,}){
    _date = date;
}

  UpdatedAt.fromJson(dynamic json) {
    _date = json['$date'];
  }
  num? _date;
UpdatedAt copyWith({  num? date,
}) => UpdatedAt(  date: date ?? _date,
);
  num? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['$date'] = _date;
    return map;
  }

}

/// _id : "YbWWv3ojjGErsqwwW"
/// username : "0888111111"

U uFromJson(String str) => U.fromJson(json.decode(str));
String uToJson(U data) => json.encode(data.toJson());
class U {
  U({
      String? id, 
      String? username,}){
    _id = id;
    _username = username;
}

  U.fromJson(dynamic json) {
    _id = json['_id'];
    _username = json['username'];
  }
  String? _id;
  String? _username;
U copyWith({  String? id,
  String? username,
}) => U(  id: id ?? _id,
  username: username ?? _username,
);
  String? get id => _id;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['username'] = _username;
    return map;
  }

}