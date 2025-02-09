import 'package:flutter/material.dart';
import 'package:flutter_advance_course/presentation/login/login_viewmodel.dart';
import 'package:flutter_advance_course/presentation/resources/asset_manager.dart';
import 'package:flutter_advance_course/presentation/resources/color_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel =
      LoginViewModel(null); // TODO: pass here login usecase

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p20),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            child: Form(
                child: Column(
              children: [
                SvgPicture.asset(ImageAssets.splashLogo),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                              labelText: AppStrings.username,
                              hintText: AppStrings.username,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.usernameError),
                        );
                      }),
                ),
                SizedBox(height: AppSize.s28),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: AppStrings.password,
                              hintText: AppStrings.password,
                              errorText: (snapshot.data ?? true)
                                  ? null
                                  : AppStrings.passwordError),
                        );
                      }),
                ),
              ],
            )),
            key: _formKey,
          ),
        ),
      ),
    );
  }
}
