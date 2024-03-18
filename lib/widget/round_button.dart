import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  const Roundbutton(
      {super.key,
      required this.Title,
      required this.ontap,
      this.loading = false});

  final String Title;
  final VoidCallback ontap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  "$Title",
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
