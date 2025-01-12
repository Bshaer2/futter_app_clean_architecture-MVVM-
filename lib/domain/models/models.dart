class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
      {required this.title, required this.subTitle, required this.image});
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentSliderObjectIndex;

 SliderViewObject(
      {required this.sliderObject,required this.numberOfSlides, required this.currentSliderObjectIndex});
}

class User {
  String id;
  String name;
  int numberOfNotifications;

  User(
      {required this.id,
      required this.name,
      required this.numberOfNotifications});
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts({required this.phone, required this.email, required this.link});
}

class Authentication{
  User? user;
  Contacts? contacts;

  Authentication({required this.user, required this.contacts});
}