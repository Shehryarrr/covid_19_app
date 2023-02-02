// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:covid_19_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:covid_19_app/Model/WorldStatesModel.dart';
import 'package:covid_19_app/Services/states_services.dart';

class WorldStatesRecords extends StatefulWidget {
  const WorldStatesRecords({super.key});

  @override
  State<WorldStatesRecords> createState() => _WorldStatesRecordsState();
}

class _WorldStatesRecordsState extends State<WorldStatesRecords>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01),
            FutureBuilder(
              future: statesServices.fetchWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total':
                              double.parse(snapshot.data!.cases!.toString()),
                          'Recoverd': double.parse(
                              snapshot.data!.recovered!.toString()),
                          'Deaths':
                              double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        animationDuration: const Duration(microseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .05),
                        child: Card(
                          child: Column(children: [
                            ReuseableRow(
                              title: 'Total',
                              value: snapshot.data!.cases.toString(),
                            ),
                            ReuseableRow(
                              title: 'Deaths',
                              value: snapshot.data!.deaths.toString(),
                            ),
                            ReuseableRow(
                              title: 'Recoverd',
                              value: snapshot.data!.recovered.toString(),
                            ),
                            ReuseableRow(
                              title: 'Active',
                              value: snapshot.data!.active.toString(),
                            ),
                            ReuseableRow(
                              title: 'Critical',
                              value: snapshot.data!.critical.toString(),
                            ),
                            ReuseableRow(
                              title: 'Today Deaths',
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                            ReuseableRow(
                              title: 'Today Recoverd',
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                          ]),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CountriesList()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
