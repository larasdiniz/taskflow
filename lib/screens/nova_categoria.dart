import 'package:flutter/material.dart';

class NovaCategoriaPage extends StatefulWidget {
  const NovaCategoriaPage({super.key});

  @override
  State<NovaCategoriaPage> createState() => _NovaCategoriaPageState();
}

class _NovaCategoriaPageState extends State<NovaCategoriaPage> {
  final TextEditingController nomeController = TextEditingController();
  
  String iconeSelecionado = 'assets/icons/icon_trabalho.png';
  
  final List<Map<String, String>> icones = [
    {
      "caminho": "assets/icons/icon_trabalho.png",
      "nome": "Trabalho"
    },
    {
      "caminho": "assets/icons/icon_livro.png", 
      "nome": "Estudos"
    },
    {
      "caminho": "assets/icons/icon_casa.png",
      "nome": "Casa"
    },
    {
      "caminho": "assets/icons/icon_coracao.png",
      "nome": "Saúde"
    },
    {
      "caminho": "assets/icons/icon_compras.png",
      "nome": "Compras"
    },
    {
      "caminho": "assets/icons/icon_esportes.png",
      "nome": "Esportes"
    },
    {
      "caminho": "assets/icons/icon_lazer.png",
      "nome": "Lazer"
    },
    {
      "caminho": "assets/icons/icon_familia.png",
      "nome": "Família"
    },
  ];

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
          "Nova Categoria",
          style: TextStyle(
            color: Color(0xFFA069FF),
            fontWeight: FontWeight.bold,
            fontSize: 22,
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

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo para nome da categoria
              _buildCard(
                title: "Nome da Categoria",
                child: TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    hintText: "Digite o nome da categoria",
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Seletor de ícone
              _buildCard(
                title: "Ícone",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    
                    // Ícone selecionado atualmente
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            iconeSelecionado,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getNomeIcone(iconeSelecionado),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Grid de ícones
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: icones.length,
                      itemBuilder: (context, index) {
                        final icone = icones[index];
                        final bool isSelected = iconeSelecionado == icone["caminho"];
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              iconeSelecionado = icone["caminho"]!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFA069FF).withOpacity(0.1) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFA069FF) : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  icone["caminho"]!,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  icone["nome"]!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isSelected ? const Color(0xFFA069FF) : Colors.grey,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
                        "Cancelar",
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
                        // Validar e salvar a nova categoria
                        if (nomeController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Por favor, digite um nome para a categoria"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        
                        // Aqui você pode salvar a nova categoria
                        final novaCategoria = {
                          "nome": nomeController.text.trim(),
                          "icone": iconeSelecionado,
                          "quantidade": 0, // Inicia com 0 tarefas
                        };
                        
                        // Retornar a nova categoria para a tela anterior
                        Navigator.pop(context, novaCategoria);
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

  String _getNomeIcone(String caminhoIcone) {
    for (var icone in icones) {
      if (icone["caminho"] == caminhoIcone) {
        return icone["nome"]!;
      }
    }
    return "Ícone";
  }
}