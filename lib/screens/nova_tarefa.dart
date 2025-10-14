import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:intl/intl.dart';

class NovaTarefaPage extends StatefulWidget {
  const NovaTarefaPage({super.key});

  @override
  State<NovaTarefaPage> createState() => _NovaTarefaPageState();
}

class _NovaTarefaPageState extends State<NovaTarefaPage> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  String prioridadeSelecionada = 'Média';
  String statusSelecionado = 'Em andamento';
  String categoriaSelecionada = 'Trabalho';
  DateTime? prazoSelecionado;

  final List<String> prioridades = ['Alta', 'Média', 'Baixa'];
  final List<String> status = ['Em andamento', 'Concluída', 'Pendente'];
  final List<String> categorias = ['Trabalho', 'Estudo', 'Pessoal'];

  Future<void> selecionarPrazo() async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (selecionado != null) {
      setState(() {
        prazoSelecionado = selecionado;
      });
    }
  }

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
          "Nova Tarefa",
          style: themeModel.currentTheme.appBarTheme.titleTextStyle,
        ),
        iconTheme: themeModel.currentTheme.appBarTheme.iconTheme,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF55525B),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard(
                themeModel: themeModel,
                title: "Tarefa",
                child: TextField(
                  controller: tituloController,
                  decoration: InputDecoration(
                    hintText: "Digite o título da tarefa",
                    hintStyle: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildCard(
                themeModel: themeModel,
                title: "Descrição",
                child: TextField(
                  controller: descricaoController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Adicione uma breve descrição",
                    hintStyle: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                themeModel: themeModel,
                title: "Prioridade",
                value: prioridadeSelecionada,
                items: prioridades,
                onChanged: (value) => setState(() => prioridadeSelecionada = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                themeModel: themeModel,
                title: "Status",
                value: statusSelecionado,
                items: status,
                onChanged: (value) => setState(() => statusSelecionado = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                themeModel: themeModel,
                title: "Categoria",
                value: categoriaSelecionada,
                items: categorias,
                onChanged: (value) => setState(() => categoriaSelecionada = value!),
              ),
              const SizedBox(height: 16),
              _buildCard(
                themeModel: themeModel,
                title: "Prazo",
                child: GestureDetector(
                  onTap: selecionarPrazo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prazoSelecionado != null
                            ? DateFormat('dd/MM/yyyy').format(prazoSelecionado!)
                            : "Selecione o prazo",
                        style: TextStyle(
                          fontSize: 16, 
                          color: themeModel.isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today, 
                        color: themeModel.currentTheme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
                      onPressed: () {
                        // Aqui você pode salvar a nova tarefa
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required ThemeModel themeModel,
    required String title, 
    required Widget child
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

  Widget _buildDropdownCard({
    required ThemeModel themeModel,
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return _buildCard(
      themeModel: themeModel,
      title: title,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFEEEBF5),
          style: TextStyle(
            color: themeModel.currentTheme.textTheme.bodyLarge?.color, 
            fontSize: 16
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}