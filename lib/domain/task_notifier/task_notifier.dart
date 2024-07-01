import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/data/importance_enum.dart';
import 'package:flutter_todo_app/data/task.dart';
import 'package:logging/logging.dart';

class OneTaskNotifier extends ChangeNotifier {
  OneTaskNotifier({
    Task? todo,
    TextEditingController? textEditingController,
    TextEditingController? dropdownController,
  })  : _todo = todo ?? Task.empty(),
        _textEditingController =
            textEditingController ?? TextEditingController(),
        _dropdownController = dropdownController ?? TextEditingController() {
    _textEditingController.text = _todo.text;
  }

  late final _logger = Logger('TodoNotifier');

  Task _todo;

  final TextEditingController _textEditingController;
  final TextEditingController _dropdownController;

  Task get todo => _todo;

  String get id => todo.id;

  TextEditingController get textEditingController => _textEditingController;

  TextEditingController get dropdownController => _dropdownController;

  void onChangeDeadline(DateTime? newDeadline) {
    _logger.fine('new deadline $newDeadline');
    _todo = todo.copyWith(
      forceNullDeadline: (newDeadline == null),
      deadline: newDeadline,
    );
    _logger.fine('on change deadline to ${todo.deadline}');
    notifyListeners();
  }

  void onChangePriority(Importance? newPriority) {
    if (newPriority != null) {
      _todo = todo.copyWith(priority: newPriority);
      notifyListeners();
    }
  }

  void onChangeText(String value) {
    // textEditingController.text = value;
    // TODO(TrueFalseMary): подумать как исправить это место
    _todo = todo.copyWith(description: value);
    notifyListeners();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
