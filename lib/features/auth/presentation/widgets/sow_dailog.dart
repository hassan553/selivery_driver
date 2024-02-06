import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, Function(bool) onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(' سائق Selivery '),
        actions: [
          ElevatedButton(
            onPressed: () {
              onTap(true);
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Text color
            ),
            child: Text('كاميرا'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              onTap(false);
              Navigator.of(context).pop(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Text color
            ),
            child: Text('المعرض'),
          ),
        ],
      );
    },
  );
}
