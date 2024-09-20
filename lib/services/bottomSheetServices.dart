// lib/services/bottom_sheet_service.dart

import 'package:flutter/material.dart';

class BottomSheetService {
  static Future<void> showSmallBottomSheet({
    required BuildContext context,
    required Widget content,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            content,
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
    );
  }

  static Future<void> showLargeBottomSheet({
    required BuildContext context,
    required Widget content,
  }) async {
    await showModalBottomSheet(
      context: context,
   //   isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        //controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: content,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
    );
  }
}
