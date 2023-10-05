import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

void scrollToBottom(ScrollController controller) {
  if (controller.hasClients) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeOut,
      );
    });
  }
}
