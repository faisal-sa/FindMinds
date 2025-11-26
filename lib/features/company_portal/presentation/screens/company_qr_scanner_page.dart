import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class CompanyQrScannerPage extends StatelessWidget {
  const CompanyQrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Candidate QR')),
      body: BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is BookmarkAddedSuccessfully) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Candidate bookmarked!')),
            );
            Navigator.pop(context);
          } else if (state is CompanyError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        // child: QRView(
        //   key: qrKey,
        //   onQRViewCreated: (controller) {
        //     controller.scannedDataStream.listen((scan) {
        //       final code = scan.code;
        //       context.read<CompanyBloc>().add(AddCandidateBookmarkEvent(code));
        //       controller.pauseCamera();
        //     });
        //   },
        // ),
      ),
    );
  }
}
