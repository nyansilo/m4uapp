import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app.dart';
import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';
import '../../../controller/controller.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  _LanguageSettingState createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {
  LanguageController langController = Get.put(LanguageController());
  final _textLanguageController = TextEditingController();

  var _listLanguage = Language.languageList();

  //List<Locale> _listLanguage = AppLanguage.supportLanguage;
  //Locale _languageSelected = AppBloc.languageCubit.state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textLanguageController.dispose();
    super.dispose();
  }

  ///On filter language
  void _onFilter(String text) {
    if (text.isEmpty) {
      langController.foundlanguage;
    }
    langController.filterLangauge(text);
  }

  void _onClose() {
    _textLanguageController.clear();
    langController.foundlanguage;
  }

  ///On change language
  void _changeLanguage(int index) async {
    final item = _listLanguage[index];
    UtilOther.hiddenKeyboard(context);
    if (item.toString().isNotEmpty) {
      Locale locale = await setLocale(item.languageCode);
      App.setLocale(context, locale);
    }
    langController.updateLanguageName(item.name);
    ;
  }

  @override
  Widget build(BuildContext context) {
    var _languageSelected = langController.languageName;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translation(context).change_language,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextInput(
                hintText: translation(context).search,
                controller: _textLanguageController,
                onChanged: _onFilter,
                onSubmitted: _onFilter,
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: _onClose,
                  child: const Icon(Icons.clear),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Widget? trailing;
                    final selected = langController.languageName;
                    final item = langController.foundlanguage.value[index];

                    if (item.name == selected) {
                      trailing = Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    return AppListTitle(
                      title: item.name,
                      trailing: trailing,
                      onPressed: () async {
                        if (item.toString().isNotEmpty) {
                          Locale locale = await setLocale(item.languageCode);
                          App.setLocale(context, locale);
                        }
                        langController.updateLanguageName(item.name);
                        // setState(() {
                        // _languageSelected = item.name;
                        //});
                      },
                      border: index !=
                          langController.foundlanguage.value.length - 1,
                      leading: CircleFlag(
                        item.countryCode,
                        size: 25,
                      ),
                    );
                  },
                  itemCount: langController.foundlanguage.value.length,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton('confirm',
                  mainAxisSize: MainAxisSize.max,
                  onPressed: () {} //_changeLanguage,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
