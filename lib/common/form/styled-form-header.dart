import 'package:budgeto_flutter/constants/routes.dart';
import 'package:flutter/material.dart';

class StyledFormHeader extends StatelessWidget {
  late final String? title;
  late final RoutesEnum? backRoute;

  StyledFormHeader({this.title, this.backRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.pinkAccent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    goTo(context, backRoute!);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
