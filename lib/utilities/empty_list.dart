import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyList{
  static Widget empty(BuildContext context, PackageImage packageImage,String title, String subtitle) {
    return EmptyListWidget(
    image: null,
    //packageImage: PackageImage.Image_2,
    packageImage: packageImage,
    title: title,
    subTitle: subtitle,
    titleTextStyle: Theme.of(context)
        .typography
        .dense
        .headline4
        .copyWith(color: Color(0xff9da9c7)),
    subtitleTextStyle: Theme.of(context)
        .typography
        .dense
        .bodyText1
        .copyWith(color: Color(0xffabb8d6)));
  }
}