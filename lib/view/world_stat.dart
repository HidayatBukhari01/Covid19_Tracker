import 'package:covid_tracker/Models/world_stats_model.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStat extends StatefulWidget {
  const WorldStat({super.key});

  @override
  State<WorldStat> createState() => _WorldStatState();
}

class _WorldStatState extends State<WorldStat> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff003cbe),
    const Color(0xff05cafb),
    const Color(0xfffe5b4c),
    const Color(0xff00ff00),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                  future: statsServices.fetchWorldStatsRecords(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Color.fromARGB(255, 2, 0, 135),
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          const Text(
                            'Covid-19 Global Cases',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                          PieChart(
                            ringStrokeWidth: 35.0,
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                            ),
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString()),
                              "Active Cases": double.parse(
                                  snapshot.data!.active!.toString()),
                            },
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius:
                                MediaQuery.of(context).size.width / 2.2,
                            legendOptions: const LegendOptions(
                              legendShape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff003cbe),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                        elevation: 5.0,
                                        shadowColor: Color(0xff05cafb),
                                        child: ReusableCard(
                                            color: const Color(0xff05cafb),
                                            title: 'Recovered',
                                            value: snapshot.data!.recovered
                                                .toString())),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                        elevation: 5.0,
                                        shadowColor: Color(0xfffe5b4c),
                                        child: ReusableCard(
                                            color: Color(0xfffe5b4c),
                                            title: 'Death',
                                            value: snapshot.data!.deaths!
                                                .toString())),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                        elevation: 5.0,
                                        shadowColor: Color(0xff003cbe),
                                        child: ReusableCard(
                                            color: Color(0xff003cbe),
                                            title: 'Critical',
                                            value: snapshot.data!.critical!
                                                .toString())),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Card(
                                        elevation: 5.0,
                                        shadowColor: Colors.green,
                                        child: ReusableCard(
                                            color: Colors.green,
                                            title: 'Active Cases',
                                            value: snapshot.data!.active!
                                                .toString())),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: const [
                              //     Image(
                              //       image: AssetImage('images/world.png'),
                              //       //alignment: Alignment.center,
                              //       height: 150,
                              //       width: 360,
                              //       fit: BoxFit.cover,
                              //       color: Color.fromARGB(255, 170, 235, 251),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  final Color color;
  String title, value;
  ReusableCard(
      {Key? key,
      this.color = const Color(0xffffffff),
      required this.title,
      required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: color,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(title),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
