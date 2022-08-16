import 'package:flutter/cupertino.dart';
import 'package:medic/views/listBandsView.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
 'usuarios': (_) => Bands()
};