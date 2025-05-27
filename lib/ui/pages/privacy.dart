import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart';
import '../legos/button.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}


class _PrivacyPageState extends State<PrivacyPage> {
  String? _markdownContent;

  @override
  void initState() {
    super.initState();
    loadMarkdownContent();
  }

  Future<void> loadMarkdownContent() async {
    _markdownContent = await rootBundle.loadString('PRIVACY_POLICY_en.md');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          const SizedBox(height: 10,),
          const BackBtn(),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 77
            ),
              child: Scaffold(
                body: _markdownContent == null
                  ? Center(child: CircularProgressIndicator())
                  : buildMarkdown()
              ),
          )
        ],
      );
  }

  Widget buildMarkdown() => MarkdownWidget(data: _markdownContent!, padding: const EdgeInsetsGeometry.all(50.0),);
}
