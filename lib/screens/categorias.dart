import 'package:flutter/material.dart';
import 'package:taskflow/screens/configuracao.dart';
import 'package:taskflow/screens/estatisticas.dart';
import 'package:taskflow/screens/metas.dart';
import 'package:taskflow/screens/tarefas.dart';
import 'package:taskflow/screens/nova_categoria.dart'; // Importe a nova tela

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  // Lista de categorias
  List<Map<String, dynamic>> categorias = [
    {
      "imagem": "assets/icons/icon_trabalho.png",
      "titulo": "Trabalho",
      "quantidade": 4,
    },
    {
      "imagem": "assets/icons/icon_livro.png",
      "titulo": "Estudos",
      "quantidade": 8,
    },
    {
      "imagem": "assets/icons/icon_casa.png",
      "titulo": "Casa",
      "quantidade": 5,
    },
    {
      "imagem": "assets/icons/icon_coracao.png",
      "titulo": "Saúde",
      "quantidade": 3,
    },
  ];

  // Função para adicionar nova categoria
  void _adicionarCategoria() async {
    final novaCategoria = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NovaCategoriaPage()),
    );
    
    if (novaCategoria != null) {
      // Adicionar a nova categoria à lista
      setState(() {
        categorias.add({
          "imagem": novaCategoria["icone"],
          "titulo": novaCategoria["nome"], 
          "quantidade": novaCategoria["quantidade"],
        });
      });
      
      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Categoria "${novaCategoria["nome"]}" criada com sucesso!'),
          backgroundColor: const Color(0xFFA069FF),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Categorias',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Minhas Categorias",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF130F2B),
                ),
              ),
            ),

            // Lista de categorias
            Expanded(
              child: categorias.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Nenhuma categoria criada",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Clique em 'Nova Categoria' para começar",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: categorias.length,
                      itemBuilder: (context, index) {
                        final categoria = categorias[index];
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
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Imagem da categoria
                              Image.asset(
                                categoria["imagem"],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 12),

                              // Título e quantidade
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categoria["titulo"],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF130F2B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${categoria["quantidade"]} tarefas",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Botão de opções (opcional)
                              IconButton(
                                onPressed: () {
                                  // Aqui você pode adicionar opções como editar/excluir
                                  _mostrarOpcoesCategoria(context, index, categoria["titulo"]);
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // Botão + Nova Categoria (do meio até a direita)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Spacer(), 
                  Expanded(
                    flex: 1, 
                    child: GestureDetector(
                      onTap: _adicionarCategoria,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA069FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: FittedBox( 
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.add, color: Colors.white, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  "Nova Categoria",
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
            const SizedBox(height: 10),
          ],
        ),
      ),

      // Footer
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
              onTap: () {}, 
              child: Image.asset("assets/icons/icon_categorias_roxo.png", height: 40),
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

  // Função para mostrar opções da categoria (editar/excluir)
  void _mostrarOpcoesCategoria(BuildContext context, int index, String nomeCategoria) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nomeCategoria,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF130F2B),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit, color: Color(0xFFA069FF)),
                title: const Text('Editar Categoria'),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar edição
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Excluir Categoria'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmarExclusao(context, index, nomeCategoria);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDFE1E4),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Color(0xFF818181)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Função para confirmar exclusão
  void _confirmarExclusao(BuildContext context, int index, String nomeCategoria) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Categoria'),
        content: Text('Tem certeza que deseja excluir a categoria "$nomeCategoria"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                categorias.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Categoria "$nomeCategoria" excluída!'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}