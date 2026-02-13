import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthtrack/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healthtrack/features/dashboard/presentation/bloc/dashboard_bloc.dart';

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
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: 0,
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLogoutState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/login_screen",
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutEvent());
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfff5f7fa),
              Color(0xffe4eaf5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Insights",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Quick overview of your health records",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              /// Total Patients
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return _dashboardCard(
                    context: context,
                    title: "Total Patients",
                    value: state is LoadedDashboardState
                        ? state.details["totalPatient"].toString()
                        : state is LoadingDashboardState
                            ? "..."
                            : "Can't Load...",
                    color: Colors.blueAccent,
                    icon: Icons.people_alt_rounded,
                    onTap: () async {
                      await Navigator.pushNamed(context, "/patient_screen");
                      context
                          .read<DashboardBloc>()
                          .add(GetDetailDashboardEvent());
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              /// Recent Reports
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return _dashboardCard(
                    context: context,
                    title: "Recent Reports",
                    value: state is LoadedDashboardState
                        ? state.details["totalReports"].toString()
                        : state is LoadingDashboardState
                            ? "..."
                            : "Can't Load...",
                    color: Colors.redAccent,
                    icon: Icons.medical_services_rounded,
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Card(
        elevation: 8,
        shadowColor: color.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
