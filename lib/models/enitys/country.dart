class Country{
  String name;
  String capital;
  String currency;
  Country.init();
  Country.fromJson(Map map){
    this.name=map['name'];
    this.capital=map['capital'];
    this.currency=map['currency'];
  }
}