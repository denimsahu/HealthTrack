import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/diagnosis/presentation/bloc/diagnosis_bloc.dart';
import 'package:healthtrack/features/patient/presentation/widgets/custom_elevated_button.dart';
import 'package:lottie/lottie.dart';

class DiagnosisListScreen extends StatefulWidget {
  @override
  State<DiagnosisListScreen> createState() => _DiagnosisListScreenState();
}

class _DiagnosisListScreenState extends State<DiagnosisListScreen> {

  late int patientId;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      patientId = ModalRoute.of(context)!.settings.arguments as int;
      context.read<DiagnosisBloc>().add(GetAllDiagnosisEvent(patientId: patientId));
      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diagnosis"),),
      body: SafeArea(
        child: BlocConsumer<DiagnosisBloc, DiagnosisState>(
          listener: (context, state) {
            print(state);
          },
          builder: (context, state) {
            if (state is LoadingDiagnosisState){
              return Center(child: CircularProgressIndicator(),);
            }

            else if (state is EmptyDiagnosisState){
              return Center(child: Text("No Diagnosis to Show......"),);
            }

            else if (state is LoadedDiagnosisState){
              return ListView.builder(
                itemCount: state.allDiagnosis.length,
                padding: EdgeInsets.symmetric(
                vertical:MediaQuery.of(context).size.height * 0.01),
                itemBuilder: (context,index){
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width *0.01),
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(
                                          255, 255, 255, 255)),
                                  borderRadius:
                                      BorderRadius.circular(15)),
                              child: ListTile(
                                tileColor:state.allDiagnosis[index].analysis==0?Colors.redAccent:state.allDiagnosis[index].analysis==1?Colors.amberAccent:Colors.greenAccent,
                                onTap: () {
                                  Navigator.pushNamed(context, "/detail_diagnosis_screen",arguments:state.allDiagnosis[index]);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30)),
                                leading: Container(
                                  padding:
                                      EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 2.0,
                                              color: Colors
                                                  .grey.shade400))),
                                  child: CircleAvatar(
                                    child: Lottie.asset(
                                        "assets/Receipt.json"),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  'Analysis : ${state.allDiagnosis[index].analysis==0?"High Risk":state.allDiagnosis[index].analysis==1?"Need Attention":"Normal"}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                    'Diagnosis Added on : ${state.allDiagnosis[index].dateTime.day}-${state.allDiagnosis[index].dateTime.month}-${state.allDiagnosis[index].dateTime.year}'),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                            height:
                                MediaQuery.of(context).size.height *
                                    0.03,
                            thickness: 5,
                            indent:
                                MediaQuery.of(context).size.width *
                                    0.015,
                            endIndent:
                                MediaQuery.of(context).size.width *
                                    0.015,
                          ),
                        ],
                      ),
                  );
                },
                );
              }

            else if (state is ErrorDiagnosisState){
              return Center(child: Text("Some Error Occoured"),);
            }
            else{
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/add_diagnosis_screen",
              arguments: patientId,
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
