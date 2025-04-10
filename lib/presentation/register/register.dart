import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_course/data/mapper/mapper.dart';
import 'package:flutter_advance_course/presentation/register/register_viewmodel.dart';
import 'package:flutter_advance_course/presentation/resources/color_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/di.dart';
import '../common/state_renderfer/state_renderfer_impl.dart';
import '../resources/asset_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  ImagePicker picker = instance<ImagePicker>();
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
    return Container(
      padding: EdgeInsets.only(top: AppPadding.p60),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          child: Form(
              child: Column(
            children: [
              Image(image: AssetImage(ImageAssets.splashLogo)),
              SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            labelText: AppStrings.username,
                            hintText: AppStrings.username,
                            errorText: snapshot.data,
                          ));
                    }),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                      bottom: AppPadding.p28),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country) {
                              // update view model with the selected code
                              _viewModel
                                  .setCountryCode(country.dialCode ?? EMPTYSTR);
                            },
                            initialSelection: "+33",
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            favorite: ["+966", "+02", "+39"],
                          )),
                      Expanded(
                        flex: 3,
                        child: StreamBuilder<String?>(
                            stream: _viewModel.outputErrorMobileNumber,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileNumberController,
                                  decoration: InputDecoration(
                                    labelText: AppStrings.mobileNumber,
                                    hintText: AppStrings.mobileNumber,
                                    errorText: snapshot.data,
                                  ));
                            }),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmail,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: AppStrings.emailHint,
                            hintText: AppStrings.emailHint,
                            errorText: snapshot.data,
                          ));
                    }),
              ),
              SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outputPasswordValid,
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
              SizedBox(height: AppSize.s28),
              Padding(
                padding: EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey)),
                  child: GestureDetector(
                    child: _getMediaWidget(),
                    onTap: () {
                      /*_showPicker(context)*/
                    },
                  ),
                ),
              ),
              SizedBox(height: AppSize.s28),
              Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              // if snapshot.data
                              // true => login
                              // false => null
                              // null => false => null
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: Text(AppStrings.login)),
                        );
                      })),
              Padding(
                padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.end,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.end,
                        )),
                  ],
                ),
              )
            ],
          )),
          key: _formKey,
        ),
      ),
    );
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(AppStrings.profilePicture),
          ),
          Flexible(
              child: StreamBuilder<File?>(
                  stream: _viewModel.outputProfilePicture,
                  builder: (context, snapshot) {
                    return _imagePickedByUser(snapshot.data);
                  })),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePickedByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                leading: Icon(Icons.camera_alt_outlined),
                title: Text(AppStrings.photoCamera),
                onTap: () {
                  _imageFormCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFormGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? EMPTYSTR));
  }

  _imageFormCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? EMPTYSTR));
  }
}
