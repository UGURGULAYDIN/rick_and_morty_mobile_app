import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/characters_model.dart';
import 'package:rickandmorty/views/screens/character_profileview/character_profile_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/decorated_container.dart';
import 'package:rickandmorty/views/widgets/episodes_listviews.dart';

class CharacterProfileView extends StatefulWidget {
  final CharacterModel characterModel;
  const CharacterProfileView({super.key, required this.characterModel});

  @override
  State<CharacterProfileView> createState() => _CharacterProfileViewState();
}

class _CharacterProfileViewState extends State<CharacterProfileView> {
  @override
  void initState() {
    super.initState();
    context
        .read<CharacterProfileViewmodel>()
        .getEpisodes(widget.characterModel.episode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppbarWidget(
          title: 'Karakter',
          transparentBackground: true,
        ),
        body: DecoratedContainer(
          topChild: _characterAvatar(context),
          child: Column(
            children: [
              const SizedBox(height: 13),
              _characterName(),
              const SizedBox(height: 15),
              _labelsView(context),
              const SizedBox(height: 38),
              _scenesTitle(),
              const SizedBox(height: 15),
              _episodeListView(),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _episodeListView() {
    return Flexible(
      child: Consumer<CharacterProfileViewmodel>(
        builder: (context, viewModel, child) {
          return EpisodesListviews(episodes: viewModel.episodes);
        },
      ),
    );
  }

  Text _characterName() {
    return Text(
      widget.characterModel.name,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Container _scenesTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        'Bölümler (${widget.characterModel.episode.length})',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Padding _labelsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 14,
        spacing: 7,
        children: [
          _labelWidget(context, label: widget.characterModel.status),
          _labelWidget(context, label: widget.characterModel.origin.name),
          _labelWidget(context, label: widget.characterModel.gender),
          _labelWidget(context, label: widget.characterModel.species),
        ],
      ),
    );
  }

  Container _labelWidget(BuildContext context, {required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Padding _characterAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 52),
      child: CircleAvatar(
        radius: 100,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: CircleAvatar(
          radius: 98,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Hero(
            tag: widget.characterModel.image,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.characterModel.image),
              radius: 95,
            ),
          ),
        ),
      ),
    );
  }
}
