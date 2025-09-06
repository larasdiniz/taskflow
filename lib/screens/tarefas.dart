import 'package:flutter/material.dart';
import 'package:taskflow/screens/estatisticas.dart';
import 'package:taskflow/screens/login.dart';
import 'package:taskflow/screens/categorias.dart';
import 'package:intl/intl.dart';
import 'package:taskflow/screens/metas.dart'; 

class Tarefa {
  String titulo;
  String prioridade;
  bool concluida;
  DateTime? prazo; 
  Tarefa({
    required this.titulo,
    required this.prioridade,
    this.concluida = false,
    this.prazo, 
  });
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  String prioridadeSelecionada = 'Todas'; 
  final List<String> prioridades = ['Todas', 'Alta', 'Média', 'Baixa'];
  String ordenarPor = 'Prazo'; 
  final List<String> opcoesOrdenacao = ['Prazo', 'Prioridade', 'Alfabética'];


  final List<Tarefa> tarefas = [
    Tarefa(
      titulo: "Revisar proposta do projeto",
      prioridade: "Alta",
      prazo: DateTime.now().add(const Duration(days: 2)),
    ),
    Tarefa(
      titulo: "Enviar relatório mensal",
      prioridade: "Alta",
      prazo: DateTime.now().add(const Duration(days: 1)),
    ),
    Tarefa(
      titulo: "Agendar reunião com a equipe",
      prioridade: "Média",
      prazo: DateTime.now().add(const Duration(days: 5)),
    ),
    Tarefa(
      titulo: "Finalizar apresentação",
      prioridade: "Média",
      prazo: DateTime.now().add(const Duration(days: 3)),
    ),
    Tarefa(
      titulo: "Organizar documentos",
      prioridade: "Baixa",
      prazo: DateTime.now().add(const Duration(days: 7)),
    ),
  ];

  Color corDaBolinha(Tarefa tarefa) {
    if (tarefa.concluida) return const Color(0xFFB991FF);
    switch (tarefa.prioridade) {
      case "Alta":
        return const Color(0xFFFF6969);
      case "Média":
        return const Color(0xFFE6C026);
      case "Baixa":
        return const Color(0xFF818181);
      default:
        return Colors.grey;
    }
  }

  // Função para ordenar as tarefas
  List<Tarefa> getTarefasOrdenadas() {
    List<Tarefa> tarefasFiltradas = tarefas.where((tarefa) {
      if (prioridadeSelecionada == 'Todas') return true;
      return tarefa.prioridade == prioridadeSelecionada;
    }).toList();

    // Aplicar ordenação
    switch (ordenarPor) {
      case 'Prazo':
        tarefasFiltradas.sort((a, b) {
          // Tarefas sem prazo vão para o final
          if (a.prazo == null && b.prazo == null) return 0;
          if (a.prazo == null) return 1;
          if (b.prazo == null) return -1;
          return a.prazo!.compareTo(b.prazo!);
        });
        break;
      case 'Prioridade':
        // Ordenar por prioridade (Alta > Média > Baixa)
        final ordemPrioridade = {'Alta': 1, 'Média': 2, 'Baixa': 3};
        tarefasFiltradas.sort((a, b) {
          return ordemPrioridade[a.prioridade]!.compareTo(ordemPrioridade[b.prioridade]!);
        });
        break;
      case 'Alfabética':
        tarefasFiltradas.sort((a, b) => a.titulo.compareTo(b.titulo));
        break;
    }

    return tarefasFiltradas;
  }

  @override
  Widget build(BuildContext context) {
    final tarefasOrdenadas = getTarefasOrdenadas();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      
      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tarefas',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: Image.asset('assets/icons/icon_ajuda.png', height: 24),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0xFF000000),
              size: 28,
            ),
            onPressed: () {
              // Aqui você pode adicionar a lógica para criar uma nova tarefa
            },
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Perfil
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/perfil.png'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Olá, Ursula!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF130F2B),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Vamos organizar suas tarefas",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Cards principais
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA069FF), Color(0xFFB991FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Taxa de conclusão",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "20%",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFC8B6F3), Color(0xFFE0D9F0)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Em andamento",
                            style: TextStyle(
                              color: Color(0xFF413491),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "3",
                                    style: TextStyle(
                                      color: Color(0xFF413491),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "tarefas",
                                    style: TextStyle(
                                      color: Color(0xFF413491),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.directions_run,
                                color: Color(0xFF413491),
                                size: 28,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Filtros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA069FF), Color(0xFFB991FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Prioridade",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: prioridadeSelecionada,
                                dropdownColor: const Color(0xFFA069FF),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                items: prioridades
                                    .map(
                                      (p) => DropdownMenuItem(
                                        value: p,
                                        child: Text(p),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    prioridadeSelecionada = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0D9F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: ordenarPor,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF413491),
                          ),
                          style: const TextStyle(
                            color: Color(0xFF413491),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          items: opcoesOrdenacao
                              .map(
                                (opcao) => DropdownMenuItem(
                                  value: opcao,
                                  child: Text(opcao),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              ordenarPor = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: tarefasOrdenadas.length,
                itemBuilder: (context, index) {
                  final tarefa = tarefasOrdenadas[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              tarefa.concluida = !tarefa.concluida;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: tarefa.concluida
                                  ? corDaBolinha(tarefa)
                                  : Colors.transparent,
                              border: Border.all(
                                color: corDaBolinha(tarefa),
                                width: 2,
                              ),
                            ),
                            child: tarefa.concluida
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tarefa.titulo,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: tarefa.concluida
                                      ? Colors.grey
                                      : Colors.black,
                                  decoration: tarefa.concluida
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "Prioridade: ${tarefa.prioridade}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  if (tarefa.prazo != null)
                                    Text(
                                      "Prazo: ${DateFormat('dd/MM/yyyy').format(tarefa.prazo!)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: tarefa.prazo!.isBefore(DateTime.now().add(const Duration(days: 1)))
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Footer simples
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
              onTap: () {},
              child: Image.asset("assets/icons/icon_tarefas_roxo.png", height: 40),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Image.asset("assets/icons/icon_config_cinza.png", height: 40),
            ),
          ],
        ),
      ),
    );
  }
}