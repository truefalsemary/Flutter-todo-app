part of '../../screens/task_screen.dart';

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.backSecondary,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            color: context.appColors.supportOverlay.withOpacity(0.06),
            blurRadius: 2,
          ),
          BoxShadow(
            offset: const Offset(0, 2),
            color: context.appColors.supportOverlay.withOpacity(0.12),
            blurRadius: 2,
          )
        ],
      ),
      child: TextField(
        minLines: 5,
        onChanged: context.read<OneTaskNotifier>().onChangeText,
        controller: context.read<OneTaskNotifier>().textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          hintText: 'Что надо сделать...',
          hintStyle: AppFonts.b2.copyWith(
            color: context.appColors.labelTertiary,
          ),
          constraints: const BoxConstraints(minHeight: 104),
          // fillColor: context.appColors.backSecondary,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}
