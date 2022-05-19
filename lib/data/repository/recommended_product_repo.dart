
import 'package:fooddelivery/data/api/api_client.dart';
import 'package:fooddelivery/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommmendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommmendedProductRepo({required this.apiClient});
  Future<Response>getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMENDED_PRODUCT_URI);
  }
}