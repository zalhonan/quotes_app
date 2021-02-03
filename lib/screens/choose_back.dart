import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../services/decorations.dart';
import '../stores/decoration_store.dart';
import '../services/constants.dart';
import '../widgets/expandable_app_bar.dart';

void chooseBack(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      // стор, в котором хранятся элементы оформления
      final _decorationStore = Provider.of<DecorationStore>(context);

      // контроллер для перехода по списку
      ScrollController _controller = ScrollController();

      double _screenWidth = MediaQuery.of(context).size.width;

      // текущий размер аппдара
      double _appBarHeight = AppBar().preferredSize.height;

      double _index0 = 0;
      double _index1 =
          ((quoteBackgroundPictures.length / 3) * _screenWidth / 3).toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;
      double _index2 =
          (_index1 + (gradientList.length / 3) * _screenWidth / 3).toDouble() +
              kExpandedAppBarHeight -
              _appBarHeight;

      return Container(
        height: MediaQuery.of(context).size.height / 4 * 3,
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            ExpandableAppBar(
              controller: _controller,
              index: _index0,
              title: "backgroundPictures".tr(),
              backgroundColor: Colors.pink,
              backgroundImage: AssetImage('images/appbars/background.jpg'),
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (String currentBackgroundPicture in quoteBackgroundPictures)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(currentBackgroundPicture),
                        ),
                      ),
                    ),
                    onTap: () {
                      _decorationStore
                          .setQuoteBackgroundImage(currentBackgroundPicture);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
            ExpandableAppBar(
              controller: _controller,
              index: _index1,
              title: "backgroundGradients".tr(),
              backgroundColor: Colors.blue[900],
              backgroundImage: AssetImage('images/appbars/gradient.jpg'),
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (BoxDecoration currentGradient in gradientList)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: currentGradient,
                    ),
                    onTap: () {
                      _decorationStore
                          .setQuoteBackgroundGradient(currentGradient);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
            ExpandableAppBar(
              controller: _controller,
              index: _index2,
              title: "backgroundColors".tr(),
              backgroundColor: Colors.purpleAccent,
              backgroundImage: AssetImage('images/appbars/color.jpg'),
            ),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                for (Color currentColor in quoteColors)
                  GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(1),
                      color: currentColor,
                    ),
                    onTap: () {
                      _decorationStore.setQuoteBackgroundColor(currentColor);
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
