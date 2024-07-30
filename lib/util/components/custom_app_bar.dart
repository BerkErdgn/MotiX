import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imageUrl;
  final VoidCallback onPressed;
  final bool showAddButton;

  const CustomAppBar({
    Key? key,
    required this.imageUrl,
    required this.onPressed,
    this.showAddButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(top: 5),
            child: ClipOval(
              child: SvgPicture.asset(
                "assets/animalIcon/$imageUrl.svg",
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          Center(
            child: Image.asset('assets/logo/MotiX.png', width: 70),
          ),
          if (showAddButton)
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 38,
              ),
              onPressed: onPressed,
            ),
          if (!showAddButton)
            Container(width: 54), // Maintain space for the button
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}