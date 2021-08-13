import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_stop_watch/models/stop_watch_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'provider demo',
        // providerで状態管理する箇所を囲む
        home: _ProviderWidget());
  }
}

class _ProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StopWatchModel>(
          create: (context) => StopWatchModel(),
        )
      ],
      child: _MainPageBody(),
    );
  }
}

class _MainPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stopWatchModel = Provider.of<StopWatchModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('シンプルストップウォッチ'),
        ),
        // 再描画したい箇所だけConsumerで囲む
        // notifyListeners()で再描画される
        // modelの中身はCountModel
        body: Center(
          child: Column(
            children: [
              Consumer<StopWatchModel>(
                  builder: (context, model, _) => Text(
                        model.stopWatchTimeDisplay,
                        style: Theme.of(context).textTheme.headline2,
                      )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: stopWatchModel.isStartPressed
                          ? stopWatchModel.startStopWatch
                          : null,
                      child: Text('スタート')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: stopWatchModel.isStopPressed
                          ? null
                          : stopWatchModel.stopStopWatch,
                      child: Text('ストップ')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: stopWatchModel.isResetPressed
                          ? null
                          : stopWatchModel.resetStopWatch,
                      child: Text('リセット')),
                ],
              ),
            ],
          ),
        ));
  }
}
