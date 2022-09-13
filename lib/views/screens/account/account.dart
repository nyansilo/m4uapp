import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m4uapp/controller/controller.dart';

import '../../../classes/language_constant.dart';
import '../../../utils/branding_color.dart';
import '../../../config/config.dart';
import '../../../controller/controller.dart';

import '../../../utils/utils.dart';

import '../../widgets/widget.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  ///On navigation

  @override
  Widget build(BuildContext context) {
    void _onNavigate(String route) {
      Navigator.pushNamed(context, route);
    }

    var controller = Get.find<PropertyController>();
    var data = controller.allProperties[0];
    var user = data.createdBy;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          //backgroundColor: AppColor.whiteColor,
          elevation: 0,
          title: Text(translation(context).account,
              style: Theme.of(context).textTheme.headline6),
          actions: [
            AppButton(
              translation(context).sign_out,
              mainAxisSize: MainAxisSize.max,
              onPressed: () {},
              type: ButtonType.text,
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  //margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).dividerColor.withOpacity(
                              .05,
                            ),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: const Offset(
                          0,
                          2,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: AppUserInfo(
                    user: user,
                    type: UserViewType.information,
                    onPressed: () {
                      //_onProfile(user);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                AppListTitle(
                  leading: Icon(
                    Icons.view_list_rounded,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).my_property,
                  subtitle: translation(context).check_out_your_properties,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.ballot_rounded,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).my_booking,
                  subtitle: translation(context).check_out_your_bookings,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.favorite_rounded,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).wish_list,
                  subtitle: translation(context).your_most_loved_items,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.help_center_rounded,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).help_center,
                  subtitle:
                      translation(context).help_regarding_your_recent_urchase,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                  border: false,
                ),
                const SizedBox(height: 20),
                AppListTitle(
                  leading: Icon(
                    Icons.manage_accounts_outlined,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).edit_profile,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.lock_reset_outlined,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).change_password,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    size: kTrallingIconSize,
                    Icons.chevron_right,
                  ),
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.settings_outlined,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).setting,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    Icons.chevron_right,
                    size: kTrallingIconSize,
                  ),
                  onPressed: () {
                    _onNavigate(Routes.settingRoute);
                  },
                ),
                AppListTitle(
                  leading: Icon(
                    Icons.logout_outlined,
                    size: kLeadingIconSize,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: translation(context).sign_out,
                  // ignore: prefer_const_constructors
                  trailing: Icon(
                    Icons.chevron_right,
                    size: kTrallingIconSize,
                  ),
                  border: false,
                ),
                const SizedBox(height: 20),
                AppListTitle(
                    isButton: true, title: translation(context).about_us),
                AppListTitle(
                    isButton: true, title: translation(context).contact_us),
                AppListTitle(isButton: true, title: translation(context).faq),
                AppListTitle(
                  isButton: true,
                  title: translation(context).term_of_use,
                ),
                AppListTitle(
                  isButton: true,
                  title: translation(context).privacy_policy,
                  border: false,
                ),
                const SizedBox(height: 20),
                AppListTitle(
                  isButton: true,
                  title: translation(context).app_version,
                ),
              ],
            ),
          ),
        ));
  }
}
