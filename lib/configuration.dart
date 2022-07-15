import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:workinstructionhelper/workinstruction.dart';

final arrMenuItem = [
  "자주검사",
  "메뉴숨기기"
];
final arrTitle = [
  "자주검사",
  ""
];

final arrIcon = [
  Icons.auto_fix_high_sharp ,
  Icons.auto_fix_normal_rounded,
  Icons.assessment,
  Icons.warning_rounded,
  Icons.stop_circle_outlined ,
  Icons.image_search_rounded,
  Icons.person_search_rounded,
  Icons.fence_rounded,
  Icons.calendar_today_rounded ,
  Icons.apartment_rounded,
  Icons.checklist_rtl_rounded,
  Icons.sms_failed_rounded,
];

class Configuration {
  static String? strWO = "INS22071224";
  static String? strWID = "A4CA2B87-9901-ED11-9D2B-005056BCA963";

  static String strDashBoardTitle = arrTitle[0].toString();                     // 상단 중앙에 표시될 제목
  static Color clrMenuTextColor = Colors.white;                                 // Menu 글자 색
  static Color clrMenuBackColor = Colors.transparent;                              // Menu 배경 색
  static Color clrMenuOverColor = Colors.teal;                                  // Menu  Mouse Over 배경 색

  static Color clrGridHeaderColor = const Color(0xff01377f);                    // Grid Header 배경색
  static Color clrGridDefaultRowColor = const Color(0xff222942);                // Grid Row Default 배경색
  static Color clsGridAlterRowColor = const Color(0xff222222);                  // Grid Row Alternate 배경색

  static Color clrMiddleTileBackground = Colors.teal;

  static int iMenuIndex = 0;                                                    // 현재 선택한 Menu의 Index
  static Widget wCenterContents = const Text("Hello!");                         // Contents 영역에 표시될 위젯 Instance

  static double dSizeAdjustRatio = 1.0;                                         // 화면 폭을 기준으로(1920)에 따라 길이와 크기를 조절할 비율
  static double dMenuItemWidth = 270;                                           // 메뉴 아이템의 기준 폭
  static double dMenuItemMinWidth = 75;                                         // 메뉴 아이템을 최소화 할 경우의 기준 폭


  static String strServiceLocation = "http://127.0.0.1:9999/service/";
  static String strGetWorkInstruction = strServiceLocation + "workinstruction.asp";

  static List<List<WorkInstructionItem>> lstWII = [[]];
  static List<PlutoColumn> columns = [];
  static List<PlutoRow> rows = [];

  static TextStyle tstMainTitle()              // 메인 타이틀 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 56 * dSizeAdjustRatio, color: Colors.white ); }

  static TextStyle tstDateTime()              // 현재 날짜시간 표시 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 30 * dSizeAdjustRatio, color: Colors.white ); }

  static TextStyle tstMenu()                // 메뉴에 사용할 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 20 * dSizeAdjustRatio, color: Colors.white ); }

  static TextStyle tstMarquee()                // 메뉴에 사용할 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 30 * dSizeAdjustRatio, color: Colors.black ); }

  static TextStyle tstGridHeaderText()              // 현재 날짜시간 표시 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 23 * dSizeAdjustRatio, color: const Color.fromRGBO(0, 239, 225, 1) ); }

  static TextStyle tstGridDefaultText()              // 현재 날짜시간 표시 Text Style
  { return TextStyle( fontFamily: 'default', fontSize: 23 * dSizeAdjustRatio, color: const Color.fromRGBO(255, 255, 255, 1) ); }


}