import 'package:epp_user/core/enums/custom_enums.dart';
import 'package:epp_user/core/widgets/custom_toast_widget.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  List<BoxShadow> get boxShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(-5, 5), // changes position of shadow
        ),
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(5, 5), // changes position of shadow
        ),
      ];

  void showToast({
    required String message,
    ToastType toastType = ToastType.error,
    int? maxLines,
    int? duration,
  }) async {
    OverlayEntry? overlayEntry;

    overlayEntry = null;

    final overlayState = Overlay.of(this);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 24,
          right: 24,
          top: 8,
          child: CustomToastWidget(
            message: message,
            toastType: toastType,
            maxLines: 10,
            duration: duration,
            callback: () {
              overlayEntry = _removedOverlayEntry(overlayEntry);
            },
            onDismissed: () {
              overlayEntry = _removedOverlayEntry(overlayEntry);
            },
          ),
        );
      },
    );

    overlayState.insert(overlayEntry!);
  }

  OverlayEntry? _removedOverlayEntry(OverlayEntry? overlayEntry) {
    overlayEntry?.remove();
    overlayEntry = null;
    return overlayEntry;
  }
}
