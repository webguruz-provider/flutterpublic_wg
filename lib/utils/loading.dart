import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foodguru/utils/utils.dart';

Widget loadingProvider(BuildContext context,
    {String? msg, bool? transparent, double? opacity}) {
  var brightness = SchedulerBinding.instance.window.platformBrightness;
  return Align(
    alignment: Alignment.center,
    child: Container(
      height: MediaQuery.of(context).size.height,
      color: transparent != null && transparent
          ? Colors.black.withOpacity(0.3)
          : brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
      alignment: Alignment.center,
      child: Stack(
        children: [
          // new Align(
          //   child:  Opacity(
          //     opacity: 0.3,
          //     child: Container(
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //           color: Theme.of(context).primaryColor,
          //           borderRadius: BorderRadius.circular(10)),
          //       height: 100,
          //
          //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //     ),
          //   ),
          // ),
          Align(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: isValidString(msg!)
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xAA000000))
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(msg,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Lato',
                            color: brightness == Brightness.dark
                                ? Colors.black
                                : Colors.white.withOpacity(0.9),
                          ))),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
