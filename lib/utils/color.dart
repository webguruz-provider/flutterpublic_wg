import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color black9007f = fromHex('#7f000000');

  static Color whiteA7007f = fromHex('#7fffffff');

  static Color gray5001 = fromHex('#fafffc');

  static Color black9007e = fromHex('#7e000000');

  static Color greenA700 = fromHex('#1BAC4B');
  
  static Color greenA70087 = fromHex('#1BAC4B');


  static Color greenA70002 = fromHex('#1aac5d');

  static Color greenA70001 = fromHex('#04a863');

  static Color red800 = fromHex('#c8241b');

  static Color gray80004 = fromHex('#3a3a3a');

  static Color gray80003 = fromHex('#4d4d4d');

  static Color gray80002 = fromHex('#444444');

  static Color gray80001 = fromHex('#4d4e4d');

  static Color black9003f = fromHex('#3f000000');

  static Color black900B7 = fromHex('#b7000000');

  static Color lightBlue900 = fromHex('#01448b');

  static Color green500 = fromHex('#37b662');

  static Color whiteA70099 = fromHex('#99ffffff');

  static Color black90001 = fromHex('#0c0c0c');

  static Color gray40059 = fromHex('#59b8b8b8');

  static Color blueGray90001 = fromHex('#313131');

  static Color blueGray900 = fromHex('#292b2d');

  static Color black90003 = fromHex('#09041b');

  static Color black90002 = fromHex('#130e07');

  static Color redA700 = fromHex('#e00606');

  static Color greenA7007a = fromHex('#7a1aac4a');

  static Color gray600 = fromHex('#727272');

  static Color gray400 = fromHex('#b6b6b6');

  static Color blueGray100 = fromHex('#d9d9d9');

  static Color gray800 = fromHex('#4c4747');

  static Color gray4003f = fromHex('#3faeaeae');

  static Color blueGray10035 = fromHex('#35d9d9d9');

  static Color greenA70056 = fromHex('#561aac4a');

  static Color black9000f = fromHex('#0f000000');

  static Color orange400 = fromHex('#ff9b26');

  static Color gray60026 = fromHex('#26808080');

  static Color gray200 = fromHex('#e7e7e7');

  static Color blueGray4007f = fromHex('#7f8e8e8e');

  static Color black90055 = fromHex('#55000000');

  static Color gray40001 = fromHex('#b8b8b8');

  static Color black90093 = fromHex('#93000000');

  static Color bluegray400 = fromHex('#888888');

  static Color gray10001 = fromHex('#f3f3f3');

  static Color black90019 = fromHex('#19000000');

  static Color redA70001 = fromHex('#ff0606');

  static Color blueGray40002 = fromHex('#868686');

  static Color blue2006c = fromHex('#6c9bcafb');

  static Color blueGray40001 = fromHex('#8d8b8b');

  static Color whiteA700 = fromHex('#ffffff');

  static Color black9005e = fromHex('#5e000000');

  static Color blueGray50 = fromHex('#f1f1f1');

  static Color blueGray10001 = fromHex('#d0d0d0');

  static Color gray5003f = fromHex('#3fadadad');

  static Color red500 = fromHex('#ff2828');

  static Color gray50 = fromHex('#f8f8f8');

  static Color black9001e = fromHex('#1e000000');

  static Color lightBlue800 = fromHex('#007bad');

  static Color black900 = fromHex('#000000');

  static Color gray50001 = fromHex('#939393');

  static Color greenA7001c = fromHex('#1c1aac4a');

  static Color greenA70026 = fromHex('#261aac4a');

  static Color gray50003 = fromHex('#979797');

  static Color gray50002 = fromHex('#9d9898');

  static Color gray50004 = fromHex('#9b9b9b');

  static Color gray700 = fromHex('#949494');

  static Color gray60002 = fromHex('#867f7f');

  static Color gray500 = fromHex('#aaaaaa');

  static Color black9002b = fromHex('#2b000000');

  static Color gray60001 = fromHex('#7d7d7d');

  static Color blueGray400 = fromHex('#8e8e8e');

  static Color gray900 = fromHex('#1c0f0c');

  static Color gray90001 = fromHex('#121212');

  static Color green50 = fromHex('#ddf3e4');

  static Color gray300 = fromHex('#e1e1e1');

  static Color gray30002 = fromHex('#dedbdb');

  static Color gray30001 = fromHex('#e3e3e3');

  static Color gray100 = fromHex('#f2f2f2');

  static Color whiteA70087 = fromHex('#87ffffff');

  static Color whiteA70044 = fromHex('#44ffffff');

  static Color gray300B5 = fromHex('#b5dedbdb');

  static Color yellowFF9B26 = fromHex('#FF9B26');

  static Color lineColor = fromHex('#DADADA');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
