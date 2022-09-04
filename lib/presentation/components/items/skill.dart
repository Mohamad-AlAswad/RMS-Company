import 'package:flutter/material.dart';

import '../../../domain/usecases/autocomplete/autocomplete_skills.dart';
import '../../../provider/theme.dart';
import '../../controllers/skills_controllers.dart';
import '../custome_auto_complete.dart';

class SkillItem extends StatefulWidget {
  const SkillItem({
    Key? key,
    required this.enabled,
    required this.titles,
    required this.index,
    required this.skillsController,
    required this.delete,
    this.short = false,
    this.required,
    this.sp = false,
  }) : super(key: key);

  final bool enabled, short, sp;
  final List<String> titles;
  final int index;
  final SkillsControllers skillsController;
  final Function(int) delete;
  final Function(bool)? required;

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  DateTime gDate = DateTime.now();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15).copyWith(right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.short) ...[
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.c2.withAlpha(70),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Required',
                    style: TextStyle(fontSize: 18),
                  ),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (!widget.sp)
                        ? (val) {
                            if (widget.required != null) widget.required!(val!);
                            value = val!;
                          }
                        : null,
                    value: value,
                  ),
                ],
              ),
            ),
          ],
          Column(
            children: [
              CustomeAutoComplete(
                controller: widget.skillsController.title,
                autoApi: AutocompleteSkills(),
                label: 'Title',
                enabled: widget.enabled,
                w: widget.sp
                    ? 0.55
                    : widget.short
                        ? 0.4
                        : widget.enabled
                            ? 0.7
                            : 0.8,
              ),
            ],
          ),
          if (widget.enabled) ...[
            IconButton(
              padding: const EdgeInsets.only(right: 1, bottom: 2),
              onPressed: () {
                widget.delete(widget.index);
              },
              icon: const Icon(
                Icons.delete,
                size: 40,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
