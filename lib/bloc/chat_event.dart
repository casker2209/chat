import '../models/message.dart';

class ChatEvent{

}

class LoadHistoryEvent extends ChatEvent{

}

class GetMessageEvent extends ChatEvent{
  RocketMessage message;
  GetMessageEvent(this.message);
}
class SendMessageEvent extends ChatEvent{
  String message;
  SendMessageEvent(this.message);
}
class TypingEvent extends ChatEvent{
  bool isTyping;
  TypingEvent(this.isTyping);
}
class TextChangedEvent extends ChatEvent{
  String text;
  TextChangedEvent(this.text);
}
class ReactionEvent extends ChatEvent{
  String id;
  String emoji;
  ReactionEvent(this.id,this.emoji);
}