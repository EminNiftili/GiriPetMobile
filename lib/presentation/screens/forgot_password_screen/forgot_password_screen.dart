import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();

  bool isCodeSent = false;
  String lastEmail = '';
  int remainingSeconds = 0;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      if (isCodeSent && emailController.text != lastEmail) {
        setState(() {
          isCodeSent = false;
          countdownTimer?.cancel();
          remainingSeconds = 0;
        });
      }
    });
  }

  void sendCode() {
    setState(() {
      isCodeSent = true;
      remainingSeconds = 60;
      lastEmail = emailController.text;
    });

    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  void resendCode() {
    countdownTimer?.cancel();
    setState(() {
      remainingSeconds = 60;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kod tekrar gönderildi!')),
    );
  }

  void verifyCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kod doğrulandı! (mock)')),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Giriş Yap Dönüş Butonu
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.teal),
                  label: const Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Şifrəni unutdun?',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
              ),
              const SizedBox(height: 8),
              const Text(
                'E-poçt adresini daxil et və sənə doğrulama kodu göndərək.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              if (isCodeSent)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yenidən göndərmək üçün: ${remainingSeconds}s',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: '6 Rəqəmli Kod',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: remainingSeconds == 0 ? resendCode : null,
                      child: Text(
                        'Yenidən Kod Gönder',
                        style: TextStyle(
                          color:
                              remainingSeconds == 0 ? Colors.teal : Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isCodeSent ? verifyCode : sendCode,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isCodeSent ? 'Doğrula' : 'Kod Gönder',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
