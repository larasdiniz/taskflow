import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';

class EditarMetaPage extends StatefulWidget {
  final int metaAtual;
  final int metaDesejada;

  const EditarMetaPage({
    super.key,
    required this.metaAtual,
    required this.metaDesejada,
  });

  @override
  State<EditarMetaPage> createState() => _EditarMetaPageState();
}

class _EditarMetaPageState extends State<EditarMetaPage> {
  late TextEditingController metaSemanalController;
  late TextEditingController metaDiariaController;
  
  String periodoSelecionado = 'Semanal';
  final List<String> periodos = ['Diária', 'Semanal', 'Mensal'];

  @override
  void initState() {
    super.initState();
    metaSemanalController = TextEditingController(text: widget.metaDesejada.toString());
    metaDiariaController = TextEditingController(text: (widget.metaDesejada ~/ 5).toString());
  }

  @override
  void dispose() {
    metaSemanalController.dispose();
    metaDiariaController.dispose();
    super.dispose();
  }

  void _salvarMeta() {
    // Validar os campos
    if (metaSemanalController.text.isEmpty || metaDiariaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha todas as metas'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final novaMetaSemanal = int.tryParse(metaSemanalController.text) ?? 0;
    final novaMetaDiaria = int.tryParse(metaDiariaController.text) ?? 0;

    if (novaMetaSemanal <= 0 || novaMetaDiaria <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('As metas devem ser maiores que zero'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Retornar os dados atualizados
    final dadosAtualizados = {
      'metaSemanal': novaMetaSemanal,
      'metaDiaria': novaMetaDiaria,
      'periodo': periodoSelecionado,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Meta atualizada com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

    Navigator.pop(context, dadosAtualizados);
  }

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
          'Editar Meta',
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card de Resumo Atual
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.track_changes,
                            color: themeModel.currentTheme.primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Resumo Atual",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Progresso Atual",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF757575),
                                ),
                              ),
                              Text(
                                "${widget.metaAtual}/${widget.metaDesejada}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeModel.currentTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Taxa de Conclusão",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF757575),
                                ),
                              ),
                              Text(
                                "${((widget.metaAtual / widget.metaDesejada) * 100).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF32BE65),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Card de Período
                _buildCard(
                  themeModel: themeModel,
                  title: "Período da Meta",
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: periodoSelecionado,
                      isExpanded: true,
                      dropdownColor: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFEEEBF5),
                      style: TextStyle(
                        color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                      items: periodos
                          .map((periodo) => DropdownMenuItem(
                                value: periodo,
                                child: Text(periodo),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          periodoSelecionado = value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Card de Meta Semanal
                _buildCard(
                  themeModel: themeModel,
                  title: "Meta Semanal",
                  subtitle: "Número de tarefas por semana",
                  child: TextField(
                    controller: metaSemanalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Ex: 25",
                      hintStyle: TextStyle(
                        color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.assignment,
                        color: themeModel.currentTheme.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      // Atualizar meta diária automaticamente (aproximadamente)
                      if (value.isNotEmpty) {
                        final semanal = int.tryParse(value) ?? 0;
                        final diaria = (semanal / 5).ceil();
                        metaDiariaController.text = diaria.toString();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Card de Meta Diária
                _buildCard(
                  themeModel: themeModel,
                  title: "Meta Diária",
                  subtitle: "Número de tarefas por dia",
                  child: TextField(
                    controller: metaDiariaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Ex: 5",
                      hintStyle: TextStyle(
                        color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.today,
                        color: themeModel.currentTheme.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                      fontSize: 16,
                    ),
                    onChanged: (value) {
                      // Atualizar meta semanal automaticamente
                      if (value.isNotEmpty) {
                        final diaria = int.tryParse(value) ?? 0;
                        final semanal = diaria * 5;
                        metaSemanalController.text = semanal.toString();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Dicas
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFE0D9F0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: themeModel.isDarkMode ? Colors.amber : const Color(0xFF413491),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Meta realista: Comece com números alcançáveis e aumente gradualmente.",
                          style: TextStyle(
                            fontSize: 14,
                            color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF413491),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Botões de ação
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeModel.isDarkMode ? const Color(0xFF333333) : const Color(0xFFDFE1E4),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF818181),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeModel.currentTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: _salvarMeta,
                        child: const Text(
                          "Salvar Meta",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required ThemeModel themeModel,
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF413491),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: themeModel.isDarkMode ? Colors.white54 : const Color(0xFF757575),
            ),
          ),
        ],
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFEEEBF5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ],
    );
  }
}