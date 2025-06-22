import 'package:flutter/material.dart';

void main() {
  runApp(const BeFitApp());
}

class BeFitApp extends StatelessWidget {
  const BeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with rounded background
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFAF7EEB),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'BE',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Krona One',
                        ),
                      ),
                      Text(
                        'FIT',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontFamily: 'Lacquer',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Sign up/in toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF33234C),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Create An Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'Itim',
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInputField(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      controller: fullNameController,
                    ),
                    const SizedBox(height: 15),
                    _buildInputField(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    _buildInputField(
                      icon: Icons.lock_outline,
                      label: 'Password',
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF33234C),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '────────  Or sign up with  ────────',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialButton('Google', Icons.g_mobiledata),
                _socialButton('facebook', Icons.facebook),
              ],
            ),

            const SizedBox(height: 40),

            // Footer curve
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFAF7EEB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: suffixIcon,
        labelText: '$label :',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: const Color(0xFFD9D9D9),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) =>
      value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  Widget _socialButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
