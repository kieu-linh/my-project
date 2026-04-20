import 'package:my_project/base/base_view_model.dart';
import 'package:my_project/components/common/error.dart';
import 'package:my_project/components/common/loading.dart';
import 'package:my_project/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

mixin BasePage<T extends BaseViewModel> {
  late T _provider;

  T get provider => _provider;

  @protected
  T create();

  @protected
  void initialise(BuildContext context);

  Widget builder(Widget Function() builder) => ChangeNotifierProvider<T>(
        create: (context) {
          _provider = create();

          _provider.onShowError = (message) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red));
            }
          };

          _provider.onShowNotification = (message) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message), backgroundColor: Colors.green));
            }
          };

          _provider.onLogOut = () {
            _provider.prefs.removeAll();
            AppRouter.goLogin(context);
          };

          initialise(context);

          return _provider;
        },
        child: Consumer<T>(
          builder: (context, provider, _) {
            _provider = provider;

            if (provider.isloading) {
              return Stack(
                children: [
                  builder.call(),
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }

            state() {
              switch (provider.state) {
                case ChangeState.blank:
                  return const Scaffold();
                case ChangeState.loading:
                  return const LoadingWidget();
                case ChangeState.serverError:
                  return const ServerErrorWidget();
                case ChangeState.page:
                case ChangeState.clone:
                default:
                  return builder.call();
              }
            }

            return VisibilityDetector(
              onVisibilityChanged: (info) {
                if (info.visibleFraction >= 1) {
                  try {
                    _provider.appear();
                  } catch (_) {}
                }
              },
              key: Key(T.toString()),
              child: GestureDetector(
                child: state(),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            );
          },
        ),
      );
}
