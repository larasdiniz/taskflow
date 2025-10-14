import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:intl/intl.dart';

class DetalhesTarefaPage extends StatefulWidget {
  final String titulo;
  final String descricao;
  final String prioridade;
  final String status;
  final String categoria;
  final DateTime prazo;

  const DetalhesTarefaPage({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.status,
    required this.categoria,
    required this.prazo,
  });

  @override
  State<DetalhesTarefaPage> createState() => _DetalhesTarefaPageState();
}

class _DetalhesTarefaPageState extends State<DetalhesTarefaPage> {
  late TextEditingController tituloController;
  late TextEditingController descricaoController;
  late String prioridadeSelecionada;
  late String statusSelecionado;
  late String categoriaSelecionada;
  late DateTime prazoSelecionado;

  final List<String> prioridades = ['Alta', 'Média', 'Baixa'];
  final List<String> statusList = ['Em andamento', 'Concluída', 'Pendente'];
  final List<String> categorias = ['Trabalho', 'Estudo', 'Pessoal'];

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.titulo);
    descricaoController = TextEditingController(text: widget.descricao);
    
    prioridadeSelecionada = prioridades.contains(widget.prioridade) 
        ? widget.prioridade 
        : prioridades.first;
    
    statusSelecionado = statusList.contains(widget.status)
        ? widget.status
        : statusList.first;
    
    categoriaSelecionada = categorias.contains(widget.categoria)
        ? widget.categoria
        : categorias.first;
    
    prazoSelecionado = widget.prazo;
  }

  @override
  void dispose() {
    tituloController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  Future<void> selecionarPrazo() async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: prazoSelecionado,
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
          "Detalhes da Tarefa",
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
                    border: InputBorder.none,
                    hintText: "Digite o título da tarefa",
                    hintStyle: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
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
                    border: InputBorder.none,
                    hintText: "Digite a descrição da tarefa",
                    hintStyle: TextStyle(
                      color: themeModel.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
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
                onChanged: (value) {
                  if (value != null) {
                    setState(() => prioridadeSelecionada = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                themeModel: themeModel,
                title: "Status",
                value: statusSelecionado,
                items: statusList,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => statusSelecionado = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                themeModel: themeModel,
                title: "Categoria",
                value: categoriaSelecionada,
                items: categorias,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => categoriaSelecionada = value);
                  }
                },
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
                        DateFormat('dd/MM/yyyy').format(prazoSelecionado),
                        style: TextStyle(
                          fontSize: 16, 
                          color: themeModel.isDarkMode ? Colors.white70 : Colors.black87,
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
                        _excluirTarefa(context, themeModel);
                      },
                      child: Text(
                        "Excluir",
                        style: TextStyle(
                          color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF818181), 
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                        _salvarEdicoes(context);
                      },
                      child: const Text(
                        "Salvar",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
    final String safeValue = items.contains(value) ? value : items.first;
    
    return _buildCard(
      themeModel: themeModel,
      title: title,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          dropdownColor: themeModel.isDarkMode ? const Color(0xFF2A2A3D) : const Color(0xFFEEEBF5),
          style: TextStyle(
            color: themeModel.currentTheme.textTheme.bodyLarge?.color, 
            fontSize: 16,
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
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

  void _salvarEdicoes(BuildContext context) {
    final updatedData = {
      'titulo': tituloController.text,
      'descricao': descricaoController.text,
      'prioridade': prioridadeSelecionada,
      'status': statusSelecionado,
      'categoria': categoriaSelecionada,
      'prazo': prazoSelecionado,
    };
    
    print('Dados atualizados: $updatedData');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Tarefa atualizada com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    
    Navigator.pop(context, updatedData);
  }

  void _excluirTarefa(BuildContext context, ThemeModel themeModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeModel.currentTheme.colorScheme.surface,
          title: Text(
            "Excluir Tarefa",
            style: TextStyle(
              color: themeModel.currentTheme.textTheme.bodyLarge?.color,
            ),
          ),
          content: Text(
            "Tem certeza que deseja excluir esta tarefa?",
            style: TextStyle(
              color: themeModel.currentTheme.textTheme.bodyMedium?.color,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancelar",
                style: TextStyle(
                  color: themeModel.isDarkMode ? Colors.white70 : Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, 'deleted');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tarefa excluída com sucesso!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text(
                "Excluir",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}