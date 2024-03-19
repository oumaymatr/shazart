import 'package:flutter/material.dart';
import 'artists_data.dart';
import 'artist_gallery.dart';

class Home extends StatefulWidget {
  final int selectedIndex;

  const Home({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 2.0),
            child: Text(
              'Our 12 Artists',
              style: TextStyle(
                fontSize: 30,
                fontFamily: "ZenOldMincho",
                color: Color(0xFF2D2D42),
              ),
            ),
          ),
          if (widget.selectedIndex ==
              1) // Show search bar only if 'Search' is selected
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search artist...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                // Filter artists based on search text
                if (searchText.isEmpty ||
                    artists[index]['painterName']!
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return CardArtist(
                    painterName: artists[index]['painterName']!,
                    painterPhoto: artists[index]['painterPhoto']!,
                    backgroundImage: artists[index]['backgroundImage']!,
                    years: artists[index]['years']!,
                    country: artists[index]['country']!,
                    text: artists[index]['text']!,
                    artistName: artists[index]['painterName']!,
                    imagePaths: artists[index]['imagePaths']!,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardArtist extends StatelessWidget {
  final String painterName;
  final String painterPhoto;
  final String backgroundImage;
  final String years;
  final String country;
  final String text;
  final String artistName;
  final List<String> imagePaths;

  const CardArtist({
    Key? key,
    required this.painterName,
    required this.painterPhoto,
    required this.backgroundImage,
    required this.years,
    required this.country,
    required this.text,
    required this.artistName,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          color: Colors.transparent,
          elevation: 5,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Adjust as needed
                  child: Image.asset(
                    backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12.withOpacity(0.6),
                  ),
                ),
              ),
              // Content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Center(
                      child: Text(
                        painterName,
                        style: TextStyle(
                          fontFamily: "Whisper",
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  years,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "ZenOldMincho",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  country,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "ZenOldMincho",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  'assets/images/brush.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: DescriptionTextWidget(
                                text: text,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ZenOldMincho",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArtistGallery(
                                  artistName: artistName,
                                  imagePaths: imagePaths,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Visit Gallery",
                            style: TextStyle(
                                color: Colors.black45,
                                fontFamily: "ZenOldMincho"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Avatar
              Positioned(
                top: 35,
                right: 10,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  backgroundImage: AssetImage(
                    painterPhoto,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;

  DescriptionTextWidget({required this.text, required this.style});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
              style: widget.style,
            )
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: widget.style,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "Show more" : "Show less",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
