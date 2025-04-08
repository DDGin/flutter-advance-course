import 'package:flutter/material.dart';
import 'package:flutter_advance_course/presentation/register/register_viewmodel.dart';
import 'package:flutter_advance_course/presentation/resources/color_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';

import '../../app/di.dart';
import '../common/state_renderfer/state_renderfer_impl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setUserName(_passwordController.text));
    _emailController
        .addListener(() => _viewModel.setUserName(_emailController.text));
    _mobileNumberController.addListener(
        () => _viewModel.setUserName(_mobileNumberController.text));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context: context,
                    contentScreenWidget: _getContentWidget(),
                    retryActionFunction: () {
                      _viewModel.register();
                    },
                    resetFlowState: _viewModel.resetFlowState) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Container();
  }
}
