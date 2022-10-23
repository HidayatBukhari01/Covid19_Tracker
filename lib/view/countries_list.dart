import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/view/details_countries.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff003cbe),
        ),
        backgroundColor: const Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  //style: TextStyle(color: Colors.white),
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.blue,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: 'Search Country',
                    suffixIcon: Icon(Icons.search),
                    suffixIconColor: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: statsServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.blue.shade700,
                                highlightColor: Colors.blue.shade300,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 20,
                                        width: 89,
                                        color: Colors.blue,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.blue,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsCountries(
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                      todayRecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                    )));
                                      },
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]['country'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          snapshot.data![index]['cases']
                                              .toString(),
                                        ),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsCountries(
                                                      name:
                                                          snapshot.data![index]
                                                              ['country'],
                                                      image: snapshot
                                                                  .data![index]
                                                              ['countryInfo']
                                                          ['flag'],
                                                      totalCases:
                                                          snapshot.data![index]
                                                              ['cases'],
                                                      totalDeaths:
                                                          snapshot.data![index]
                                                              ['deaths'],
                                                      totalRecovered:
                                                          snapshot.data![index]
                                                              ['recovered'],
                                                      critical:
                                                          snapshot.data![index]
                                                              ['critical'],
                                                      todayRecovered: snapshot
                                                              .data![index]
                                                          ['todayRecovered'],
                                                      active:
                                                          snapshot.data![index]
                                                              ['active'],
                                                      test:
                                                          snapshot.data![index]
                                                              ['tests'],
                                                    )));
                                        setState(() {});
                                      },
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]['country'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          snapshot.data![index]['cases']
                                              .toString(),
                                        ),
                                        leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
