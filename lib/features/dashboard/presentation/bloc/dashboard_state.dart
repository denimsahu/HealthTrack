part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class LoadedDashboardState extends DashboardState{
  final Map<String,String> details;
  LoadedDashboardState({required this.details});
}

class LoadingDashboardState extends DashboardState{}

class ErrorDashboardState extends DashboardState{}