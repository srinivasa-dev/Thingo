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
  final TextEditingController _codeController = TextEditingController();

  Uri _url = Uri.parse('https://wa.me/');

  void _launchURL() async {
    if(_formKey.currentState!.validate()){
      setState(() {
        _url = Uri.parse('https://wa.me/+${_codeController.text}${_phoneController.text}?text=${_textController.text}');
      });
      print(_url);
      if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) throw 'Could not launch $_url';
    }
  }

  @override
  void initState() {
    _codeController.text = '91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Send WhatsApp Text'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (cont) {
                  return AlertDialog(
                    title: const Text('About WhatsApp Direct Chat'),
                    content: const Text('This feature allows you to send a WhatsApp Text to an unknown number without saving the number to your contacts.'),
                    actions: [
                      CustomTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        btnTxt: 'CLOSE',
                        enableBorder: false,
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 105.0,
                    child: CustomTextField(
                      controller: _codeController,
                      keyboardType: TextInputType.phone,
                      validator: (text) {
                        if(text!.isEmpty) {
                          return 'Required*';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.add,
                        size: 20.0,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 10.0,),
                  Expanded(
                    child: CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (text) {
                        if(text!.isEmpty) {
                          return 'Required*';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0,),
              CustomTextField(
                controller: _textController,
                hintText: 'Text (Optional)',
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                minLines: 4,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 20.0,),
              CustomTextButton(
                onPressed: _launchURL,
                btnTxt: 'START CHAT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
