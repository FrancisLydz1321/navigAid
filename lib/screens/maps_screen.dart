import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:navigaid/app_colors.dart';
import 'package:navigaid/screens/select_an_option_screen.dart';
import 'package:navigaid/widgets/card_widget.dart';
import 'package:navigaid/widgets/custom_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

enum ButtonType {
  start('Start'),
  mic('Mic'),
  cancel('Cancel'),
  end('End'),
  exit('Exit');

  final String rawValue;

  const ButtonType(this.rawValue);
}

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  ButtonType buttonTitle = ButtonType.start;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'For Blind Option'),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Position>(
              future: _determinePosition(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Scaffold(
                    body: Center(
                      child: Text(
                        'Error fetching location...\nPlease try again later.',
                      ),
                    ),
                  );
                }

                //? for the documentation of Flutter Map - https://docs.fleaflet.dev/
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: FlutterMap(
                        options: MapOptions(
                          onTap: (tapPosition, point) {
                            switch (buttonTitle) {
                              case ButtonType.mic:
                                setState(() => buttonTitle = ButtonType.cancel);
                                break;
                              case ButtonType.cancel:
                                setState(() => buttonTitle = ButtonType.end);
                                break;
                              case ButtonType.end:
                                setState(() => buttonTitle = ButtonType.exit);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      alignment: const Alignment(0, -0.5),
                                      backgroundColor: AppColors.red.withOpacity(0.5),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 4,
                                        ),
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      child: SizedBox(
                                        height: 500,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'DESTINATION ARRIVED!',
                                              style: TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/images/fireworks.png'),
                                                Image.asset('assets/images/fireworks.png'),
                                                Image.asset('assets/images/fireworks.png'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                break;
                              default:
                            }
                          },
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom | InteractiveFlag.flingAnimation | InteractiveFlag.drag,
                          ),
                          initialCenter: LatLng(snapshot.data?.latitude ?? 51.509364, snapshot.data?.longitude ?? -0.128928),
                          initialZoom: 18,
                          minZoom: 16,
                          maxZoom: 18,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                              ),
                            ],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                child: const Icon(
                                  Icons.location_history,
                                  size: 40,
                                ),
                                point: LatLng(snapshot.data?.latitude ?? 51.509364, snapshot.data?.longitude ?? -0.128928),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 127,
                    child: CardWidget(
                      title: buttonTitle == ButtonType.exit ? 'HOME' : buttonTitle.rawValue,
                      customTitle: buttonTitle == ButtonType.mic ? Image.asset('assets/images/el_mic.png') : null,
                      backgroundColor: AppColors.red,
                      fontSize: 18,
                      fontColor: AppColors.white,
                      onTap: () {
                        switch (buttonTitle) {
                          case ButtonType.start:
                            setState(() => buttonTitle = ButtonType.mic);
                            break;
                          case ButtonType.mic:
                            setState(() => buttonTitle = ButtonType.cancel);
                            break;
                          case ButtonType.cancel:
                            setState(() => buttonTitle = ButtonType.start);
                            break;
                          case ButtonType.exit:
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const SelectAnOptionScreen()),
                              ModalRoute.withName('/'),
                            );
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 127,
                    child: CardWidget(
                      title: buttonTitle == ButtonType.exit ? 'AGAIN' : 'Remind Destination',
                      backgroundColor: AppColors.red,
                      fontSize: 18,
                      fontColor: AppColors.white,
                      onTap: buttonTitle == ButtonType.exit ? () => Navigator.pop(context) : null,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
