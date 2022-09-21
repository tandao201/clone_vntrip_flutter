import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                height: 32,
                child: Image.asset('assets/images/logo.png'),
              ),
              Row(
                children: const [
                  Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 16,
                  ),
                  Text(
                    '096 326 6688',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}