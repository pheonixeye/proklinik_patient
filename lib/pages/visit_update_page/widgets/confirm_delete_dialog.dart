import 'package:flutter/material.dart';
import 'package:patient/extensions/loc_ext.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Text(context.loc.confirmDeleteBookingTitle),
          const Spacer(),
          IconButton.outlined(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.loc.confirmDeleteBookingMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.loc.confirm),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.loc.cancel),
        ),
      ],
    );
  }
}
