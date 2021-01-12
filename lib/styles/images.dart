import 'package:flutter/material.dart';

abstract class ImportedImages {
  static ImageProvider homeOn = Image.asset("assets/Images/Home_on.png").image;
  static ImageProvider homeOff =
      Image.asset("assets/Images/Home_off.png").image;

  static ImageProvider likedOn =
      Image.asset("assets/Images/Liked_on.png").image;
  static ImageProvider likedOff =
      Image.asset("assets/Images/Liked_off.png").image;
  static ImageProvider accountsOn =
      Image.asset("assets/Images/Accounts_on.png").image;
  static ImageProvider accountsOff =
      Image.asset("assets/Images/Accounts_off.png").image;
}
