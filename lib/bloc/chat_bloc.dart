import 'dart:convert';

import 'package:chat/service/rocket_chat/rocket_service.dart';
import 'package:chat/utils/date_utils.dart';
import 'package:chatview/chatview.dart';
import 'package:get_it/get_it.dart';

import '../models/message.dart';
import '../models/room.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChatBloc extends Bloc<ChatEvent,ChatState>{
  RocketService service = GetIt.instance<RocketService>();
  ChatUser you;
  ChatUser me;
  String roomId;
  List<RocketMessage> message = [];
  ChatBloc({required this.roomId,required this.you,required this.me}):super(ChatState()){
    _subscribe();
    on<ChatEvent>((event,emit) {
      if(event is GetMessageEvent){
        RocketMessage rocketMessage = event.message;
        if(rocketMessage.user!.id == me){
          for(var element in message){
            String messageString = element.msg!;
            Message message = Message.fromJson(jsonDecode(messageString));

          }
        }
        emit(state.copyWith(messages: List.of(message)..add(event.message)));
      }
      else if(event is SendMessageEvent){
        service.sendMessageOnRoom(event.message,roomId);
      }
      else if(event is TypingEvent){
        emit(state.copyWith(youTyping: event.isTyping));
      }
      else if(event is TextChangedEvent){
        service.sendTypingMessageOnRoom(event.text.isNotEmpty, roomId, me.username);
      }
      else if(event is ReactionEvent){
        service.setReaction(event.id, event.emoji, true);
      }
    });
  }
  
  void _subscribe() async{
     service.subscribeMessage(you.id);
    service.subMsgRoom(you.id);
    service.streamNotifyTypingSubscribe(roomId);
    service.loadHistory(roomId, endTime: DateUtils.getDateUnixNow());
    service.onGetLocalMessage = (rs){
      List<RocketMessage> messages = rs.result!.messages!..sort((a,b){
        return a.ts!.isAfter(b.ts!) ? 1 : 0;
      });
      emit(LoadHistoryState.clone(state.copyWith(messages: messages)));
      emit(ChatState.clone(state));
    };
    service.onGetNewMessage = (message){
      add(GetMessageEvent(message));
    };
    service.onTyping = (id,isTyping){
      if(id == you.username){
        add(TypingEvent(isTyping));
      }
    };
  }
}