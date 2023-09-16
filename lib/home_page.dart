import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/next_page.dart';

import 'blocs/area_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AreaBloc areaBloc = AreaBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    areaBloc.add(AreaLoadedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer(
            bloc: areaBloc,
            listenWhen: (p, c) => c is AreaActionState,
            buildWhen: (p, c) => c is! AreaActionState,
            listener: (context, state) {
              // TODO: implement listener
              if (state is NavigateNextPage) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NextPage(),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AreaInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AreaLoadedState) {
                return Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        shrinkWrap: true,
                        itemCount: state.areaData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: state.clickIndexByArea == index ? Colors.blue : Colors.green),
                                  onPressed: () {
                                    areaBloc.add(AreaClickEvent(state.areaData[index], index));
                                  },
                                  child: Text(state.areaData[index]),
                                ),
                              ),

                              // Expanded(child: Text(state.areaData[index])),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: state.allData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              areaBloc.add(AreaClickEvent(state.allData[index], index));
                            },
                            child: Card(
                                color: state.clickIndexByArea == index ? Colors.blue : Colors.grey,
                                child: Text(state.allData.isNotEmpty ? state.allData[index].toString() : 'empty')),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            areaBloc.add(NavigateToNextPageEvent());
                          },
                          child: Text('Next Page')),
                    )
                  ],
                );
              } else if (state is AreaErrorState) {
                return Container(
                  color: Colors.red,
                  child: Text('Error State'),
                );
              } else {
                return const Text('error');
              }
            },
          ),
        ],
      ),
    );
  }
}
