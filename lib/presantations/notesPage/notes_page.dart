import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/util/components/custom_app_bar.dart';
import 'package:motix_app/util/consts/motix_color_consts.dart';
import 'package:motix_app/util/consts/motix_text_consts.dart';
import '../../data/auth/Auth.dart';
import '../../data/entity/userImageEntity.dart';
import '../../cubit/imageCubit.dart';
import 'note_add.dart';
import 'note_provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
} //end class NotesPage

class _NotesPageState extends State<NotesPage> {
  final User? user = Auth().currentUser;
  String _selectedCategory = NotesStrings.allCategory;

  @override
  void initState() {
    super.initState();
    context.read<Imagecubit>().getUserImage(user?.email ?? "");
    context.read<NoteProvider>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context
        .watch<NoteProvider>()
        .notes
        .where((note) =>
            _selectedCategory == NotesStrings.allCategory ||
            note.category == _selectedCategory)
        .toList();

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
                      label: const Text(NotesStrings.allCategory),
                      selected: _selectedCategory == NotesStrings.allCategory,
                      onSelected: (bool value) {
                        setState(() {
                          _selectedCategory = NotesStrings.allCategory;
                        });
                      }),
                  FilterChip(
                      label: const Text(NotesStrings.workCategory),
                      selected: _selectedCategory == NotesStrings.workCategory,
                      onSelected: (bool value) {
                        setState(() {
                          _selectedCategory = NotesStrings.workCategory;
                        });
                      }),
                  FilterChip(
                      label: const Text(NotesStrings.personalCategory),
                      selected:
                          _selectedCategory == NotesStrings.personalCategory,
                      onSelected: (bool value) {
                        setState(() {
                          _selectedCategory = NotesStrings.personalCategory;
                        });
                      }),
                  FilterChip(
                      label: const Text(NotesStrings.studyCategory),
                      selected: _selectedCategory == NotesStrings.studyCategory,
                      onSelected: (bool value) {
                        setState(() {
                          _selectedCategory = NotesStrings.studyCategory;
                        });
                      }),
                  FilterChip(
                      label: const Text(NotesStrings.sportsCategory),
                      selected:
                          _selectedCategory == NotesStrings.sportsCategory,
                      onSelected: (bool value) {
                        setState(() {
                          _selectedCategory = NotesStrings.sportsCategory;
                        });
                      }),
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
                                color: MotixColor.mainColorDarkGrey,
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.subtitle,
                              style: const TextStyle(
                                fontSize: 16,
                                color: MotixColor.mainColorDarkGrey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                color: MotixColor.mainColorDarkGrey,
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
                                  color: MotixColor.mainColorDarkGrey,
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
} // end class _NotesPageState
