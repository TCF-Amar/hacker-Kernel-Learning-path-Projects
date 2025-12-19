import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonText extends StatelessWidget {
  final VoidCallback action;
  final Widget? icon;
  final String text;
  final String? loadingText;
  final RxBool loading;

  const ButtonText({
    super.key,
    required this.action,
    this.icon,
    required this.text,
    this.loadingText,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: loading.value ? null : action,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: loading.value ? Colors.grey : Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading.value)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else if (icon != null)
                  icon!,
                const SizedBox(width: 8),
                Text(loading.value ? (loadingText ?? "Please wait...") : text),
              ],
            ),
          ),
        ),
      );
    });
  }
}
