import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppConfig {
  static const String logo = "assets/logo/logoThais.png";
  // Função para mostrar o spinner
  static void showLoadingSpinner(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede fechar ao clicar fora
      builder: (BuildContext context) {
        return Center(
          child: SpinKitFadingCircle(
            color: Colors.pink, // Cor rosa
            size: 50.0,         // Tamanho do spinner
          ),
        );
      },
    );
  }

  // Função para ocultar o spinner
  static void hideLoadingSpinner(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop(); // Fecha o diálogo
  }
}
