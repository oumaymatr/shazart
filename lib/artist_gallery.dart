import 'package:flutter/material.dart';

class ArtistGallery extends StatelessWidget {
  final String artistName;
  final List<String> imagePaths;

  const ArtistGallery({
    Key? key,
    required this.artistName,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4EADB),
        title: Text(
          "$artistName's Gallery",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "ZenOldMincho",
            color: Color(0xFF2D2D42),
          ),
        ),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all<Color>(
              Color(0xFF80B2BE),
            ),
          ),
        ),
        child: Scrollbar(
          child: GridView.builder(
            itemCount: imagePaths.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              return ImageFrame(imagePath: imagePaths[index]);
            },
          ),
        ),
      ),
    );
  }
}

class ImageFrame extends StatelessWidget {
  final String imagePath;

  const ImageFrame({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullScreenImage(imagePath: imagePath),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      appBar: AppBar(
        backgroundColor: Color(0xFFF4EADB),
      ),
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
