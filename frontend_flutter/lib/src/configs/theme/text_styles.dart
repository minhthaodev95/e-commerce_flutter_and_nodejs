import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextStyle {
  AppTextStyle();
  //style text profile page
  static const TextStyle styleTextProfile = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.grey9,
  );

  // style text Title page
  static const TextStyle styleTitlePage = TextStyle(
    fontSize: 22,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.textTitlePage,
  );

  static const TextStyle styleText1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.text1,
  );

  // style text heading homepage
  static const TextStyle styleHeading1 = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: AppColors.text1,
  );

  // style list text category home page
  static const styleTextCategory1 = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w300,
    color: AppColors.black,
  );

  //title product card homepage
  static const styleTextTitleProduct1 = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.text2,
  );

  //style adtocart homepage
  static const styleTextAdtocart1 = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.text3,
  );

  //style price product card homepage
  static const styleTextPriceProduct1 = TextStyle(
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.text4,
  );

  // category page style :
  // style Heading 1  Category
  static const styleHeadingCategory1 = TextStyle(
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.text4,
  );

  // style Heading 2  Category
  static const styleHeadingCategory2 = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: AppColors.text1,
  );

  // Text Style for product detail page
  // style heading page
  static const styleHeadingProductDetail1 = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    color: AppColors.text4,
  );

  // style title product detail page
  static const styleTitleProductDetail1 = TextStyle(
    fontSize: 22,
    fontFamily: 'Vollkorn',
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  // style description product detail page
  static const styleDescriptionProductDetail1 = TextStyle(
    fontSize: 20,
    fontFamily: 'Vollkorn',
    fontWeight: FontWeight.w400,
    color: AppColors.text2,
  );

  // style price product detail page
  static const stylePriceProductDetail1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.red3,
  );

  // style author product detail page
  static const styleAuthorProductDetail1 = TextStyle(
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.tertiaryColor,
  );
}
