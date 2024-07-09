import 'package:flutter/material.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _nameState();
}

class _nameState extends State<SocialMediaPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('SocialMediaPage Page'));
  }
}
