import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x59141414),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/cropCare_logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),
              const Text('Crop Care', style: TextStyle(fontSize: 40, color: Color(0xFF08A989), fontWeight: FontWeight.w600)),
              const SizedBox(height: 25),
              const Text('Welcome to Crop Care', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w500)),
              const SizedBox(height: 40),
              const Text(
                'Detect crop diseases early, follow easy care steps, and embrace the healing power of horticulture while watching your garden flourish!',
                style: TextStyle(fontSize: 20, color: Color(0xFFF3FCEB), fontWeight: FontWeight.w400, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}