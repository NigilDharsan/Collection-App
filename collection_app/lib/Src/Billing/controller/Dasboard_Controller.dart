import 'package:get/get.dart';

import '../../SchemeJoin/model/BranchModel.dart';
import '../repository/BillingRepo.dart';


class DashboardController extends GetxController implements GetxService {
  final BillingRepo billingRepo;

  DashboardController({required this.billingRepo});
  final RxString selectedEstimateBranchName = 'All Branches'.obs;
  final RxInt selectedEstimateBranchId = 0.obs;

  BranchModel? branchModel;


}
