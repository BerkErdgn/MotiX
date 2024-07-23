import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth/Auth.dart';
import '../../data/entity/userImageEntity.dart';
import '../../product/components/custom_app_bar.dart';
import '../cubit/imageCubit.dart';
import 'note_add.dart';
import 'note_provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final User? user = Auth().currentUser;

  @override
  void initState() {
    super.initState();
    context.read<Imagecubit>().getUserImage(user?.email ?? "");
    context.read<NoteProvider>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<NoteProvider>().notes;

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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNotePage(),
                  ),
                );
              },
              showAddButton: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterChip(
                          label: const Text('Hepsi'),
                          onSelected: (bool value) {}),
                      FilterChip(
                          label: const Text('İş'), onSelected: (bool value) {}),
                      FilterChip(
                          label: const Text('Kişisel'),
                          onSelected: (bool value) {}),
                      FilterChip(
                          label: const Text('Ders'),
                          onSelected: (bool value) {}),
                      FilterChip(
                          label: const Text('Spor'),
                          onSelected: (bool value) {}),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddNotePage(note: note),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: note.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  note.subtitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddNotePage(note: note),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${note.date.day}/${note.date.month}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
