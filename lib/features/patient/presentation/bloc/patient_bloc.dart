import 'package:bloc/bloc.dart';
import 'package:healthtrack/features/patient/data/models/patient.dart';
import 'package:healthtrack/features/patient/data/patient_repository.dart';
import 'package:meta/meta.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc(PatientRepository patientRepository) : super(PatientInitial()) {
    on<AddPatientEvent>((event, emit) async {
      emit(LoadingPatientState());
      try{
        await patientRepository.addPatient(name: event.name, age: event.age, contact: event.contact, gender: event.gender, notes: event.notes);
        emit(SuccessPatientAddedState());
      }
      catch(error){
        emit(ErrorPatientState(error: error.toString()));
      }
    });
    on<LoadPatientsEvent>((event, emit) async {
      emit(LoadingPatientState());
      try{
        List<Patient> patients = await patientRepository.getAllPatients();
        if(patients.isEmpty){
          emit(EmptyPatientState());
        }
        else{
          emit(PatientLoadedState(patients: patients));
        }
      }
      catch(error){
        emit(ErrorPatientState(error: error.toString()));
      }
    });
  }
}
