import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9), 
      body: SafeArea(
        top: true,    
        bottom: true, 
        left: true,  
        right: true, 
        maintainBottomViewPadding: true, 
        minimum: EdgeInsets.zero, 
        child: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xFFF6F6F9),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Tarefas',
                style: TextStyle(
                  color: Color(0xFFA069FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Color(0xFFA069FF),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  'assets/icons/icon_ajuda.png',
                  height: 24,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Bem-vindo à página de tarefas!',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









/*import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tarefas',
          style: TextStyle(
            color: Color(0xFFA069FF),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFA069FF),
        ),
        leading: Padding(  
          padding: const EdgeInsets.only(left: 16),  
          child: Image.asset(
            'assets/icons/icon_ajuda.png',
            height: 24,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à página de tarefas!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}*/