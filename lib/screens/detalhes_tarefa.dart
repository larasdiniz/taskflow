import 'package:flutter/material.dart';
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

  // Use Set para evitar valores duplicados
  final List<String> prioridades = ['Alta', 'Média', 'Baixa'];
  final List<String> statusList = ['Em andamento', 'Concluída', 'Pendente']; // Renomeado para evitar conflito
  final List<String> categorias = ['Trabalho', 'Estudo', 'Pessoal'];

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.titulo);
    descricaoController = TextEditingController(text: widget.descricao);
    
    // Garantir que os valores iniciais estejam nas listas
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detalhes da Tarefa",
          style: TextStyle(
            color: Color(0xFFA069FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFA069FF)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard(
                title: "Tarefa",
                child: TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Digite o título da tarefa",
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              _buildCard(
                title: "Descrição",
                child: TextField(
                  controller: descricaoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Digite a descrição da tarefa",
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
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
                title: "Prazo",
                child: GestureDetector(
                  onTap: selecionarPrazo,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(prazoSelecionado),
                        style: const TextStyle(
                          fontSize: 16, 
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(Icons.calendar_today, color: Color(0xFFA069FF)),
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
                        backgroundColor: const Color(0xFFDFE1E4),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        _excluirTarefa(context);
                      },
                      child: const Text(
                        "Excluir",
                        style: TextStyle(
                          color: Color(0xFF818181), 
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
                        backgroundColor: const Color(0xFFA069FF),
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

  Widget _buildCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF413491),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEBF5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildDropdownCard({
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    // Verificação adicional para garantir que o valor está na lista
    final String safeValue = items.contains(value) ? value : items.first;
    
    return _buildCard(
      title: title,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          dropdownColor: const Color(0xFFEEEBF5),
          style: const TextStyle(
            color: Colors.black87, 
            fontSize: 16,
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _salvarEdicoes(BuildContext context) {
    // Aqui você implementaria a lógica para salvar as edições
    final updatedData = {
      'titulo': tituloController.text,
      'descricao': descricaoController.text,
      'prioridade': prioridadeSelecionada,
      'status': statusSelecionado,
      'categoria': categoriaSelecionada,
      'prazo': prazoSelecionado,
    };
    
    print('Dados atualizados: $updatedData');
    
    // Mostrar mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa atualizada com sucesso!'),
        backgroundColor: Color(0xFFA069FF),
      ),
    );
    
    Navigator.pop(context, updatedData);
  }

  void _excluirTarefa(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Excluir Tarefa"),
          content: const Text("Tem certeza que deseja excluir esta tarefa?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fechar dialog
                Navigator.pop(context, 'deleted'); // Retornar para tela anterior
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