class CalcOpt{
  
  double _precoAlcool;
  double _precoGasolina;

  CalcOpt(double prAl, double prGas){
    this._precoAlcool   = prAl;
    this._precoGasolina = prGas;
  }

  bool isValidaInput(){
    if( this._precoAlcool == null || this._precoGasolina == null ){
     return false;
    }else{
      return true;
    }
  }

  String calcOpt(){
    if( (this._precoAlcool / this._precoGasolina) >= 0.7){
      return "gasolina";
    }else{
      return "alcool";
    }
  }
  
}