sub main(externalParams)
    port = CreateObject("roMessagePort")

    screen = CreateObject("roSGScreen")
    scene = screen.createScene("MainScene")
    device = createObject("roDeviceInfo")
    input = CreateObject("roInput")

    screen.setMessagePort(port)
    device.setMessagePort(port)
    input.SetMessagePort(port)

    device.enableLinkStatusEvent(true)

    screen.Show()

    scene.update({
        backgroundColor: "#0E0E0EFF",
        deeplink: externalParams
    }, true) 

    while(true)
        msg = wait(20, port)
        msgType = type(msg)

    end while
end sub