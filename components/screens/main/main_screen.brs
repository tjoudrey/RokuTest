sub init()
    ? "[main_screen] init"
    m.main = m.top.getScene()
    m.cocktailPoster = m.top.findNode("cocktailPoster")
    m.rowlist = m.top.findNode("cocktailRowList")
    m.rowlist.content = CreateObject("roSGNode", "ContentNode")
    m.row1 = m.rowlist.content.createChild("ContentNode")
    m.row2 = m.rowlist.content.createChild("ContentNode")
    m.row1.title = "row 1"
    m.row2.title = "row 2"

    m.top.observeField("visible", "onVisibleChange")
    m.rowlist.observeField("rowItemFocused", "onCocktailFocused")
    m.rowlist.observeField("rowItemSelected", "onCocktailSelected")
    m.rowlist.setFocus(true)

    m.top.ObserveField("cocktails", "onCocktailsUpdated")
end sub

sub onCocktailsUpdated()
    if m.top.cocktails = invalid
        ? "[main_screen] invalid cocktails updated"
    else
        ? "[main_screen] cocktails updated"
        isTopRow = true
        for each drink in m.top.cocktails 
            node = CreateObject("roSGNode", "cocktail")
            node.id = drink.idDrink
            node.title = drink.strDrink
            node.HDPosterUrl = drink.strDrinkThumb
            if isTopRow
                m.row1.appendChild(node)
                isTopRow = false
            else
                m.row2.appendChild(node)
                isTopRow = true
            end if 
        end for
        m.cocktailPoster.uri = m.row1.getChild(0).HDPosterUrl
    end if 
    
end sub

sub onCocktailFocused()
    if m.top.cocktails = invalid
        ? "[main_screen] invalid focus changed"
    else 
        ? "[main_screen] focus changed" m.rowlist.rowItemFocused[0] ", " m.rowlist.rowItemFocused[1]
        if m.rowlist.rowItemFocused[0] = 0 'row 1
            m.cocktailPoster.uri = m.row1.getChild(m.rowlist.rowItemFocused[1]).HDPosterUrl
        end if
        if m.rowlist.rowItemFocused[0] = 1 'row 2
            m.cocktailPoster.uri = m.row2.getChild(m.rowlist.rowItemFocused[1]).HDPosterUrl
        end if
    end if
end sub

sub onCocktailSelected()
    ? "[main_screen] drink selected"
    if m.rowlist.rowItemFocused[0] = 0 'row 1
        if m.rowlist.rowItemFocused[1] = -1
            m.main.callFunc("onCocktailSelected", m.row1.getChild(0))
        else
            m.main.callFunc("onCocktailSelected", m.row1.getChild(m.rowlist.rowItemFocused[1]))
        end if
    end if

    if m.rowlist.rowItemFocused[0] = 1 'row 2
        m.main.callFunc("onCocktailSelected", m.row2.getChild(m.rowlist.rowItemFocused[1]))
    end if
end sub

sub onVisibleChange()
  if m.top.visible = true then
    m.rowlist.setFocus(true)
  end if
end sub