import 'package:flutter/material.dart';
import 'package:ocean_common_module/ocean_common_module.dart';

import '../../../../constans/app_constants.dart';
import '../../../../utils/helpers/app_helpers.dart';

class OverviewHeader extends StatelessWidget {
  const OverviewHeader({
    required this.onSelected,
    this.axis = Axis.horizontal,
    Key? key,
  }) : super(key: key);

  final Function(TaskType? task) onSelected;
  final Axis axis;
  @override
  Widget build(BuildContext context) {
    final Rx<TaskType?> task = Rx(null);

    return Obx(
      () => (axis == Axis.horizontal)
          ? Row(
              children: [
                const Text(
                  "Task Overview",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                ..._listButton(
                  task: task.value,
                  onSelected: (value) {
                    task.value = value;
                    onSelected(value);
                  },
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Task Overview",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: _listButton(
                      task: task.value,
                      onSelected: (value) {
                        task.value = value;
                        onSelected(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _listButton({
    required TaskType? task,
    required Function(TaskType? value) onSelected,
  }) {
    return [
      _button(
        selected: task == null,
        label: "All",
        onPressed: () {
          task = null;
          onSelected(null);
        },
      ),
      _button(
        selected: task == TaskType.todo,
        label: "To do",
        onPressed: () {
          task = TaskType.todo;
          onSelected(TaskType.todo);
        },
      ),
      _button(
        selected: task == TaskType.inProgress,
        label: "In progress",
        onPressed: () {
          task = TaskType.inProgress;
          onSelected(TaskType.inProgress);
        },
      ),
      _button(
        selected: task == TaskType.done,
        label: "Done",
        onPressed: () {
          task = TaskType.done;
          onSelected(TaskType.done);
        },
      ),
    ];
  }

  Widget _button({
    required bool selected,
    required String label,
    required Function() onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor:
              selected ? kFontColorPallets[0] : kFontColorPallets[2],
          backgroundColor: selected
              ? Theme.of(Get.context!).cardColor
              : Theme.of(Get.context!).canvasColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
        ),
      ),
    );
  }
}
