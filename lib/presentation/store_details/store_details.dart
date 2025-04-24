import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/di.dart';
import 'package:flutter_advance_course/domain/model/model.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:flutter_advance_course/presentation/resources/color_manager.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter_advance_course/presentation/store_details/store_details_viewmodel.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  _StoreDetailsViewState createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return Scaffold(
                  body: snapshot.data?.getScreenWidget(
                      context: context,
                      contentScreenWidget: _getContentWidget(),
                      retryActionFunction: () {},
                      resetFlowState: () {}),
                ) ??
                Container();
          }),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back)),
        title: Text(AppStrings.storeDetails),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: StreamBuilder<StoreDetails>(
              stream: _viewModel.outputStoreDetails,
              builder: (context, snapshot) {
                return _getItem(snapshot.data);
              }),
        ),
      ),
    );
  }

  Widget _getItem(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              storeDetails.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
          _getSection(AppStrings.details),
          _getInfoText(storeDetails.details),
          _getSection(AppStrings.services),
          _getInfoText(storeDetails.services),
          _getSection(AppStrings.about),
          _getInfoText(storeDetails.about)
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }

  Widget _getInfoText(String info) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p12),
      child: Text(
        info,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
