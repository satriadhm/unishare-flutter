import 'package:flutter/material.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/profil/controller/user_service.dart';

class ProfilPage extends StatefulWidget {
  final ProfileService? profileService;

  ProfilPage({this.profileService});
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late final ProfileService profileService;

  Map<String, dynamic>? userData;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileService = widget.profileService ?? ProfileService();
    _getUserData();
  }

  void _getUserData() async {
    Map<String, dynamic>? data = await profileService.getUserData();
    setState(() {
      userData = data;
      namaController.text = userData?['nama'] ?? '';
      emailController.text = userData?['email'] ?? '';
      passwordController.text = userData?['password'] ?? '';
      alamatController.text = userData?['alamat'] ?? '';
    });
  }

  Future<void> _updateUserData() async {
    try {
      Map<String, dynamic> userData = {
        'nama': namaController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'alamat': alamatController.text,
      };
      await profileService.updateUserData(userData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating user data: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'assets/img/dazai.jpg'), // Provide your profile picture asset path
              child: Icon(
                Icons.account_circle,
                size: 150,
              ),
            ),
            const SizedBox(
                height: 20), // Spacer between profile picture and text fields
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            const SizedBox(height: 20), // Spacer between text fields and button
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Update'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}