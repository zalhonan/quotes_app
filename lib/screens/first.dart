import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import '../stores/quote_store.dart';
import '../models/models.dart';
import '../screens/quotes_list.dart';
import '../widgets/quote_card.dart';
import '../widgets/category_card.dart';
import '../widgets/progress_bar_indicator.dart';
import '../widgets/app_scaffold.dart';
import '../services/constants.dart';
import '../models/async_quote_repository.dart';
import '../widgets/expandable_app_bar.dart';

class First extends StatefulWidget {
  static const String id = '/';

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  final _repository = AsyncQuoteRepository(client: http.Client());
  Future<Quote> _quoteOfTheDay;
  Future<List<QuoteCategory>> _quoteCategories;

  @override
  void initState() {
    _quoteOfTheDay = _repository.getQuoteOfTheDayFromAPI(kLang, kFixedAuthorId);
    _quoteCategories = _repository.getCategoriesFromAPI(kLang);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _quoteStore = Provider.of<QuoteStore>(context);

    ScrollController _controller = ScrollController();

    return AppScaffold(
      currentSelectedNavBarItem: 0,
      noAppBar: true,
      body: FutureBuilder(
        // ждем два future одновременно
        future: Future.wait([_quoteOfTheDay, _quoteCategories]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          // проверяем, есть ли все данные
          if (snapshot.hasData) {
            return Scrollbar(
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  ExpandableAppBar(
                      title: 'fixedTitle'.tr(),
                      controller: _controller,
                      index: 0,
                      backgroundImage: AssetImage('images/appbars/buddha1.jpg'),
                      backgroundColor: Colors.blueGrey),
                  SliverToBoxAdapter(
                    child: QuoteCard(
                      quote: snapshot.data[0],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // управление через index
                      (BuildContext context, int index) {
                        // маппинг по схеме
                        // items.map((item) => ItemWidget(item: item)).toList(),
                        return snapshot.data[1]
                            .map(
                              (category) => CategoryCard(
                                category: category,
                                onPressed: () {
                                  _quoteStore.setCategory(category);
                                  Navigator.pushNamed(
                                    context,
                                    QuotesList.id,
                                  );
                                },
                              ),
                            )
                            .toList()[index];
                      },
                      // кол-во элементов
                      childCount: snapshot.data[1].length,
                    ),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('errorText'.tr() + '\n ${snapshot.error}'),
            );
          }
          return ProgressBarIndicator();
        },
      ),
    );
  }
}
