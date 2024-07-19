import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(screenHeight),
          SizedBox(height: screenHeight * 0.07),
          const UserName(),
          SizedBox(height: screenHeight * 0.01),
          const UserMail(),
          SizedBox(height: screenHeight * 0.03),
          const PostLine(),
          Expanded(child: _buildPostList(screenHeight)),
        ],
      ),
    );
  }

Widget _buildHeader(double screenHeight) {
  return Container(
    height: screenHeight * 0.3,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFBCFAD),
          Color.fromARGB(0, 254, 138, 71),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Center(
      child: Transform.translate(
        offset: Offset(0, screenHeight * 0.1),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF141414).withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
              ),
            ],
          ),
          child: const Ellipse3(),
        ),
      ),
    ),
  );
}




  Widget _buildPostList(double screenHeight) {
    return ListView.builder(
      itemCount: 12, // Number of items in the list
      itemBuilder: (context, index) {
        return PostCard(index: index);
      },
    );
  }
}

class Ellipse3 extends StatelessWidget {
  const Ellipse3({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageSize = MediaQuery.of(context).size.width * 0.45;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: const ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(width: 6, color: Colors.white),
        ),
      ),
      child: ClipOval(
        child: Image.network(
          'https://pbs.twimg.com/profile_images/1446636619/saaaagoooppaaaa_400x400.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Sagopa Kajmer',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class UserMail extends StatelessWidget {
  const UserMail({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'sagokafkef@gmail.com',
          style: TextStyle(
            color: const Color(0xFFE38343),
            fontSize: screenWidth * 0.033,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PostLine extends StatelessWidget {
  const PostLine({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'Gönderilerim',
          style: TextStyle(
            color: const Color(0xFFE38343),
            fontSize: screenWidth * 0.035,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          width: screenWidth * 0.9,
          height: 1,
          color: const Color(0xFFCAC4C4),
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  final int index;
  const PostCard({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.delete),color: Color (0xFFed7d32), ),
              SizedBox(width: screenWidth * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post $index',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    'This is the detail of post $index.',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
