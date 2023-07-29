import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeModel? payment;
  final PaymentTypeController controller;
  const PaymentTypeFormModal(
      {super.key, required this.payment, required this.controller});

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final nameEC = TextEditingController();
  final siglaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var ativo = false;

  @override
  void initState() {
    final fp = widget.payment;
    if (fp != null) {
      nameEC.text = fp.name;
      siglaEC.text = fp.acronym;
      ativo = fp.enabled;
    }
    super.initState();
  }

  void _closeModal() => Navigator.of(context).pop();
  @override
  void dispose() {
    nameEC.dispose();
    siglaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.payment == null ? 'Adicionar' : 'Editar'} forma de pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        _closeModal();
                      },
                      child: const Icon(Icons.close),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
                controller: nameEC,
                validator: Validatorless.required('Nome deve ser preenchido'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Sigla'),
                ),
                validator: Validatorless.required('Sigla deve ser iformada.'),
                controller: siglaEC,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Ativo',
                    style: context.textStyles.textRegular,
                  ),
                  Switch(
                    value: ativo,
                    onChanged: (value) {
                      setState(() {
                        ativo = value;
                      });
                    },
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: _closeModal,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          final name = nameEC.text;
                          final sigla = siglaEC.text;
                          widget.controller.savePayment(
                            id: widget.payment?.id,
                            name: name,
                            sigla: sigla,
                            ativo: ativo,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
