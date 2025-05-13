import 'package:flutter/material.dart';
import 'package:proklinik_patient/extensions/loc_ext.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      scrollable: false,
      title: Row(
        children: [
          Expanded(
            child: Text(context.loc.confirmDeleteBookingTitle),
          ),
          IconButton.outlined(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(Icons.close),
          ),
          const SizedBox(width: 5),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
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
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).canvasColor,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(context.loc.yes),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(context.loc.no),
        ),
      ],
    );
  }
}
