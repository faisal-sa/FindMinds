<<<<<<< HEAD
import 'package:graduation_project/core/exports/app_exports.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/CompanySearchPage.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/advanced_searchpage.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_qr_scanner_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_settings_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/company_status_wrapper.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/pages/ompany_bookmarks_page.dart';
import 'package:graduation_project/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:graduation_project/features/payment/presentation/pages/pay_page.dart';
import 'package:graduation_project/features/payment/presentation/pages/webview_page.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/CandidateResultsPage.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_bookmarks_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_onboarding_router_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_qr_page.dart';

import 'package:graduation_project/features/company_portal/presentation/screens/company_search_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/company_settings_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/complete_company_profile_page.dart';
import 'package:graduation_project/features/company_portal/presentation/screens/payment_page.dart';

import 'package:graduation_project/features/individuals/chat/presentation/pages/chats_tab.dart';
import 'package:graduation_project/features/individuals/features/basic_information/presentation/pages/basic_info_page.dart';
import 'package:graduation_project/features/individuals/insights/presentation/pages/insights_tab.dart';
import 'package:graduation_project/features/individuals/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/pages/profile_tab.dart';
import 'package:graduation_project/features/temp/dashboard.dart';
import 'package:graduation_project/features/individuals/navigation/pages/individuals_home_page.dart';

import 'package:graduation_project/features/auth/presentation/pages/login_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/signup_page.dart';
import 'package:graduation_project/features/auth/presentation/pages/otp_verification_page.dart';

import 'package:flutter/material.dart';
>>>>>>> abbass

// keep it here for now
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final getIt = GetIt.instance;

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return OTPVerificationPage(email: email);
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: serviceLocator.get<UserCubit>()),
            BlocProvider(create: (context) => ProfileCubit()),
          ],
          child: IndividualsHomePage(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/insights',
              builder: (context, state) => const InsightsTab(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chats',
              builder: (context, state) => const ChatsTab(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileTab(),
              routes: [
                GoRoute(
                  path: 'basic-info',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: userCubit),
                        BlocProvider(
                          create: (context) =>
                              serviceLocator.get<BasicInfoCubit>(),
                        ),
                      ],
                      child: BasicInfoPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'about-me',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final userCubit = serviceLocator.get<UserCubit>();

                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: userCubit),

                        BlocProvider(
                          create: (context) {
                            final cubit = serviceLocator.get<AboutMeCubit>();
                            final currentUser = userCubit.state.user;

                            cubit.initialize(
                              currentUser.summary,
                              currentUser.videoUrl,
                            );
                            return cubit;
                          },
                        ),
                      ],
                      child: const AboutMePage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'experience',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<WorkExperienceCubit>(),
                      child: const WorkExperienceListPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'education',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<EducationCubit>()
                            ..loadEducations(),
                      child: const EducationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'certification',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return BlocProvider(
                      create: (context) =>
                          serviceLocator.get<CertificationCubit>()
                            ..loadCertifications(),
                      child: const CertificationPage(),
                    );
                  },
                ),
                GoRoute(
                  path: 'skills',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return const SkillsPage();
                  },
                ),
                GoRoute(
                  path: 'preferences',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    return const JobPreferencesPage();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
<<<<<<< HEAD

    // -------------------- 4. COMPANY PORTAL FLOW --------------------
    GoRoute(
      path: '/company',
      name: 'company-root',
      builder: (context, state) {
        // Provide the CompanyBloc at the root
        return BlocProvider(
          create: (_) => serviceLocator.get<CompanyBloc>(),
          child: const CompanyStatusWrapper(), // The Gatekeeper
        );
      },
=======
    // -------------------- COMPANY PORTAL FLOW --------------------

    // 1. THE ROUTER: Checks the status after successful login/signup
    GoRoute(
      path: '/company/onboarding-router',
      name: 'company-onboarding-router',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompanyOnboardingRouterPage(),
      ),
    ),

    // 2. ONBOARDING STEP 1: Profile Completion (if profile is incomplete)
    GoRoute(
      path: '/company/complete-profile',
      name: 'company-complete-profile',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: const CompleteCompanyProfilePage(),
      ),
    ),

    // 3. ONBOARDING STEP 2: Payment/Verification (if profile is complete but unverified/unpaid)
    GoRoute(
      path: '/company/payment',
      name: 'company-payment',
      builder: (context, state) => const PaymentPage(),
    ),

    // 4. MAIN FEATURE: Search Candidates (if all prerequisites are met)
    GoRoute(
      path: '/company/search',
      name: 'company-search',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<CompanyBloc>(),
        child: CompanySearchPage(),
      ),
>>>>>>> abbass
      routes: [
        // 4a. PROFILE COMPLETION (Mandatory) - First step after login
        GoRoute(
<<<<<<< HEAD
          path: 'complete-profile',
          name: 'company-complete-profile',
          builder: (context, state) => CompleteCompanyProfilePage(),
        ),

        // 4c. SEARCH HOME (Final Destination)
        GoRoute(
          path: 'search',
          name: 'company-search',
          builder: (context, state) => const CompanySearchPage(),
          routes: [
            // Nested features under the main search/home view
            GoRoute(
              path: 'advanced',
              name: 'company-advanced-search',
              builder: (context, state) => AdvancedSearchPage(),
            ),
            GoRoute(
              path: 'bookmarks',
              name: 'company-bookmarks',
              builder: (context, state) => const CompanyBookmarksPage(),
            ),
            GoRoute(
              path: 'qr-scanner',
              name: 'company-qr-scanner',
              builder: (context, state) => const CompanyQRScannerPage(),
            ),
            GoRoute(
              path: 'settings',
              name: 'company-settings',
              builder: (context, state) => const CompanySettingsPage(),
            ),
          ],
=======
          path: 'search-results',
          name: 'company-search-results',
          builder: (context, state) {
            final bloc = state.extra as CompanyBloc;
            return BlocProvider.value(
              value: bloc,
              child: const CandidateResultsPage(),
            );
          },
        ),
        GoRoute(
          path: 'bookmarks',
          name: 'company-bookmarks',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyBookmarksPage(),
          ),
        ),

        GoRoute(
          path: 'qr',
          name: 'company-qr',
          builder: (context, state) => BlocProvider(
            create: (_) => getIt<CompanyBloc>(),
            child: const CompanyQRScannerPage(),
          ),
        ),
        GoRoute(
          path: 'settings',
          name: 'company-settings',
          builder: (context, state) => const CompanySettingsPage(),
>>>>>>> abbass
        ),
      ],
    ),
    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE START ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
    //

    // ==================  Pay Page  =================== //
    //
    GoRoute(
      path: '/pay',
      builder: (context, state) => BlocProvider(
        create: (_) => serviceLocator<PaymentCubit>(),
        child: const PayPage(),
      ),
    ),

    // ==================  Payment WebView (3DS Authentication)  =================== //
    //
    GoRoute(
      path: '/payment-webview',
      builder: (context, state) {
        final url = state.uri.queryParameters['url'] ?? '';
        return PaymentWebViewPage(url: url);
      },
    ),

    // ==================  CR Info Page  =================== //
    //
    GoRoute(
      path: '/cr-info',
      builder: (context, state) {
        return const CrInfoPage(); //spalsh later page
      },
    ),


    //▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲ ROUTE END ▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼
  ],
);
