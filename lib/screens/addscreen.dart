import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:explore_city/utils/constant.dart';
import 'package:explore_city/widget/customtextformfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String? dropdownvalue;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add City",
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
                      child: DropdownButton2(
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        ),
                        // isExpanded: true,
                        disabledHint: Text(
                          'Select Item',
                          style: Dosis.kTextStyleNormal.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        hint: Text(
                          'Select Item',
                          style: Dosis.kTextStyleNormal.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: Dosis.kTextStyleNormal,
                                  ),
                                ))
                            .toList(),
                        value: dropdownvalue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: buildField(
                    title: 'City',
                    child: CustomTextFormField(
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
                hintText: 'Enter City',
                hintTextStyle: Dosis.kTextStyleNormal,
              ),
            ),
            const SizedBox(height: 10),
            buildField(
              title: 'City Discription',
              child: CustomTextFormField(
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
              onPressed: () {},
              child: Text(
                "Add City",
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
