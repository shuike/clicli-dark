import 'package:clicli_dark/utils/toast_utils.dart';
import 'package:clicli_dark/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: FixedAppBar(title: Text('FAQ')),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: MarkdownBody(
          data: '''
![](https://s1.ax1x.com/2020/03/28/GApV6H.jpg)

## network time out

尝试更换网络或扶梯。

## 账号相关

注册请在网页端注册

## 视频播放出错？

尝试在网页观看，如果网页也无法观看可加 QQ 群报错或补档。


## QQ 群列表

- [CliCli ⑥ 群-异度侵入](https://jq.qq.com/?_wv=1027&k=5n8QbrB)
- [CliCli ⑦ 群-来点学习资料](https://jq.qq.com/?_wv=1027&k=5BN7gor)
- [CliCli 番剧报错]()
- [CliCli 番剧更新补档中队](https://jq.qq.com/?_wv=1027&k=5egQFSv)
- [admin@clicli.us](admin@clicli.us)
      ''',
          onTapLink: (url) async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              showErrorSnackBar('打开链接失败');
            }
          },
        ),
      ),
    );
  }
}
