part of '../../screens/main_screen.dart';

class _MainScreenSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  _MainScreenSliverPersistentHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    required this.state,
    required this.topPadding,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent;

  final double _minExtent;
  final double _maxExtent;

  final double topPadding;

  final AllTasksState state;

  @override
  double get minExtent => _minExtent + topPadding;

  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final shrinkCoef = _countCoeff(shrinkOffset);
    return Align(
      alignment: Alignment.bottomCenter,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appColors.backPrimary,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: context.appColors.supportOverlay.withOpacity(0.2),
              blurRadius: 10,
            ),
            BoxShadow(
              offset: const Offset(0, 4),
              color: context.appColors.supportOverlay.withOpacity(0.12),
              blurRadius: 5,
            )
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 44 - 28 * shrinkCoef,
                left: 60 - 44 * shrinkCoef,
                child: const Text(
                  'Мои дела',
                  style: AppFonts.h1,
                ),
              ),
              if (shrinkOffset < maxExtent - minExtent)
                Positioned(
                    bottom: 16,
                    left: 60 - 44 * shrinkCoef,
                    child: _buildTasksCount(context)),
              Positioned(
                // top: 10,
                bottom: 14 + 8 * shrinkCoef,
                right: 24 - 8 * shrinkCoef,
                child: _buildIconButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(
      covariant _MainScreenSliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.state != state;
  }

  double _countCoeff(double shrinkOffset) {
    return math.min(shrinkOffset, maxExtent - minExtent) /
        (maxExtent - minExtent);
  }

  Widget _buildIconButton(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<TasksBloc>()
          .add(AllTasksFilter(!(state as TasksSuccess).showCompleted)),
      child: Icon(
        (state as TasksSuccess).showCompleted
            ? Icons.visibility_off
            : Icons.visibility,
        color: context.appColors.colorBlue,
      ),
    );
  }

  Widget _buildTasksCount(BuildContext context) {
    return Text(
      'Выполнено — ${(state as TasksSuccess).tasks.where((todo) => todo.isCompleted).length}',
      style: AppFonts.b2
          .copyWith(color: context.appColors.labelTertiary.withOpacity(0.3)),
    );
  }
}
