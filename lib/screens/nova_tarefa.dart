import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Nova Tarefa",
          style: TextStyle(
            color: Color(0xFFA069FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFA069FF)),
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
                    hintText: "Digite o título da tarefa",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildCard(
                title: "Descrição",
                child: TextField(
                  controller: descricaoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Adicione uma breve descrição",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                title: "Prioridade",
                value: prioridadeSelecionada,
                items: prioridades,
                onChanged: (value) => setState(() => prioridadeSelecionada = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                title: "Status",
                value: statusSelecionado,
                items: status,
                onChanged: (value) => setState(() => statusSelecionado = value!),
              ),
              const SizedBox(height: 16),
              _buildDropdownCard(
                title: "Categoria",
                value: categoriaSelecionada,
                items: categorias,
                onChanged: (value) => setState(() => categoriaSelecionada = value!),
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
                        prazoSelecionado != null
                            ? DateFormat('dd/MM/yyyy').format(prazoSelecionado!)
                            : "Selecione o prazo",
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Excluir",
                        style: TextStyle(color: Color(0xFF818181), fontSize: 16),
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
    return _buildCard(
      title: title,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFFEEEBF5),
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
