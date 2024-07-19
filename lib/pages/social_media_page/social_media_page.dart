import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/data/entity/post.dart';
import 'package:motix_app/data/entity/userImageEntity.dart';
import 'package:motix_app/pages/cubit/imageCubit.dart';
import 'package:motix_app/pages/cubit/socialMediaCubit.dart';
import 'package:motix_app/pages/social_media_page/add_blog_post_page.dart';
import 'package:motix_app/pages/social_media_page/blog_post.dart';
import 'package:motix_app/pages/social_media_page/category_item.dart';
import 'package:motix_app/product/components/custom_app_bar.dart';


class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  @override
  _SocialMediaPageState createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  List<Map<String, dynamic>> categories = [
    {'label': 'Trend', 'icon': "assets/categoryIcons/trending.png"},
    {'label': 'Başarı', 'icon': 'assets/categoryIcons/success.png'},
    {'label': 'Kariyer', 'icon': "assets/categoryIcons/career.png"},
    {'label': 'Motivasyon', 'icon': "assets/categoryIcons/motivation.png"},
    {'label': 'Gelişim', 'icon': "assets/categoryIcons/hard-work.png"},
    {'label': 'Kitaplar', 'icon': "assets/categoryIcons/books.png"},
    {'label': 'Eğitim', 'icon': "assets/categoryIcons/education.png"},
    {'label': 'Zaman', 'icon': "assets/categoryIcons/time.png"},
    {'label': 'Hedefler', 'icon': "assets/categoryIcons/goal.png"},
    {'label': 'İlham', 'icon': "assets/categoryIcons/inspiration.png"},
    {'label': 'Özgüven', 'icon': "assets/categoryIcons/self-confidence.png"},
  ];
  String selectedCategory = 'Trend';

  //İmage için
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    context.read<Imagecubit>().getUserImage(user?.email ?? "");
    context.read<SocialMediaCubit>().getAllPost();
  }

  void _navigateToAddBlogPostPage() {

    final imageCubit = context.read<Imagecubit>();
    final socialMediaCubit = context.read<SocialMediaCubit>();

    String postOwnerEmail = imageCubit.state.isNotEmpty ? imageCubit.state.first.userEmail : '';
    String postOwnerName = imageCubit.state.isNotEmpty ? imageCubit.state.first.userName : 'Anonymous';
    String postOwnerProfileIcon = imageCubit.state.isNotEmpty ? imageCubit.state.first.profileIcon : 'cat';


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AddBlogPostPage(
              postOwnerEmail: postOwnerEmail,
              postOwnerName: postOwnerName,
              postOwnerProfileIcon: postOwnerProfileIcon,
              onAdd: (post) {
                context.read<SocialMediaCubit>()
                    .getAllPost(); //Burası yeni ekleme yapıldığı zaman tekrardan güncellemesi için,
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Imagecubit, List<UserImageEntity>>(
        builder: (context, userImageList) {
          String imageUrl;
          if (userImageList.isNotEmpty) {
            imageUrl = userImageList.first.profileIcon;
          } else {
            imageUrl = 'chick';
          }

          return Scaffold(
            appBar: CustomAppBar(
              imageUrl: imageUrl,
              showAddButton: true,
              onPressed: () {
                _navigateToAddBlogPostPage();
              },
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 18),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category['label'];
                            });
                            context.read<SocialMediaCubit>().getPostsByCategory(
                                selectedCategory);
                          },
                          child: CategoryItem(
                            label: category['label'],
                            icon: category['icon'],
                            isSelected: selectedCategory == category['label'],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    selectedCategory,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: BlocBuilder<SocialMediaCubit, List<Post>>(
                      builder: (context, posts) {
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            Post post = posts[index];
                            return BlogPostCard(post: post);
                          },
                        );
                      },
                    )
                ),
              ],
            ),
          );
        }
    );
  }
}
