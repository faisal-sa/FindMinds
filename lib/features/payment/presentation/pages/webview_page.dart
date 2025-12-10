import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String url;

  const PaymentWebViewPage({super.key, required this.url});

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;

  // FIX: Removed the space between '_is' and 'handled'
  bool _is_handled = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: Loading indicator logic
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // Check for success URL
            if (request.url.contains('success') ||
                request.url.contains('approved') ||
                request.url.contains('example.com')) {
              if (!_is_handled) {
                _is_handled = true;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment verified successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                if (context.canPop()) {
                  context.pop(true);
                }
              }

              return NavigationDecision.prevent;
            }

            // Check for failure URL
            if (request.url.contains('failed') ||
                request.url.contains('error')) {
              if (!_is_handled) {
                _is_handled = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment verification failed.'),
                    backgroundColor: Colors.red,
                  ),
                );
                context.pop(false);
              }
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Verification'),
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(false),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
