import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum Method { post, get, put, delete, patch }

class HttpService {
  Dio? _dio;
  String? _bearerToken;

  header() => {"Content-Type": "application/json", "Authorization": "Bearer $_bearerToken"};

  Future<HttpService> init(baseUrl, {String? bearerToken}) async {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: header()));
    _bearerToken = bearerToken;
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          requestOptions.headers.addAll(header());
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (err, handler) {
          return handler.next(err);
        },
      ),
    );
  }

  Future<dynamic> request(
      {required String url,
        required Method method,
        Map<String, dynamic>? params,
        String? data,
        required BuildContext context}) async {
    Response response;
    try {
      if (method == Method.post) {
        response = await _dio!.post(url, data: data ?? params);
      } else if (method == Method.delete) {
        response = await _dio!.delete(url);
      } else if (method == Method.patch) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something went wrong");
      }
    } on SocketException catch (e) {
      throw Exception("No Internet Connection${e.message}");
    } on FormatException catch (e) {
      throw Exception("Bad response format${e.message}");
    } on DioError catch (e) {
      return null;
      //throw Exception(e);
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}