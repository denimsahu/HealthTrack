import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:healthtrack/features/patient/presentation/bloc/patient_bloc.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {

  @override
  void initState() {
    context.read<PatientBloc>().add(LoadPatientsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patients"),),
      body: Center(
        child: BlocBuilder<PatientBloc, PatientState>(
          builder: (context,state){
            if(state is LoadingPatientState){
              return CircularProgressIndicator();
            }
            else if (state is ErrorPatientState){
              return Text(state.error);
            }
            else if (state is PatientLoadedState) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                vertical:MediaQuery.of(context).size.height * 0.01),
                itemCount: state.patients.length,
                itemBuilder: (context, int index) {
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
                                onTap: () {
                                  Navigator.pushNamed(context, "/diagnosis_list_screen",arguments:index);
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
                                        "assets/PatientFeedback.json"),
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  'Patient Name : ${state.patients[index].name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                    'Note: ${state.patients[index].notes}'),
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
              });
            }
            else{
              return Text("No Patients Record Found");
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: (){
        Navigator.pushNamed(context, "/add_patient_screen");
      }, 
      child: Text("Add Patient")),
    );
  }
}