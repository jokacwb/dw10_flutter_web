import 'package:flutter/material.dart';

import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel formaPagto;

  const PaymentTypeItem({
    super.key,
    required this.formaPagto,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorAll = formaPagto.enabled ? Colors.black : Colors.grey;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${formaPagto.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/icons/payment_notfound_icon.png',
                  color: colorAll,
                );
              },
              color: colorAll,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Forma de pagamento',
                      style: context.textStyles.textRegular
                          .copyWith(color: colorAll),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FittedBox(
                    child: Text(
                      formaPagto.name,
                      style: context.textStyles.textTitle
                          .copyWith(color: colorAll),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    controller.editPayment(formaPagto);
                  },
                  child: Text(
                    'Editar',
                    style: context.textStyles.textMedium.copyWith(
                      color: formaPagto.enabled
                          ? context.colors.primary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
