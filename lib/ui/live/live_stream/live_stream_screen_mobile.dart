import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/live/live_stream/components/item_livestream.dart';


class LiveStreamScreenMobile extends StatefulWidget {
  const LiveStreamScreenMobile({super.key});

  @override
  State<LiveStreamScreenMobile> createState() => _LiveStreamScreenMobileState();
}

class _LiveStreamScreenMobileState extends State<LiveStreamScreenMobile> {
  final _controller = PageController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: const [
            ItemLiveStream(
              link: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/26/1498493367-wonder-woman-2017.jpg?crop=0.601xw:1.00xh;0.133xw,0&resize=1200:*',
            ),
            ItemLiveStream(
              link: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/26/1498493367-wonder-woman-2017.jpg?crop=0.601xw:1.00xh;0.133xw,0&resize=1200:*',
            ),
            ItemLiveStream(
              link: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/26/1498493367-wonder-woman-2017.jpg?crop=0.601xw:1.00xh;0.133xw,0&resize=1200:*',
            ),
            ItemLiveStream(
              link: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/26/1498493367-wonder-woman-2017.jpg?crop=0.601xw:1.00xh;0.133xw,0&resize=1200:*',
            ),
          ],
        ),
      ),
    );
  }
}
