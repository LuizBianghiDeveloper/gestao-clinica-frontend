import 'package:core_dashboard/shared/constants/config.dart';
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
    double imageWidth = MediaQuery.of(context).size.width * 0.4;
    double imageHeight = MediaQuery.of(context).size.height * 0.3;
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
                  SizedBox(
                    width: 296,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
