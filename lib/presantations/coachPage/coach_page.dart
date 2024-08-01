import 'dart:io';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:motix_app/data/auth/Auth.dart';
import 'package:motix_app/cubit/imageCubit.dart';
import 'package:motix_app/util/components/custom_app_bar.dart';
import 'package:motix_app/util/consts/motix_assets_consts.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import '../../data/entity/userImageEntity.dart';

class CoachPage extends StatefulWidget {
  const CoachPage({super.key});

  @override
  State<CoachPage> createState() => _CoachPageState();
} //end class CoachPage

class _CoachPageState extends State<CoachPage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1", firstName: "MotAI", profileImage: MotixImage.coachProfileImage);

  //for image,
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    context.read<Imagecubit>().getUserImage(user?.email ?? "");

    ChatMessage initalMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: "Bugün neler yapıyorsun ? Yardım edebileceğim bir şey var mı ?");
    setState(() {
      messages = [initalMessage, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Imagecubit, List<UserImageEntity>>(
      builder: (context, userImageList) {
        String imageUrl;
        if (userImageList.isNotEmpty) {
          imageUrl = userImageList.first.profileIcon;
        } else {
          imageUrl = CoachPageStrings.noProfileImagePlaceholder;
        }

        return Scaffold(
          appBar: CustomAppBar(
            imageUrl: imageUrl,
            showAddButton: false,
            onPressed: () {
              // Define what happens when the add button is pressed
            },
          ),
          body: _builUI(),
        );
      },
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
            trailing: [
              IconButton(
                  onPressed: _sendMediaMessage,
                  icon: Icon(
                    Icons.image,
                    color: MotixColor.mainColorWhite,
                  )),
            ],
            sendButtonBuilder: (void Function() sendMessage) {
              return IconButton(
                  onPressed: sendMessage,
                  icon: Icon(
                    Icons.send,
                    color: MotixColor.mainColorWhite,
                  ));
            },
            inputDecoration: InputDecoration(
              hintText: CoachPageStrings.promptText,
              hintStyle: TextStyle(color: MotixColor.mainColorDarkGrey),
              fillColor: MotixColor.mainColorLightGray,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            ),
            inputTextStyle:
                const TextStyle(color: MotixColor.mainColorDarkGrey),
          ),
          scrollToBottomOptions: ScrollToBottomOptions(
            disabled: false,
            scrollToBottomBuilder: (scrollController) {
              return IconButton(
                icon: Icon(Icons.keyboard_arrow_down,
                    color: MotixColor.mainColorWhite),
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
              currentUserContainerColor: MotixColor.CoachYellow,
              currentUserTextColor: MotixColor.mainColorDarkGrey)),
    );
  }

  void _sendMessage(ChatMessage chatMassage) {
    // To send prompts to AI,
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
  } // end void _sendMessage

  void _sendMediaMessage() async {
    //To send prompts with media to AI,
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: CoachPageStrings.imageButtonText,
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      _sendMessage(chatMessage);
    }
  } //end void _sendMediaMessage
} // end class _CoachPageState
