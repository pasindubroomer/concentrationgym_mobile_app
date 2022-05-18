import 'package:flutter/material.dart';

class Challenge {
  final String title;
  final String? subtitle;
  final IconData icon;

  Challenge(this.title, this.subtitle, this.icon);

  static List<Challenge> getChallengeList() {
    List<Challenge> listChallenge = [
      Challenge("GOALIE MINDSET GYM", 'EXPLORE EXCERCISES', Icons.home),
      Challenge("27 DAY GOALIE MINDSET \nCHALLENGE ", '', Icons.people),
      Challenge(
          "GOALIE MINDSET \nE-LEARNING", 'REGULAR AND GUIDED', Icons.place),
      Challenge("GAME MASTERY", '', Icons.ac_unit)
    ];

    return listChallenge;
  }
}
