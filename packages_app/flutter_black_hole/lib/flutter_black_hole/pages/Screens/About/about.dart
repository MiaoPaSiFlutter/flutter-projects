/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'package:flutter/material.dart';
import 'package:flutter_black_hole/flutter_black_hole.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n-output/app_localizations.dart';
import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';
import 'package:ocean_common_module/ocean_common_module.dart' hide copyToClipboard;

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? appVersion;

  @override
  void initState() {
    main();
    super.initState();
  }

  Future<void> main() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double separationHeight = MediaQuery.sizeOf(context).height * 0.035;

    return GradientContainer(
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.sizeOf(context).width / 2,
            top: MediaQuery.sizeOf(context).width / 5,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  Utils.assets('images/icon-white-trans.png'),
                ),
              ),
            ),
          ),
          const GradientContainer(
            child: null,
            opacity: true,
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.secondary,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context).about,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          width: 150,
                          child: Image(
                            image: AssetImage(
                                Utils.assets('images/ic_launcher.png')),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).appTitle,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('v$appVersion'),
                    ],
                  ),
                  SizedBox(
                    height: separationHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context).aboutLine1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                'https://github.com/Sangwan5688/BlackHole',
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width / 4,
                            child: Image(
                              image: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AssetImage(
                                      Utils.assets(
                                          'images/GitHub_Logo_White.png'),
                                    )
                                  : AssetImage(
                                      Utils.assets('images/GitHub_Logo.png')),
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).aboutLine2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: separationHeight,
                  ),
                  Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              'https://www.buymeacoffee.com/ankitsangwan',
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: Image(
                            image: AssetImage(
                                Utils.assets('images/black-button.png')),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).or,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                        ),
                        onPressed: () {
                          const String upiUrl =
                              'upi://pay?pa=ankit.sangwan.5688@oksbi&pn=BlackHole&mc=5732&aid=uGICAgIDn98OpSw&tr=BCR2DN6T37O6DB3Q';
                          launchUrl(
                            Uri.parse(upiUrl),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        onLongPress: () {
                          copyToClipboard(
                            context: context,
                            text: 'ankit.sangwan.5688@oksbi',
                            displayText: AppLocalizations.of(
                              context,
                            ).upiCopied,
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: Image(
                            image: AssetImage(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Utils.assets('images/gpay-white.png')
                                  : Utils.assets('images/gpay-white.png'),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).sponsor,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: separationHeight,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).madeBy,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
