import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/app_prefs.dart';
import 'package:flutter_advance_course/app/di.dart';
import 'package:flutter_advance_course/data/data_source/local_data_source.dart';
import 'package:flutter_advance_course/presentation/resources/asset_manager.dart';
import 'package:flutter_advance_course/presentation/resources/route_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          title: Text(AppStrings.changeLang),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          onTap: () {
            _changeLang();
          },
        ),
        ListTile(
          title: Text(AppStrings.contactUs),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(AppStrings.inviteFriend),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          onTap: () {
            _inviteFriend();
          },
        ),
        ListTile(
          title: Text(AppStrings.logout),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: SvgPicture.asset(ImageAssets.settingRightArrowIc),
          onTap: () {
            _logout();
          },
        )
      ],
    );
  }

  void _changeLang() {}

  void _contactUs() {}

  void _inviteFriend() {}

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
