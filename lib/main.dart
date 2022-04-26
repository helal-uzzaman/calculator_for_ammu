import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController totalWorkingDaysController =
      TextEditingController();
  final TextEditingController totalStudentController = TextEditingController();
  final TextEditingController totalPresenceController = TextEditingController();
  double result = 0.0;
  double mean = 0;

  void calculate(BuildContext context) {
    final validate = _formKey.currentState!.validate();
    if (validate) {
      try {
        setState(() {
          print(totalPresenceController.text);
          print(totalWorkingDaysController.text);
          print(totalStudentController.text);
          result = (double.parse(totalPresenceController.text) /
              (double.parse(totalWorkingDaysController.text) *
                  double.parse(totalStudentController.text)) *
              100);

          mean = (double.parse(totalPresenceController.text) /
              double.parse(totalWorkingDaysController.text));
          print(result);
          if (result > 100) {
            throw Exception('ভুল তথ্য দিয়েছন।  ঠিক ভাবে তথ্য দিন ');
          }
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              ElevatedButton(
                  onPressed: () => {
                        Navigator.pop(context),
                      },
                  child: Text('Okay'))
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Present calculation'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Result ${result.toStringAsFixed(2)} %',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    Text(
                      'mean ${mean.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(children: [
                  TitleText('মোট কার্য দিবস '),
                  AppFromField(
                    textController: totalWorkingDaysController,
                  ),
                ]),
                Row(
                  children: [
                    TitleText('মোট ছাত্র ছাত্রী'),
                    AppFromField(
                      textController: totalStudentController,
                    ),
                  ],
                ),
                Row(
                  children: [
                    TitleText('উপস্হিতির  যোগফল '),
                    AppFromField(
                      textController: totalPresenceController,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => calculate(context),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Calculate'),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text(result.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(
    this.text, {
    Key? key,
  }) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class AppFromField extends StatelessWidget {
  const AppFromField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            return null;
          } else {
            return 'Enter value';
          }
        },
        autofocus: true,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
          // suffixIcon: IconButton(
          //   padding: EdgeInsets.zero,
          //   onPressed: () => {
          //     textController.clear(),
          //   },
          //   icon: const Icon(Icons.close_rounded),
          // ),
        ),
      ),
    );
  }
}
