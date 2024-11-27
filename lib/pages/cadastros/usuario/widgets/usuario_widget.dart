import 'package:core_dashboard/controllers/usuarios_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/defaults.dart';
import '../../../../shared/constants/ghaps.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../theme/app_colors.dart';

class UsuarioWidget extends StatefulWidget {
  const UsuarioWidget({super.key});

  @override
  State<UsuarioWidget> createState() => _UsuarioWidgetState();
}

class _UsuarioWidgetState extends State<UsuarioWidget> {
  final formKey = GlobalKey<FormState>();

  final senhaController = MaskedTextController(mask: '000.000.000-00');
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();
  final UsuariosController usuariosController = Get.find<UsuariosController>();
  String? selectedPerfil;

  @override
  void initState() {
    super.initState();

    if (usuariosController.usuarioSelecionado != null && usuariosController.usuarioSelecionado != "") {
      final usuario = usuariosController.usuarioSelecionado;

      loginController.text = usuario['login'] ?? '';
      nomeController.text = usuario['nomeUsuario'] ?? '';
      selectedPerfil = usuario['permissao'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              SectionTitle(title: "Dados Pessoais"),
              Spacer(),
            ],
          ),
          gapH24,
          Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: nomeController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do usuário',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o nome do usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                  ],
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: loginController,
                        decoration: const InputDecoration(
                          labelText: 'Login',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o login do usuario';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: selectedPerfil,
                        decoration: const InputDecoration(
                          labelText: 'Tipo de perfil',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Administrador',
                            child: Text('Administrador'),
                          ),
                          DropdownMenuItem(
                            value: 'Usuário Comum',
                            child: Text('Usuário Comum'),
                          ),
                          DropdownMenuItem(
                            value: 'Convidado',
                            child: Text('Convidado'),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPerfil = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, selecione o tipo de perfil';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                  ],
                ),
                gapH16,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        obscureText: true,
                        controller: senhaController,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a senha';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        obscureText: true,
                        controller: confirmaSenhaController,
                        decoration: const InputDecoration(
                          labelText: 'Confirme a senha',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a confirmação da senha';
                          }
                          return null;
                        },
                      ),
                    ),
                    gapW16,
                  ],
                ),
                gapH24,
              ],
            ),
          ),
          gapH24,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding * 0.5,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true ) {
                        if (usuariosController.usuarioSelecionado != null && usuariosController.usuarioSelecionado != "") {
                          var params = <String, dynamic>{};

                          params["nomeUsuario"] = nomeController.text;
                          params["login"] = loginController.text;
                          params["senha"] = senhaController.text;
                          params["permissao"] = selectedPerfil;

                          await usuariosController.atualizarUsuarios(context, params, usuariosController.usuarioSelecionado['idUsuario']);
                          if (usuariosController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel atualizar o usuário, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário atualizado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await usuariosController.listarUsuarios(context);
                            context.go('/cadastro-search-usuario');
                          }
                        } else {
                          var params = <String, dynamic>{};
                          params["nomeUsuario"] = nomeController.text;
                          params["login"] = loginController.text;
                          params["senha"] = senhaController.text;
                          params["permissao"] = selectedPerfil;

                          await usuariosController.adicionarUsuarios(context, params);
                          if (usuariosController.isError.isTrue) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não foi possivel adicionar o usuário, por favor, tente novamente.'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário adicionado com sucesso.'),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            await usuariosController.listarUsuarios(context);
                            context.go('/cadastro-search-usuario');
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos do cadastro de usuário.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: usuariosController.usuarioSelecionado != null && usuariosController.usuarioSelecionado != "" ? const Text('Atualizar') : const Text('Salvar'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDefaults.padding * 0.5,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/cadastro-search-usuario');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.pink,
                      side: const BorderSide(color: Colors.pink),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
              ),
              gapW16,
            ],
          ),
        ],
      ),
    );
  }
}
