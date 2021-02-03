import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../services/constants.dart';
import '../models/async_quote_repository.dart';
import '../widgets/quote_card.dart';
import '../widgets/progress_bar_indicator.dart';
import '../widgets/app_scaffold.dart';
import '../stores/quote_store.dart';
import '../widgets/expandable_app_bar.dart';

class QuotesList extends StatefulWidget {
  static const String id = '/quotes';

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  @override
  Widget build(BuildContext context) {
    //обращение к стору для текущей категории и цитаты
    final _quoteStore = Provider.of<QuoteStore>(context);

    // клиент для запроса страниц
    final _repository = AsyncQuoteRepository(client: http.Client());

    ScrollController _controller = ScrollController();

    return AppScaffold(
      currentSelectedNavBarItem: 1,
      noAppBar: true,
      body: FutureBuilder(
        future: _repository.getQuotesFromAPI(
            kLang, 1, _quoteStore.currentCategory.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scrollbar(
              child: CustomScrollView(
                controller: _controller,
                slivers: [
                  ExpandableAppBar(
                      title: 'Buddha\'s Quotes: ${_quoteStore.currentCategory.name}',
                      controller: _controller,
                      index: 0,
                      backgroundImage:
                      AssetImage('images/appbars/temple.jpg'),
                      backgroundColor: Colors.blueGrey),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // управление через index
                          (BuildContext context, int index) {
                        // маппинг по схеме
                        // items.map((item) => ItemWidget(item: item)).toList(),
                        return snapshot.data
                            .map((quote) => QuoteCard(quote: quote))
                            .toList()[index];
                      },
                      // кол-во элементов
                      childCount: snapshot.data.length,
                    ),
                  )
                ],
              ),
            );
          }
          return ProgressBarIndicator();
        },
      ),
    );
  }
}
