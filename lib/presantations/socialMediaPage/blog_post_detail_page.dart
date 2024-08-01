import 'package:flutter/material.dart';
import 'package:motix_app/data/entity/post.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';

class BlogPostDetailPage extends StatelessWidget {
  final Post post;

  const BlogPostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.postTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.postTitle,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MotixColor.mainColorWhite),
            ),
            const SizedBox(height: 10),
            Text(
              post.postDescription,
              style: const TextStyle(
                  fontSize: 16, color: MotixColor.mainColorWhite),
            ),
          ],
        ),
      ),
    );
  }
} // end class BlogPostDetailPage
