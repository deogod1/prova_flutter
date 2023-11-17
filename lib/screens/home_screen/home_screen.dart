import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/presentation/home_bloc.dart';
import 'package:prova_flutter/core/home/presentation/home_events.dart';
import 'package:prova_flutter/screens/components/text_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloC bloc;
  final textController = TextEditingController();
  final uuid = const Uuid();
  String? _errorText;
  final myFocusNode = FocusNode();

  @override
  void initState() {
    bloc = Injector.appInstance.get();
    bloc.textDataSink.add(HomeLoadAllTextsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              _buildBody(context),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildPoliticasLink(context),
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white),
                height: 350,
                child: _buildTextList(context),
              ),
              const SizedBox(
                height: 50,
              ),
              _buildTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextList(BuildContext context) {
    return Observer(
        builder: (context) => ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: bloc.entities.length,
            shrinkWrap: true,
            itemBuilder: ((context, index) =>
                TextListTile(entity: bloc.entities[index], bloc: bloc))));
  }

  Widget _buildPoliticasLink(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        child: const Text(
          "Política de privacidade",
          style: TextStyle(fontSize: 16),
        ),
        onTap: () => launchUrl(Uri.parse('https://www.google.com.br/')),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return StreamBuilder(
      stream: bloc.textEditDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          textController.text = snapshot.data!.text;
        }
        return TextField(
          focusNode: myFocusNode,
          onTapOutside: (event) => myFocusNode.requestFocus(),
          onSubmitted: (value) {
            if (value.isEmpty) {
              _errorText = 'Texto em branco!';
              setState(() {});
              return;
            }
            snapshot.hasData
                ? bloc.textDataSink.add(HomeSaveTextEvent(
                    entity: TextEntity(id: snapshot.data!.id, text: value)))
                : bloc.textDataSink.add(HomeSaveTextEvent(
                    entity: TextEntity(id: uuid.v1(), text: value)));
            textController.clear();
            _errorText = null;
            bloc.textEditDataSink.add(null);
            setState(() {});
          },
          controller: textController,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          decoration: InputDecoration(
              errorText: _errorText,
              hintText: 'Digite seu texto',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(6))),
        );
      },
    );
  }
}
