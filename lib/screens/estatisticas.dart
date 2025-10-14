import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:taskflow/screens/categorias.dart';
import 'package:taskflow/screens/configuracao.dart';
import 'package:taskflow/screens/metas.dart';
import 'package:taskflow/screens/tarefas.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  String selecionado = "Semana";

  final int concluidas = 1;
  final int pendentes = 4;
  final int total = 5;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    
    return Scaffold(
      backgroundColor: themeModel.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: themeModel.currentTheme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Estatísticas',
          style: themeModel.currentTheme.appBarTheme.titleTextStyle,
        ),
        iconTheme: themeModel.currentTheme.appBarTheme.iconTheme,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF55525B),
              size: 28,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Card do gráfico
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeModel.currentTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(themeModel.isDarkMode ? 0.1 : 0.15),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Barra horizontal dentro do card
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFE0D9F0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ["Semana", "Dia", "Mês"].map((item) {
                          bool isSelected = selecionado == item;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selecionado = item;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? (themeModel.isDarkMode ? Colors.white : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: isSelected 
                                          ? (themeModel.isDarkMode ? const Color(0xFF1B1B2C) : const Color(0xFFA069FF))
                                          : (themeModel.isDarkMode ? Colors.white70 : const Color(0xFF413491)),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Título gráfico
                    Text(
                      "Tarefas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Barras do gráfico
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _barraGrafico(concluidas, "Concluídas", 0.7, const Color(0xFF44DE7C)),
                        _barraGrafico(pendentes, "Pendentes", 0.2, const Color(0xFF818181)),
                        _barraGrafico(total, "Total", 1.0, themeModel.currentTheme.primaryColor),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Linha cinza
                    Container(
                      height: 1,
                      color: (themeModel.isDarkMode ? Colors.white30 : Colors.grey).withOpacity(0.5),
                    ),

                    const SizedBox(height: 8),

                    // Valores abaixo da linha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("$concluidas",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF44DE7C))),
                        Text("$pendentes",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF818181))),
                        Text("$total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeModel.currentTheme.primaryColor)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Linha com ícone e texto Dicas de Produtividade
              Row(
                children: [
                  Image.asset(
                    "assets/icons/icon-dicas-produtividade.png", 
                    height: 30,
                    width: 30,
                    color: themeModel.isDarkMode ? Colors.white70 : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Dicas de Produtividade",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Cards de dicas
              Column(
                children: [
                  _cardDica("Foque em 3 tarefas principais por dia.", themeModel),
                  const SizedBox(height: 12),
                  _cardDica("Use o método Pomodoro", themeModel),
                  const SizedBox(height: 12),
                  _cardDica("Ative as notificações", themeModel),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: themeModel.isDarkMode ? const Color(0xFF333333) : const Color(0xFF818181),
              width: 0.5,
            ),
          ),
          color: themeModel.isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
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
              child: Image.asset(
                "assets/icons/icon_tarefas_cinza.png", 
                height: 40,
                color: themeModel.isDarkMode ? Colors.white54 : null,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriasPage()),
                );
              },
              child: Image.asset(
                "assets/icons/icon_categorias_cinza.png", 
                height: 40,
                color: themeModel.isDarkMode ? Colors.white54 : null,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetasPage()),
                );
              },
              child: Image.asset(
                "assets/icons/icon_metas_cinza.png", 
                height: 40,
                color: themeModel.isDarkMode ? Colors.white54 : null,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/icons/icon-estatistica-roxo.png", 
                height: 40,
                color: themeModel.isDarkMode ? themeModel.currentTheme.primaryColor : null,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfiguracaoPage()),
                );
              },
              child: Image.asset(
                "assets/icons/icon_config_cinza.png", 
                height: 40,
                color: themeModel.isDarkMode ? Colors.white54 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para criar cada barra do gráfico
  Widget _barraGrafico(int valor, String titulo, double proporcao, Color cor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 120 * proporcao,
          width: 30,
          decoration: BoxDecoration(
            color: cor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cor,
          ),
        ),
      ],
    );
  }

  // Função auxiliar para criar os cards de dica
  Widget _cardDica(String texto, ThemeModel themeModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFE0D9F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF413491),
        ),
      ),
    );
  }
}