import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/app_prefs.dart';
import 'package:flutter_advance_course/app/di.dart';
import 'package:flutter_advance_course/data/data_source/local_data_source.dart';
import 'package:flutter_advance_course/presentation/resources/asset_manager.dart';
import 'package:flutter_advance_course/presentation/resources/language_manager.dart';
import 'package:flutter_advance_course/presentation/resources/route_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dart:math' as math;

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppPreferences _appPreferences = instance<AppPreferences>();

  LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(AppStrings.changeLanguage).tr(),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: Transform(
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          ),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(AppStrings.contactUs).tr(),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: Transform(
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          ),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(AppStrings.inviteYourFriends).tr(),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: Transform(
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          ),
          onTap: () {
            _inviteFriend();
          },
        ),
        ListTile(
          title: Text(AppStrings.logout).tr(),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: Transform(
            transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
            alignment: Alignment.center,
            child: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          ),
          onTap: () {
            _logout();
          },
        )
      ],
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriend() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
