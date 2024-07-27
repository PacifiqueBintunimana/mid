import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  RatingWidget({required this.rating, required this.onRatingChanged});

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    Color color;

    if (index >= rating) {
      icon = Icons.star_border;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Colors.amber;
    } else {
      icon = Icons.star;
      color = Colors.amber;
    }

    return InkWell(
      onTap: () => onRatingChanged(index + 1.0),
      child: Icon(
        icon,
        color: color,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}
/*import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final Function(double) onRatingChanged;

  RatingWidget({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }
}
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  RatingWidget({required this.rating, required this.onRatingChanged});

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    Color color;

    if (index >= rating) {
      icon = Icons.star_border;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Colors.amber;
    } else {
      icon = Icons.star;
      color = Colors.amber;
    }

    return InkWell(
      onTap: () => onRatingChanged(index + 1.0),
      child: Icon(
        icon,
        color: color,
        size: 30.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) => buildStar(context, index)),
    );
  }
}*/
