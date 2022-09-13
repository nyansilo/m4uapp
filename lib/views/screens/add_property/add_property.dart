import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../classes/language_constant.dart';
import '../../../config/config.dart';
import '../../../controller/controller.dart';
import '../../../models/model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class AddProperty extends StatefulWidget {
  final PropertyModel? item;
  const AddProperty({
    Key? key,
    this.item,
  }) : super(key: key);

  @override
  _AddPropertyState createState() {
    return _AddPropertyState();
  }
}

class _AddPropertyState extends State<AddProperty> {
  final _textTitleController = TextEditingController();
  final _textContentController = TextEditingController();
  final _textTagsController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textZipCodeController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final _textFaxController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textWebsiteController = TextEditingController();
  final _textStatusController = TextEditingController();
  final _textPriceMinController = TextEditingController();
  final _textPriceMaxController = TextEditingController();

  final _focusTitle = FocusNode();
  final _focusContent = FocusNode();
  final _focusAddress = FocusNode();
  final _focusZipCode = FocusNode();
  final _focusPhone = FocusNode();
  final _focusFax = FocusNode();
  final _focusEmail = FocusNode();
  final _focusWebsite = FocusNode();
  final _focusPriceMin = FocusNode();
  final _focusPriceMax = FocusNode();

  bool _processing = false;

  String? _errorTitle;
  String? _errorContent;
  String? _errorAddress;
  String? _errorZipCode;
  String? _errorPhone;
  String? _errorFax;
  String? _errorEmail;
  String? _errorWebsite;
  String? _errorStatus;
  String? _errorPriceMin;
  String? _errorPriceMax;
  bool _loading = false;

  /// Data
  List<PropertyCategoryModel> _listCategory = [];

  ///Data Params

  List<PropertyImageModel> _galleryImage = [];
  List<PropertyCategoryModel> _categories = [];
  List<PropertyRegionModel>? _regionList;
  List<PropertyDistrictModel>? _districtList;

  PropertyRegionModel? _region;
  PropertyDistrictModel? _district;

  Color? _color;

  @override
  void initState() {
    super.initState();
    //_onProcess();
  }

  @override
  void dispose() {
    _textTitleController.dispose();
    _textContentController.dispose();
    _textTagsController.dispose();
    _textAddressController.dispose();
    _textZipCodeController.dispose();
    _textPhoneController.dispose();
    _textFaxController.dispose();
    _textEmailController.dispose();
    _textWebsiteController.dispose();
    _textStatusController.dispose();
    _textPriceMinController.dispose();
    _textPriceMaxController.dispose();
    _focusTitle.dispose();
    _focusContent.dispose();
    _focusAddress.dispose();
    _focusZipCode.dispose();
    _focusPhone.dispose();
    _focusFax.dispose();
    _focusEmail.dispose();
    _focusWebsite.dispose();
    _focusPriceMin.dispose();
    _focusPriceMax.dispose();
    super.dispose();
  }

  ///On Select Country
  void _onSelectRegion() async {
    var controller = Get.find<AddPropertyController>();
    //controller.updateCategoryId(category!.categoryId);
    final _regionList = controller.allRegions;
    final selected = await Navigator.pushNamed(
      context,
      Routes.pickerRoute,
      arguments: PickerModel(
        title: 'choose_country',
        selected: [_region],
        data: _regionList,
      ),
    );
    if (selected != null && selected is PropertyRegionModel) {
      setState(() {
        _region = selected;
        _districtList = null;
        _district = null;
      });

      controller.updateRegionId(selected.id);
      print('ID id: ${selected.id}');
      final result = controller.relatedDistricts;
      print('Result: ${result}');
      //final result = await CategoryRepository.loadLocation(selected.id);
      if (result != null) {
        setState(() {
          _districtList = result;
        });
      }
    }
  }

  ///On Select city
  void _onSelectDistrict() async {
    var controller = Get.find<AddPropertyController>();

    //controller.updateCategoryId(category!.categoryId);
    // final result = controller.allRegions;
    final selected = await Navigator.pushNamed(
      context,
      Routes.pickerRoute,
      arguments: PickerModel(
        title: 'choose_district',
        selected: [_district],
        data: _districtList ?? [],
      ),
    );

    if (selected != null && selected is PropertyDistrictModel) {
      setState(() {
        _district = selected;
      });
    }
  }

  ///On Upload Gallery
  void _onUploadGallery() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.galleryUploadRoute,
      arguments: List<PropertyImageModel>.from(_galleryImage).map((item) {
        return PropertyImageModel(
          id: item.id,
          imgUrl: item.imgUrl,
        );
      }).toList(),
    );

    if (result != null && result is List<PropertyImageModel>) {
      setState(() {
        _galleryImage = result;
      });
    }
  }

  ///On Select Color
  void _onSelectColor() async {
    final result = await showDialog<Color?>(
      context: context,
      builder: (BuildContext context) {
        Color? selected;
        return AlertDialog(
          title: Text('choose_color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Theme.of(context).primaryColor,
              onColorChanged: (color) {
                selected = color;
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            AppButton(
              'close',
              onPressed: () {
                Navigator.pop(context);
              },
              type: ButtonType.text,
            ),
            AppButton(
              'apply',
              onPressed: () {
                Navigator.pop(context, selected);
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        _color = result;
      });
    }
  }

  ///On Submit
  void _onSubmit() async {
    final success = _validData();
    if (success) {
      setState(() {
        _loading = true;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  ///On Success
  void _onSuccess() {
    // Navigator.pushReplacementNamed(context, Routes.submitSuccess);
  }

  ///valid data
  bool _validData() {
    ///Title
    _errorTitle = UtilValidator.validate(
      _textTitleController.text,
    );

    ///Content
    _errorContent = UtilValidator.validate(
      _textContentController.text,
    );

    ///Address
    _errorAddress = UtilValidator.validate(
      _textAddressController.text,
    );

    ///ZipCode
    _errorZipCode = UtilValidator.validate(
      _textZipCodeController.text,
      type: ValidateType.number,
      allowEmpty: true,
    );

    ///Phone
    _errorPhone = UtilValidator.validate(
      _textPhoneController.text,
      type: ValidateType.phone,
      allowEmpty: true,
    );

    ///Fax
    _errorFax = UtilValidator.validate(
      _textFaxController.text,
      type: ValidateType.phone,
      allowEmpty: true,
    );

    ///Email
    _errorEmail = UtilValidator.validate(
      _textEmailController.text,
      type: ValidateType.email,
      allowEmpty: true,
    );

    ///Website
    _errorWebsite = UtilValidator.validate(
      _textWebsiteController.text,
      allowEmpty: true,
    );

    ///Status
    _errorStatus = UtilValidator.validate(
      _textStatusController.text,
      allowEmpty: true,
    );

    ///Price Min
    _errorPriceMin = UtilValidator.validate(
      _textPriceMinController.text,
      type: ValidateType.number,
      allowEmpty: true,
    );

    ///Price Max
    _errorPriceMax = UtilValidator.validate(
      _textPriceMinController.text,
      type: ValidateType.number,
      allowEmpty: true,
    );

    final min = int.tryParse(_textPriceMinController.text) ?? 0;
    final max = int.tryParse(_textPriceMaxController.text) ?? 0;
    if (min > max) {
      _errorPriceMax = 'min_value_not_valid';
    }

    if (_errorTitle != null ||
        _errorContent != null ||
        _errorAddress != null ||
        _errorAddress != null ||
        _errorPhone != null ||
        _errorFax != null ||
        _errorEmail != null ||
        _errorWebsite != null ||
        _errorStatus != null ||
        _errorPriceMin != null ||
        _errorPriceMax != null) return false;

    return true;
  }

  ///Build gallery
  Widget _buildGallery() {
    DecorationImage? decorationImage;
    IconData icon = Icons.add;
    if (_galleryImage.isNotEmpty) {
      icon = Icons.dashboard_customize_outlined;
      decorationImage = DecorationImage(
        image: NetworkImage(
          _galleryImage.first.imgUrl!,
        ),
        fit: BoxFit.cover,
      );
    }
    return InkWell(
      onTap: _onUploadGallery,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(8),
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: decorationImage,
          ),
          alignment: Alignment.center,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ///Build content
  Widget _buildContent() {
    String textActionOpenTime = 'add';
    Widget icon = Icon(
      Icons.help_outline,
      color: Theme.of(context).hintColor,
    );

    if (_processing) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                _buildGallery(),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'title',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_title',
              errorText: _errorTitle,
              controller: _textTitleController,
              focusNode: _focusTitle,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorTitle = UtilValidator.validate(
                    _textTitleController.text,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusTitle,
                  _focusContent,
                );
              },
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textTitleController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'content',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              maxLines: 6,
              hintText: 'input_content',
              errorText: _errorContent,
              controller: _textContentController,
              focusNode: _focusContent,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  _errorContent = UtilValidator.validate(
                    _textContentController.text,
                  );
                });
              },
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textContentController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'category',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            /*AppPickerItem(
              title: 'choose_category',
              value: _categories.map((e) => e.title).join(", "),
              onPressed: _onSelectCategory,
            ),
            */

            const Divider(),
            const SizedBox(height: 16),
            AppPickerItem(
              title: 'choose_region',
              value: _region?.name,
              onPressed: _onSelectRegion,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: AppPickerItem(
                    title: 'choose_district',
                    value: _district?.name,
                    loading: _region != null && _districtList == null,
                    onPressed: _onSelectDistrict,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            AppTextInput(
              hintText: 'input_address',
              errorText: _errorAddress,
              controller: _textAddressController,
              focusNode: _focusAddress,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorAddress = UtilValidator.validate(
                    _textAddressController.text,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusAddress,
                  _focusZipCode,
                );
              },
              leading: Icon(
                Icons.home_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textAddressController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_zipcode',
              errorText: _errorZipCode,
              controller: _textZipCodeController,
              focusNode: _focusZipCode,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorZipCode = UtilValidator.validate(
                    _textZipCodeController.text,
                    type: ValidateType.number,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusZipCode,
                  _focusPhone,
                );
              },
              leading: Icon(
                Icons.wallet_travel_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textZipCodeController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_phone',
              errorText: _errorPhone,
              controller: _textPhoneController,
              focusNode: _focusPhone,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorPhone = UtilValidator.validate(
                    _textPhoneController.text,
                    type: ValidateType.phone,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusPhone,
                  _focusFax,
                );
              },
              leading: Icon(
                Icons.phone_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textPhoneController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_fax',
              errorText: _errorFax,
              controller: _textFaxController,
              focusNode: _focusFax,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorFax = UtilValidator.validate(
                    _textFaxController.text,
                    type: ValidateType.phone,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusFax,
                  _focusEmail,
                );
              },
              leading: Icon(
                Icons.phone_callback_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textFaxController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_email',
              errorText: _errorEmail,
              controller: _textEmailController,
              focusNode: _focusEmail,
              textInputAction: TextInputAction.next,
              onChanged: (text) {
                setState(() {
                  _errorEmail = UtilValidator.validate(
                    _textEmailController.text,
                    type: ValidateType.email,
                    allowEmpty: true,
                  );
                });
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusEmail,
                  _focusWebsite,
                );
              },
              leading: Icon(
                Icons.email_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textEmailController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_website',
              errorText: _errorWebsite,
              controller: _textWebsiteController,
              focusNode: _focusWebsite,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  _errorWebsite = UtilValidator.validate(
                    _textWebsiteController.text,
                    allowEmpty: true,
                  );
                });
              },
              leading: Icon(
                Icons.language_outlined,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textWebsiteController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'color',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppPickerItem(
                        leading: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _color ?? Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        value: _color?.value.toRadixString(16),
                        title: 'choose_color',
                        onPressed: _onSelectColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'status',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'input_status',
              errorText: _errorStatus,
              controller: _textStatusController,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  _errorStatus = UtilValidator.validate(
                    _textStatusController.text,
                    allowEmpty: true,
                  );
                });
              },
              leading: Icon(
                Icons.alternate_email,
                color: Theme.of(context).hintColor,
              ),
              trailing: GestureDetector(
                dragStartBehavior: DragStartBehavior.down,
                onTap: () {
                  _textStatusController.clear();
                },
                child: const Icon(Icons.clear),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'price_min',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: 'input_price',
                        errorText: _errorPriceMin,
                        controller: _textPriceMinController,
                        focusNode: _focusPriceMin,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          setState(() {
                            _errorPriceMin = UtilValidator.validate(
                              _textPriceMinController.text,
                              type: ValidateType.number,
                              allowEmpty: true,
                            );
                          });
                        },
                        onSubmitted: (text) {
                          UtilOther.fieldFocusChange(
                            context,
                            _focusPriceMin,
                            _focusPriceMax,
                          );
                        },
                        leading: Icon(
                          Icons.price_change_outlined,
                          color: Theme.of(context).hintColor,
                        ),
                        trailing: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _textPriceMinController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'price_max',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: 'input_price',
                        errorText: _errorPriceMax,
                        controller: _textPriceMaxController,
                        focusNode: _focusPriceMax,
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          setState(() {
                            _errorPriceMax = UtilValidator.validate(
                              _textPriceMaxController.text,
                              type: ValidateType.number,
                              allowEmpty: true,
                            );
                          });
                        },
                        leading: Icon(
                          Icons.price_change_outlined,
                          color: Theme.of(context).hintColor,
                        ),
                        trailing: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _textPriceMaxController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String textTitle = 'add_new_listing';
    String textAction = 'add';
    if (widget.item != null) {
      textTitle = 'update_listing';
      textAction = 'update';
    }
    Widget action = AppButton(
      textAction,
      onPressed: _onSubmit,
      type: ButtonType.text,
    );
    if (_loading) {
      action = Row(
        children: const [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 16),
        ],
      );
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(textTitle),
          actions: [action],
        ),
        body: SafeArea(
          child: _buildContent(),
        ),
      ),
    );
  }
}
