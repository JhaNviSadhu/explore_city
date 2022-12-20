import 'package:explore_city/screens/addscreen.dart';
import 'package:explore_city/utils/colors.dart';
import 'package:explore_city/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
          Get.to(() => const AddScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
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
                  offset: const Offset(9, 7), // changes position of shadow
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
                    color: primarycolor2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "City Name",
                        style: DosisSemiBold.kTextStyle18Normal,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "city discription",
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
        itemCount: 10,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }

  PopupMenuButton<int> _buildPopupMenu(int index) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert_rounded),
      position: PopupMenuPosition.under,
      onSelected: (ind) {
        print(ind);
        // _actionOnClickPopupMenu(ind, index);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0,
          height: 25,
          child: Text("Edit"),
        ),
        const PopupMenuDivider(height: 1),
        const PopupMenuItem(
          value: 1,
          height: 25,
          child: Text("Delete"),
        ),
      ],
      offset: const Offset(10, 10),
    );
  }
}
