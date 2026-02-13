import 'package:bloc/bloc.dart';
import 'package:healthtrack/features/dashboard/data/dashboard_repository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required DashboardRepository dashboardRepository}) : super(DashboardInitial()) {
    on<GetDetailDashboardEvent>((event, emit) async {
      emit(LoadingDashboardState());
      try{
        emit(LoadedDashboardState(details: await dashboardRepository.getDashboardDetails()));
        
      }
      catch(error){
        emit(ErrorDashboardState());
      }
    });
  }
}
