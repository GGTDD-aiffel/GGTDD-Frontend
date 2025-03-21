import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'custom_modal_container.dart';

class CustomModal extends StatelessWidget {
  final Widget? title;
  final Widget? body;
  final Widget? bottom;
  final String defaultTitle;
  final String defaultBodyText;
  final VoidCallback? onPressed;

  const CustomModal(
      {super.key,
      this.title,
      this.body,
      this.bottom,
      this.defaultTitle = '제목',
      this.defaultBodyText = '내용을 입력해주세요.',
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final modalWidth = MediaQuery.of(context).size.width * 0.9;
    final buttonWidth = modalWidth * 0.38;

    return Dialog(
      child: CustomModalContainer(
        title: title ??
            Text(
              defaultTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
        body: body ??
            Text(
              defaultBodyText,
              style: const TextStyle(fontSize: 16),
            ),
        bottom: bottom ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: buttonWidth,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      foregroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      '취소',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Gap(8),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () => {
                      if (onPressed != null) {onPressed!()} else {Get.back()}
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
      ),
    );
  }
}
