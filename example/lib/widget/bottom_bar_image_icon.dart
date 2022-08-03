import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BottomImageIconWidget extends StatefulWidget {
  final String iconUrl;

  const BottomImageIconWidget({
    Key? key,
    required this.iconUrl,
  }) : super(key: key);


  @override
  _BottomImageIconWidgetState createState() => _BottomImageIconWidgetState();
}

class _BottomImageIconWidgetState extends State<BottomImageIconWidget> {

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
    imageUrl: widget.iconUrl,
    imageBuilder:
        (context, imageProvider) =>
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
    /*placeholder: (context, url) =>
          null,*/
    errorWidget:
        (context, url, error) =>
        Icon(Icons.business_outlined, color: Colors.grey,size:40.0),
  );
}


