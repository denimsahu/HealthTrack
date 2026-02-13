part of 'diagnosis_bloc.dart';

@immutable
sealed class DiagnosisState {}

final class DiagnosisInitial extends DiagnosisState {}

class LoadingDiagnosisState extends DiagnosisState{}

class LoadedDiagnosisState extends DiagnosisState{
  List<Diagnosis> allDiagnosis;
  LoadedDiagnosisState({required this.allDiagnosis});
}

class EmptyDiagnosisState extends DiagnosisState{}

class ErrorDiagnosisState extends DiagnosisState{}

