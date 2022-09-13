import 'package:flutter/material.dart';

import '../../../domain/usecases/job/applied/add_note.dart';
import '../../../provider/theme.dart';
import '../components.dart';
import '../dialog_button.dart';
import 'custome_expansion_tile_applied.dart';
import 'sidebar/applied_job_elements/applied_job_elements.dart';

export 'costume_expansion_tile.dart';
export 'job_offer_widget.dart';

class AppliedJobWidget extends StatefulWidget {
  const AppliedJobWidget({
    Key? key,
    required this.ajob,
    required this.index,
    required this.callAccDial,
    required this.callRejDial,
    this.refresh,
  }) : super(key: key);

  final AppliedJob ajob;
  final int index;
  final Function(int) callAccDial, callRejDial;
  final Function()? refresh;

  @override
  State<AppliedJobWidget> createState() => _AppliedJobWidgetState();
}

class _AppliedJobWidgetState extends State<AppliedJobWidget> {
  late AppliedJob ajob;
  bool ratingOpened = false;
  bool noteEditorOpened = false;
  TextEditingController note = TextEditingController();

  saveNote(String value) {
    if (value != '') {
      AddNote()(appliedJob: ajob, note: value);
    }
  }

  @override
  void initState() {
    super.initState();
    ajob = widget.ajob;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(120),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: CustomTheme.c2,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DateRow(ajob: ajob),
          ClickableApplicantName(ajob: ajob),
          StatusRow(ajob: ajob),
          ChangeStatusButtonsRow(
            callAccDial: widget.callAccDial,
            index: widget.index,
            callRejDial: widget.callRejDial,
          ),
          ApplicantSummary(ajob: ajob),
          CustomExpansionTileApplied(job: ajob),
          const SizedBox(height: 10),
          if (ratingOpened) ...[
            TopRow(
              aJob: ajob,
              refresh: widget.refresh,
              iconOnPress: () {
                setState(() {
                  ratingOpened = false;
                });
              },
            ),
          ],
          if (!ratingOpened) ...[
            BottomRow(
              iconOnPress: () {
                setState(() {
                  ratingOpened = true;
                });
              },
              addOnPress: () {
                setState(() {
                  noteEditorOpened = true;
                });
              },
              showOnPress: () {
                setState(() {
                  showNotes(context, setState);
                });
              },
            ),
          ],
          const SizedBox(height: 10),
          if (noteEditorOpened) ...[
            NoteEdit(
              note: note,
              onPress: (value) {
                saveNote(value);
                setState(() {
                  noteEditorOpened = false;
                  note.clear();
                  if (widget.refresh != null) {
                    widget.refresh!();
                  }
                });
              },
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Future<dynamic> showNotes(BuildContext context, setState) {
    String value = 'interviewing';

    Map<String, List<String>> notes = {};
    for (var e in ajob.notes) {
      if (notes[e.state] == null) {
        notes[e.state] = [];
      }
      notes[e.state]!.add(e.note);
    }

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                  .copyWith(bottom: 0),
          actionsPadding: const EdgeInsets.all(10).copyWith(top: 0),
          actions: [
            DialogButton(
              onPress: () => Navigator.pop(context),
              text: 'Ok',
            ),
          ],
          title: const Text('Select a state to show notes'),
          titleTextStyle:
              (Theme.of(context).textTheme.headline6)?.copyWith(fontSize: 20),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedDropdownButton(
                  icon: Icons.work_history,
                  label: 'State',
                  enabled: true,
                  list: const [
                    'all',
                    'screening',
                    'reviewing',
                    'interviewing',
                    'rejected',
                    'hired',
                  ],
                  value: value,
                  color: Theme.of(context).primaryColor,
                  valueChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: ListView(
                    children: [
                      if (notes.isEmpty ||
                          (value != 'all' &&
                              (notes[value] == null ||
                                  notes[value]!.isEmpty))) ...[
                        const SizedBox(height: 30),
                        Image.asset('assets/png/Asset 2.png', height: 100),
                        const SizedBox(height: 20),
                        Center(
                          child: ListTile(
                            title: Text(
                              'No Notes in $value state',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                      if (notes.isNotEmpty) ...[
                        if (value == 'all')
                          ...ajob.notes.map((e) {
                            return ListTile(
                              title: Text(
                                e.state,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                e.note,
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        if (value != 'all')
                          ...(notes[value] != null)
                              ? notes[value]!.map(
                                  (e) => ListTile(
                                    title: Text(
                                      e,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )
                              : [],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NoteEdit extends StatelessWidget {
  const NoteEdit({
    Key? key,
    required this.note,
    this.onPress,
  }) : super(key: key);
  final Function(String val)? onPress;
  final TextEditingController note;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      suffixText: 'save',
      suffixPress: onPress,
      label: 'Note',
      icon: Icons.note_alt,
      enabled: true,
      multiLines: true,
      controller: note,
      color: Theme.of(context).primaryColor,
      w: 0.8,
    );
  }
}
