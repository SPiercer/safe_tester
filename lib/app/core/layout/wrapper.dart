import 'package:flutter/material.dart';
import 'package:safe_tester/app/core/providers/order_provider.dart';
import 'package:safe_tester/app/feats/pageA/screen.dart';
import 'package:safe_tester/app/feats/pageB/screen.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage>
    with SingleTickerProviderStateMixin, SignalsMixin {
  late final TabController tabController;
  late final Signal<String> titleSignal;
  final tabs = const <Tab>[
    Tab(text: 'Insights'),
    Tab(text: 'Graphs'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    titleSignal = signal('Insights');
    tabController.addListener(() {
      titleSignal.value = tabs[tabController.index].text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Watch.builder(builder: (context) => Text(titleSignal.value)),
        bottom: TabBar(controller: tabController, tabs: tabs),
      ),
      body: SignalProvider(
        create: () => OrdersNotifier(),
        child: TabBarView(
          controller: tabController,
          children: const <Widget>[
            PageA(),
            PageB(),
          ],
        ),
      ),
    );
  }
}
