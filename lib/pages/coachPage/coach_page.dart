import 'dart:io';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/pages/cubit/imageCubit.dart';

import '../../data/entity/userImageEntity.dart';


class CoachPage extends StatefulWidget {
  const CoachPage({super.key});

  @override
  State<CoachPage> createState() => _CoachPageState();
}

class _CoachPageState extends State<CoachPage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "MotAI");

  //GeminiUser progileimage ile resim verilebilir., Aynı şekilde current user'a da

  //İmage için
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    context.read<Imagecubit>().getUserImage(user?.email ?? "user email");
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            BlocBuilder<Imagecubit, List<UserImageEntity>>(
              builder: (context, userImageList) {
                String imageName;
                if (userImageList.isNotEmpty) {
                  imageName = userImageList.first.profileIcon;
                  print("cıktı");
                  print(imageName);
                } else {
                  imageName = "bear";
                }

                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      "assets/animalIcon/$imageName.svg",
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Image.asset('assets/logo/yeniMotix.png', width: 90),
              ),
            ),
          ],
        ),
      ),
      body: _builUI(),
    );
  }

  Widget _builUI() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 5),
      child: DashChat(
          currentUser: currentUser,
          onSend: _sendMessage,
          messages: messages,
          inputOptions: InputOptions(
            cursorStyle: CursorStyle(color: Colors.amber),
            trailing: [
              IconButton(
                  onPressed: _sendMediaMessage,
                  icon: Icon(
                    Icons.image,
                    color: Color(0xFFD4FAFC),
                  )),
            ],
            sendButtonBuilder: (void Function() sendMessage) {
              return IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.send,
                    color: Color(0xFFD4FAFC),
                  ));
            },
            inputDecoration: InputDecoration(
              hintText: "MotAI'a sor...",
              hintStyle: TextStyle(color: Colors.black38),
              fillColor: Color(0xFFFFFBF5),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            ),
            inputTextStyle: const TextStyle(color: Colors.black),
          ),
          scrollToBottomOptions: ScrollToBottomOptions(
            disabled: false,
            scrollToBottomBuilder: (scrollController) {
              return IconButton(
                icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFFD4FAFC)),
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              );
            },
          ),
          messageOptions: MessageOptions(
              currentUserContainerColor: Colors.orange.shade200,
              currentUserTextColor: Colors.black)),
    );
  }

  void _sendMessage(ChatMessage chatMassage) {
    setState(() {
      messages = [chatMassage, ...messages];
    });
    try {
      String question = chatMassage.text;
      List<Uint8List>? images;
      if (chatMassage.medias?.isNotEmpty ?? false) {
        images = [File(chatMassage.medias!.first.url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMassage = messages.firstOrNull;
        if (lastMassage != null && lastMassage.user == geminiUser) {
          lastMassage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMassage.text += response;
          setState(() {
            messages = [lastMassage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Bana bunu açıkla ?",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatMessage);
    }
  }
}
