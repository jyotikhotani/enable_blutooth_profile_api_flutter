import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

ValueNotifier<bool> isConnected = ValueNotifier(true);

class _NoConnectivityBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Platform.isIOS ? 50 : 40,
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: Platform.isIOS ? false : true,
          maintainBottomViewPadding: Platform.isIOS ? true : false,
          child: Container(
            padding:const EdgeInsets.all(8),
            width: double.infinity,
            color: Colors.red,
            height: 50,
            child: const Text(
              'No Internet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class ConnectivityWidget extends StatefulWidget {
  /// Builder method for the child widget.
  ///
  /// Provides a [iSOnline] parameter and a [context] to build the child
  final Widget Function(BuildContext, bool) builder;

  final VoidCallback? onlineCallback;

  final VoidCallback? offlineCallback;

  const ConnectivityWidget({
    Key? key,
    required this.builder,
    this.onlineCallback,
    this.offlineCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConnectivityWidgetState();
}

class ConnectivityWidgetState extends State<ConnectivityWidget>
    with SingleTickerProviderStateMixin {
  bool isOffline = false;

  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snap) {
        final value = snap.data == ConnectivityResult.none;
        if (isOffline != value) {
          isConnected.value = !value;
          //isConnected.notifyListeners();
          isOffline = value;
          if (isOffline) {
            animationController.forward();
            widget.offlineCallback?.call();
          } else {
            animationController.reverse();
            widget.onlineCallback?.call();
          }
        }

        return Stack(
          children: <Widget>[
            widget.builder(context, !isOffline),
            if (isOffline)
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: animationController.drive(
                    Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).chain(
                      CurveTween(curve: Curves.fastOutSlowIn),
                    ),
                  ),
                  child: _NoConnectivityBanner(),
                ),
              ),
          ],
        );
      },
    );
  }
}
