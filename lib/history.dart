import 'package:flutter/material.dart';
import 'components/search_history.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      body: searchHistoryProvider.searchHistoryList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "You haven't explored any paintings yet. Take a moment to discover them!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontFamily: "ZenOldMincho",
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: searchHistoryProvider.searchHistoryList.length,
              itemBuilder: (context, index) {
                final searchHistory = searchHistoryProvider.searchHistoryList[
                    searchHistoryProvider.searchHistoryList.length - index - 1];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: FileImage(searchHistory.image),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.5),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 50, 16, 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 45,
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 40,
                                  child: Image.asset(
                                    'assets/images/brush.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  searchHistory.artistName,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontFamily: "ZenOldMincho",
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  searchHistory.date,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 20,
                                    fontFamily: "ZenOldMincho",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
