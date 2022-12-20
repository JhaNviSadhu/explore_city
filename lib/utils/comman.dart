import 'package:explore_city/utils/colors.dart';
import 'package:explore_city/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MessageType { error, warning, success }

String getTitle(MessageType type) {
  switch (type) {
    case MessageType.error:
      return "Error";
    case MessageType.success:
      return "Success";
    case MessageType.warning:
      return "Warning";
  }
}

getColor(MessageType type) {
  switch (type) {
    case MessageType.error:
      return Colors.red;
    case MessageType.success:
      return primarycolor3;
    case MessageType.warning:
      return Colors.yellow[700];
  }
}

Icon getIcon(MessageType type) {
  switch (type) {
    case MessageType.error:
      return const Icon(
        Icons.cancel,
        color: Colors.white,
      );
    case MessageType.success:
      return const Icon(
        Icons.check_circle_outline_outlined,
        color: Colors.white,
      );
    case MessageType.warning:
      return const Icon(
        Icons.warning_amber,
        color: Colors.white,
      );
  }
}

showSnackbar(MessageType type, message) {
  Get.closeAllSnackbars();
  return Get.snackbar(
    getTitle(type),
    "$message",
    snackbarStatus: (status) {
      debugPrint("$status");
    },
    colorText: Colors.white,
    backgroundColor: getColor(type),
    icon: getIcon(type),
  );
}

showActionDialog({VoidCallback? onYesClickEvent}) {
  return Get.defaultDialog(
      actions: [
        ElevatedButton(
          onPressed: onYesClickEvent,
          child: Text("YES"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text("NO"),
        ),
      ],
      title: "Are you sure ?",
      middleText: "You want to delete this City",
      titleStyle: DosisSemiBold.kTextStyle18Normal,
      middleTextStyle: Dosis.kTextStyleNormal,
      radius: 30);
}
