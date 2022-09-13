import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decapet/global/app_styles.dart';
import 'package:decapet/language/language_service.dart';

class PhotoDialog extends StatefulWidget {
  PhotoDialog({Key? key, required this.onGallery, required this.onCamera})
      : super(key: key);

  final void Function() onGallery;
  final void Function() onCamera;

  @override
  PhotoDialogState createState() => PhotoDialogState();
}

class PhotoDialogState extends State<PhotoDialog> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onBackPressed,
        child: AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                InkWell(
                    onTap: widget.onGallery,
                    child: SizedBox(
                      width: 235,
                      child: Row(
                        children: [
                          Text(LanguageService.trans('select_gallery'),
                              style: AppTextStyle.PD(Colors.black, 14))
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                InkWell(
                  onTap: widget.onCamera,
                  child: Row(
                    children: [
                      Text(LanguageService.trans('select_camera'),
                          style: AppTextStyle.PD(Colors.black, 14))
                    ],
                  ),
                )
              ],
            ),
          ),
          contentPadding: EdgeInsets.all(20),
        ));
  }
}
