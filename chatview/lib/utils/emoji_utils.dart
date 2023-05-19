import 'package:flutter/material.dart';

class EmojiUtils{
  static String LIKE_KEY = ":thumbsup:";
  static String WOW_KEY = ":open_mouth:";
  static String SAD_KEY = ":cry:";
  static String LOVE_KEY = ":heart:";
  static String HAHA_KEY = ":laughing:";
  static String CARE_KEY = ":kissing_heart:";
  static String ANGRY_KEY = ":angry:";
  static Map<String,String> EMOJI_MAP = {
    LIKE_KEY:"assets/image/like.png",
    WOW_KEY:"assets/image/wow.png",
    SAD_KEY:"assets/image/sad.png",
    LOVE_KEY:"assets/image/love.png",
    HAHA_KEY:"assets/image/haha.png",
    CARE_KEY:"assets/image/care.png",
    ANGRY_KEY:"assets/image/angry.png",
  };
}