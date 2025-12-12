import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

SnackBar customSnackBar(String message) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Card(
      color: Colors.red.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(CupertinoIcons.exclamationmark_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: CustomText(
                text: message,
                color: Colors.white,
                size: 14,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
