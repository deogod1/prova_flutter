import 'package:flutter/material.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/presentation/home_bloc.dart';
import 'package:prova_flutter/core/home/presentation/home_events.dart';

class TextListTile extends StatelessWidget {
  final TextEntity entity;
  final HomeBloC bloc;
  const TextListTile({super.key, required this.entity, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(
          entity.text,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  bloc.textEditDataSink.add(entity);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  bloc.textDataSink.add(HomeDeleteTextEvent(entity: entity));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
