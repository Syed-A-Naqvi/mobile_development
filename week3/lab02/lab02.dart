void main()
{

  // part 1 ---------------------------------------------------------------------
  List<double> grades = [46.5, 64.0, 71.5, 68.0, 76.0, 70.0, 62.3, 100, 0];
  grades = grades.map((grade) => ((grade)*(0.3)+2)).toList();
  print("Scaled Grades: $grades");
  // ----------------------------------------------------------------------------

  // part 2 ---------------------------------------------------------------------
  Student me = Student(sid:"100590852", name:"Arham");
  print(me);
  // ----------------------------------------------------------------------------
  
  // part 3 ---------------------------------------------------------------------
  List<int> numbers = [1,2,3,4,5,6,7,8,9,10];
  List<Student> students = numbers.map((n) {
    return Student(name:"Student #$n", sid:"${100000000+n}");
  }).toList();
  // ----------------------------------------------------------------------------

  // part 4 ---------------------------------------------------------------------
  // print(students); -> prints each student as part of containing list
  students.forEach((s) => print(s));
  // ----------------------------------------------------------------------------

  // part 5 ---------------------------------------------------------------------

  Enemy e = Enemy(name: "Boss", hp: 1000, attackPower: 200, stamina: 200, defense: 110);
  Player p = Player(name: "Player", hp: 1000, magicDamage: 300, mana: 200, defense: 180);

  while(e.hp > 0 && p.hp > 0)
  {
    print("${e.name} hits ${p.name} for ${e.attack(p)} points of damage!");
    print("${p.name}'s new health is ${p.hp}\n");
    print("${p.name} hits ${e.name} for ${p.castSpell(e)} points of damage!");
    print("${e.name}'s new health is ${e.hp}\n");
  }

  if(e.hp == 0)
  {
    print("${e.name} has DIED!");
    print("${p.name} has WON!");
  }
  else
  {
    print("${p.name} has DIED!");    
    print("${e.name} has WON!");
  }

  // ----------------------------------------------------------------------------



}

// part 2 ---------------------------------------------------------------------
class Student {
  //fields  
  String sid;
  String name;
  //constructor
  Student({required this.name, required this.sid});
  // toString()
  String toString()
  {
    return "Student name: ${this.name}, StudentID: ${this.sid}";
  }
}
// ----------------------------------------------------------------------------

// part 5 ---------------------------------------------------------------------
mixin Magic{

  int mana = 0;
  int magicDamage = 0;

  int castSpell(Character e)
  {
    
    if(this.mana > 10)
    {
      this.mana -= 10;
    }
    else
    {
      this.mana = 0;
    }

    int damage = this.magicDamage - e.defense;
    
    if(e.hp > damage)
    {
      e.hp -= damage;
    }
    else
    {
      e.hp = 0;
    }

    return damage;
  }

}

mixin Melee{
  int stamina = 0;
  int attackPower = 0;

  int attack(Character e)
  {
    
    if(this.stamina > 10)
    {
      this.stamina -= 10;
    }
    else
    {
      this.stamina = 0;
    }

    int damage = this.attackPower - e.defense;
    
    if(e.hp > damage)
    {
      e.hp -= damage;
    }
    else
    {
      e.hp = 0;
    }

    return damage;
  }
}
// ----------------------------------------------------------------------------


class Character {
  String name;
  int hp;
  int defense;
  Character({required this.name, required this.hp, required this.defense});
}

class Player extends Character with Magic {
  Player({name, hp, magicDamage, mana, defense}) : super(name: name, hp: hp, defense: defense) {
    this.mana = mana;
    this.magicDamage = magicDamage;
  }
}

class Enemy extends Character with Melee {
  Enemy({name, hp, attackPower, stamina, defense}) : super(name: name, hp: hp, defense: defense) {
    this.stamina = stamina;
    this.attackPower = attackPower;
  }
}