part of '../../screens/task_screen.dart';

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 2,
            ),
          ]),
      child: TextField(
        minLines: 5,
        onChanged: context.read<OneTaskNotifier>().onChangeText,
        controller: context.read<OneTaskNotifier>().textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
              // Radius.zero,
            ),
          ),
          hintText: 'Что надо сделать...',
          constraints: const BoxConstraints(
            minHeight: 104,
          ),
          fillColor: Theme.of(context).colorScheme.onSecondary,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
