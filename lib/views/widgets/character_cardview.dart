import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmorty/app/locator.dart';
import 'package:rickandmorty/app/router.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/services/preferences_service.dart';

class CharacterCardView extends StatefulWidget {
  final CharacterModel characterModel;
  final bool isFavourited;

  const CharacterCardView({
    super.key,
    required this.characterModel,
    this.isFavourited = false,
  });

  @override
  State<CharacterCardView> createState() => _CharacterCardViewState();
}

class _CharacterCardViewState extends State<CharacterCardView> {
  late bool isFavourited;

  @override
  void initState() {
    isFavourited = widget.isFavourited;
    super.initState();
  }

  void _favouriteCharacter() {
    if (isFavourited) {
      locator<PreferencesService>().removeCharacter(widget.characterModel.id);
      isFavourited = false;
    } else {
      locator<PreferencesService>().saveCharacter(widget.characterModel.id);
      isFavourited = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.characterProfile,
          extra: widget.characterModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Hero(
                      tag: widget.characterModel.image,
                      child: Image.network(
                        widget.characterModel.image,
                        height: 100,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.characterModel.name,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          const SizedBox(height: 5),
                          _infoWidget(
                              type: 'Köken',
                              value: widget.characterModel.origin.name),
                          const SizedBox(height: 4),
                          _infoWidget(
                              type: 'Durum',
                              value:
                                  '${widget.characterModel.status} - ${widget.characterModel.species}'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: _favouriteCharacter,
              icon: Icon(isFavourited ? Icons.bookmark : Icons.bookmark_border),
            ),
          ],
        ),
      ),
    );
  }

  Column _infoWidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
