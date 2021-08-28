import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/home/home_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_event.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_state.dart';
import 'package:schedule/presentation/journey/profile/profile_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..add(GetUserNameEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
          log(profileState.username.length.toString());
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColor.secondColor,
              body: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: ProfileConstants.margin),
                          padding: EdgeInsets.all(ProfileConstants.iconPadding),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle),
                          child: Text(
                            profileState.username.length != 0
                                ? profileState.username.substring(0, 2)
                                : '',
                            style:
                                ThemeText.headerStyle2.copyWith(fontSize: 35),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ProfileConstants.paddingVertical),
                          child: Text(
                            profileState.username,
                            textAlign: TextAlign.center,
                            style: ThemeText.headerStyle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildListTile(
                      icon: Icons.score_outlined,
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(OnTabChangeEvent(1));
                      },
                      title: ProfileConstants.myScoresTxt),
                  _buildListTile(
                      icon: Icons.language,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) =>
                                languageDialog(context));
                      },
                      title: ProfileConstants.languageTxt),
                  _buildListTile(
                      icon: Icons.info_outline,
                      onTap: _launchURL,
                      title: ProfileConstants.aboutUsTxt),
                  _buildListTile(
                      icon: Icons.star_rate_outlined,
                      onTap: () {
                        StoreRedirect.redirect(
                          androidAppId: ProfileConstants.androidAppId,
                        );
                      },
                      title: ProfileConstants.rateMeTxt),
                  _buildListTile(
                      icon: Icons.logout,
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context)
                            .add(OnTabChangeEvent(4));
                      },
                      title: ProfileConstants.logOutTxt),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildListTile(
      {required Function()? onTap,
      required String title,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ProfileConstants.listTilePadding),
        color: AppColor.secondColor,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.signInColor,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(title,
                style: ThemeText.buttonStyle
                    .copyWith(color: AppColor.signInColor)),
          ],
        ),
      ),
    );
  }

  Widget languageDialog(BuildContext context) {
    return SimpleDialog(
        contentPadding: EdgeInsets.only(
          bottom: ProfileConstants.listTilePadding,
          top: ProfileConstants.listTilePadding,
        ),
        title: Text(ProfileConstants.languageTxt,
            style: ThemeText.titleStyle
                .copyWith(color: AppColor.personalScheduleColor2)),
        children: [
          _languageItem(ProfileConstants.englishTxt, context),
          _languageItem(ProfileConstants.vietnameseTxt, context)
        ]);
  }

  Widget _languageItem(String title, BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(ProfileConstants.listTilePadding),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: ThemeText.buttonStyle
                          .copyWith(color: AppColor.personalScheduleColor2),
                    ),
                  ),
                ),
                Visibility(
                    visible: true,
                    child: Icon(
                      Icons.check,
                      color: AppColor.personalScheduleColor2,
                    ))
              ],
            ),
          ),
          Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width - 50,
              color: Colors.grey),
        ]));
  }

  _launchURL() async {
    const url = 'https://www.facebook.com/kitclubKMA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      log('Could not launch $url');
    }
  }
}
