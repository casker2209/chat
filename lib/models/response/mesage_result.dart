import 'dart:convert';

MessageResult messageResultFromJson(String str) => MessageResult.fromJson(json.decode(str));
String messageResultToJson(MessageResult data) => json.encode(data.toJson());

class MessageResult {
  String? _messageId;
  String? _roomId;
  String? _message;
  String? _detect;
  String? _originalMessage;
  int? _time;
  String? _mode;
  String? _image;
  String? _usernameOriginalMessage;

  MessageResult(
    String? messageId,
    String? roomId,
    String? message,
    String? detect,
    String? originalMessage,
    int? time,
    String? mode,
    String? image,
    String? usernameOriginalMessage
){
      _messageId = messageId;
      _roomId = roomId;
      _message = message;
      _detect = detect;
      _originalMessage=originalMessage;
      _time=time;
      _mode=mode;
      _image = image;
  _usernameOriginalMessage=usernameOriginalMessage;}

  DateTime getDateFromMap(dynamic json) {
    if (json.toString().contains("date")) {
      var number = json.toString().replaceAll(new RegExp(r'[^0-9]'), '');
      return new DateTime.fromMillisecondsSinceEpoch(int.parse(number));
    } else {
      return DateTime.now();
    }
  }
  MessageResult.fromJson(Map<String, dynamic>? json){
    if(json!=null){
      _messageId = json['messageId'];
      _roomId = json['roomId'];
      _message = json['message'];
      _detect = json['detect'];
      _originalMessage = json['originalMessage'];
      _time = json['time'] ;
      _mode = json['mode'];
      _image = json['image']??"";
      _usernameOriginalMessage = json['usernameOriginalMessage'];
    }
  }
//   MessageResult copyWith( {String? messageId,
//     String? roomId,
//     String? message,
//     String? detect,
//     String? originalMessage,
//     int? time,
//     String? mode,
//     String? image,}) => MessageResult(
// message: message ?? _message,
//     messageId: messageId ?? _messageId,
//     mode: mode ?? _mode,
//     roomId: roomId ?? _roomId,
//     detect: detect ?? _detect,
//     originalMessage: originalMessage ?? _originalMessage,
//     time: time ??_time,
//     image: image?? _image,
// );
  String? get messageId => _messageId;

  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
      map['messageId'] = _messageId;
      map['roomId'] = _roomId;
      map['message'] = _message;
      map['detect'] = _detect;
      map['originalMessage'] = _originalMessage;
      map['time'] = _time;
      map['mode'] = _mode;
      map['image'] = _image;
      map['usernameOriginalMessage']=_usernameOriginalMessage;
    return map;
  }

  @override
  String toString() {
    return "{\"messageId\":\""+messageId!+"\",\"roomId\":\""+roomId!+"\",\"message\":\""+message!+"\",\"detect\":\""+detect!+"\",\"originalMessage\":\""+originalMessage!+"\",\"time\":"+time!.toString()+",\"image\":\""+(image??'')+"\",\"mode\":\""+mode!+ "\",\"usernameOriginalMessage\":\""+usernameOriginalMessage!+"\"}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MessageResult &&
              runtimeType == other.runtimeType &&
              time == other.time &&
              messageId == other.messageId &&
              message == other.message &&
              detect == other.detect &&
              originalMessage == other.originalMessage &&
              mode == other.mode &&
              image == other.image &&
              usernameOriginalMessage == other.usernameOriginalMessage &&
              roomId == other.roomId;

  @override
  int get hashCode =>
      time.hashCode ^
      messageId.hashCode ^
      message.hashCode ^
      messageId.hashCode ^
      roomId.hashCode ^
      originalMessage.hashCode ^
      image.hashCode ^
      usernameOriginalMessage.hashCode ^
      detect.hashCode;

  String? get roomId => _roomId;

  String? get message => _message;

  String? get detect => _detect;

  String? get originalMessage => _originalMessage;

  int? get time => _time;

  String? get mode => _mode;

  String? get image => _image;

  String? get usernameOriginalMessage => _usernameOriginalMessage;

  void  setUsernameOriginalMessage(String value) {
    _usernameOriginalMessage = value;
  }
}
ImageDetect imageDetectFromJson(String str) => ImageDetect.fromJson(json.decode(str));
String imageDetectToJson(ImageDetect data) => json.encode(data.toJson());

class ImageDetect{
  String? _message;
  String? _imageUrl;
  ImageDetect(
      String? message,
      String? imageUrl
      ){
    _message = message;
    _imageUrl = imageUrl;
  }
  ImageDetect.fromJson(Map<String, dynamic>? json){
    if(json!=null){
      _message = json['message'];
      _imageUrl = json['imageUrl'];
    }
  }
  Map<String, dynamic> toJson(){
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['imageUrl'] = _imageUrl;
    return map;
  }
}