import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groove/main.dart';
import 'package:groove/pages/auth/providers.dart';
import 'package:groove/pages/auth/signin.dart';
import 'package:groove/pages/home/home.dart';
import 'package:groove/pages/home/rooms.dart';
import 'package:groove/pages/splash/splash.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Outlet extends StatefulWidget {
  const Outlet({super.key});

  @override
  State<Outlet> createState() => _OutletState();
}

class _OutletState extends State<Outlet> {
  String? _userId;
  late StreamSubscription _ascs;

  @override
  void initState() {
    super.initState();
    _ascs = supabase.auth.onAuthStateChange.listen(
      (data) {
        setState(() {
          _userId = data.session?.user.id;
        });
        print(data.session?.user.id);
        print('auth changed!!!!!!!');
      },
    );
  }

  @override
  void dispose() {
    _ascs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    if (_userId == null) {
      return AuthNavigator();
    } else {
      return HomeNavigator();
    }
  }
}

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => Splash());

          case '/authProvider':
            return MaterialPageRoute(builder: (_) => const Providers());

          case '/signin':
            return MaterialPageRoute(builder: (_) => const SignIn());

          default:
            return MaterialPageRoute(
              builder: (_) => Container(
                child: const Text(
                  'Unknown route',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
        }
      },
    );
  }
}

class RoomArguments {
  final IO.Socket socket;
  final String roomID;

  RoomArguments(this.socket, this.roomID);
}

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => Home());

          case '/room':
            final args = settings.arguments as RoomArguments;
            return MaterialPageRoute(
                builder: (_) => Room(
                      socket: args.socket,
                      roomID: args.roomID,
                    ));

          default:
            return MaterialPageRoute(
              builder: (_) => Container(
                child: const Text(
                  'Unknown route',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
        }
      },
    );
  }
}
