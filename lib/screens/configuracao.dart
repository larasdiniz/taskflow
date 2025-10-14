import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
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
  bool lembretesAtivos = false;
  bool notificacaoPrioridades = false;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context); // ← Acesso ao ThemeModel
    
    return Scaffold(
      backgroundColor: themeModel.currentTheme.scaffoldBackgroundColor, // ← Cor dinâmica

      // AppBar
      appBar: AppBar(
        backgroundColor: themeModel.currentTheme.appBarTheme.backgroundColor, // ← Cor dinâmica
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Configurações',
          style: themeModel.currentTheme.appBarTheme.titleTextStyle, // ← Estilo dinâmico
        ),
        iconTheme: themeModel.currentTheme.appBarTheme.iconTheme, // ← Ícone dinâmico
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF55525B), // ← Cor dinâmica
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
                  color: themeModel.isDarkMode ? const Color(0xFF2D2D2D) : const Color(0xFFE0D9F0), // ← Cor dinâmica
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
                              children: [
                                Text(
                                  "Usuário",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "ursula@task.flow",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF757575), // ← Cor dinâmica
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
                            side: BorderSide(
                                color: themeModel.currentTheme.primaryColor, width: 1.5), // ← Cor dinâmica
                            foregroundColor: themeModel.currentTheme.primaryColor, // ← Cor dinâmica
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                          ),
                          child: Text(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Aparência",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                  ),
                ),
              ),
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tema",
                      style: TextStyle(
                        fontSize: 16,
                        color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      themeModel.isDarkMode ? "Escuro" : "Claro", // ← Agora usa o themeModel
                      style: TextStyle(
                        fontSize: 14,
                        color: themeModel.isDarkMode ? Colors.white70 : Colors.black54, // ← Cor dinâmica
                      ),
                    ),
                  ],
                ),
                trailing: Switch(
                  value: themeModel.isDarkMode, // ← Agora usa o themeModel
                  activeColor: Colors.white,
                  activeTrackColor: themeModel.currentTheme.primaryColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0D9F0),
                  trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    themeModel.setTheme(value); // ← AGORA ALTERA O TEMA GLOBAL!
                  },
                ),
              ),

              // Seção Notificação
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Notificação",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Lembretes",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  lembretesAtivos ? "Ativado" : "Desativado",
                  style: TextStyle(
                    fontSize: 14, 
                    color: themeModel.isDarkMode ? Colors.white70 : Colors.black54, // ← Cor dinâmica
                  ),
                ),
                trailing: Switch(
                  value: lembretesAtivos,
                  activeColor: Colors.white,
                  activeTrackColor: themeModel.currentTheme.primaryColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0D9F0),
                  trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      lembretesAtivos = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  "Notificação de Prioridades",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  notificacaoPrioridades ? "Ativado" : "Desativado",
                  style: TextStyle(
                    fontSize: 14, 
                    color: themeModel.isDarkMode ? Colors.white70 : Colors.black54, // ← Cor dinâmica
                  ),
                ),
                trailing: Switch(
                  value: notificacaoPrioridades,
                  activeColor: Colors.white,
                  activeTrackColor: themeModel.currentTheme.primaryColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0D9F0),
                  trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      notificacaoPrioridades = value;
                    });
                  },
                ),
              ),

              // Seção Sincronização
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Sincronização",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Firebase",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Supabase",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Seção Conta
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Conta",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Gerenciar conta",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color, // ← Cor dinâmica
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                title: Text(
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
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: themeModel.isDarkMode ? const Color(0xFF333333) : const Color(0xFF818181), // ← Cor dinâmica
              width: 0.5,
            ),
          ),
          color: themeModel.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white, // ← Cor dinâmica
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
              child: Image.asset("assets/icons/icon_tarefas_cinza.png", height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_categorias_cinza.png", height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_metas_cinza.png", height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EstatisticasPage()),
                );
              },
              child: Image.asset("assets/icons/icon_estatistica_cinza.png", height: 40),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/icon-config-roxo.png", 
                height: 40,
                color: themeModel.isDarkMode ? const Color(0xFFA069FF) : null, // ← Ícone dinâmico
              ),
            ),
          ],
        ),
      ),
    );
  }
}