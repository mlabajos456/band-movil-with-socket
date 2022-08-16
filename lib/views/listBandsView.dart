import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic/controllers/bandsController.dart';
import 'package:medic/controllers/socketController.dart';
import 'package:medic/models/band.dart';
import 'package:pie_chart/pie_chart.dart';

class Bands extends StatelessWidget {
  final BandsController bandCon = Get.put(BandsController());
  Bands({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<Socket>(
        init: Socket(),
        builder: (_) {
          return Scaffold(
            floatingActionButton: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                bandCon.addBand(Banda(name: 'Control', votes:0));
              },
            ),
            body: Column(
              children: [
               _.bandmai.isNotEmpty ? _showGraph(_) : const Text('Cargando Pie'),
             /*    !_.cargando.value
                    ? const Center(
                        child: Text('Loading'),
                      )
                    :  */
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: _.bandmai.length,
                            itemBuilder: (context, index) {
                              var band = _.bandmai[index];
                              return Dismissible(
                                key: Key(band.id.toString()),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (data) {
                                  _.emit('delete-band', band.id);
                                },
                                child: ListTile(
                                  title: Text(band.name),
                                  leading: Text(band.votes.toString()),
                                  onTap: () {
                                    _.emit('vote-band', band.id);
                                  },
                                ),
                              );
                            },
                          ),
                      ),
                    ),
              ],
            ),
          );
        });
  }
}

Widget _showGraph(Socket _) {
  Map<String, double> dataMap = new Map();
  _.bandmai.forEach((band) {
    dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
  });
  return Container(
    width: double.infinity,
    height: 200,
    child: PieChart(
      dataMap: dataMap,
    ),
  );
}
