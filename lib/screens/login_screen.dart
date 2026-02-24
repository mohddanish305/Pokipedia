import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main_nav_screen.dart';

const pokeGradient = LinearGradient(
  colors: [Color(0xFF48D0B0), Color(0xFF2EC4A6)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: pokeGradient),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),

              Lottie.asset(
                "assets/lottie/pokemon.json",
                height: 240,
              ),

              const SizedBox(height: 10),

              const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon:
                    const Icon(Icons.email, color: Colors.white),
                    hintText: "Email",
                    hintStyle:
                    const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon:
                    const Icon(Icons.lock, color: Colors.white),
                    hintText: "Password",
                    hintStyle:
                    const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MainNavScreen(trainerName: controller.text),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}