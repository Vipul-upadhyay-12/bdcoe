public class Cat{
    private String mood;
    private String color;

    public Cat(String color , String mood) {
        this.color = color;
        this.mood = mood;
    }
    public String getMood(){
        return mood;
    }
    public String getColor() {
        return color;
    }
    private void changeMood(String newMood){
        mood = newMood;
    }

    public void purr() {
        System.out.println("Cat Purrs..");
    }
    public void makeHappy() {
        changeMood("Happy");
        purr();
    }

}

public class YellowCat{
    public static void main(String[] args){
        Cat myCat =new  Cat("Orange", "Scared");
        System.out.println("the cat is "+ myCat.getColor()+ " and feels "+ myCat.getMood());
        myCat.makeHappy();
    }
}