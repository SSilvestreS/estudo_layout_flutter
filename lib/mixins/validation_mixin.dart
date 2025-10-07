import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Mixin com validações reutilizáveis seguindo princípios DRY
mixin ValidationMixin {
  /// Valida se o email está no formato correto
  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    if (!value.contains('@') || !value.contains('.')) {
      return 'Email inválido';
    }
    if (value.length > AppConstants.maxEmailLength) {
      return 'Email muito longo';
    }
    return null;
  }

  /// Valida se a senha atende aos critérios mínimos
  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'Senha deve ter pelo menos ${AppConstants.minPasswordLength} caracteres';
    }
    return null;
  }

  /// Valida se o campo não está vazio
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório';
    }
    return null;
  }

  /// Valida CPF (formato básico)
  String? validateCPF(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'CPF é obrigatório';
    }
    final numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    return null;
  }

  /// Valida data (formato básico)
  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Data é obrigatória';
    }
    final numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 8) {
      return 'Data deve ter 8 dígitos (DD/MM/AAAA)';
    }
    return null;
  }

  /// Formata CPF com máscara
  String formatCPF(String value) {
    String numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length > 11) numbers = numbers.substring(0, 11);
    
    if (numbers.length <= 3) return numbers;
    if (numbers.length <= 6) return '${numbers.substring(0, 3)}.${numbers.substring(3)}';
    if (numbers.length <= 9) return '${numbers.substring(0, 3)}.${numbers.substring(3, 6)}.${numbers.substring(6)}';
    return '${numbers.substring(0, 3)}.${numbers.substring(3, 6)}.${numbers.substring(6, 9)}-${numbers.substring(9)}';
  }

  /// Formata data com máscara
  String formatDate(String value) {
    String numbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length > 8) numbers = numbers.substring(0, 8);
    
    if (numbers.length <= 2) return numbers;
    if (numbers.length <= 4) return '${numbers.substring(0, 2)}/${numbers.substring(2)}';
    return '${numbers.substring(0, 2)}/${numbers.substring(2, 4)}/${numbers.substring(4)}';
  }

  /// Mostra mensagem de erro
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Mostra mensagem de sucesso
  void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppConstants.accentGreen,
      ),
    );
  }
}
