import 'package:equatable/equatable.dart';

import '../models/message.dart';

class ChatState extends Equatable{
  List<RocketMessage> messages = [];
  bool youTyping;
  bool meTyping;
  bool loadingHistory = false;

  ChatState({this.messages = const [],this.youTyping = false,this.meTyping = false,this.loadingHistory = false});

  ChatState copyWith({
    List<RocketMessage>? messages,
    bool? youTyping,
    bool? meTyping,
    bool? loadingHistory,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      youTyping: youTyping ?? this.youTyping,
      meTyping: meTyping ?? this.meTyping,
      loadingHistory: loadingHistory ?? this.loadingHistory,
    );
  }

  @override
  List<Object?> get props => [messages,youTyping,meTyping,loadingHistory];

  factory ChatState.clone(ChatState other) => ChatState(messages: other.messages,youTyping: other.youTyping,meTyping: other.meTyping,loadingHistory: other.loadingHistory);

}

class LoadHistoryState extends ChatState{
  LoadHistoryState({super.messages = const [],super.youTyping = false,super.meTyping = false,super.loadingHistory = false});

  factory LoadHistoryState.clone(ChatState other) => LoadHistoryState(messages: other.messages,youTyping: other.youTyping,meTyping: other.meTyping,loadingHistory: other.loadingHistory);

  @override
  LoadHistoryState copyWith({
    List<RocketMessage>? messages,
    bool? youTyping,
    bool? meTyping,
    bool? loadingHistory,
  }) {
    return LoadHistoryState(
      messages: messages ?? this.messages,
      youTyping: youTyping ?? this.youTyping,
      meTyping: meTyping ?? this.meTyping,
      loadingHistory: loadingHistory ?? this.loadingHistory,
    );
  }

  @override
  List<Object?> get props => [messages,youTyping,meTyping,loadingHistory];


}