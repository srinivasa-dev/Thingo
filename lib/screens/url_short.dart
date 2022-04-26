import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thingo/blocs/url/url_bloc.dart';
import 'package:thingo/service/url_service.dart';
import 'package:thingo/widgets/custom_text_button.dart';
import 'package:thingo/widgets/custom_text_field.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class UrlShort extends StatefulWidget {
  const UrlShort({Key? key}) : super(key: key);

  @override
  State<UrlShort> createState() => _UrlShortState();
}

class _UrlShortState extends State<UrlShort> {

  final TextEditingController _urlText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late UrlBloc _urlBloc;
  final UrlService _urlService = UrlService();

  @override
  void initState() {
    _urlBloc = UrlBloc(_urlService);
    _urlBloc.add(const UrlInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _urlBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('URL Shortener'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _urlText,
                      hintText: 'Paste Your Link...',
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if(text!.isEmpty){
                          return 'Required*';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  CustomTextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        _urlBloc.add(UrlAPIEvent(url: _urlText.text, context: context));
                      }
                    },
                    btnTxt: 'CREATE',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15.0,),
            BlocConsumer<UrlBloc, UrlState>(
              bloc: _urlBloc,
              builder: (context, state) {
                if(state is UrlLoadingState) {
                  return const Center(
                    child: SpinKitChasingDots(color: Colors.deepOrange),
                  );
                } else if (state is UrlLoadedState) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildList(
                          title: state.urlModel.shortLink,
                          subtitle: 'Short Link',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.shortLink));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.shortLink);
                          },
                          onOpen: () async {
                            if (!await launch('https://'+state.urlModel.shortLink)) throw 'Could not launch ${'https://'+state.urlModel.shortLink}';
                          },
                        ),
                        buildList(
                          title: state.urlModel.fullShortLink,
                          subtitle: 'Full Short Link',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.fullShortLink));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.fullShortLink);
                          },
                          onOpen: () async {
                            if (!await launch(state.urlModel.fullShortLink)) throw 'Could not launch ${state.urlModel.fullShortLink}';
                          },
                        ),
                        buildList(
                          title: state.urlModel.shortLink2,
                          subtitle: 'Short Link 2',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.shortLink2));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.shortLink2);
                          },
                          onOpen: () async {
                            if (!await launch('https://'+state.urlModel.shortLink2)) throw 'Could not launch ${'https://'+state.urlModel.shortLink2}';
                          },
                        ),
                        buildList(
                          title: state.urlModel.fullShortLink2,
                          subtitle: 'Full Short Link 2',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.fullShortLink2));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.fullShortLink2);
                          },
                          onOpen: () async {
                            if (!await launch(state.urlModel.fullShortLink2)) throw 'Could not launch ${state.urlModel.fullShortLink2}';
                          },
                        ),
                        buildList(
                          title: state.urlModel.shortLink3,
                          subtitle: 'Short Link 3',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.shortLink3));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.shortLink3);
                          },
                          onOpen: () async {
                            if (!await launch('https://'+state.urlModel.shortLink3)) throw 'Could not launch ${'https://'+state.urlModel.shortLink3}';
                          },
                        ),
                        buildList(
                          title: state.urlModel.fullShortLink3,
                          subtitle: 'Full Short Link 3',
                          onCopy: () async {
                            await Clipboard.setData(ClipboardData(text: state.urlModel.fullShortLink3));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copied!',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          onShare: () {
                            Share.share(state.urlModel.fullShortLink3);
                          },
                          onOpen: () async {
                            if (!await launch(state.urlModel.fullShortLink3)) throw 'Could not launch ${state.urlModel.fullShortLink3}';
                          },
                        ),
                      ],
                    ),
                  );
                } else if (state is UrlErrorState) {
                  return Container();
                } else {
                  return Container();
                }
              },
              listener: (context, state) {

              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildList({
    required String title,
    required String subtitle,
    required void Function() onCopy,
    required void Function() onShare,
    required void Function() onOpen,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
      ),
      trailing: Wrap(
        children: [
          IconButton(
            splashRadius: 20.0,
            onPressed: onCopy,
            icon: const Icon(
              Icons.copy,
            ),
          ),
          IconButton(
            splashRadius: 20.0,
            onPressed: onShare,
            icon: const Icon(
              Icons.share,
            ),
          ),
          IconButton(
            splashRadius: 20.0,
            onPressed: onOpen,
            icon: const Icon(
              Icons.open_in_new,
            ),
          ),
        ],
      ),
    );
  }
}
