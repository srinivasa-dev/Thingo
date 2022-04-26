import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thingo/blocs/ig_profile/ig_profile_bloc.dart';
import 'package:thingo/service/ig_profile_service.dart';
import 'package:thingo/widgets/custom_text_button.dart';
import 'package:thingo/widgets/custom_text_field.dart';


class IgProfileInfo extends StatefulWidget {
  const IgProfileInfo({Key? key}) : super(key: key);

  @override
  State<IgProfileInfo> createState() => _IgProfileInfoState();
}

class _IgProfileInfoState extends State<IgProfileInfo> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  late IgProfileBloc _igProfileBloc;
  final IgProfileService _igProfileService = IgProfileService();

  @override
  void initState() {
    _igProfileBloc = IgProfileBloc(_igProfileService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Profile Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _searchController,
                      hintText: 'Username only',
                      validator: (text) {
                        if(text!.isEmpty) {
                          return 'Cannot be empty!';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 20.0,),
                  CustomTextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        FocusScope.of(context).unfocus();
                        _igProfileBloc.add(IgProfileAPIEvent(username: _searchController.text));
                      }
                    },
                    btnTxt: 'FIND',
                  ),
                ],
              ),
              const SizedBox(height: 50.0,),
              BlocBuilder<IgProfileBloc, IgProfileState>(
                bloc: _igProfileBloc,
                builder: (context, state) {
                  if(state is IgProfileLoadingState) {
                    return const Center(
                      child: SpinKitChasingDots(color: Colors.deepOrange),
                    );
                  } else if (state is IgProfileLoadedState) {
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Image.network(
                              state.profile.profilePicUrlHd,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
