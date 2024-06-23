import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/data/todo_entity.dart';

class TodoNotifier extends ChangeNotifier {
  TodoNotifier({
    required int id,
    Todo? todo,
    TextEditingController? textEditingController,
    TextEditingController? dropdownController,

  })  : _id = id,
        _todo = todo ?? Todo.empty(id),
        _textEditingController =
            textEditingController ?? TextEditingController(),
        _dropdownController = dropdownController ?? TextEditingController();

  // _priority = todo?.priority ?? Priority.no,
  // _deadline = todo?.deadline,


  Todo _todo;
  final int _id;

  final TextEditingController _textEditingController;
  final TextEditingController _dropdownController;

  Todo get todo => _todo;
  // DateTime? _deadline;
  // Priority _priority = Priority.no;

  int get id => _id;

  // DateTime? get deadline => _deadline;
  //
  // Priority get priority => _priority;

  TextEditingController get textEditingController => _textEditingController;
  TextEditingController get dropdownController => _dropdownController;


  void onChangeDeadline(DateTime? newDeadline) {
    // _deadline = newDeadline;
    _todo = todo.copyWith(deadline: newDeadline);
    notifyListeners();
  }

  void onChangePrority(Priority? newPriority) {
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
