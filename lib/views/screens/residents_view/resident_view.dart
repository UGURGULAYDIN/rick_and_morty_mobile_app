import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/models/location_model.dart';
import 'package:rickandmorty/views/screens/residents_view/resident_viewmodel.dart';
import 'package:rickandmorty/views/widgets/appbar_widget.dart';
import 'package:rickandmorty/views/widgets/character_card_listview.dart';

class ResidentView extends StatefulWidget {
  final LocationItem locationItem;
  const ResidentView({super.key, required this.locationItem});

  @override
  State<ResidentView> createState() => _ResidentViewState();
}

class _ResidentViewState extends State<ResidentView> {
  @override
  void initState() {
    super.initState();
    context
        .read<ResidentViewmodel>()
        .getResidents(widget.locationItem.residents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.locationItem.name),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Consumer<ResidentViewmodel>(
              builder: (context, viewModel, child) {
                return CharacterCardListView(
                  characters: viewModel.residents,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
