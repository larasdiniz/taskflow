import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:taskflow/screens/categorias.dart';
import 'package:taskflow/screens/configuracao.dart';
import 'package:taskflow/screens/estatisticas.dart';
import 'package:taskflow/screens/tarefas.dart';
import 'package:taskflow/screens/editar_meta.dart'; // Importe a nova tela

class MetasPage extends StatefulWidget {
  const MetasPage({super.key});

  @override
  State<MetasPage> createState() => _MetasPageState();
}

class _MetasPageState extends State<MetasPage> {
  double progressoMetaSemanal = 0.76;
  int metaAtual = 19;
  int metaDesejada = 25;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    
    return Scaffold(
      backgroundColor: themeModel.currentTheme.scaffoldBackgroundColor,

      // AppBar
      appBar: AppBar(
        backgroundColor: themeModel.currentTheme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Metas',
          style: themeModel.currentTheme.appBarTheme.titleTextStyle,
        ),
        iconTheme: themeModel.currentTheme.appBarTheme.iconTheme,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF55525B),
              size: 28,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Minhas Metas",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Seu desempenho esta semana",
                style: TextStyle(
                  fontSize: 14,
                  color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 20),

              // Card Meta Semanal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/icon-selo-meta-semanal.png", 
                              height: 24,
                              width: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Meta Semanal",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "$metaAtual/$metaDesejada",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: themeModel.currentTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Barra de progresso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressoMetaSemanal,
                        minHeight: 10,
                        backgroundColor: themeModel.isDarkMode ? const Color(0xFF333333) : const Color(0xFFE0E0E0),
                        color: themeModel.currentTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "${(progressoMetaSemanal * 100).toStringAsFixed(0)}% concluído | ${metaDesejada - metaAtual} para a meta",
                      style: TextStyle(
                        fontSize: 12,
                        color: themeModel.isDarkMode ? Colors.white54 : const Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ),

              // Linha divisória
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 1,
                  color: (themeModel.isDarkMode ? Colors.white30 : const Color(0xFF818181)).withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 12),

              // Cards de estatísticas
              _buildStatCard(
                themeModel,
                "assets/icons/icon-sequencia.png",
                "Sequência",
                "Mantenha o ritmo!",
                "7 dias",
                const Color(0xFFFF6969),
              ),
              const SizedBox(height: 20),

              _buildStatCard(
                themeModel,
                "assets/icons/icon-semana.png",
                "Esta Semana",
                "sua eficiência",
                "76%",
                themeModel.currentTheme.primaryColor,
              ),
              const SizedBox(height: 20),

              _buildStatCard(
                themeModel,
                "assets/icons/icon-tarefas-criadas.png",
                "Tarefas Criadas",
                "esta semana",
                "25",
                themeModel.currentTheme.primaryColor,
              ),
              const SizedBox(height: 20),

              _buildStatCard(
                themeModel,
                "assets/icons/icon-tarefas-concluidas.png",
                "Tarefas concluídas",
                "hoje",
                "1",
                const Color(0xFF32BE65),
              ),
              const SizedBox(height: 20),

              _buildStatCard(
                themeModel,
                "assets/icons/icon-tarefas-ativas.png",
                "Tarefas ativas",
                "hoje",
                "3",
                themeModel.isDarkMode ? Colors.white54 : const Color(0xFF757575),
              ),

              const SizedBox(height: 20),

              // Botão Editar Meta
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () async {
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarMetaPage(
                                metaAtual: metaAtual,
                                metaDesejada: metaDesejada,
                              ),
                            ),
                          );
                          
                          if (resultado != null) {
                            // Atualizar os dados com o resultado
                            setState(() {
                              metaDesejada = resultado['metaSemanal'] ?? metaDesejada;
                              // Recalcular o progresso (mantendo o mesmo número de tarefas concluídas)
                              progressoMetaSemanal = metaAtual / metaDesejada;
                            });
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Meta atualizada com sucesso!'),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: themeModel.currentTheme.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.edit, color: Colors.white, size: 24),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Editar Meta",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              onTap: () {},
              child: Image.asset(
                "assets/icons/icon_metas_roxo.png", 
                height: 40,
                color: themeModel.isDarkMode ? themeModel.currentTheme.primaryColor : null,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EstatisticasPage()),
                );
              },
              child: Image.asset(
                "assets/icons/icon_estatistica_cinza.png", 
                height: 40,
                color: themeModel.isDarkMode ? Colors.white54 : null,
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

  Widget _buildStatCard(ThemeModel themeModel, String iconPath, String title, String subtitle, String value, Color valueColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFEEEAF5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                      fontSize: 18, 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: themeModel.currentTheme.textTheme.bodyMedium?.color,
                      fontSize: 16, 
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 22, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}