// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/defaults.dart';
import '../services/http_service.dart';

class SalasController extends GetxController {

  RxBool isLoading = false.obs;
  var isError = false.obs;
  var message = "";
  HttpService httpService = HttpService();
  var sala;
  var salaAtualizada;
  var salasAdicionada;
  var salaSelecionado;

  @override
  void onInit() {
    httpService.init(ApiKey.urlBase);
    super.onInit();
  }

  listarSalas(BuildContext? context) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/salas");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.get(url, headers: headers);
      if (result.statusCode == 200) {
        sala = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }

  atualizarSala(BuildContext? context, Map<String, dynamic>? params, int atributoDinamico) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/salas/${atributoDinamico}");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.put(url, headers: headers, body: json.encode(params));
      if (result.statusCode == 200) {
        salaAtualizada = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }

  deletarSala(BuildContext? context, int atributoDinamico) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/salas/${atributoDinamico}");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.delete(url, headers: headers);
      if (result.statusCode == 200) {
        salaAtualizada = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }

  adicionarSalas(BuildContext? context, Map<String, dynamic>? params) async {
    try {
      isLoading(true);
      isError(false);
      final url = Uri.parse("${ApiKey.urlBase}/salas");
      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final result = await http.post(url, headers: headers, body: json.encode(params));
      if (result.statusCode == 200) {
        salasAdicionada = utf8.decode(result.bodyBytes);
      } else {
        isError(true);
      }
    } finally {
      isLoading(false);
    }
  }
}