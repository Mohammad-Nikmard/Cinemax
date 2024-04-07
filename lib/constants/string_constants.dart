import 'package:cinemax/util/app_manager.dart';

class StringConstants {
  static const baseImage = "https://pocketbase-t303vjb-1.liara.run";

  static const Map<int, String> months = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "June",
    7: "July",
    8: "Aug",
    9: "Sept",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  static String setBoldPersianFont() {
    if (AppManager.getLnag() == 'fa') {
      return "SM";
    } else {
      return "MSB";
    }
  }

  static String setMediumPersionFont() {
    if (AppManager.getLnag() == 'fa') {
      return "SM";
    } else {
      return "MM";
    }
  }

  static String setSmallPersionFont() {
    if (AppManager.getLnag() == 'fa') {
      return "SM";
    } else {
      return "MR";
    }
  }
}
