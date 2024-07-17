import 'package:flutter/material.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = '${now.day}/${now.month}/${now.year}';

    String profileImageUrl = 'https://picsum.photos/200/300';
    String profileName = 'Kullanıcı Adı';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPostDetailPage(post: post),
          ),
        );
      },
      child: Card(
        color: Colors.grey[700],
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              title: Text(
                profileName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                formattedDate,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                post.description.length > 100
                    ? '${post.description.substring(0, 100)}...'
                    : post.description,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 6.0,
                children: post.categories
                    .map((category) => Chip(
                          label: Text(category),
                          backgroundColor: Colors.grey[800],
                          labelStyle: const TextStyle(color: Colors.white),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogPostDetailPage extends StatelessWidget {
  final BlogPost post;

  const BlogPostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              post.description,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogPost {
  final String title;
  final String description;
  final List<String> categories;

  BlogPost({
    required this.title,
    required this.description,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categories': categories,
    };
  }

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      title: json['title'],
      description: json['description'],
      categories: List<String>.from(json['categories']),
    );
  }
}
