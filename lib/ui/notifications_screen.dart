import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/util/query_handler.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool notifSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
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
                  const Text(
                    "Notification",
                    style: TextStyle(
                      fontFamily: "MSB",
                      fontSize: 16,
                      color: TextColors.whiteText,
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
                height: 163,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.2,
                    color: const Color(0xff252836),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Messages Notifications",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize: 12,
                          color: TextColors.greyText,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Show Notifications",
                            style: TextStyle(
                              fontFamily: "MM",
                              fontSize:
                                  (MediaQueryHandler.screenWidth(context) < 350)
                                      ? 12
                                      : 16,
                              color: TextColors.whiteText,
                            ),
                          ),
                          Transform.scale(
                            scale:
                                (MediaQueryHandler.screenWidth(context) < 350)
                                    ? 0.6
                                    : 0.8,
                            child: CupertinoSwitch(
                              activeColor: PrimaryColors.blueAccentColor,
                              value: notifSwitch,
                              onChanged: (value) {
                                setState(() {
                                  notifSwitch = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1.3,
                        color: Color(0xff252836),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Exceptions",
                        style: TextStyle(
                          fontFamily: "MM",
                          fontSize:
                              (MediaQueryHandler.screenWidth(context) < 350)
                                  ? 12
                                  : 16,
                          color: TextColors.whiteText,
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
    );
  }
}
