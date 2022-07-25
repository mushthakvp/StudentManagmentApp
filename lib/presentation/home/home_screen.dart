import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_model/core/const/colors.dart';
import 'package:student_model/core/style/style.dart';
import 'package:student_model/domain/home/model/home_model.dart';
import 'package:student_model/infrastructure/home/home_impliment.dart';
import 'package:student_model/presentation/add/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<HomeImpl>(context, listen: false).getAllDetails();
    });

    return Scaffold(
      backgroundColor: redColor,
      appBar: AppBar(
        backgroundColor: redColor,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        centerTitle: true,
        title: Text(
          'All Details',
          style: sFont(
            color: whiteColor,
          ),
        ),
      ),
      body: Consumer<HomeImpl>(
        builder: (BuildContext context, value, _) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: value.listNotifier.length,
            itemBuilder: (context, index) {
              final data = value.listNotifier[index];
              return CardWidget(data: data);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          nextPage(
            context: context,
            screen: AddScreen(type: ActionType.add, visible: false),
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  nextPage({context, screen}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn);
          return ScaleTransition(alignment: Alignment.center, scale: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final HomeModel data;
  const CardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextPage(
          context: context,
          screen: AddScreen(
            data: data,
            type: ActionType.edit,
            visible: true,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Card(
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(
                          const Base64Decoder().convert(data.image),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    data.name,
                    style: sFont(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextPage({context, screen}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn);
          return ScaleTransition(alignment: Alignment.center, scale: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
      ),
    );
  }
}
