import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/payment/export_payment.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      //==================  App Bar  =================== //
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),

      //==================  Body  ===================//
      body: BlocListener<PaymentCubit, PaymentState>(
        // في ملف features/payment/presentation/pages/pay_page.dart

        // ... داخل BlocListener
        listener: (context, state) async {
          // <-- أضف async هنا
          switch (state.status) {
            case PaymentStatus.requiresAuth:
              if (state.authUrl != null) {
                // 1. نذهب لصفحة الويب وننتظر النتيجة
                final bool? webViewResult = await context.push<bool>(
                  '/payment-webview?url=${Uri.encodeComponent(state.authUrl!)}',
                );

                // 2. إذا عادت صفحة الويب بـ true، يعني أن المصادقة نجحت
                if (webViewResult == true && context.mounted) {
                  // نغلق صفحة الدفع ونعود لصفحة البروفايل بنجاح
                  context.pop(true);
                }
              }
              break;

            case PaymentStatus.success:
              final response = state.response!;
              if (response.isPaid) {
                AppSnackbar.success(context, 'Payment Successful');

                // إذا كان الدفع مباشراً بدون 3DS
                if (context.canPop()) {
                  context.pop(true);
                } else {
                  context.go('/company/search');
                }
              } else {
                AppSnackbar.warning(context, 'Payment Failed');
              }
              break;

            // ... بقية الحالات
            case PaymentStatus.initial:
              // TODO: Handle this case.
              throw UnimplementedError();
            case PaymentStatus.loading:
              // TODO: Handle this case.
              throw UnimplementedError();
            case PaymentStatus.failure:
              // TODO: Handle this case.
              throw UnimplementedError();
          }
        },
        //==================  Main Widget  ===================//
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //==================  Payment amount  ===================//
              payTitleWidget('199 SAR'), // Edit The Amount Here
              const SizedBox(height: 16),

              //==================  Credit Card Widget  ===================//
              creditCardWidget(context),
              const SizedBox(height: 16),

              //==================  Card Details  ===================//
              buildSectionTitle('Card Details'),

              //==================  Card Input Form  ===================//
              const CardInputForm(),
              const SizedBox(height: 32),

              //==================  BlocBuilder for Pay Now Button  ===================//
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  final isLoading = state.status == PaymentStatus.loading;

                  //==================  Pay Now Button  ===================//
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : context.read<PaymentCubit>().submitPayment,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[800],
                    ),
                    child: isLoading
                        //==================  Pay Now Button Loading  ===================//
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        // ==================  Pay Now Button Text  =================== //
                        : const Text(
                            'Pay Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
