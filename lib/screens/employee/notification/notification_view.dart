import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/notification_response.dart';
import 'package:reimburse_rb/screens/employee/notification/notification_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/employee/card_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationViewModel>(
      create: (_) => NotificationViewModel(context: context),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NotificationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Notifikasi',
        isHasCustomLeading: false,
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: viewModel.listNotification.isEmpty
            ? const Column(
                children: [
                  Spacer(),
                  EmptyStateGeneral(),
                  Spacer(),
                ],
              )
            : ListView(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 24,
                      left: 24,
                      right: 24,
                      bottom: 32,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewModel.listNotification.length,
                    itemBuilder: (context, index) {
                      ItemNotificationData item = viewModel.listNotification[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: CardNotification(
                          notificationData: item,
                        ),
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
