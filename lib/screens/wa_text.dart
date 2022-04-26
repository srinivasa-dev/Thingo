import 'package:flutter/material.dart';
import 'package:thingo/widgets/custom_text_button.dart';
import 'package:thingo/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class WaText extends StatefulWidget {
  const WaText({Key? key}) : super(key: key);

  @override
  State<WaText> createState() => _WaTextState();
}

class _WaTextState extends State<WaText> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _url = 'https://wa.me/';

  void _launchURL() async {
    if(_formKey.currentState!.validate()){
      setState(() {
        _url = 'https://wa.me/${_phoneController.text}?text=${_textController.text}';
      });
      if (!await launch(_url)) throw 'Could not launch $_url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Send WhatsApp Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _textController,
                hintText: 'Text (Optional)',
              ),
              const SizedBox(height: 10.0,),
              CustomTextField(
                controller: _phoneController,
                hintText: 'Phone Number With Country Code',
                keyboardType: TextInputType.phone,
                validator: (text) {
                  if(text!.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
              CustomTextButton(
                onPressed: _launchURL,
                btnTxt: 'CHAT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
