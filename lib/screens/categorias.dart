import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow/models/theme_model.dart';
import 'package:taskflow/screens/configuracao.dart';
import 'package:taskflow/screens/estatisticas.dart';
import 'package:taskflow/screens/metas.dart';
import 'package:taskflow/screens/tarefas.dart';
import 'package:taskflow/screens/nova_categoria.dart';

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
      setState(() {
        categorias.add({
          "imagem": novaCategoria["icone"],
          "titulo": novaCategoria["nome"], 
          "quantidade": novaCategoria["quantidade"],
        });
      });
      
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
    final themeModel = Provider.of<ThemeModel>(context);
    
    return Scaffold(
      backgroundColor: themeModel.currentTheme.scaffoldBackgroundColor,

      // AppBar
      appBar: AppBar(
        backgroundColor: themeModel.currentTheme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Categorias',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Minhas Categorias",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                ),
              ),
            ),

            // Lista de categorias
            Expanded(
              child: categorias.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: themeModel.isDarkMode ? Colors.white54 : Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Nenhuma categoria criada",
                            style: TextStyle(
                              fontSize: 18,
                              color: themeModel.isDarkMode ? Colors.white54 : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Clique em 'Nova Categoria' para começar",
                            style: TextStyle(
                              fontSize: 14,
                              color: themeModel.isDarkMode ? Colors.white54 : Colors.grey,
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
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${categoria["quantidade"]} tarefas",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: themeModel.isDarkMode ? Colors.white54 : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Botão de opções
                              IconButton(
                                onPressed: () {
                                  _mostrarOpcoesCategoria(context, index, categoria["titulo"], themeModel);
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: themeModel.isDarkMode ? Colors.white54 : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // Botão + Nova Categoria
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
              onTap: () {}, 
              child: Image.asset(
                "assets/icons/icon_categorias_roxo.png", 
                height: 40,
                color: themeModel.isDarkMode ? const Color(0xFFA069FF) : null,
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

  // Função para mostrar opções da categoria
  void _mostrarOpcoesCategoria(BuildContext context, int index, String nomeCategoria, ThemeModel themeModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: themeModel.currentTheme.colorScheme.surface,
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.edit, color: themeModel.currentTheme.primaryColor),
                title: Text(
                  'Editar Categoria',
                  style: TextStyle(
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Implementar edição
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Excluir Categoria',
                  style: TextStyle(
                    color: themeModel.currentTheme.textTheme.bodyLarge?.color,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmarExclusao(context, index, nomeCategoria, themeModel);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeModel.isDarkMode ? const Color(0xFF333333) : const Color(0xFFDFE1E4),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: themeModel.isDarkMode ? Colors.white70 : const Color(0xFF818181)
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Função para confirmar exclusão
  void _confirmarExclusao(BuildContext context, int index, String nomeCategoria, ThemeModel themeModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: themeModel.currentTheme.colorScheme.surface,
        title: Text(
          'Excluir Categoria',
          style: TextStyle(
            color: themeModel.currentTheme.textTheme.bodyLarge?.color,
          ),
        ),
        content: Text(
          'Tem certeza que deseja excluir a categoria "$nomeCategoria"?',
          style: TextStyle(
            color: themeModel.currentTheme.textTheme.bodyMedium?.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar', 
              style: TextStyle(color: themeModel.isDarkMode ? Colors.white70 : Colors.grey)
            ),
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