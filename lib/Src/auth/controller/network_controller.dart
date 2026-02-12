import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/widgets/custom_snackbar.dart';

class NetworkController extends GetxController {
  var isOffline = false.obs;
  var downloadSpeed = '0 KB/s'.obs;
  final double lowSpeedThreshold = 100.0;

  Timer? _timer;
  bool checkNetworkStatus = true;

  @override
  void onInit() {
    super.onInit();
    // Initial check
    _checkConnectivity();

    // Set up periodic timer to check connectivity every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _checkConnectivity();
    });

    // Timer.periodic(Duration(seconds: 30), (timer) {
    //   _checkDownloadSpeed();
    // });
  }

  // Function to check network connectivity
  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    isOffline.value = connectivityResult == ConnectivityResult.none;

    if (Get.find<NetworkController>().isOffline.value && checkNetworkStatus) {
      checkNetworkStatus = false;
      //customSnackBar('You are offline.'.tr);
    } else if (!(Get.find<NetworkController>().isOffline.value) &&
        !checkNetworkStatus) {
      checkNetworkStatus = true;
      //customSnackBar('You are online.'.tr, isError: false);
    }
  }

  // Function to check download speed
  Future<void> _checkDownloadSpeed() async {
    if (isOffline.value) return;

    const url =
        'https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_92x30dp.png'; // A small image to test download speed

    try {
      final startTime = DateTime.now().millisecondsSinceEpoch;
      final response = await http.get(Uri.parse(url));
      final endTime = DateTime.now().millisecondsSinceEpoch;

      if (response.statusCode == 200) {
        final downloadTime = endTime - startTime;
        final fileSizeInBytes = response.contentLength ?? 0;
        final downloadSpeedInBytesPerSecond =
            fileSizeInBytes / (downloadTime / 1000); // bytes per second
        final downloadSpeedInKBPerSecond =
            downloadSpeedInBytesPerSecond / 1024; // Convert to KB/s

        downloadSpeed.value =
            '${downloadSpeedInKBPerSecond.toStringAsFixed(2)} KB/s';

        // Check if the download speed is below the threshold
        if (downloadSpeedInKBPerSecond < lowSpeedThreshold) {
          // Show an alert for low download speed
          customSnackBar('Low Network Speed');
        }
      } else {
        downloadSpeed.value = 'Error';
      }
    } catch (e) {
      downloadSpeed.value = 'Error';
      print('Error checking download speed: $e');
    }
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _timer?.cancel();
    super.onClose();
  }
}
