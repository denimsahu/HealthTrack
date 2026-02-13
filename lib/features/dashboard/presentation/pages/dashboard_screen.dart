import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:healthtrack/features/patient/data/models/patient.dart';
import 'package:healthtrack/features/diagnosis/data/models/diagnosis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    context.read<DashboardBloc>().add(GetDetailDashboardEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), elevation: 2),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Insights",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 24),

            /// Total Patients Card
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return _dashboardCard(
                  context: context,
                  title: "Total Patients",
                  value: state is LoadedDashboardState?state.details["toalPatient"].toString():state is LoadingDashboardState?"...":"Can't Load...",
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.pushNamed(context, "/patient_screen");
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            /// Recent Reports Card
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                print(state is LoadedDashboardState?state.details:state);
                return _dashboardCard(
                          context: context,
                          title: "Total Reports",
                          value: state is LoadedDashboardState?state.details["totalReports"].toString():state is LoadingDashboardState?"...":"Can't Load...",
                          color: Colors.redAccent,
                          onTap: () {
                            Navigator.pushNamed(context, "/diagnosis_list_screen");
                          },
                        );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),

              Icon(Icons.arrow_forward_ios, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
