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
    List<Widget> actions = [];
    if (showAddButton) {
      actions.add(
        IconButton(
          icon: const Icon(
            Icons.add,
            size: 38,
          ),
          onPressed: onPressed,
        ),
      );
    }

    return AppBar(
      title: Center(
        child: Row(
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
            Expanded(
              child: Center(
                child: Image.asset('assets/logo/MotiX.png', width: 70),
              ),
            ),
          ],
        ),
      ),
      actions: actions.isEmpty ? null : actions,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
