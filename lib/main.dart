import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/providers/cart_provider.dart';
import 'package:watchhub/providers/product_provider.dart';
import 'package:watchhub/providers/user_provider.dart';
import 'package:watchhub/screens/auth/login_screen.dart';

void main() {
  runApp(const WatchHubApp());
}

class WatchHubApp extends StatelessWidget {
  const WatchHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'WatchHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF0D47A1),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}


