import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sahayatri/features/favourites/presentation/view_model/add_favourite_view_model.dart';
import 'package:sahayatri/features/map/presentation/vehicleDetails.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/presentation/view_model/vehicle_view_model.dart';

class VehicleView extends ConsumerStatefulWidget {
  const VehicleView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleViewState();
}

class _VehicleViewState extends ConsumerState<VehicleView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehicleViewModelProvider);
    // final add = ref.read(favouriteViewModelProvider.notifier);

    final List<VehicleEntity> filteredVehicles =
        state.vehicles.where((vehicle) {
      final searchTerm = _searchController.text.toLowerCase();
      return vehicle.vehicleName.toLowerCase().contains(searchTerm) ||
          vehicle.from.toLowerCase().contains(searchTerm) ||
          vehicle.to.toLowerCase().contains(searchTerm);
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
        title: const Text('Vehicle List'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (_scrollController.position.extentAfter == 0) {
                    ref
                        .read(vehicleViewModelProvider.notifier)
                        .getAllVehicles();
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                color: Colors.green,
                backgroundColor: Colors.amberAccent,
                onRefresh: () async {
                  ref.read(vehicleViewModelProvider.notifier).resetState();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  controller: _scrollController,
                  itemCount: filteredVehicles.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final vehicle = filteredVehicles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VehicleDetailsPage(
                              vehicleName: vehicle.vehicleName,
                              origin: vehicle.from,
                              destination: vehicle.to,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(15),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child:
                                Icon(Icons.directions_bus, color: Colors.white),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vehicle.vehicleName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.favorite),
                                color:
                                    Colors.red, // Customize the color as needed
                                onPressed: () {
                                  FavouriteEntity favourite = FavouriteEntity(
                                    vehicleId: vehicle.vehicleId!,
                                  );
                                  ref.read(favouriteViewModelProvider.notifier)
                                      .addFavourite(favourite);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Added to Favorites'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('From: ${vehicle.from}'),
                              Text('To: ${vehicle.to}'),
                            ],
                          ),
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
