import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_control/presentation/resources/palette.dart';

class NeonSplash extends StatelessWidget {
  const NeonSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff19191B),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 40,
                  left: 6,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffFE53BB)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 100, sigmaX: 100),
                      child: Container(
                        color: Colors.transparent,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  )),
              Positioned(
                  top: 240,
                  right: 6,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff09FBD3),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 100, sigmaX: 100),
                      child: Container(
                        color: Colors.transparent,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 80,
                  left: 140,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffFE53BB)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 40, sigmaX: 40),
                      child: Container(
                        color:const Color(0xffFE53BB),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 80,
                  right: 130,
                  child: Container(
                    width: 40,
                    height:40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff09FBD3),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 40, sigmaX: 40),
                      child: Container(
                        // color:Color(0xff09FBD3),
                        height: 30,
                        width: 30,
                      ),
                    ),
                  )),
              SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //   width: 344,
                  //   height: 344,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(
                  //         width: 2,
                  //       ),
                  //       shape: BoxShape.circle,
                  //       gradient: const RadialGradient(colors: [
                  //         Color(0xffFE53BB),
                  //         Colors.transparent,
                  //         Color(0xff09FBD3)
                  //       ])),
                  // ),
                  Center(
                    child: CustomPaint(
                      painter: _GradiantPainter(
                        strokeWidth: 4,
                        radius: 344/2,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                            colors: [
                          Color(0xffFE53BB),
                          Color(0xff9E95C4).withOpacity(0.999),
                          Color(0xff6AB9CA).withOpacity(0.999),
                          Color(0xff09FBD3)]
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 344,
                          width: 344,

                          // padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomLeft,
                                image: AssetImage('assets/photos/splash1.png'))
                          ),
                          // child: Image.asset('assets/photos/splash1.png',fit:BoxFit.contain,),
                        ),
                      ),

                    ),
                  ),
                  const SizedBox(height: 62,),

                 SizedBox(
                   width: MediaQuery.of(context).size.width/1.5,
                   child: const Text("Watch movies in Virtual Reality",
                     textAlign: TextAlign.center,
                     maxLines: 2,
                     style: TextStyle(fontSize: 34,color: Palette.white,fontWeight: FontWeight.bold),),
                 ),
                  const SizedBox(height: 30,),
                  SizedBox(
                   width: MediaQuery.of(context).size.width/1.6,
                   child: const Text("Download and watch offline wherever you are",
                     textAlign: TextAlign.center,
                     maxLines: 2,
                     style: TextStyle(fontSize: 16,color: Palette.white,fontWeight: FontWeight.bold),),
                 ),
                  const SizedBox(height: 30,),

                  CustomPaint(
                    painter: _GradiantPainter(
                      strokeWidth: 3,
                      radius: 40,
                      gradient:const LinearGradient(
                        begin:Alignment.centerLeft,
                        // end: Alignment.bottomRight,
                        colors: [
                          Color(0xffFE53BB),
                          Color(0xff09FBD3)
                        ],
                      ),

                    ),
                    child: Container(
                      height: 41,
                      width: 160,
                      color: Colors.transparent,
                      child:Center(
                        child: const Text("Sign up",
                          textAlign: TextAlign.center
                          ,style: TextStyle(color: Palette.white,fontSize: 14),),
                      ) ,
                    ),
                  )

                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _GradiantPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradiantPainter(
      {required double strokeWidth,
      required double radius,
      required Gradient gradient})
      : this.strokeWidth = strokeWidth,
        this.radius = radius,
        this.gradient = gradient;

  @override
  void paint(Canvas canvas, Size size) {
    ///outer rect
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    /// inner rect
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;

}
