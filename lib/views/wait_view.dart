import 'package:flutter/material.dart';
import 'package:legion/views/home_view.dart';

class WaitView extends StatefulWidget {
  const WaitView({super.key});

  @override
  State<WaitView> createState() => _WaitViewState();
}

class _WaitViewState extends State<WaitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    )
  ),
        title: const Text('Pending'), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your account is not yet approved by the admin! Come back later'),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}