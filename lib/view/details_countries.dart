import 'package:covid_tracker/view/world_stat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailsCountries extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  const DetailsCountries(
      {super.key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.critical,
      required this.todayRecovered,
      required this.active,
      required this.test});

  @override
  State<DetailsCountries> createState() => _DetailsCountriesState();
}

class _DetailsCountriesState extends State<DetailsCountries> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff003cbe),
        appBar: AppBar(
          backgroundColor: Color(0xff003cbe),
          centerTitle: true,
          title: Text(widget.name),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          ReusableDetailsCard(
                              title: 'Cases',
                              value: widget.totalCases.toString()),
                          ReusableDetailsCard(
                              title: 'Active Cases',
                              value: widget.active.toString()),
                          ReusableDetailsCard(
                              title: 'Recovered',
                              value: widget.totalRecovered.toString()),
                          ReusableDetailsCard(
                              title: 'Deaths',
                              value: widget.totalDeaths.toString()),
                          ReusableDetailsCard(
                              title: 'Recovered Today',
                              value: widget.todayRecovered.toString()),
                          ReusableDetailsCard(
                              title: 'Crtical',
                              value: widget.critical.toString()),
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
        ),
      ),
    );
  }
}

class ReusableDetailsCard extends StatelessWidget {
  String title, value;
  ReusableDetailsCard({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
