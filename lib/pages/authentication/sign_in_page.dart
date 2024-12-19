import 'package:core_dashboard/controllers/usuarios_controller.dart';
import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/extensions.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/clientes_controller.dart';
import '../../controllers/profissional_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AppController appController = Get.put(AppController());
  final ClientesController clientesController = Get.put(ClientesController());
  final UsuariosController usuariosController = Get.put(UsuariosController());
  final ProfissionalController profissionalCOntroller = Get.put(ProfissionalController());

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * 0.4;
    double imageHeight = MediaQuery.of(context).size.height * 0.3;
    emailController.text = "luizbianghi";
    passwordController.text = "Luiz@1996";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 296,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppConfig.logo,
                      width: imageWidth > 250 ? 250 : imageWidth,
                      height: imageHeight > 200 ? 200 : imageHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                  gapH24,
                  Center(
                    child: Text(
                      'Entrar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  gapH24,
                  const Divider(),
                  gapH24,
                  Text(
                    'Informe as credenciais de acesso abaixo:',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  gapH16,
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/mail_light.svg',
                        height: 16,
                        width: 20,
                        fit: BoxFit.none,
                      ),
                      suffixIcon: SvgPicture.asset(
                        'assets/icons/check_filled.svg',
                        width: 17,
                        height: 11,
                        fit: BoxFit.none,
                        colorFilter: AppColors.success.toColorFilter,
                      ),
                      hintText: 'Digite o e-mail',
                    ),
                  ),
                  gapH16,
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/lock_light.svg',
                        height: 16,
                        width: 20,
                        fit: BoxFit.none,
                      ),
                      hintText: 'Digite a senha',
                    ),
                  ),
                  gapH16,
                  Obx(
                        () => SizedBox(
                      width: 296,
                      child: ElevatedButton(
                        onPressed: appController.isLoading.isTrue
                            ? null
                            : () async {
                          var params = <String, dynamic>{};
                          params["nomeUsuario"] =
                              emailController.text.trim();
                          params["senha"] =
                              passwordController.text.trim();
                          await appController.autenticacao(
                              context, params);
                          if (appController.isError.isTrue) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.bottomSlide,
                              title: 'Atenção',
                              desc:
                              'Ocorreu um erro durante o login. Tente novamente ou verifique suas informações.',
                              btnOkOnPress: () {},
                              btnOkColor: Colors.red,
                            ).show();
                          } else {
                            String diaAtual = DateTime.now()
                                .toIso8601String()
                                .split('T')[0];
                            await appController.aniversarianteDoDia(
                                context, diaAtual);
                            if (appController.isError.isTrue) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.bottomSlide,
                                title: 'Atenção',
                                desc:
                                'Ocorreu um erro durante o login. Tente novamente ou verifique suas informações.',
                                btnOkOnPress: () {},
                                btnOkColor: Colors.red,
                              ).show();
                            } else {
                              await appController.agendamentoDoDia(
                                  context, diaAtual);
                              if (appController.isError.isTrue) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  animType: AnimType.bottomSlide,
                                  title: 'Atenção',
                                  desc:
                                  'Ocorreu um erro durante o login. Tente novamente ou verifique suas informações.',
                                  btnOkOnPress: () {},
                                  btnOkColor: Colors.red,
                                ).show();
                              } else {
                                context.go('/');
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        child: appController.isLoading.isTrue
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                            : const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  gapH24,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
