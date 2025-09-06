import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Estatísticas',
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Card do gráfico
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
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
                        color: const Color(0xFFE0D9F0),
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
                                  color: isSelected ? Colors.white : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      color: isSelected ? const Color(0xFFA069FF) : const Color(0xFF413491),
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
                    const Text(
                      "Tarefas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF130F2B),
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
                        _barraGrafico(total, "Total", 1.0, const Color(0xFFA069FF)),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Linha cinza
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),

                    const SizedBox(height: 8),

                    // Valores abaixo da linha com cor igual à barra
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
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFA069FF))),
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
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Dicas de Produtividade",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF130F2B),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Cards de dicas
              Column(
                children: [
                  _cardDica("Foque em 3 tarefas principais por dia."),
                  const SizedBox(height: 12),
                  _cardDica("Use o método Pomodoro"),
                  const SizedBox(height: 12),
                  _cardDica("Ative as notificações"),
                ],
              ),
            ],
          ),
        ),
      ),
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
              onTap: () {},
              child: Image.asset("assets/icons/icon-estatistica-roxo.png", height: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConfiguracaoPage()),
                );
              },
              child: Image.asset("assets/icons/icon_config_cinza.png", height: 40),
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
  Widget _cardDica(String texto) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0D9F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF413491),
        ),
      ),
    );
  }
}
