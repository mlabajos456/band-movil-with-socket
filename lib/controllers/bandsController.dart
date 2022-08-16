import 'package:get/get.dart';
import 'package:medic/controllers/socketController.dart';
import 'package:medic/models/band.dart';

class BandsController extends GetxController {
   final Socket socketCon = Get.put(Socket());

  List<Banda> bands = [];
  @override
  void onInit() {
  /*   getBands(); */
  }

  addBand(Banda band) {
    print(band);
    socketCon.emit('add-band',{band.name});
  }
}
