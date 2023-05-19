import 'dart:convert';

import 'package:chat/bloc/chat_event.dart';
import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_state.dart';
import '../utils/color_utils.dart';
import '../utils/string_utils.dart';

class ChatScreen extends StatefulWidget{
  ChatUser me;
  ChatUser you;
  ChatScreen({required this.me,required this.you});
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  late ChatController _chatController;
  late final ChatUser _me = widget.me;
  late final ChatUser _you = widget.you;
  late ChatBloc bloc;
  @override
  void initState() {
    super.initState();
    _chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      chatUsers: [
       _you
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ChatBloc>(
        create: (BuildContext context) {
          bloc =  ChatBloc(roomId: _you.id+_me.id,you: _you,me: _me);
          return bloc;
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<ChatBloc,ChatState>(listener: (_,state){
              for (var element in state.messages) {
                String messageString = element.msg!;
                Message message = Message.fromJson(jsonDecode(messageString));
                message.id = element.id!;
                if(element.reactions!=null) {
                  for (var reaction in element.reactions!.keys) {
                    for(var username in element.reactions![reaction]!.usernames!){
                      message.reaction.
                    }
                  }
                }
                _chatController.initialMessageList.add(message);
              }
            },
            listenWhen: (state1,state2) => state2 is LoadHistoryState),

          ],
          child: BlocBuilder<ChatBloc,ChatState>(
            builder:(blocContext,state) {
              return ChatView(
              chatController: _chatController,
              currentUser: _me,
              repliedMessageConfig: RepliedMessageConfiguration(
                verticalBarColor: ColorUtils.colorGreenPrimary,
                verticalBarWidth:3,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                  replyTitleTextStyle:const TextStyle(
                    fontSize: 12,
                    height: 10/12,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.colorDarkGrey,
                )
              ),
              sendMessageConfig: SendMessageConfiguration(
                onChanged: (text){
                  bloc.add(TextChangedEvent(text));
                },
                textFieldConfig: TextFieldConfiguration(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.colorDarkGrey,
                  )
                )
              ),
              chatBubbleConfig: ChatBubbleConfiguration(
                outgoingChatBubbleConfig: ChatBubble(
                  textStyle: const TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    height: 20/16,
                    color: Colors.white
                  ),
                  color: ColorUtils.colorGreenPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                  margin: const EdgeInsets.fromLTRB(0, 6, 22, 0)
                ),
                inComingChatBubbleConfig: ChatBubble(
                    textStyle: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        height: 20/16,
                        color: Colors.black
                    ),
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    margin: const EdgeInsets.fromLTRB(6, 6, 6, 0)
                ),
              ),
              chatBackgroundConfig: const ChatBackgroundConfiguration(
                  backgroundColor:ColorUtils.colorLightGrey,
              ),
              showTypingIndicator:state.youTyping,

              typeIndicatorConfig: TypeIndicatorConfiguration(
              ),
              featureActiveConfig: const FeatureActiveConfig(
                enableOtherUserProfileAvatar: true,
                enableTextField: true,
                enableChatSeparator: true,
                  enableSwipeToSeeTime:true,

              ),
              reactionPopupConfig: ReactionPopupConfiguration(
                userReactionCallback: (message,emoji){
                  bloc.add(ReactionEvent(message.id,emoji));
                }
              ),
              onSendTap: _onSendTap,
                chatViewState: ChatViewState.hasMessages,
            );
            }
          ),
        ),
      ),
    );
  }
  

  void _onSendTap(String message, ReplyMessage replyMessage, MessageType messageType) {
    final _message = Message(
      //id: StringUtils.randomId(),
      message: message,
      createdAt: DateTime.now(),
      sendBy: _me.id,
      replyMessage: replyMessage,
      messageType: messageType,
    );
    _chatController.addMessage(_message);
    String jsonMessage = jsonEncode(_message.toJson());
    bloc.add(SendMessageEvent(jsonMessage));
  }
}
