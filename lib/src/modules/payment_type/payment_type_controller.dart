import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMesssage;

  @readonly
  bool? _filterEnabled;

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  PaymentTypeControllerBase(this._paymentTypeRepository);

  @action
  void changeFilter(bool? enabled) => _filterEnabled = enabled;

  @action
  Future<void> loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(_filterEnabled);
      _status = PaymentTypeStateStatus.loaded;
    } on Exception catch (e, s) {
      _errorMesssage = 'Erro ao carregado formas de pagamento';
      log(_errorMesssage!, error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
    }
  }

  @action
  Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    //Força a atualização da tela (status) via event loop
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    //Avisa o controle de tela para Abrir o modal
    //é possivel abrir direto por aqui, mas para manter o padrão de arquitetura
    //deixamos que somente o controle de tela que tem o context faça isso.
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> editPayment(PaymentTypeModel payment) async {
    _status = PaymentTypeStateStatus.loading;
    //Força a atualização da tela (status) via event loop
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = payment;
    //Avisa o controle de tela para Abrir o modal
    //é possivel abrir direto por aqui, mas para manter o padrão de arquitetura
    //deixamos que somente o controle de tela que tem o context faça isso.
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String sigla,
    required bool ativo,
  }) async {
    _status = PaymentTypeStateStatus.loading;
    final model = PaymentTypeModel(
      acronym: sigla,
      enabled: ativo,
      name: name,
      id: id,
    );
    await _paymentTypeRepository.save(model);
    _status = PaymentTypeStateStatus.saved;
  }
}
