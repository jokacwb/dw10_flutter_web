import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

class BaseHeader extends StatelessWidget {
  final String title;
  final ValueChanged<String>? searchChange;
  final String buttonLabel;
  final VoidCallback? buttonPressed;
  final bool addButton;
  final Widget? filterWidget;

  const BaseHeader({
    super.key,
    required this.title,
    this.searchChange,
    required this.buttonLabel,
    this.buttonPressed,
    this.addButton = true,
    this.filterWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Wrap(
          children: [
            Visibility(
              visible: filterWidget == null,
              replacement: filterWidget ??
                  const SizedBox
                      .shrink(), // usado o orOperator?? pois o visibility renderiza a opcao de replacement e como pode ser null daria erro por isso geramos o box minimo
              child: SizedBox(
                width: constraints.maxWidth * .15,
                child: TextFormField(
                  onChanged: searchChange,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(
                      Icons.search,
                      size: constraints.maxWidth * .03,
                    ),
                    label: Text(
                      'Buscar',
                      style: context.textStyles.textRegular
                          .copyWith(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: constraints.maxWidth * .65,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textStyles.textTitle.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                ),
              ),
            ),
            Visibility(
              visible: addButton,
              child: SizedBox(
                height: 48,
                width: constraints.maxWidth * .15,
                child: OutlinedButton.icon(
                  onPressed: buttonPressed,
                  icon: Icon(
                    Icons.add,
                    size: constraints.maxWidth * .03,
                  ),
                  label: Text(buttonLabel),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
