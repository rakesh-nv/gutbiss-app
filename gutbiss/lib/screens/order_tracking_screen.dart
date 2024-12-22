import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/order.dart';

class OrderTrackingScreen extends StatefulWidget {
  final Order order;

  const OrderTrackingScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late GoogleMapController _mapController;
  bool _isMapReady = false;

  // Sample delivery agent location (replace with real-time data)
  // final LatLng _driverLocation = const LatLng(37.7749, -122.4194);
  // final LatLng _restaurantLocation = const LatLng(37.7748, -122.4192);
  // final LatLng _deliveryLocation = const LatLng(37.7750, -122.4196);

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    _markers = {
      Marker(
        markerId: const MarkerId('driver'),
        //position: _driverLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Driver'),
      ),
      Marker(
        markerId: const MarkerId('restaurant'),
        //position: _restaurantLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: widget.order.restaurantName),
      ),
      Marker(
        markerId: const MarkerId('delivery'),
        //position: _deliveryLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Delivery Location'),
      ),
    };

    // _polylines = {
    //   Polyline(
    //     polylineId: const PolylineId('route'),
    //     color: Colors.blue,
    //     width: 5,
    //     points: [
    //       _restaurantLocation,
    //       _driverLocation,
    //       _deliveryLocation,
    //     ],
    //   ),
    // };
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _isMapReady = true;
    });
   // _fitBounds();
  }

  // void _fitBounds() {
  //   if (!_isMapReady) return;
  //   final bounds = LatLngBounds(
  //     southwest: LatLng(
  //       [_driverLocation.latitude, _restaurantLocation.latitude, _deliveryLocation.latitude].reduce((a, b) => a < b ? a : b),
  //       [_driverLocation.longitude, _restaurantLocation.longitude, _deliveryLocation.longitude].reduce((a, b) => a < b ? a : b),
  //     ),
  //     northeast: LatLng(
  //       [_driverLocation.latitude, _restaurantLocation.latitude, _deliveryLocation.latitude].reduce((a, b) => a > b ? a : b),
  //       [_driverLocation.longitude, _restaurantLocation.longitude, _deliveryLocation.longitude].reduce((a, b) => a > b ? a : b),
  //     ),
  //   );
  //
  //   _mapController.animateCamera(
  //     CameraUpdate.newLatLngBounds(bounds, 100),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),
      body: Column(
        children: [
          // Map View
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            // child: GoogleMap(
            //   onMapCreated: _onMapCreated,
            //   initialCameraPosition: CameraPosition(
            //     target: _driverLocation,
            //     zoom: 15,
            //   ),
            //   markers: _markers,
            //   polylines: _polylines,
            //   myLocationEnabled: true,
            //   myLocationButtonEnabled: true,
            // ),
          ),

          // Order Status
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Estimated Time
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.deepOrange.shade50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Estimated Delivery Time',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${DateTime.now().add(const Duration(minutes: 30)).hour}:${DateTime.now().add(const Duration(minutes: 30)).minute}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Driver Info (if available)
                  if (widget.order.driverName != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.order.driverName!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text('Your Delivery Partner'),
                              ],
                            ),
                          ),
                          if (widget.order.driverPhone != null)
                            IconButton(
                              onPressed: () {
                                
                              },
                              icon: const Icon(Icons.phone),
                              color: Colors.deepOrange,
                            ),
                        ],
                      ),
                    ),

                  // Order Details
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('Order #${widget.order.id}'),
                        const SizedBox(height: 8),
                        Text(
                          widget.order.restaurantName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Delivery Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(widget.order.address.address),
                        Text(widget.order.address.details),
                      ],
                    ),
                  ),

                  // Cancel Button (if order is not yet being prepared)
                  if (widget.order.status == OrderStatus.placed ||
                      widget.order.status == OrderStatus.confirmed)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: OutlinedButton(
                        onPressed: () {
                          _showCancelConfirmation();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text('Cancel Order'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure you want to cancel this order? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No, Keep Order'),
          ),
          TextButton(
            onPressed: () {
            
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Yes, Cancel Order'),
          ),
        ],
      ),
    );
  }
} 