import 'package:flutter/material.dart';
import 'package:taskflow/screens/categorias.dart';
import 'package:taskflow/screens/estatisticas.dart';
import 'package:taskflow/screens/metas.dart';
import 'package:taskflow/screens/tarefas.dart';
import 'package:taskflow/screens/login.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  bool isDarkMode = false;
  bool lembretesAtivos = false;
  bool notificacaoPrioridades = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Configurações',
          style: TextStyle(
            color: Color(0xFFA069FF),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFA069FF)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF55525B),
              size: 28,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card do Usuário
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color: const Color(0xFFE0D9F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  AssetImage("assets/images/foto_perfil.png"),
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Usuário",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF121417),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "ursula@task.flow",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Botão Editar
                        OutlinedButton(
                          onPressed: () {
                            // ação do botão editar
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFFA069FF), width: 1.5),
                            foregroundColor: const Color(0xFFA069FF),
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                          ),
                          child: const Text(
                            "Editar",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Seção Aparência
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Aparência",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tema",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      isDarkMode ? "Escuro" : "Claro",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                trailing: Switch(
                  value: isDarkMode,
                  activeColor: Colors.white, // bolinha branca
                  activeTrackColor:
                      const Color(0xFFA069FF), // fundo roxo quando ativo
                  inactiveThumbColor: Colors.white, // bolinha branca
                  inactiveTrackColor: const Color(
                      0xFFE0D9F0), // fundo lilás claro quando desativado
                  trackOutlineColor: MaterialStateProperty.all(
                      Colors.transparent), // sem borda
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),

              // Seção Notificação
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Notificação",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Lembretes",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  lembretesAtivos ? "Ativado" : "Desativado",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                trailing: Switch(
                  value: lembretesAtivos,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFFA069FF),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0D9F0),
                  trackOutlineColor:
                      MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      lembretesAtivos = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  "Notificação de Prioridades",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  notificacaoPrioridades ? "Ativado" : "Desativado",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                trailing: Switch(
                  value: notificacaoPrioridades,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFFA069FF),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0D9F0),
                  trackOutlineColor:
                      MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      notificacaoPrioridades = value;
                    });
                  },
                ),
              ),

              // Seção Sincronização
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Sincronização",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  "Firebase",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  "Supabase",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Seção Conta
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Conta",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  "Gerenciar conta",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  "Sair",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Footer
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF818181),
              width: 0.5,
            ),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TarefasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_tarefas_cinza.png",
                  height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_categorias_cinza.png",
                  height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_metas_cinza.png",
                  height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EstatisticasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_estatistica_cinza.png",
                  height: 40),
            ),
            GestureDetector(
              onTap: () {},
              child:
                  Image.asset("assets/icons/icon-config-roxo.png", height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
