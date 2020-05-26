sub init()
    ? "[details_screen] init"
    m.title = m.top.findNode("title")
    m.glass = m.top.findNode("glass")
    m.ingredients = m.top.findNode("ingredients")
    m.measurements = m.top.findNode("measurments")
    m.instructions = m.top.findNode("instructions")
end sub

sub onCocktailLoaded(cocktail)
    ? "[details_screen] drink loaded"
    m.ingredients.removeChildrenIndex(m.ingredients.getChildCount(),0)
    m.measurements.removeChildrenIndex(m.measurements.getChildCount(),0)

    m.title.text = cocktail.strDrink
    m.glass.text = cocktail.strGlass

    ingredients = parseIngredients(cocktail)
    measurments = parseMeasurments(cocktail)

    ingredientTranslationX = 550
    ingredientTranslationY = 275

    for each i in ingredients
        label = CreateObject("roSGNode", "Label")
        ingredientTranslationY += 50
        label.text = i
        label.translation = "["+Str(ingredientTranslationX)+", "+Str(ingredientTranslationY)+"]"
    

        m.ingredients.appendChild(label)
    end for 

    measurmentTranslationX = 360
    measurmentTranslationY = 275

    for each q in measurments
        label = CreateObject("roSGNode", "Label")
        measurmentTranslationY += 50
        label.text = q
        label.translation = "["+Str(measurmentTranslationX)+", "+Str(measurmentTranslationY)+"]"
        m.measurements.appendChild(label)
    end for 

    m.instructions.text = cocktail.strInstructions

    m.top.visible = true
end sub

function parseIngredients(cocktail)
    out = CreateObject("roList")
    baseKey = "strIngredient"
    keyNum = 1 

    while keyNum <= 15
        key = basekey + Right(StrI(keyNum), Len(StrI(keyNum)) - 1)
        if cocktail[key] = invalid
        else
            if Len(cocktail[key]) > 0
                out.addTail(cocktail[key])
            end if
        end if  
        keyNum += 1
    end while

    return out
end function

function parseMeasurments(cocktail)
    out = CreateObject("roList")
    baseKey = "strMeasure"
    keyNum = 1 

    while keyNum <= 15
        key = basekey + Right(StrI(keyNum), Len(StrI(keyNum)) - 1)
        if cocktail[key] = invalid
        else
            if Len(cocktail[key]) > 0
                out.addTail(cocktail[key])
            end if
        end if  
        keyNum += 1
    end while

    return out
end function