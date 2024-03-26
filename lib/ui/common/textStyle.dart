import 'package:flutter/material.dart';

class CustomTextStyle {
  final BuildContext context;

  CustomTextStyle._(this.context); // make this constructor private

  static CustomTextStyle of(BuildContext context) =>
      CustomTextStyle._(context); // pass context to above constructor

  TextStyle largeTitleBoldStyle() {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 28)
        .copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle mediumTitleBoldStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 20)
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(color: color);
  }

  TextStyle appTitleBoldStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 24)
        .copyWith(fontWeight: FontWeight.w700)
        .copyWith(color: color);
  }

  TextStyle titleBoldStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 14)
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(color: color);
  }

  TextStyle subtitleRegularStyle({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 14)
        .copyWith(fontWeight: FontWeight.w400)
        .copyWith(color: color);
  }

  TextStyle heading3Style({Color? color}) {
    return Theme.of(context)
        .textTheme
        .headline1!
        .copyWith(fontSize: 16)
        .copyWith(letterSpacing: 1.5)
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(color: color);
  }

  TextStyle textSemiBoldStyleTSize18() {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 18)
        .copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle textRegularSize10({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 10)
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(color: color);
  }

  TextStyle textRegularSize12({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 12)
        .copyWith(fontWeight: FontWeight.w500)
        .copyWith(color: color);
  }

  TextStyle textThinSize12({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 12)
        .copyWith(fontWeight: FontWeight.w400)
        .copyWith(color: color);
  }

  TextStyle titleMedium12({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 12)
        .copyWith(fontWeight: FontWeight.w600)
        .copyWith(color: color);
  }

  TextStyle titleBold14({Color? color}) {
    return Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(fontSize: 14)
        .copyWith(fontWeight: FontWeight.w800)
        .copyWith(color: color);
  }
}
