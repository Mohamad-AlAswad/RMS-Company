import 'controllers.dart';

class UserController {
  final List<EduControllers> eduControllers;
  final List<ExpControllers> expControllers;
  final List<LanguagesControllers> languagesControllers;
  final List<SkillsControllers> skillsControllers;
  final PersonalControllers personalControllers;

  UserController({
    required this.eduControllers,
    required this.expControllers,
    required this.languagesControllers,
    required this.skillsControllers,
    required this.personalControllers,
  });
}
