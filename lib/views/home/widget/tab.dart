import 'package:flutter/material.dart';
import 'package:segments/constant.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const TabItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.isSelected,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: lebarlayar / 30, vertical: tinggilayar / 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? primarycolor : Colors.grey[700],
            ),
            Text(
              text,
              style: TextStyle(
                  color: isSelected ? primarycolor : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: tinggilayar / lebarlayar * 5),
            )
          ],
        ),
      ),
    );
  }
}
