import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/notifications/presentation/view_model/get_notification_view_model.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getFavouritesViewModelProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(getFavouritesViewModelProvider.notifier)
                  .clearNotifications();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (_scrollController.position.extentAfter == 0) {
                    ref
                        .read(getFavouritesViewModelProvider.notifier)
                        .getNotifications();
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                color: Colors.green,
                backgroundColor: Colors.amberAccent,
                onRefresh: () async {
                  ref
                      .read(getFavouritesViewModelProvider.notifier)
                      .resetState();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  controller: _scrollController,
                  itemCount: state.notifications.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.notifications, color: Colors.white),
                        ),
                        title: Text(
                          notification.vehicleId,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: const Text(
                          'is Offline',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (state.isLoading)
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.red),
            ),
        ],
      ),
    );
  }
}
