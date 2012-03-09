/* Refer to Asher Garland for reference. *//
package hygeia;

/* A class for containing nutrition information. No database access. */
public class Nutrition {

    private double calories;
    private double carbohydrates;
    private double protein;
    private double fat;
    
    public Nutrition(double cal, double carb, double pro, double fat) {
        this.setCalories( cal );
        this.setCarbohydrates( carb );
        this.setProtein( pro );
        this.setFat( fat );
    }

    
    /* Adds the info in n to this object. Returns this. */
    public Nutrition addNutrition(Nutrition n) {
        this.setCalories( this.getCalories() + n.getCalories() );
        this.setCarbohydrates( this.getCarbohydrates() + n.getCarbohydrates() );
        this.setProtein( this.getProtein() + n.getProtein() );
        this.setFat( this.getFat() + n.getFat() );

        return (this);

    }
    
    /* getters for all fields */
    public double getCalories() {
        return this.calories;      
    }

    private void setCalories ( double cal )
    {
        if ( cal < 0 )
        {
            cal = 0;
        }

        this.calories = cal;
    }

        
    public double getCarbohydrates() {
        return this.carbohydrates;
    }

    private void setCarbohydrates( double carb )
    {
        if (carb < 0)
        {
            carb = 0;
        }

        this.carbohydrates = carb;
    }
        
    public double getProtein() {
        return this.protein;
    }

    private void setProtein ( double pro )
    {
        if ( pro < 0 )
        {
            pro = 0;
        }

        this.protein = pro;
    }
        
    public double getFat() {
        return this.fat;
    }

    private void setFat ( double fat )
    {
        if ( fat < 0 )
        {
            fat = 0;
        }

        this.fat = fat;
    }

}
