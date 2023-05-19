import 'dart:convert';

import 'package:chatview/src/models/reply_message.dart';
import 'package:chatview/src/models/message.dart';
import 'package:collection/collection.dart';
import 'package:chat/models/bot.dart';
import 'package:chat/models/mention.dart';
import 'package:chat/models/message_attachment.dart';
import 'package:chat/models/reaction.dart';
import 'package:chat/models/response/mesage_result.dart';
import 'package:chat/models/user.dart';

class RocketMessage {
  String? id;
  String? alias;
  String? msg;
  bool? parseUrls;
  Bot? bot;
  bool? groupable;
  String? t;
  DateTime? ts;
  User? user;
  String? rid;
  DateTime? updatedAt;
  Map<String, Reaction>? reactions;
  List<Mention>? mentions;
  List<String>? channels;
  Map<String, String>? starred;
  String? emoji;
  String? avatar;
  List<MessageAttachment>? attachments;
  User? editedBy;
  DateTime? editedAt;
  List<String>? urls;
  String? imageLocal;
  bool? isUploadingImage = false;

  RocketMessage(
      {this.alias,
      this.id,
      this.msg,
      this.parseUrls,
      this.bot,
      this.groupable,
      this.t,
      this.ts,
      this.user,
      this.rid,
      this.reactions,
      this.mentions,
      this.channels,
      this.starred,
      this.emoji,
      this.avatar,
      this.attachments,
      this.editedBy,
      this.editedAt,
      this.urls,
      this.isUploadingImage,
      this.imageLocal});

  RocketMessage.fromMap(Map<String, dynamic>? json) {
    if (json != null) {
      alias = json['alias'];
      msg = json['msg'];
      parseUrls = json['parseUrls'];
      bot = json['bot'] != null ? Bot.fromMap(json['bot']) : null;
      groupable = json['groupable'];
      t = json['t'];
      ts = json['ts'] != null ? getDateFromMap(json['ts']) : null;
      user = json['u'] != null ? User.fromMap(json['u']) : null;
      rid = json['rid'];
      updatedAt = json['_updatedAt'] != null
          ? getDateFromMap(json['_updatedAt'])
          : null;
      id = json['_id'];

      if (json['reactions'] != null) {
        Map<String, dynamic> reactionMap =
            Map<String, dynamic>.from(json['reactions']);
        reactions = reactionMap.map((a, b) => MapEntry(a, Reaction.fromMap(b)));
      }

      if (json['mentions'] != null) {
        List<dynamic> jsonList = json['mentions'].runtimeType == String //
            ? jsonDecode(json['mentions'])
            : json['mentions'];
        mentions = jsonList
            .where((json) => json != null)
            .map((json) => Mention.fromMap(json))
            .toList();
      }
      channels =
          json['channels'] != null ? List<String>.from(json['channels']) : null;
      starred = json['starred'] != null
          ? Map<String, String>.from(json['starred'])
          : null;
      emoji = json['emoji'];
      avatar = json['avatar'];

      if (json['attachments'] != null) {
        List<dynamic> jsonList = json['attachments'].runtimeType == String //
            ? jsonDecode(json['attachments'])
            : json['attachments'];
        attachments = jsonList
            .where((json) => json != null)
            .map((json) => MessageAttachment.fromMap(json))
            .toList();
      }

      editedBy =
          json['editedBy'] != null ? User.fromMap(json['editedBy']) : null;
      editedAt =
          json['editedAt'] != null ? DateTime.parse(json['editedAt']) : null;
      // urls = json['urls'] != null ? List<String>.from(json['urls']) : null;
    }
  }

  bool isAttachment() {
    var isLocal = imageLocal?.isNotEmpty ?? false;
    var isUrl = attachments?.isNotEmpty ?? false;
    return isUrl || isLocal;
  }

  bool isDetectMode() {
    if (isAttachment()) {
      return false;
    }
    return msg?.contains("[DETECT_MODE]Mode detect") ?? false;
  }

  bool isReplyEditMode(){
    return isEditMode() || isReplyMode() || isCancelMode();
  }
  bool isReplyMode() {
    if (isAttachment()) {
      return false;
    }
    return msg?.contains("[REPLY_MODE]") ?? false;
  }

  bool isEditMode() {
    if (isAttachment()) {
      return false;
    }
    return msg?.contains("[EDIT_MODE]") ?? false;
  }
  bool isCancelMode() {
    if (isAttachment()) {
      return false;
    }
    return msg?.contains("[CANCEL_MODE]") ?? false;
  }
  String? getId(){
    return this.id;
  }

  DateTime getDateFromMap(dynamic json) {
    if (json.toString().contains("date")) {
      var number = json.toString().replaceAll(new RegExp(r'[^0-9]'), '');
      return new DateTime.fromMillisecondsSinceEpoch(int.parse(number));
    } else {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    if (id != null) {
      map['_id'] = id;
    }
    if (alias != null) {
      map['alias'] = alias;
    }
    if (msg != null) {
      map['msg'] = msg;
    }
    if (parseUrls != null) {
      map['parseUrls'] = parseUrls;
    }
    if (bot != null) {
      map['bot'] = bot != null ? bot!.toMap() : null;
    }
    if (groupable != null) {
      map['groupable'] = groupable;
    }
    if (t != null) {
      map['t'] = t;
    }
    if (ts != null) {
      map['ts'] = ts!.toIso8601String();
    }
    if (user != null) {
      map['u'] = user != null ? user!.toMap() : null;
    }
    if (rid != null) {
      map['rid'] = rid;
    }
    if (updatedAt != null) {
      map['_updatedAt'] = updatedAt!.toIso8601String();
    }
    if (reactions != null) {
      map['reactions'] = reactions!.map((a, b) => MapEntry(a, b.toMap()));
    }
    if (mentions != null) {
      map['mentions'] = mentions
              ?.where((json) => json != null)
              ?.map((mention) => mention.toMap())
              ?.toList() ??
          [];
    }
    if (channels != null) {
      map['channels'] = channels;
    }
    if (starred != null) {
      map['starred'] = starred;
    }
    if (emoji != null) {
      map['emoji'] = emoji;
    }
    if (avatar != null) {
      map['avatar'] = avatar;
    }
    if (attachments != null) {
      map['attachments'] = attachments
              ?.where((json) => json != null)
              ?.map((attachment) => attachment.toMap())
              ?.toList() ??
          [];
    }
    if (editedBy != null) {
      map['editedBy'] = editedBy != null ? editedBy!.toMap() : null;
    }
    if (editedAt != null) {
      map['editedAt'] = editedAt!.toIso8601String();
    }
    if (urls != null) {
      map['urls'] = urls;
    }

    return map;
  }

  @override
  String toString() {
    return 'Message{_id: $id, alias: $alias, msg: $msg, parseUrls: $parseUrls, bot: $bot, groupable: $groupable, t: $t, ts: $ts, user: $user, rid: $rid, _updatedAt: $updatedAt, reactions: $reactions, mentions: $mentions, channels: $channels, starred: $starred, emoji: $emoji, avatar: $avatar, attachments: $attachments, editedBy: $editedBy, editedBy: $editedBy, urls: $urls}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RocketMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          alias == other.alias &&
          msg == other.msg &&
          parseUrls == other.parseUrls &&
          bot == other.bot &&
          groupable == other.groupable &&
          t == other.t &&
          ts == other.ts &&
          user == other.user &&
          rid == other.rid &&
          updatedAt == other.updatedAt &&
          DeepCollectionEquality().equals(
              reactions != null ? reactions!.keys : null,
              other.reactions != null ? other.reactions!.keys : null) &&
          DeepCollectionEquality().equals(
              reactions != null ? reactions!.values : null,
              other.reactions != null ? other.reactions!.values : null) &&
          DeepCollectionEquality().equals(mentions, other.mentions) &&
          DeepCollectionEquality().equals(channels, other.channels) &&
          DeepCollectionEquality().equals(starred, other.starred) &&
          emoji == other.emoji &&
          avatar == other.avatar &&
          DeepCollectionEquality().equals(attachments, other.attachments) &&
          editedBy == other.editedBy &&
          editedAt == other.editedAt &&
          DeepCollectionEquality().equals(urls, other.urls);

  @override
  int get hashCode =>
      id.hashCode ^
      alias.hashCode ^
      msg.hashCode ^
      parseUrls.hashCode ^
      bot.hashCode ^
      groupable.hashCode ^
      t.hashCode ^
      ts.hashCode ^
      user.hashCode ^
      rid.hashCode ^
      updatedAt.hashCode ^
      reactions.hashCode ^
      mentions.hashCode ^
      channels.hashCode ^
      starred.hashCode ^
      emoji.hashCode ^
      avatar.hashCode ^
      attachments.hashCode ^
      editedBy.hashCode ^
      editedAt.hashCode ^
      urls.hashCode;

  ReplyMessage replyFromRocketMessage(){
    return ReplyMessage();
  }

  Message messageFromRocketMessage(){
    return Message(message: '', createdAt: DateTime.fromMillisecondsSinceEpoch(ts!.microsecondsSinceEpoch),
        sendBy: id!,
    );
  }
}
