import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  const CadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130F2B),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Linha com seta e título
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFF55525B)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'TaskFlow',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA069FF),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 60, 
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDFDFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: const [
                            Text(
                              'Cadastro',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF55525B),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/icon_person.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9FA),
                          hintText: "Nome",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo de Email
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/icon_email.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9FA),
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo Senha
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/icon_senha.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9FA),
                          hintText: "Senha",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/icons/icon_senha.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9F9FA),
                          hintText: "Confirmar Senha",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        width: double.infinity,
                        height: 1,
                        color: const Color(0xFF818181),
                      ),
                      const SizedBox(height: 20),

                      // Botão de cadastro
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA069FF),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Criar Conta",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20), 

                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Já tem uma conta?',
                            style: TextStyle(
                              color: Color(0xFFA069FF),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
