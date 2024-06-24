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

  final ManyTasksState state;

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
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
              blurRadius: 10,
            )
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 44 - 28 * shrinkCoef,
                left: 60 - 44 * shrinkCoef,
                child: Text(
                  'Мои дела',
                  style: Theme.of(context).textTheme.headlineLarge,
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

  double _countCoeff(double shrinkOffset) {
    return math.min(shrinkOffset, maxExtent - minExtent) /
        (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(
      covariant _MainScreenSliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.state != state;
  }

  Widget _buildIconButton(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<ManyTasksBloc>()
          .add(ManyTasksFilter(!(state as ManyTasksSuccess).showCompleted)),
      child: Icon(
        (state as ManyTasksSuccess).showCompleted
            ? Icons.visibility_off
            : Icons.visibility,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildTasksCount(BuildContext context) {
    return Text(
      'Выполнено — ${(state as ManyTasksSuccess).todos.where((todo) => todo.isCompleted).length}',
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
