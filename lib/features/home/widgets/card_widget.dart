import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_egypt_with_firebase/core/blocs/theme_bloc/theme_bloc.dart';
import 'package:go_egypt_with_firebase/core/helpers/is_current_locale_english.dart';
import 'package:go_egypt_with_firebase/features/home/models/card_model.dart';
import 'package:go_egypt_with_firebase/features/home/widgets/place_item_widget.dart';

import '../models/place_model.dart';

class CardWidget extends StatefulWidget {
  final CardModel card;
  final PlaceModel place;
  const CardWidget({
    super.key,
    required this.card,
    required this.place,
  });
  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: BlocProvider.of<ThemeBloc>(context).darkMode
            ? Colors.grey.shade900
            : Colors.grey.shade300,
      ),
      child: Column(
        children: [
          PlaceItemWidget(
            place: widget.place,
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  isCurrentLocaleEnglish()
                      ? widget.card.enGovernmentName
                      : widget.card.arGovernmentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    var db = FirebaseFirestore.instance;
                    final data = {
                      "enName": widget.place.enName,
                      "arName": widget.place.arName,
                      "image": widget.place.imagePath,
                      "enGovernmentName": widget.card.enGovernmentName,
                      "arGovernmentName": widget.card.arGovernmentName,
                    };

                    db
                        .collection("favorites")
                        .add(data)
                        .then((documentSnapshot) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Place added to favorites'),
                        ),
                      );
                    });

                    pressed = !pressed;
                    setState(() {});
                  },
                  icon: Icon(
                      pressed ? Icons.favorite : Icons.favorite_border_outlined,
                      color:
                          pressed ? Theme.of(context).colorScheme.error : null),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
