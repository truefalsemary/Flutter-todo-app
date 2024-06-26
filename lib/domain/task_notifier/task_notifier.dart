import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/data/task_entity.dart';
import 'package:logging/logging.dart';

class OneTaskNotifier extends ChangeNotifier {
  OneTaskNotifier({
    required int id,
    TaskEntity? todo,
    TextEditingController? textEditingController,
    TextEditingController? dropdownController,
  })  : _id = id,
        _todo = todo ?? TaskEntity.empty(id),
        _textEditingController =
            textEditingController ?? TextEditingController(),
        _dropdownController = dropdownController ?? TextEditingController() {
    _textEditingController.text = _todo.description;
  }

  late final _logger = Logger('TodoNotifier');

  TaskEntity _todo;
  final int _id;

  final TextEditingController _textEditingController;
  final TextEditingController _dropdownController;

  TaskEntity get todo => _todo;

  int get id => _id;

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

  void onChangePriority(Priority? newPriority) {
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
