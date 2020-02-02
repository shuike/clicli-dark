import 'dart:convert';

import 'package:clicli_dark/api/post.dart';
import 'package:clicli_dark/widgets//post_card.dart';
import 'package:clicli_dark/widgets/appbar.dart';
import 'package:clicli_dark/widgets/refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UGCPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UGCPageState();
  }
}

class _UGCPageState extends State<UGCPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = new ScrollController();
  List data = [];
  int page = 1;

  Future<void> getUGC() async {
    final res = (await getPost('原创', '', page, 10)).data;
    data.addAll(jsonDecode(res)['posts']);
    page += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      children: <Widget>[
        HomeStackTitleAppbar('UGC'),
        Expanded(
            child: RefreshWrapper(
          onLoadMore: getUGC,
          onRefresh: getUGC,
          scrollController: _scrollController,
          child: GridView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 20.0,
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
            ),
            padding: EdgeInsets.all(10.0),
            children: data.map((f) => PostCard(f)).toList(),
          ),
        ))
      ],
    ));
  }
}
