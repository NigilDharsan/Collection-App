import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../CollectionReports/model/AreaModel.dart';
import '../../Dashboard/controller/Collection_Dashboard_Controller.dart';
import '../model/CityModel.dart';
import '../model/CountryModel.dart';
import '../model/StateModel.dart';
import '../repo/Customer_Join_repo.dart';


class CustomerJoinController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final CustomerJoinRepo customerJoinRepo;

  CustomerJoinController({required this.customerJoinRepo});

  // Form controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();

  // Models
  CountryModel? countryModel;
  StateModel? stateModel;
  CityModel? cityModel;
  AreaModel? areaModel;

  // Selected values
  int? selectedCountryId;
  int? selectedStateId;
  int? selectedCityId;
  int? selectedAreaId;
  DateTime? selectedDOB;

  // Dropdown lists
  List<CountryData> get countryList => countryModel?.data ?? [];
  List<StateData> get stateList => stateModel?.data ?? [];
  List<CityData> get cityList => cityModel?.data ?? [];
  List<AreaData> get areaList => areaModel?.data ?? [];

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    line1Controller.dispose();
    line2Controller.dispose();
    mobileController.dispose();
    emailController.dispose();
    pincodeController.dispose();
    dobController.dispose();
    super.onClose();
  }

  // Load all initial data
  Future<void> loadInitialData() async {
    _isLoading = true;
    update();
    try {
      // Load countries first
      await loadCountries();
      await Future.wait([
        loadStates(),
        loadCities(),
        loadAreas(),
      ]);
      await Future.delayed(const Duration(milliseconds: 100));
      setDefaults();
    } catch (e) {
      print('Error loading initial data: $e');
      Get.snackbar(
        'Error',
        'Failed to load form data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    _isLoading = false;
    update();
  }

  // Set default values
  void setDefaults() {
    bool updated = false;

    if (countryList.isNotEmpty && selectedCountryId == null) {
      selectedCountryId = countryList.first.idCountry;
      updated = true;
      print('Default country set: $selectedCountryId');
    }

    if (stateList.isNotEmpty && selectedStateId == null) {
      // Find first state that matches selected country
      final matchingState = stateList
          .firstWhereOrNull((state) => state.country == selectedCountryId);
      if (matchingState != null) {
        selectedStateId = matchingState.idState;
        updated = true;
        print('Default state set: $selectedStateId');
      }
    }

    if (cityList.isNotEmpty && selectedCityId == null) {
      // Find first city that matches selected state
      final matchingCity =
          cityList.firstWhereOrNull((city) => city.state == selectedStateId);
      if (matchingCity != null) {
        selectedCityId = matchingCity.idCity;
        updated = true;
        print('Default city set: $selectedCityId');
      }
    }

    if (areaList.isNotEmpty && selectedAreaId == null) {
      selectedAreaId = areaList.first.areaId;
      updated = true;
      print('Default area set: $selectedAreaId');
    }

    if (updated) {
      update();
    }
  }

  // Load countries
  Future<void> loadCountries() async {
    try {
      Response? response = await customerJoinRepo.getCountryList();
      if (response != null && response.statusCode == 200) {
        if (response.body is Map<String, dynamic>) {
          countryModel = CountryModel.fromJson(response.body);
          print('Countries loaded: ${countryList.length}');
        } else {
          print('Invalid country response format');
        }
      }
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  // Load states
  Future<void> loadStates([int? countryId]) async {
    if (countryId != null) {
      selectedCountryId = countryId;
      selectedStateId = null;
      selectedCityId = null;
      selectedAreaId = null;
    }

    try {
      Response? response = await customerJoinRepo.getStateList();
      if (response != null && response.statusCode == 200) {
        if (response.body is Map<String, dynamic>) {
          stateModel = StateModel.fromJson(response.body);
          print('States loaded: ${stateList.length}');

          // Set default state after loading if country is selected
          if (countryId != null && stateList.isNotEmpty) {
            final matchingState = stateList.firstWhereOrNull(
                (state) => state.country == selectedCountryId);
            if (matchingState != null) {
              selectedStateId = matchingState.idState;
            }
          }
        } else {
          print('Invalid state response format');
        }
      }
    } catch (e) {
      print('Error loading states: $e');
    }
    update();
  }

  // Load cities
  Future<void> loadCities([int? stateId]) async {
    if (stateId != null) {
      selectedStateId = stateId;
      selectedCityId = null;
      selectedAreaId = null;
    }

    try {
      Response? response = await customerJoinRepo.getCityList();
      if (response != null && response.statusCode == 200) {
        if (response.body is Map<String, dynamic>) {
          cityModel = CityModel.fromJson(response.body);
          print('Cities loaded: ${cityList.length}');

          // Set default city after loading if state is selected
          if (stateId != null && cityList.isNotEmpty) {
            final matchingCity = cityList
                .firstWhereOrNull((city) => city.state == selectedStateId);
            if (matchingCity != null) {
              selectedCityId = matchingCity.idCity;
            }
          }
        } else {
          print('Invalid city response format');
        }
      }
    } catch (e) {
      print('Error loading cities: $e');
    }
    update();
  }

  // Load areas
  Future<void> loadAreas() async {
    try {
      Response? response = await customerJoinRepo.getAreaList();
      if (response != null && response.statusCode == 200) {
        if (response.body is Map<String, dynamic>) {
          areaModel = AreaModel.fromJson(response.body);
          print('Areas loaded from Map: ${areaList.length}');
        } else if (response.body is List) {
          areaModel = AreaModel.fromJson({'data': response.body});
          print('Areas loaded from List: ${areaList.length}');
        } else {
          print('Invalid area response format: ${response.body.runtimeType}');
        }
      }
    } catch (e) {
      print('Error loading areas: $e');
    }
    update();
  }

  void selectCity(int cityId) {
    selectedCityId = cityId;
    print('City selected: $cityId');
    update();
  }

  void selectArea(int areaId) {
    selectedAreaId = areaId;
    print('Area selected: $areaId');
    update();
  }

  void selectDOB(DateTime date) {
    selectedDOB = date;
    dobController.text = "${date.day}/${date.month}/${date.year}";
    update();
  }

  Future<void> createCustomer() async {
    if (!_validateForm()) return;
    _isLoading = true;
    update();

    final String? formattedDob = selectedDOB != null
        ? DateFormat('yyyy-MM-dd').format(selectedDOB!)
        : null;

    final body = {
      "firstname": firstNameController.text.trim(),
      "lastname": lastNameController.text.trim(),
      "mobile": mobileController.text.trim(),
      "email": emailController.text.trim(),
      "date_of_birth": formattedDob,
      "country": selectedCountryId,
      "state": selectedStateId,
      "city": selectedCityId,
      "area": selectedAreaId,
      "pincode": pincodeController.text.trim(),
      "line1": line1Controller.text.trim(),
      "line2": line2Controller.text.trim(),
      "line3": null,
      "is_employee_wise_create": true
    };

    final Response? response = await customerJoinRepo.customerCreate(body);
    _isLoading = false;
    if (response != null && response.statusCode == 201) {
      Get.snackbar(
        'Success',
        'Customer created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      _clearForm();
      Get.find<CollectionDashboardController>().getCollectionDashboardCount();

      Get.offAllNamed('/collectionDashboard');
    } else {
      Get.snackbar(
        'Error',
        response?.body['message'] ?? 'Failed to create customer',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    update();
  }

  bool _validateForm() {
    if (firstNameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter first name');
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter last name');
      return false;
    }
    if (line1Controller.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter Address');
      return false;
    }

    if (mobileController.text.trim().isEmpty ||
        mobileController.text.length != 10) {
      Get.snackbar('Error', 'Please enter valid 10-digit mobile number');
      return false;
    }
    if (selectedDOB == null) {
      Get.snackbar('Error', 'Please select date of birth');
      return false;
    }
    if (selectedCountryId == null) {
      Get.snackbar('Error', 'Please select country');
      return false;
    }
    if (selectedStateId == null) {
      Get.snackbar('Error', 'Please select state');
      return false;
    }
    if (selectedCityId == null) {
      Get.snackbar('Error', 'Please select city');
      return false;
    }
    if (selectedAreaId == null) {
      Get.snackbar('Error', 'Please select area');
      return false;
    }
    if (pincodeController.text.trim().isEmpty ||
        pincodeController.text.length != 6) {
      Get.snackbar('Error', 'Please enter valid 6-digit pincode');
      return false;
    }
    return true;
  }

  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    line1Controller.clear();
    line2Controller.clear();
    mobileController.clear();
    emailController.clear();
    pincodeController.clear();
    dobController.clear();
    selectedDOB = null;
    setDefaults();
  }
}
