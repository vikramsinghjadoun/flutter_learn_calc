import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int firstNumber = 0;
  int secondNumber =0;
  num result = 0;

  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();
  late final AppLifecycleListener _listener;

  @override
  void initState(){
    super.initState();
    displayOneController.text = firstNumber.toString();
    displayTwoController.text = secondNumber.toString();
    _listener = AppLifecycleListener(
      onShow: () => print("onShow called"),
      onResume: () => print("onResume called"),
      onHide: () => print("onHide called"),
      onInactive: () => print("onInactive called"),
      onPause: () => print("onPause called"),
      onDetach: () => print("onDetach called"),
      onRestart: () => print("onRestart called"),
      // This fires for each state change. Callbacks above fire only for
      // specific state transitions.
      onStateChange: _handleStateChange,
    );
  }

   void _handleStateChange(AppLifecycleState state) {
    print("onStateChanged called with state:$state ");
  }

  @override
  void dispose() {
    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.all(32.0),
      child: Column(
        children:[
          //calculator display
         CalculatorDisplay(
          key: const Key("displayOne"),
          hint : "Enter first number", controller: displayOneController),
         const SizedBox(
            height: 30,
          ),
         CalculatorDisplay(
          key: const Key("displayTwo"),
          hint : "Enter second number", controller: displayTwoController),
         const SizedBox(
          height:20,
         ),
          //expand
          Text(
            key: Key("Result"),
          result.toString(),
          style: const TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),
          const Spacer(),
          //calculator button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    result = num.tryParse(displayOneController.text)! + 
                  num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.add),
                ),
                FloatingActionButton(
                onPressed: () {
                  setState(() {
                    result = num.tryParse(displayOneController.text)! - 
                  num.tryParse(displayTwoController.text)!;
                  });
                  
                },
                child: const Icon(CupertinoIcons.minus),
                ),
                FloatingActionButton(
                onPressed: () {
                  setState(() {
                    result = num.tryParse(displayOneController.text)! * 
                  num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.multiply),
                ),
                FloatingActionButton(
                onPressed: () {
                  setState(() {
                    result = num.tryParse(displayOneController.text)! / 
                  num.tryParse(displayTwoController.text)!;
                  });
                },
                child: const Icon(CupertinoIcons.divide),
                )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
                  onPressed: (){
                    setState(() {
                      firstNumber=0;
                      secondNumber=0;
                      result=0;

                      displayOneController.clear();
                      displayTwoController.clear();
                    });
                  },
                  label: const Text("Clear"),
                
                )
        ],
      ),
    );
  }
}

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({
    super.key,
    this.hint = "Enter a number",
    required this.controller
  });
  final String? hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2.0,
            // color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black
        )
      ),
    );
  }
}