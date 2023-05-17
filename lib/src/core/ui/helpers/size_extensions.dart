import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenShortestSide => MediaQuery.of(this).size.shortestSide;
  double get screenLongestSide => MediaQuery.of(this).size.longestSide;

  ///Retorna a largura da tela na porcentagem informada no parametro
  ///
  /// Exemplo de uso (Para obter 30% da lagura da tela):
  ///
  /// ```dart
  /// var largura30 = percentWidth(30);
  ///
  /// ```
  double percentWidth(double percent) => screenWidth * (percent / 100);

  ///Retorna a Altura da tela na porcentagem informada no parametro
  ///
  /// Exemplo de uso (Para obter 40% da altura da tela):
  ///
  /// ```dart
  /// var altura40 = percentHeight(40);
  ///
  /// ```
  double percentHeight(double percent) => screenHeight * (percent / 100);
}
