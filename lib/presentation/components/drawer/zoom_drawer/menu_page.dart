import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:provider/provider.dart';

import '../../../../provider/theme.dart';
import '../../../../provider/theme_notifier.dart';
import '../../../blocs/authentication/auth_bloc.dart';
import '../../components.dart';
import 'menu_items.dart' as mi;

// ignore: must_be_immutable
class MenuPage extends StatefulWidget {
  MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  mi.MenuItem currentItem;
  final ValueChanged<mi.MenuItem> onSelectedItem;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    Widget buildMenuItem(mi.MenuItem item) {
      return ListTile(
        selected: widget.currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon, color: Colors.white),
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white),
        ),
        onLongPress: () => widget.onSelectedItem(item),
        onTap: () {
          widget.onSelectedItem(item);
          ZoomDrawer.of(context)!.close();
        },
      );
    }

    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return Consumer(
      builder: (context, ThemeNotifier themeNotifier, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: mq.size.height,
                ),
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(flex: 2),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ScalableImageWidget.fromSISource(
                          si: ScalableImageSource.fromSvg(
                            rootBundle,
                            themeNotifier.darkTheme
                                ? 'assets/svg/Asset 6.svg'
                                : 'assets/svg/Asset 7.svg',
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                      ...mi.MenuItems.group1.map(buildMenuItem).toList(),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                        endIndent: MediaQuery.of(context).size.width * 0.1,
                        indent: MediaQuery.of(context).size.width * 0.03,
                      ),
                      ...mi.MenuItems.group2.map(buildMenuItem).toList(),
                      const Spacer(flex: 5),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 25,
                        ),
                        child: MyElevatedButton(
                          press: () async {
                            BlocProvider.of<AuthBloc>(context)
                                .add(LogOutEvent());
                            Phoenix.rebirth(context);
                          },
                          text: 'log out',
                        ),
                      ),
                      const Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Dark Mode:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Consumer(
                            builder:
                                (context, ThemeNotifier themeNotifier, child) {
                              val = themeNotifier.darkTheme;
                              return Center(
                                child: Transform.scale(
                                  scale: 2,
                                  child: Switch(
                                    activeTrackColor:
                                        CustomTheme.c1.withAlpha(100),
                                    activeColor: CustomTheme.c1,
                                    inactiveTrackColor:
                                        CustomTheme.c2.withAlpha(100),
                                    inactiveThumbColor: CustomTheme.c2,
                                    onChanged: (bool value) {
                                      setState(() {
                                        themeNotifier.toggleTheme();
                                        val = value;
                                      });
                                    },
                                    value: val,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
