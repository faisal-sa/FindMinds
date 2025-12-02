import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_state.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

// This router page is responsible for checking the company's onboarding status
// immediately after login and directing them to the next required step:
// Profile -> Payment -> Search.

class CompanyOnboardingRouterPage extends StatefulWidget {
  const CompanyOnboardingRouterPage({super.key});

  @override
  State<CompanyOnboardingRouterPage> createState() =>
      _CompanyOnboardingRouterPageState();
}

class _CompanyOnboardingRouterPageState
    extends State<CompanyOnboardingRouterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialAuthStatus(context);
    });
  }

  void _checkInitialAuthStatus(BuildContext context) {
    final authState = context.read<AuthCubit>().state;

    if (authState is AuthAuthenticated) {
      context.read<CompanyBloc>().add(
        CheckCompanyStatusEvent(authState.userId),
      );
    } else if (authState is! AuthLoading) {
      context.go('/login');
    }
  }

  void _routeToNextStep(BuildContext context, CompanyStatusChecked state) {
    if (!state.hasProfile) {
      context.go('/company/complete-profile');
    } else if (!state.hasPaid) {
      context.go('/company/payment');
    } else {
      // All steps complete (Final Destination)
      context.go('/company/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, authState) {
            if (authState is AuthAuthenticated) {
              context.read<CompanyBloc>().add(
                CheckCompanyStatusEvent(authState.userId),
              );
            } else if (authState is AuthUnauthenticated) {
              context.go('/login');
            }
          },
        ),

        // Listener 2: Acts on the result from the CompanyBloc status check
        BlocListener<CompanyBloc, CompanyState>(
          listener: (context, companyState) {
            if (companyState is CompanyStatusChecked) {
              // Success: Route based on the determined status
              // print('DEBUG: CompanyStatusChecked received. Routing to next step.');
              _routeToNextStep(context, companyState);
            } else if (companyState is CompanyError) {
              // Failure: Handle database errors, missing dependencies, etc.
              // print('ERROR: Company status check failed: ${companyState.message}');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Critical error checking profile status: ${companyState.message}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              // Send the user back to login on critical failure
              context.go('/login');
            }
          },
        ),
      ],
      // UI: Show a loading indicator while the asynchronous checks are performed.
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking company status...'),
            ],
          ),
        ),
      ),
    );
  }
}
