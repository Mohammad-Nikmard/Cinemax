import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/constants/string_constants.dart';
import 'package:cinemax/util/app_manager.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late bool notifSwitch;

  @override
  void initState() {
    notifSwitch = AppManager.getNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const BackLabel(),
                    ),
                    Text(
                      AppLocalizations.of(context)!.notif,
                      style: TextStyle(
                        fontFamily: StringConstants.setBoldPersianFont(),
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 175,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.messageNotif,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize: 12,
                            color: TextColors.greyText,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (notifSwitch == true) {
                                notifSwitch = false;
                                AppManager.setNotifications(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: _NotifMessage(
                                      message: AppLocalizations.of(context)!
                                          .notifOFF,
                                    ),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    closeIconColor: Colors.transparent,
                                  ),
                                );
                              } else if (notifSwitch == false) {
                                notifSwitch = true;
                                AppManager.setNotifications(true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: _NotifMessage(
                                      message:
                                          AppLocalizations.of(context)!.notifOn,
                                    ),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    closeIconColor: Colors.transparent,
                                  ),
                                );
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.showNotif,
                                style: TextStyle(
                                  fontFamily:
                                      StringConstants.setMediumPersionFont(),
                                  fontSize:
                                      (MediaQueryHandler.screenWidth(context) <
                                              350)
                                          ? 12
                                          : 16,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              Transform.scale(
                                scale: (MediaQueryHandler.screenWidth(context) <
                                        350)
                                    ? 0.6
                                    : 0.8,
                                child: CupertinoSwitch(
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  value: notifSwitch,
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1.3,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.exceptions,
                          style: TextStyle(
                            fontFamily: StringConstants.setMediumPersionFont(),
                            fontSize:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 12
                                    : 16,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotifMessage extends StatelessWidget {
  const _NotifMessage({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: MediaQueryHandler.screenWidth(context),
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 12,
                fontFamily: StringConstants.setBoldPersianFont(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
