import 'package:covid_19_app/View/worldStatesRecords.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReuseableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                      ReuseableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReuseableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReuseableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(
                          title: 'TodayRecoverd',
                          value: widget.todayRecovered.toString()),
                      ReuseableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReuseableRow(
                          title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
