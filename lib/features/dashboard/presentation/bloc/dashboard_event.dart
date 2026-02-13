part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class GetDetailDashboardEvent extends DashboardEvent{}