import 'package:flutter/material.dart';
import 'package:imc_app/bloc_pattern/imc_bloc_plattern.dart';
import 'package:imc_app/change_notifier/imc_change_notifier_page.dart';
import 'package:imc_app/setState/imc_setstate_page.dart';
import 'package:imc_app/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _goToPage(context, ImcSetstatePage()),
                child: Text("SetState")),
            ElevatedButton(
                onPressed: () => _goToPage(context, ValueNotifierPage()),
                child: Text("ValueNotifier")),
            ElevatedButton(
                onPressed: () => _goToPage(context, ImcChangeNotifierPage()),
                child: Text("ChangeNotifier")),
            ElevatedButton(
                onPressed: () => _goToPage(context, ImcBlocPlattern()),
                child: Text("Bloc Patern (streams)")),
          ],
        ),
      ),
    );
  }
}
