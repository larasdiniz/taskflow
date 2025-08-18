import 'package:flutter/material.dart';
import 'package:taskflow/screens/login.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  String prioridadeSelecionada = 'Alta';
  final List<String> prioridades = ['Alta', 'Média', 'Baixa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar customizado
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/icon_ajuda.png',
                    height: 24,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Color(0xFF000000),
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
              ],
            ),

            // Perfil
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/perfil.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Olá, Ursula!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF130F2B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Vamos organizar suas tarefas",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Cards principais
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  // Card Taxa de conclusão
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA069FF), Color(0xFFB991FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Taxa de conclusão",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "20%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Card Em andamento
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFC8B6F3), Color(0xFFE0D9F0)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Em andamento",
                            style: TextStyle(
                              color: Color(0xFF413491),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "3",
                                    style: TextStyle(
                                      color: Color(0xFF413491),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "tarefas",
                                    style: TextStyle(
                                      color: Color(0xFF413491),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.directions_run,
                                color: Color(0xFF413491),
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Filtros abaixo dos cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  // Card Prioridade
                  Expanded(
                    child: Container(
                      height: 50, 
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA069FF), Color(0xFFB991FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Prioridade",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: prioridadeSelecionada,
                                dropdownColor: const Color(0xFFA069FF),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                items: prioridades
                                    .map((p) => DropdownMenuItem(
                                          value: p,
                                          child: Text(p),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    prioridadeSelecionada = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Card Ordenar por
                  Expanded(
                    child: Container(
                      height: 50, 
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0D9F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Ordenar por",
                            style: TextStyle(
                              color: Color(0xFF413491),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF413491),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),

            // Espaço para lista de tarefas depois
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
