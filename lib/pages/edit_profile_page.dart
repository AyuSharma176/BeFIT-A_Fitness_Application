import 'package:befit/services/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhotoUrl;

  const EditProfilePage({
    Key? key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhotoUrl,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _photoUrlController;
  bool isSaving = false;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _photoUrlController = TextEditingController(text: widget.currentPhotoUrl);
    super.initState();
  }

  Future<void> saveChanges() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => isSaving = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'photoUrl': _photoUrlController.text,
      });

      // Optionally update FirebaseAuth user info
      await user.updateDisplayName(_nameController.text);
      await user.updateEmail(_emailController.text);
      await user.updatePhotoURL(_photoUrlController.text);

      Navigator.pop(context, true); // Indicate changes were made
    } catch (e) {
      print("Error saving profile changes: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save changes. Please try again.")),
      );
    } finally {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: AppTheme.titleTextColor),),
        backgroundColor: AppTheme.appBarBg,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.appBarBg,
              AppTheme.backgroundColor,
              AppTheme.appBarBg,
            ],
            stops: [0, 0.6, 1],
          ),
        ),
        child:
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTextField("Name", _nameController),
                const SizedBox(height: 16),
                _buildTextField("Email", _emailController),
                const SizedBox(height: 16),
                _buildTextField("Photo URL", _photoUrlController),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isSaving ? null : saveChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: isSaving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Save Changes"),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(color: AppTheme.titleTextColor),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.titleTextColor),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
