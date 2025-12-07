import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/router/router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/firebase_options.dart';

final model = FirebaseAI.googleAI().generativeModel(
  model: 'gemini-2.5-flash-lite',
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => BlocProvider(
        create: (context) => serviceLocator<AuthCubit>(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}



//in candidate result page moving to page
// Future<void> logProfileView(String candidateId) async {
//   // Don't log if viewing your own profile
//   final supabase = serviceLocator.get<SupabaseClient>();
//   if (candidateId == supabase.auth.currentUser?.id) return;

//   try {
//     await supabase.rpc(
//       'track_profile_view',
//       params: {'target_user_id': candidateId},
//     );
//   } catch (e) {
//     print("Error logging view: $e");
//   }
// }

 // Fire and forget 
 //in datasource candidate search
        // supabase
        //     .rpc(
        //       'track_search_appearances',
        //       params: {'candidate_ids': foundIds},
        //     )
        //     .catchError((e) {
        //       print('Error tracking search stats: $e');
        //     });
