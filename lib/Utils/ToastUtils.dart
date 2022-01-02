import 'package:fluttertoast/fluttertoast.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class ToastUtils {
  static showMessage(String message) {
    Fluttertoast.showToast(
        msg: "   " + message + "   ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColorScheme.lightDividerColor,
        textColor: AppColorScheme.textColor,
        fontSize: 15.0);
  }
}
