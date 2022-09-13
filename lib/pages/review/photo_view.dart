import 'package:decapet/pages/base/base_state.dart';
import 'package:decapet/pages/base/page_layout.dart';
import 'package:decapet/pages/components/simple_header.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/**
 * 사진보기, 유튜브보기
 */
class PhotoViewPage extends StatefulWidget {
  String? img;

  PhotoViewPage({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  PhotoViewPageState createState() => PhotoViewPageState();
}

class PhotoViewPageState extends BaseState<PhotoViewPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        isLoading: isLoading,
        child: Column(children: [
          SimpleHeader(
            title: "사진보기",
            onBackPressed: onBackPressed,
          ),
          Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRect(
                    child: PhotoView.customChild(
                        backgroundDecoration: BoxDecoration(color: Colors.white),
                        child: Container(
                            child: PhotoView(
                          imageProvider: NetworkImage(widget.img!),
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 1.8,
                          initialScale: PhotoViewComputedScale.contained,
                        ))),
                  )))
        ]));
  }
}
