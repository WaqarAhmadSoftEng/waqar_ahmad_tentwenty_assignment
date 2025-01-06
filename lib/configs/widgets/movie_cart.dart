import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color/app_colors.dart';

class MovieCart extends StatelessWidget {
  final String moviePic;
  final String movieName;
  const MovieCart({super.key, required this.moviePic, required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.w,
      width: 335.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
            image: CachedNetworkImageProvider(moviePic),
          fit: BoxFit.cover,
        )
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 140.h, left: 20.w),
        child: Text(movieName, style: TextStyle(fontSize: 18.sp, color: AppColors.white, fontWeight: FontWeight.bold),),
      ),
    );
  }
}