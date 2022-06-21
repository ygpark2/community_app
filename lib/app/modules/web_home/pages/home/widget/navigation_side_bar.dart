import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:layout/layout.dart';
import 'package:commune_app/app/modules/web_home/models/menu_item.dart' as menuModel;
import './profile_avatar.dart';
import 'package:commune_app/app/shared/tool/constants.dart';


const _assetsPackage = 'flutter_gallery_assets';
const _iconAssetLocation = 'reply/icons';
const _folderIconAssetLocation = '$_iconAssetLocation/twotone_folder.png';


class NavigationSideBar extends StatelessWidget {

  final int selectedIndex;
  final Function(int) onIndexSelect;
  final bool extended;
  final List<menuModel.MenuItem> destinations;
  final Map<String, String> folders;

  const NavigationSideBar({
    Key? key,
    required this.selectedIndex,
    required this.onIndexSelect,
    required this.extended,
    required this.destinations,
    required this.folders,
  }) : super(key: key);

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    final double width = context.layout.value(xs: 50.0, sm: 120.0, md: 200.0, lg: 250.0, xl: 300.0);
    final _isExtended = ValueNotifier<bool>(extended);

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          padding: new EdgeInsets.only(top: 0.0),
          // color: Color(0xFF272727),
          color: Theme.of(context).navigationRailTheme.backgroundColor,
          // width: width, // value ? width : 100,
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: ValueListenableBuilder<bool>(
                    valueListenable: _isExtended,
                    builder: (context, value, child) {
                      return NavigationRail(
                        destinations: [
                          for (var destination in destinations)
                            NavigationRailDestination(
                              icon: Material(
                                key: ValueKey(
                                  'Reply-${destination.textLabel}',
                                ),
                                color: Colors.transparent,
                                child: ImageIcon(
                                  AssetImage(
                                    destination.icon!,
                                    package: _assetsPackage +
                                        "/" +
                                        _iconAssetLocation,
                                  ),
                                ),
                              ),
                              label: Text(destination.textLabel ?? "default"),
                            ),
                        ],
                        extended: value,
                        labelType: NavigationRailLabelType.none,
                        leading: _NavigationRailHeader(
                          extended: _isExtended,
                        ),
                        // trailing: _NavigationRailFolderSection(
                        //   folders: folders,
                        // ),
                        selectedIndex: selectedIndex,
                        onDestinationSelected: onIndexSelect,
                      );
                    }),
              ),
            ),
          ));
    });

    /*
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onIndexSelect,
      labelType: NavigationRailLabelType.selected,
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.favorite_border),
          selectedIcon: Icon(Icons.favorite),
          label: Text('First'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.bookmark_border),
          selectedIcon: Icon(Icons.book),
          label: Text('Second'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('Third'),
        ),
      ],
    );
     */
  }
}

class _NavigationRailHeader extends StatelessWidget {
  const _NavigationRailHeader({
    required this.extended,
  }) : assert(extended != null);

  final ValueNotifier<bool> extended;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final animation = NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          widthFactor: animation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    InkWell(
                      key: const ValueKey('ReplyLogo'),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: () {
                        extended.value = !extended.value;
                      },
                      child: Row(
                        children: [
                          Transform.rotate(
                            angle: animation.value * math.pi,
                            child: const Icon(
                              Icons.arrow_left,
                              color: ReplyColors.white50,
                              size: 16,
                            ),
                          ),
                          const _ReplyLogo(),
                          const SizedBox(width: 10),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            widthFactor: animation.value,
                            child: Opacity(
                              opacity: animation.value,
                              child: Text(
                                'REPLY',
                                style: textTheme.bodyText1!.copyWith(
                                  color: ReplyColors.white50,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 18 * animation.value),
                        ],
                      ),
                    ),
                    if (animation.value > 0)
                      Opacity(
                        opacity: animation.value,
                        child: Row(
                          children: const [
                            SizedBox(width: 18),
                            ProfileAvatar(
                              avatar: 'reply/avatars/avatar_2.jpg',
                              radius: 16,
                            ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.settings,
                              color: ReplyColors.white50,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                ),
                child: _ReplyFab(extended: extended.value),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _NavigationRailFolderSection extends StatelessWidget {

  const _NavigationRailFolderSection(
      {required this.folders}
  )
      : assert(folders != null);

  final Map<String, String> folders;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final navigationRailTheme = theme.navigationRailTheme;
    final animation = NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: animation.value > 0,
          child: Opacity(
            opacity: animation.value,
            child: Align(
              widthFactor: animation.value,
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                height: 485,
                width: 256,
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Divider(
                      color: ReplyColors.blue200,
                      thickness: 0.4,
                      indent: 14,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 16,
                      ),
                      child: Text(
                        'FOLDERS',
                        style: textTheme.caption!.copyWith(
                          color: navigationRailTheme
                              .unselectedLabelTextStyle!.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var folder in folders.keys)
                      InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(36),
                        ),
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                ImageIcon(
                                  AssetImage(
                                    folders[folder]!,
                                    package: _assetsPackage,
                                  ),
                                  color: navigationRailTheme
                                      .unselectedLabelTextStyle!.color,
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  folder,
                                  style: textTheme.bodyText1!.copyWith(
                                    color: navigationRailTheme
                                        .unselectedLabelTextStyle!.color,
                                  ),
                                ),
                                const SizedBox(height: 72),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReplyLogo extends StatelessWidget {
  const _ReplyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      AssetImage(
        'reply/reply_logo.png',
        package: _assetsPackage,
      ),
      size: 32,
      color: ReplyColors.white50,
    );
  }
}

class _ReplyFab extends StatefulWidget {
  const _ReplyFab({this.extended = false});

  final bool extended;

  @override
  _ReplyFabState createState() => _ReplyFabState();
}

class _ReplyFabState extends State<_ReplyFab>
    with SingleTickerProviderStateMixin {
  static final fabKey = UniqueKey();
  static const double _mobileFabDimension = 56;

  void onPressed() {
    print("==============");
    print("============== pressed ====================");

    Modular.to.navigate('/create');

    /*
    var onSearchPage = Provider.of<EmailStore>(
      context,
      listen: false,
    ).onSearchPage;
    // Navigator does not have an easy way to access the current
    // route when using a GlobalKey to keep track of NavigatorState.
    // We can use [Navigator.popUntil] in order to access the current
    // route, and check if it is a ComposePage. If it is not a
    // ComposePage and we are not on the SearchPage, then we can push
    // a ComposePage onto our navigator. We return true at the end
    // so nothing is popped.
    desktopMailNavKey.currentState.popUntil( (route) {
        var currentRoute = route.settings.name;
        if (currentRoute != ReplyApp.composeRoute && !onSearchPage) {
          desktopMailNavKey.currentState
              .restorablePushNamed(ReplyApp.composeRoute);
        }
        return true;
      },
    );
     */
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.layout.breakpoint > LayoutBreakpoint.sm; // isDisplayDesktop(context);
    final theme = Theme.of(context);
    const circleFabBorder = CircleBorder();
    final onMailView = true;

    final fabSwitcher = _FadeThroughTransitionSwitcher(
      fillColor: Colors.transparent,
      child: onMailView
          ? Icon(
            Icons.reply_all,
            key: fabKey,
            color: Colors.black,
          )
          : const Icon(
            Icons.create,
            color: Colors.black,
          ),
    );
    final tooltip = onMailView ? 'Reply' : 'Compose';

    if (isDesktop) {
      final animation = NavigationRail.extendedAnimation(context);
      return Container(
        height: 56,
        padding: EdgeInsets.symmetric(
          vertical: ui.lerpDouble(0, 6, animation.value)!,
        ),
        child: animation.value == 0
            ? FloatingActionButton(
          tooltip: tooltip,
          key: const ValueKey('ReplyFab'),
          onPressed: onPressed,
          child: fabSwitcher,
        )
            : Align(
          alignment: AlignmentDirectional.centerStart,
          child: FloatingActionButton.extended(
            key: const ValueKey('ReplyFab'),
            label: Row(
              children: [
                fabSwitcher,
                SizedBox(width: 16 * animation.value),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: animation.value,
                  child: Text(
                    tooltip.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(
                      fontSize: 16,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: onPressed,
          ),
        ),
      );
    } else {
      // TODO(shihaohong): State restoration of compose page on mobile is
      // blocked because OpenContainer does not support restorablePush.
      // See https://github.com/flutter/flutter/issues/69924.
      return OpenContainer(
        openBuilder: (context, closedContainer) {
          return new Container(); // const ComposePage();
        },
        openColor: theme.cardColor,
        closedShape: circleFabBorder,
        closedColor: theme.colorScheme.secondary,
        closedElevation: 6,
        closedBuilder: (context, openContainer) {
          return Tooltip(
            message: tooltip,
            child: InkWell(
              key: const ValueKey('ReplyFab'),
              customBorder: circleFabBorder,
              onTap: openContainer,
              child: SizedBox(
                height: _mobileFabDimension,
                width: _mobileFabDimension,
                child: Center(
                  child: fabSwitcher,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

class _FadeThroughTransitionSwitcher extends StatelessWidget {

  final Widget child;
  final Color fillColor;

  const _FadeThroughTransitionSwitcher({
    required this.fillColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          fillColor: fillColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: child,
    );
  }
}
