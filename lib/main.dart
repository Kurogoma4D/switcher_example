import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Switcher(
                pageController: pageController,
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Container(color: Colors.teal),
                  Container(color: Colors.green),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Switcher extends StatefulWidget {
  const Switcher({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.pageController.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          Align(
            alignment: Alignment(
              widget.pageController.hasClients
                  ? (widget.pageController.page ?? -1) * 2 - 1
                  : -1,
              0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth / 2,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(56),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: _SwitchButton(
                    text: 'Page 1',
                    onTap: () => widget.pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
                Expanded(
                  child: _SwitchButton(
                    text: 'Page 2',
                    onTap: () => widget.pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchButton extends StatelessWidget {
  const _SwitchButton({
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
