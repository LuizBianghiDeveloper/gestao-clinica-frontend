// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/defaults.dart';
import '../services/http_service.dart';

class AppController extends GetxController {

  RxBool isLoading = false.obs;
  var isError = false.obs;
  var message = "";
  HttpService httpService = HttpService();
  var token;
  var aniversariantes;
  var agendamentos;

  @override
  void onInit() {
    httpService.init(ApiKey.urlBase);
    super.onInit();
  }

  autenticacao(BuildContext? context, Map<String, dynamic>? params) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/usuarios/login");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.post(url, headers: headers, body: json.encode(params));
        if (result.statusCode == 200) {
          token = utf8.decode(result.bodyBytes);
        } else {
          isError(true);
        }
    } finally {
      isLoading(false);
    }
  }

  aniversarianteDoDia(BuildContext? context, String atributoDinamico) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/pacientes/aniversario/$atributoDinamico");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.get(url, headers: headers);
      if (result.statusCode == 200) {
        aniversariantes = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }

  agendamentoDoDia(BuildContext? context, String atributoDinamico) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/agendamentos/dia/${atributoDinamico}");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.get(url, headers: headers);
      if (result.statusCode == 200) {
        agendamentos = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }
}