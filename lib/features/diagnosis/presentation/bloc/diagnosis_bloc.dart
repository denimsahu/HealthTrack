import 'package:bloc/bloc.dart';
import 'package:healthtrack/features/diagnosis/data/diagnosis_repository.dart';
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';
import 'package:meta/meta.dart';

part 'diagnosis_event.dart';
part 'diagnosis_state.dart';

class DiagnosisBloc extends Bloc<DiagnosisEvent, DiagnosisState> {
  DiagnosisRepository diagnosisRepository;
  DiagnosisBloc({required this.diagnosisRepository}) : super(DiagnosisInitial()) {

    on<GetAllDiagnosisEvent>((event, emit) async {
      emit(LoadingDiagnosisState());
      List<Diagnosis> allDiagnosis;
      try{
        allDiagnosis = await diagnosisRepository.getAllDiagnosis(patientId:event.patientId);
        if (allDiagnosis.isEmpty){
          emit(EmptyDiagnosisState());
        }
        else{
          emit(LoadedDiagnosisState(allDiagnosis: allDiagnosis));
        }
      }
      catch(error){
        emit(ErrorDiagnosisState());
      }
    });

    on<AddDiagnosisEvent>((event, emit) async {
      await diagnosisRepository.addDiagnosis(patientId: event.patientId, imageAddress: event.imagePath);
      emit(DiagnosisAddedState());
    });
  }
}
