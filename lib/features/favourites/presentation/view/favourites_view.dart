import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/favourites/presentation/view_model/get_favourite_view_model.dart';

class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends ConsumerState<FavouritesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getFavouriteViewModelProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (_scrollController.position.extentAfter == 0) {
                    ref
                        .read(getFavouriteViewModelProvider.notifier)
                        .getFavourite();
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                color: Colors.green,
                backgroundColor: Colors.amberAccent,
                onRefresh: () async {
                  ref.read(getFavouriteViewModelProvider.notifier).resetState();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  controller: _scrollController,
                  itemCount: state.favourites.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final notification = state.favourites[index];
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
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Add logic to delete the item here
                            // Call the delete method from the view model
                            ref
                                .read(getFavouriteViewModelProvider.notifier)
                                .deleteFavourite(notification);
                          },
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
