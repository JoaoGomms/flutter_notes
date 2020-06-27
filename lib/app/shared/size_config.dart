import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class SizeConfig{
  //Tamanho total da tela
  static double _screenWidth;
  static double _screenHeight;

  //Tamanho dos blocos da tela
  static double _blocoAltura = 0;
  static double _blocoLargura = 0;

  //Multiplicadores para elementos da tela
  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;



  void init(BoxConstraints constraints, Orientation orientation){
    //Tamanho da tela dependendo da orientação
    if(orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      //Se a orientação for portrait entao a variavel recebe true
      isPortrait = true;
      //Se a tela tiver menos que 450 de Width então consideramos que é um celular
      if(_screenWidth < 450) {
        isMobilePortrait = true;
      }
    }else{
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    //Os blocos do celular são divididos por 100 do tamanho da tela
    _blocoAltura = _screenHeight / 100;
    _blocoLargura = _screenWidth / 100;

    textMultiplier = _blocoAltura;
    imageSizeMultiplier = _blocoLargura;
    heightMultiplier = _blocoAltura;
    widthMultiplier = _blocoLargura;




    print("Bloco Altura $_blocoAltura");
    print("Bloco Largura $_blocoLargura");


  }


}