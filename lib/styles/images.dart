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
  static ImageProvider accountsLarge =
      Image.asset("assets/Images/Accounts_large.png").image;
  static ImageProvider logo = Image.asset("assets/Images/Logo.png").image;
  static ImageProvider logoCircle =
      Image.asset("assets/Images/LogoCircle.png").image;
  static ImageProvider heartOn = Image.asset("assets/Images/HeartOn.png").image;
  static ImageProvider heartOff =
      Image.asset("assets/Images/HeartOff.png").image;
}