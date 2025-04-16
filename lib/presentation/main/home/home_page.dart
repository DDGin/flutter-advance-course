import 'package:flutter/material.dart';
import 'package:flutter_advance_course/app/di.dart';
import 'package:flutter_advance_course/presentation/common/state_renderfer/state_renderfer_impl.dart';
import 'package:flutter_advance_course/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_advance_course/presentation/resources/string_manager.dart';
import 'package:flutter_advance_course/presentation/resources/value_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data?.getScreenWidget(
                      context: context,
                      contentScreenWidget: _getContentWidget(),
                      retryActionFunction: () {
                        _viewModel.start();
                      },
                      resetFlowState: () {}) ??
                  Container();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getCarouselBanner(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores(),
      ],
    );
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
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _getCarouselBanner() {
    return Container();
  }

  Widget _getServices() {
    return Container();
  }

  Widget _getStores() {
    return Container();
  }
}
