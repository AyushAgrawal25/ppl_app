import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFab/NeuFAB.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/Utils/PlatformUtils.dart';

class DisplayPicture extends StatefulWidget {
  String imgUrl;
  File? proxyImgFile;
  bool toShowProxyImgFile;
  bool isEditable;
  Function? onEditPressed;
  bool isDeletable;
  double? height;
  double? width;
  bool isElevated;
  DisplayPictureType type;
  BorderRadius? borderRadius;
  Widget? actionButton;
  double iconButtonSize;
  double contPadding;
  String token;

  DisplayPicture(
      {required this.imgUrl,
      this.proxyImgFile,
      this.toShowProxyImgFile: false,
      this.onEditPressed,
      this.isEditable: true,
      this.isDeletable: false,
      this.height,
      this.width,
      this.isElevated: true,
      this.borderRadius,
      this.actionButton,
      this.iconButtonSize: 60,
      this.contPadding: 0,
      this.token: "",
      this.type: DisplayPictureType.defaultImg});
  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  // Container Dimensions
  late double containerWidth;
  late double containerHeight;

  // Img Dimensions
  late double imgHeight;
  late double imgWidth;

  // BorderRadius
  late BorderRadius borderRadius;

  bool toShowPic = false;

  settingUpDimensions() {
    // Setting Up Height
    if (widget.height != null) {
      containerHeight = widget.height!;
      imgHeight = widget.height!;
    } else {
      containerHeight = (MediaQuery.of(context).size.width * 0.5);
      imgHeight = (MediaQuery.of(context).size.width * 0.5);
    }

    // Setting Up Width
    if (widget.width != null) {
      containerWidth = widget.width!;
      imgWidth = widget.width!;
    } else {
      containerWidth = (MediaQuery.of(context).size.width * 0.5);
      imgWidth = (MediaQuery.of(context).size.width * 0.5);
    }

    // if its Editable
    if (widget.isEditable) {
      containerHeight += widget.iconButtonSize / 2;
      containerWidth += widget.iconButtonSize / 2;
    }

    if (widget.contPadding > 0) {
      imgHeight -= (2 * widget.contPadding);
      imgWidth -= (2 * widget.contPadding);
    }
  }

  settingUpBorderRadiusAndDefPic() {
    switch (widget.type) {
      case DisplayPictureType.profilePictureMale:
        borderRadius = BorderRadius.circular(360);
        break;
      case DisplayPictureType.profilePictureFemale:
        borderRadius = BorderRadius.circular(360);
        break;
      case DisplayPictureType.slotMainImage:
        borderRadius = BorderRadius.circular(imgWidth / 18);
        break;
      case DisplayPictureType.defaultImg:
        borderRadius = BorderRadius.circular(0);
        break;
    }

    if (widget.borderRadius != null) {
      borderRadius = widget.borderRadius!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.imgUrl == "") || (widget.imgUrl == null)) {
      toShowPic = false;
    } else {
      toShowPic = true;
    }
    settingUpDimensions();
    settingUpBorderRadiusAndDefPic();

    Widget imageWidget = Container();
    OSPlatformType osPlatformType = PlatformUtils().getOSPlatformType();
    if (osPlatformType == OSPlatformType.web) {
      imageWidget = Image.network(
        widget.imgUrl,
        width: imgWidth,
        height: imgHeight,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: widget.imgUrl,
        fit: BoxFit.cover,
        width: imgWidth,
        height: imgHeight,
        errorWidget: (context, url, error) {
          return Container(
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.user_circle_fill,
              size: min(imgHeight, imgWidth),
              color: AppColorScheme.textColor,
            ),
          );
        },
        // httpHeaders: {"Authorization": widget.token},
      );
    }

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: NeuContainer(
              depth: (widget.isElevated) ? 10 : 0,
              borderRadius: borderRadius,
              // style: NeumorphicStyle(
              //     depth: (widget.isElevated) ? 5 : 0,
              //     boxShape: NeumorphicBoxShape.roundRect(borderRadius)),
              child: Container(
                padding: EdgeInsets.all(widget.contPadding),
                child: Container(
                  child: ClipRRect(
                      borderRadius: borderRadius,
                      child: (toShowPic)
                          ? imageWidget
                          : Container(
                              height: imgWidth,
                              width: imgHeight,
                              child: Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  PhosphorIcons.user_circle_fill,
                                  size: min(imgHeight, imgWidth),
                                  color: AppColorScheme.textColor,
                                ),
                              ),
                            )),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: (widget.isElevated)
                      ? [
                          BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.15))
                        ]
                      : null,
                  borderRadius: borderRadius),
              child:
                  ((widget.toShowProxyImgFile) && (widget.proxyImgFile != null))
                      ? ClipRRect(
                          borderRadius: borderRadius,
                          child: Image.file(
                            widget.proxyImgFile!,
                            width: imgWidth,
                            height: imgHeight,
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
            ),
          ),
          (widget.isEditable)
              ? Align(
                  alignment: Alignment(1, 1),
                  child: Container(
                    child: NeuFAB(
                      size: widget.iconButtonSize,
                      child: Icon(
                        FontAwesome.pencil,
                        size: 30 * widget.iconButtonSize / 50,
                        color: AppColorScheme.textColor,
                      ),
                      onPressed: () {
                        if (widget.onEditPressed != null) {
                          widget.onEditPressed!();
                        }
                      },
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          (widget.isDeletable)
              ? Align(
                  alignment: Alignment(1, -1),
                  child: Container(
                    child: NeuFAB(
                      size: 62.5,
                      child: Icon(
                        FontAwesome5.trash,
                        size: 17.5,
                        color: AppColorScheme.textColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          (widget.actionButton != null)
              ? Align(
                  alignment: Alignment(1, 1),
                  child: widget.actionButton,
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}

enum DisplayPictureType {
  profilePictureMale,
  profilePictureFemale,
  slotMainImage,
  defaultImg
}
