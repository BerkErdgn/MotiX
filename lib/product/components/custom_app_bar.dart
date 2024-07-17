import 'package:flutter/material.dart';

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
      title: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: ClipOval(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Center(
              child: Image.asset('assets/logo/yeniMotix.png', width: 90),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
