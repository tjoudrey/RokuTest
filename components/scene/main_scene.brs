sub init()
	? "[main_scene] init"
    m.scene = m.top.getScene()
    m.splash = m.top.findNode("Splash")
    m.busyspinner = m.top.findNode("LoadingSpinner")
    m.mainscreen = m.top.findNode("MainScreen")
    m.detailscreen = m.top.findNode("DetailsScreen")
    m.busyspinner.poster.observeField("loadStatus", "showspinner")
    m.busyspinner.poster.uri = "pkg:/images/busyspinner_hd.png"

    loadCocktails()
end sub

function onKeyEvent(key, press) as Boolean
	? "[home_scene] onKeyEvent", key, press

    if key = "back" and press
        if m.detailscreen.visible
            m.detailscreen.visible = false
            return true
        end if
    end if

end function


sub loadCocktails()
    ? "[main_scene] loading cocktails "
    m.feed_task = createObject("roSGNode", "load_feed_task")
    m.feed_task.observeField("response", "onCocktailListResponse")
    m.feed_task.url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    m.feed_task.control = "RUN"
end sub

sub onCocktailListResponse(obj)
	response = obj.getData() 
	data = parseJSON(response)
    showMainScreen(data.drinks)
end sub

sub loadCocktailDetails(id)
    ? "[main_scene] loading cocktail for " id
    m.feed_task = createObject("roSGNode", "load_feed_task")
    m.feed_task.observeField("response", "onLoadCocktailDetailsResponse")
    m.feed_task.url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="+id
    m.feed_task.control = "RUN"
end sub 

sub onLoadCocktailDetailsResponse(obj)
    ? "[main_scene] loaded cocktail"
	response = obj.getData() 
    data = parseJSON(response)
    m.detailscreen.callFunc("onCocktailLoaded", data.drinks[0])

end sub 

sub showMainScreen(cocktails)
    ? "[main_scene] showing main screen "
    m.splash.visible = false
    m.busyspinner.visible = false
    m.mainscreen.cocktails = cocktails
    m.mainscreen.visible = true

end sub

sub onCocktailSelected(params)
    ? "[main_scene] showing details"
    loadCocktailDetails(params.id)
end sub

sub onCocktailExited(params)
    ? "[main_scene] closing details"
    m.detailscreen.visible = false
    m.cocktail_details.setFocus(true)
end sub