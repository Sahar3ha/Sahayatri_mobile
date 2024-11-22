import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahayatri/features/feedback/domain/entity/feedback_entity.dart';
import 'package:sahayatri/features/feedback/presentation/view_model/feedback_view_model.dart';
import 'package:sahayatri/features/vehicles/domain/entity/vehicle_entity.dart';
import 'package:sahayatri/features/vehicles/presentation/view_model/vehicle_view_model.dart';

class FeedbackView extends ConsumerStatefulWidget {
  const FeedbackView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends ConsumerState<FeedbackView> {
  VehicleEntity? selectedVehicle;
  final _key = GlobalKey<FormState>();

  final review = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vehicleState = ref.watch(vehicleViewModelProvider);

    if (vehicleState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final vehicles = vehicleState.vehicles;

    if (vehicles.isEmpty) {
      return const Center(child: Text('No vehicles available'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: const Color.fromARGB(255, 112, 255, 136),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Vehicle:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<VehicleEntity>(
                hint: const Text('Select Vehicle'),
                value: selectedVehicle,
                onChanged: (VehicleEntity? newValue) {
                  setState(() {
                    selectedVehicle = newValue;
                  });
                },
                items: vehicles.map((vehicle) {
                  return DropdownMenuItem<VehicleEntity>(
                    value: vehicle,
                    child: Text(vehicle.vehicleName),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a vehicle';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Write your review:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: review,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your review';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Type your review here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    FeedbackEntity feedback = FeedbackEntity(
                        feedback: review.text,
                        vehicleId: selectedVehicle!.vehicleId);
                    if (_key.currentState!.validate()) {
                      ref
                          .read(feedbackViewModelProvider.notifier)
                          .addFeedback(feedback);
                    }
                  },
                  child: const Text('Submit Review'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
