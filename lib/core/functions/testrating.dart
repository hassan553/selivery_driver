import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RatingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('قيم السائق')),
      content: Column(
        children: [
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 3,
            itemSize: 40.0,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRatingText('good'),
              buildRatingText('Cool'),
              buildRatingText('Fair'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Get the selected rating and display a toast message
            double rating = 3; // Replace with the actual rating variable
            Fluttertoast.showToast(
              msg: getRatingMessage(rating),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            );
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget buildRatingText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(text),
    );
  }

  String getRatingMessage(double rating) {
    if (rating >= 4) {
      return 'Great!';
    } else if (rating >= 3) {
      return 'Good!';
    } else {
      return 'Could be better...';
    }
  }
}