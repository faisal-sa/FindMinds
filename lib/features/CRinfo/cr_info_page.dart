import 'package:flutter/material.dart';
import 'cr_appBar.dart';
import 'cr_info_model.dart';
import 'wathq_service.dart';
import 'widgets/co_info_widget.dart';
import 'widgets/custom_snackbar.dart';

//  ==================  page features  =================== //

class CrInfoPage extends StatefulWidget {
  const CrInfoPage({super.key});

  @override
  State<CrInfoPage> createState() => _CrInfoPageState();
}

class _CrInfoPageState extends State<CrInfoPage> {
  final service = WathqService();
  final TextEditingController controller = TextEditingController();

  CrInfoModel? data;
  bool loading = false;

  Future<void> fetchData() async {
    final id = controller.text.trim();

    if (id.isEmpty) {
      showCustomSnackbar(context, message: "يرجى إدخال رقم السجل التجاري");
      return;
    }

    setState(() {
      loading = true;
      data = null;
    });

    try {
      final result = await service.getCrInfo(id);
      if (!mounted) return;
      setState(() {
        data = result;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : "خطأ في جلب البيانات";
      showCustomSnackbar(
        context,
        message: errorMessage,
        isError: true,
        duration: const Duration(seconds: 4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Colors.transparent,
        title: crInfoAppBar(controller, fetchData),
      ),

      body: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
            const SizedBox(height: 22),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                        ),
                      )
                    : data == null
                    ? Center(
                        key: const ValueKey('empty'),
                        child: Text(
                          "أدخل رقم السجل ثم اضغط بحث",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    : CrInfoBuilder(data: data!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
