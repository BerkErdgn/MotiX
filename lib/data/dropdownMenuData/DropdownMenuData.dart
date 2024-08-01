

enum ProfileLable{
  bear('bear', "assets/animalIcon/bear.svg"),
  cat('cat', "assets/animalIcon/cat.svg"),
  chick('chick', "assets/animalIcon/chick.svg"),
  cow('cow', "assets/animalIcon/cow.svg"),
  deer('deer', "assets/animalIcon/deer.svg"),
  dog('dog', "assets/animalIcon/dog.svg"),
  octopus('octopus', "assets/animalIcon/octopus.svg"),
  rabbit('rabbit', "assets/animalIcon/rabbit.svg"),
  seal('seal', "assets/animalIcon/seal.svg"),
  sheep('sheep', "assets/animalIcon/sheep.svg"),
  tiger('tiger', "assets/animalIcon/tiger.svg"),
  whale('whale', "assets/animalIcon/whale.svg");


  const ProfileLable(this.label, this.icon);
  final String label;
  final dynamic  icon;
}

