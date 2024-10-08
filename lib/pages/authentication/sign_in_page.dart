import 'package:core_dashboard/shared/constants/config.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/extensions.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 296,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDefaults.padding * 1.5,
                      ),
                      child: SvgPicture.asset(AppConfig.logo),
                    ),
                    Text(
                      'Entrar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
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

                    /// EMAIL TEXT FIELD
                    TextFormField(
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

                    /// PASSWORD TEXT FIELD
                    TextFormField(
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

                    /// SIGN IN BUTTON
                    SizedBox(
                      width: 296,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: const Text('Entrar'),
                      ),
                    ),
                    gapH24,

                    /// FOOTER TEXT
                    Text(
                      'Este site é protegido pelo reCAPTCHA e pela Política de Privacidade do Google.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    gapH24,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
