import 'package:flutter/material.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String  icon;
  final bool isSelected;

  const CategoryItem({super.key, 
    required this.label,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: isSelected ?  MotixColor.mainColorOrange : MotixColor.mainColorWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ?  MotixColor.mainColorOrange :  MotixColor.mainColorGrey,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(icon),
                color: isSelected ?  MotixColor.mainColorWhite :  MotixColor.mainColorDarkGrey,
                size: 34,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ?  MotixColor.mainColorWhite :  MotixColor.mainColorWhite,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
