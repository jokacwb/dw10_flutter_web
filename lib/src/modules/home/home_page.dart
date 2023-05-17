import 'package:flutter/material.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/colors_app.dart';
import '../../core/ui/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page -DW10'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoader();
          await Future.delayed(const Duration(seconds: 2));
          hideLoader();
          showSuccess('Deu erro na bagaca');
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'JOSE CARLOS',
            style: context.textStyles.textTitle,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Login'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: context.percentWidth(50),
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Iniciar'),
            ),
          ),
        ],
      ),
    );
  }
}
