import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEAF8), 
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/logo.png', 
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'TaskMaster',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B0082),
                        ),
                      ),
                    ],
                  ),

                  // Icons
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.dark_mode),
                        tooltip: 'Modo Noturno',
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                        tooltip: 'Notificações',
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundImage: AssetImage('assets/profile.jpg'), // substitua por sua imagem
                          radius: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.logout),
                        tooltip: 'Sair',
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 32),

              // Card da Taxa de Conclusão
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF7D56C2),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      offset: const Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Text(
                  'Taxa de Conclusão',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
