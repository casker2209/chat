import 'dart:async';
import 'dart:convert';


import 'package:websocket_universal/websocket_universal.dart';

import '../../models/message.dart';
import '../../models/response/RocketMessageResponse.dart';
import '../../models/response/notification_typing.dart';


class RocketService {
  String ID_GET_ROOM = "SOCKET_GET_ROOM";
  String ID_GET_SUBSCRIPTIONS = "GET_SUBSCRIPTIONS";
  String ID_GET_MSG_ROOM = "ID_GET_MSG_ROOM";
  String ID_CHECK_CONNECTION = "ID_CHECK_CONNECTION";
  String ID_SEND_MSG = "ID_SEND_MSG";
  String ID_GET_HISTORY_MSG_ROOM = "ID_GET_HISTORY_MSG_ROOM";
  String ID_MSG_PING = "{\"msg\":\"ping\"}";
  String ID_REACTION = "ID_REACTION";

  //test
  String TOKEN_TEST = "D_snn_Gh1dd6xvlpHSjK02aTdYmdqXcDatT2FqA6ua7";
  //
  String ID_SUBSCRIPTION_MESSAGE = "SUBSCRIBE_MESSAGE";



  final urlRocket = "wss://rocketchat.stpsoftwares.com/websocket";
  final connectionOptions = const SocketConnectionOptions(
    pingIntervalMs: 30000, // send Ping message every 3000 ms
    timeoutConnectionMs: 5000, // connection fail timeout after 4000 ms
    skipPingMessages: false,
    pingRestrictionForce: true,
  );
  DateTime? lastTimePong = null;
  DateTime? _lastTimeRequest = null;
  RocketService();
  final IMessageProcessor<String, String> socketProcessor =
  SocketSimpleTextProcessor();
  late IWebSocketHandler handler;

  // Function(ListRoomResponse room)? onGetRoom;
  // Function(UnreadMessageRespons unreadMessageRespons)? onGetSubscription;
   Function(RocketMessage msg)? onRoomMessageChange;
   Function(RocketMessageResponse rs)? onGetLocalMessage;
   Function(RocketMessage msg)? onGetNewMessage;
   Function(String phone, bool isTyping)? onTyping;
  // Function()? onDeletedAccount;
  // Function()? onConnected;
  //
  // Function()? onReSubRoomEvent;
  // Function()? onReSubChatEvent;


  SocketService() {}
  late String token;

  connectTest(){
    connect(TOKEN_TEST);
  }

  connect(String token) async {
    this.token = token;
    handler = IWebSocketHandler<String, String>.createClient(
      urlRocket,
      socketProcessor,
      connectionOptions: connectionOptions,
    );
    await handler.connect();
    connectWss(false);
  }

  connectWss(bool forceDisconnect) async{
    if(forceDisconnect) {
      await disconnect();
      handler = IWebSocketHandler<String, String>.createClient(
        urlRocket,
        socketProcessor,
        connectionOptions: connectionOptions,
      );
      await handler.connect();
    }
    _sendConnectRequest();
    _sendLoginRequest(token);
    //
    _handleStatus();
    _handleMessage();
    lastTimePong = null;
  }

  disconnect() async {
    await handler.disconnect('manual disconnect');
    handler.close();
  }

  void _handleStatus() {
    handler.socketHandlerStateStream.listen((stateEvent) {
      print('> status changed to ${stateEvent.status}');
    });
    handler.socketStateStream.listen((event) {
      print('Socket state is ${event.status.value}');
    });
  }

  void _handleMessage() {
    // var phone = auth?.data?.me?.username ?? '';
    handler.incomingMessagesStream.listen((inMsg) {
      print('> webSocket  got text message from server: "$inMsg" '
          '[ping: ${handler.pingDelayMs}]');
       if (inMsg.toString().contains(getId(ID_GET_ROOM))) {
      //   var room = ListRoomResponse.fromJson(jsonDecode(inMsg.toString()));
      //   onGetRoom?.call(room);
       } else if(inMsg.toString().contains(ID_GET_SUBSCRIPTIONS)){
      //   var subscription = UnreadMessageRespons.fromJson(jsonDecode(inMsg.toString()));
      //   onGetSubscription?.call(subscription);
      // } else if(inMsg.toString().contains(ID_CHECK_CONNECTION)){
      //   _lastTimeRequest =  DateTime.now();
       } else if (inMsg.toString().contains(getId(ID_GET_HISTORY_MSG_ROOM))) {
         var data = RocketMessageResponse.fromJson(jsonDecode(inMsg.toString()));
         onGetLocalMessage?.call(data);
       }
         // else if (inMsg.toString().contains("Users:Deleted") ||
      //     inMsg.toString().contains("You've been logged out by the server")) {
      //   if (phone.isNotEmpty && inMsg.toString().contains(phone)) {
      //     onDeletedAccount?.call();
      //   }
      // } else if (inMsg.toString().contains("Users:NameChanged")) {
      //   if (phone.isNotEmpty && inMsg.toString().contains(phone)) {
      //     onDeletedAccount?.call();
      //   }
      // }
       else if (inMsg.toString().contains("stream-notify-room") &&
           inMsg.toString().contains("typing")) {
         NotificationTyping data =
         NotificationTyping.fromJson(jsonDecode(inMsg.toString()));
         if (data.fields.args.length > 1) onTyping?.call(data.fields.args[0], data.fields?.args?[1] == true);
       }
        else if (inMsg.toString().contains("stream-notify-user")) {
         if (jsonDecode(inMsg.toString())['fields'] != null) {
           RocketMessage msg = RocketMessage.fromMap(
               jsonDecode(inMsg.toString())['fields']['args'][1]['lastMessage']);
           onRoomMessageChange?.call(msg);
           onGetNewMessage?.call(msg);
         }
       }
       else if (inMsg.toString().contains(ID_MSG_PING)) {
         sendPong();
       }
       else if (inMsg.toString().contains("\"msg\":\"connected\"")) {
         //sub here
      //   onConnected?.call();
      //   onReSubRoomEvent?.call();
      //   onReSubChatEvent?.call();
       }
    });

    handler.outgoingMessagesStream.listen((outMsg) {
      print('> webSocket  send text message to server: "$outMsg" '
          '[ping: ${handler.pingDelayMs}]');
    });
  }

  void sendMsg(String msg) async {
    handler.sendMessage(msg);
  }

  void setReaction(String messageId,String emoji,bool set){
    Map msg = {
      "msg": "method",
      "method": "setReaction",
      "id": ID_REACTION,
      "params": [
        emoji,
        messageId,
        set
      ]
    };
    sendMsg(jsonEncode(msg));
  }

  void _sendConnectRequest() {
    Map msg = {
      "msg": "connect",
      "version": "1",
      "support": ["1", "pre2", "pre1"]
    };
    sendMsg(jsonEncode(msg));
  }

  void _sendLoginRequest(String token) {
    Map msg = {
      "msg": "method",
      "method": "login",
      "id": "42",
      "params": [
        {"resume": token}
      ]
    };
    sendMsg(jsonEncode(msg));
  }

  void getRoom() {
    Map msg = {
      "msg": "method",
      "method": "rooms/get",
      "id": ID_GET_ROOM,
      "params": [
        {"\$date": 0}
      ]
    };
    sendMsg(jsonEncode(msg));
  }

  void sendPong() {
    Map msg = {
      "msg": "pong",
    };
    lastTimePong = DateTime.now();
    sendMsg(jsonEncode(msg));
  }

  String getId(String id) {
    return "\"id\":\"$id\"";
  }

  void subMsgRoom(String userId) {
    ID_GET_MSG_ROOM = userId + "/rooms-changed";
    Map msg = {
      "msg": "sub",
      "id": ID_GET_MSG_ROOM,
      "name": "stream-notify-user",
      "params": [ID_GET_MSG_ROOM, false]
    };
    sendMsg(jsonEncode(msg));

    //
  }

  void unSubMsgRoom(String userId) {
    ID_GET_MSG_ROOM = userId + "/rooms-changed";
    Map msg = {
      "msg": "unsub",
      "id": ID_GET_MSG_ROOM,
      "name": "stream-notify-user",
      "params": [ID_GET_MSG_ROOM, false]
    };
    sendMsg(jsonEncode(msg));
  }

  void checkConnectSocket() {
    Map msg = {
      "msg": "method",
      "id": ID_CHECK_CONNECTION,
      "method": "getUserRoles",
      "params": []
    };
    sendMsg(jsonEncode(msg));
    _lastTimeRequest = null;
    Timer(Duration(milliseconds: 500), () {
      if(_lastTimeRequest==null) {
        connectWss(true);
        print('wss is not conneft');
      }
    });
  }

  void loadHistory(String roomId, {int? startTime, required int endTime}) {
    Map msg = {
      "msg": "method",
      "method": "loadHistory",
      "id": ID_GET_HISTORY_MSG_ROOM,
      "params": [
        roomId,
        startTime == null ? null : {"\$date": startTime},
        50,
        {"\$date": endTime},
        false
      ]
    };
    sendMsg(jsonEncode(msg));
  }

  void sendMessageOnRoom(String message, String roomId) {
    Map msg = {
      "msg": "method",
      "method": "sendMessage",
      "id": "42",
      "params": [
        {"rid": roomId, "msg": message}
      ]
    };

    sendMsg(jsonEncode(msg));
  }

  void streamNotifyTypingUnSubscribe(String roomId) {
    Map msg = {
      "msg": "unsub",
      "id": "$roomId typing" + "subscription-id",
      "name": "stream-notify-room",
      "params": ["$roomId/typing", false]
    };
    sendMsg(jsonEncode(msg));
  }

  void streamNotifyTypingSubscribe(String roomId) {
    Map msg = {
      "msg": "sub",
      "id": "$roomId typing" + "subscription-id",
      "name": "stream-notify-room",
      "params": ["$roomId/typing", false]
    };
    sendMsg(jsonEncode(msg));
  }

   void sendTypingMessageOnRoom(bool typing, roomId, String username) {
     Map msg = {
       "msg": "method",
       "method": "stream-notify-room",
       "id": "42",
       "params": ["$roomId/typing", username, typing]
     };
     sendMsg(jsonEncode(msg));
   }

  bool isNeedLogin() {
    return lastTimePong != null &&
        (DateTime.now().millisecondsSinceEpoch -
            lastTimePong!.millisecondsSinceEpoch >
            60000);
  }

  void notifyDeletedSubscribe(String userId) {
    Map msg = {
      "msg": "sub",
      "id": userId + "-subscription-deleted",
      "name": "stream-notify-logged",
      "params": ["Users:Deleted", false]
    };

    sendMsg(jsonEncode(msg));
  }

  void notifyNameChangeSubscribe(String userId) {
    Map msg = {
      "msg": "sub",
      "id": userId + "-subscription-name-change",
      "name": "stream-notify-logged",
      "params": ["Users:NameChanged", false]
    };

    sendMsg(jsonEncode(msg));
  }
  void getSubscriptions(String userId){
    Map msg ={
      "msg": "method",
      "method": "subscriptions/get",
      "id": ID_GET_SUBSCRIPTIONS,
      "params":[]
    };
    sendMsg(jsonEncode(msg));
  }
  void subscribeMessage(String userId){
    Map msg = {
      "msg": "sub",
      "id": ID_SUBSCRIPTION_MESSAGE,
      "name": "stream-room-messages",
      "params":[
        userId,
        false
      ]
    };
    sendMsg(jsonEncode(msg));
  }
  void unsubscribeMessage(){
    Map msg = {
      "msg": "unsub",
      "id": ID_SUBSCRIPTION_MESSAGE,
    };
    sendMsg(jsonEncode(msg));
  }


}
