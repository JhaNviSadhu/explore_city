import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:explore_city/model/model_city.dart';
import 'package:explore_city/utils/constant.dart';
import 'package:explore_city/widget/customtextformfeild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/city_controller.dart';
import '../utils/comman.dart';

class AddScreen extends StatefulWidget {
  final bool isEdit;
  final City? city;
  const AddScreen({super.key, this.isEdit = false, this.city});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _cityNameController = TextEditingController();
  TextEditingController _cityDescriptionController = TextEditingController();
  TextEditingController _cityImageUrlController = TextEditingController();
  final CityController _cityController = Get.find<CityController>();
  var items = [];
  String? dropdownvalue;

  @override
  void initState() {
    _cityController.loadStateList();
    Future.delayed(Duration(seconds: 2), () {
      return items = _cityController.stateList;
    });
    _cityController.stateName.value = widget.city?.stateName ?? '';
    if (widget.isEdit) {
      _cityImageUrlController.text = widget.city?.imageUrl ?? '';
      _cityNameController.text = widget.city?.cityName ?? '';
      _cityDescriptionController.text = widget.city?.cityDiscription ?? '';
      dropdownvalue = widget.city?.stateName;
    }

    super.initState();
  }

  getValidation() {
    if (_cityNameController.text.trim().isEmpty &&
        _cityDescriptionController.text.trim().isEmpty) {
      showSnackbar(MessageType.warning, "Please check your details");
      return false;
    }

    if (_cityNameController.text.trim().isEmpty) {
      showSnackbar(MessageType.warning, "Please enter city name");
      return false;
    }

    if (_cityDescriptionController.text.trim().isEmpty) {
      showSnackbar(MessageType.warning, "Please enter city discription");
      return false;
    }

    if (_cityController.stateName.value == '') {
      showSnackbar(MessageType.warning, "Please select state");
      return false;
    }

    return true;
  }

  onAddClick() {
    bool isValid() {
      var value = getValidation();
      return value;
    }

    if (isValid()) {
      if (widget.isEdit) {
        _cityController.updateCity(City(
          cityName: _cityNameController.text.trim(),
          cityDiscription: _cityDescriptionController.text.trim(),
          stateName: _cityController.stateName.value,
          imageUrl: _cityImageUrlController.text.trim(),
          id: widget.city?.id,
        ));
      } else {
        _cityController.addCity(City(
          cityName: _cityNameController.text.trim(),
          cityDiscription: _cityDescriptionController.text.trim(),
          stateName: _cityController.stateName.value,
          imageUrl: _cityImageUrlController.text.trim(),
        ));
      }
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.isEdit) ? "Edit City" : "Add City",
          style: DosisSemiBold.kTextStyle18Normal,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                buildField(
                  title: "State",
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 0.80),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(
                        () => (_cityController.stateList.isNotEmpty)
                            ? DropdownButton2(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                                // isExpanded: true,

                                hint: Text(
                                  'Select Item',
                                  style: Dosis.kTextStyleNormal.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: _cityController.stateList
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Text(
                                            item.name ?? '',
                                            style: Dosis.kTextStyleNormal,
                                          ),
                                        ))
                                    .toList(),
                                value: dropdownvalue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                  _cityController.stateName.value =
                                      newValue ?? '';
                                },
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildField(
                    title: 'City',
                    child: CustomTextFormField(
                      controller: _cityNameController,
                      hintText: 'Enter City',
                      hintTextStyle: Dosis.kTextStyleNormal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildField(
              title: 'Image URL',
              child: CustomTextFormField(
                controller: _cityImageUrlController,
                hintText: 'Enter City',
                hintTextStyle: Dosis.kTextStyleNormal,
              ),
            ),
            const SizedBox(height: 10),
            buildField(
              title: 'City Discription',
              child: CustomTextFormField(
                controller: _cityDescriptionController,
                hintText: 'Discription',
                hintTextStyle: Dosis.kTextStyleNormal,
                maxLines: 10,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
              ),
              onPressed: () {
                onAddClick();
              },
              child: Text(
                (widget.isEdit) ? "Edit City" : "Add City",
                style: DosisSemiBold.kTextStyle18Normal,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  buildField({title, child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: DosisSemiBold.kTextStyle18Normal,
        ),
        const SizedBox(height: 7),
        Container(
          child: child,
        ),
      ],
    );
  }
}
