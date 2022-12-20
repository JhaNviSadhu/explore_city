import 'package:cached_network_image/cached_network_image.dart';
import 'package:explore_city/controller/city_controller.dart';
import 'package:explore_city/screens/addscreen.dart';
import 'package:explore_city/utils/colors.dart';
import 'package:explore_city/utils/comman.dart';
import 'package:explore_city/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  CityController _cityController = Get.find<CityController>();

  @override
  void initState() {
    _cityController.getCity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "City",
          style: DosisSemiBold.kTextStyle18Normal,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => (_cityController.cityList.isNotEmpty)
            ? ListView.separated(
                itemCount: _cityController.cityList.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primarycolor1.withOpacity(0.4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset:
                              const Offset(9, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            // color: primarycolor2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${_cityController.cityList[index].imageUrl}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  Images.placehoalder,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text(
                                "${_cityController.cityList[index].cityName}",
                                style: DosisSemiBold.kTextStyle18Normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "${_cityController.cityList[index].cityDiscription}",
                                style: Dosis.kTextStyleNormal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 30.0,
                            maxWidth: 50.0,
                          ),
                          child: _buildPopupMenu(index),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              )
            : Center(
                child: Text(
                "NO DATA",
                style: DosisSemiBold.kTextStyle18Normal,
              )),
      ),
    );
  }

  PopupMenuButton<int> _buildPopupMenu(int index) {
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: const Icon(Icons.more_vert_rounded),
      position: PopupMenuPosition.under,
      onSelected: (ind) {
        print(ind);
        _actionOnClickPopupMenu(ind, index);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          height: 25,
          child: Text(
            "Edit",
            style: Dosis.kTextStyleNormal,
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: 1,
          height: 25,
          child: Text(
            "Delete",
            style: Dosis.kTextStyleNormal,
          ),
        ),
      ],
      offset: const Offset(10, 10),
    );
  }

  _actionOnClickPopupMenu(ind, index) {
    switch (ind) {
      case 0:
        Get.to(() => AddScreen(
              isEdit: true,
              city: _cityController.cityList[index],
            ));
        break;

      case 1:
        showActionDialog(
          onYesClickEvent: () {
            Get.back();
            _cityController.deleteCity(_cityController.cityList[index].id);
          },
        );

        break;
      default:
    }
  }
}
