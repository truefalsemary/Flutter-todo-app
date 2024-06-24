part of '../../screens/main_screen.dart';

class _MainScreenSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  _MainScreenSliverPersistentHeaderDelegate({
    required double minExtent,
    required double maxExtent,
    required this.state,
  })  : _minExtent = minExtent,
        _maxExtent = maxExtent;

  final double _minExtent;
  final double _maxExtent;

  final ManyTasksState state;

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (overlapsContent || shrinkOffset > 0.5) {
      return SizedBox(
        height: 88,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onPrimary,
                blurRadius: 10,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 16, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Мои дела',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                if (state is ManyTasksSuccess)
                  IconButton(
                    onPressed: () => context.read<ManyTasksBloc>().add(
                        ManyTasksFilter(
                            !(state as ManyTasksSuccess).showCompleted)),
                    icon: Icon(
                      (state as ManyTasksSuccess).showCompleted
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 58,
        left: 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мои дела',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state is ManyTasksSuccess)
                  Text(
                    'Выполнено — ${(state as ManyTasksSuccess).todos.where((todo) => todo.isCompleted).length}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                IconButton(
                  onPressed: () => context.read<ManyTasksBloc>().add(
                      ManyTasksFilter(
                          !(state as ManyTasksSuccess).showCompleted)),
                  icon: Icon(
                    (state as ManyTasksSuccess).showCompleted
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
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
}
