
-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Bassim Hawa
-- Description: This is the splash screen of the game. It displays the 
-- company logo.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( splash_screen )

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------
 
-- The local variables for this scene
local logo
local logoOutline
local PhoenixSounds = audio.loadSound("Sounds/Edited Phoenix Roars.mp3")
local PhoenixSoundsChannel
local brightness = 0
local glowdirection = false
--------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------------------------------------------

-- The function that moves the logo across the screen and spin
local function glow()
    
    if glowdirection then
        brightness = brightness - 0.01
    else
        brightness = brightness + 0.01
    end

    if (brightness >= 1) or (brightness <= -0.2) then
        glowdirection = not glowdirection
    end

    logoOutline.fill.effect = "filter.brightness"
    logoOutline.fill.effect.intensity = brightness
end

local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    -- Insert the logo image
    logo = display.newImageRect("Images/Logo.png", 500, 500)

    --Insert the logo outline image
    logoOutline = display.newImageRect("Images/Logo-outline.png", 500, 500)

    -- set the initial x and y position of logo and outline
    logo.x = display.contentWidth/2
    logo.y = display.contentHeight/2

    logoOutline.x = display.contentWidth/2
    logoOutline.y = display.contentHeight/2

    --display the name of the company
    textObject = display.newText( "Chubbienix Corp", display.contentWidth/2, 670, nil, 60 )
    textObject:setTextColor(255/255, 0/255, 0/255)
   
    --display the name of the company again but slightly higher and with a different colour
    --in order to make it look better
    textObject2 = display.newText( "Chubbienix Corp", display.contentWidth/2, 680, nil, 60 )
    textObject2:setTextColor(0/255, 255/255, 0/255)

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
    sceneGroup:insert( logoOutline )
    sceneGroup:insert( textObject )
    sceneGroup:insert( textObject2 )

end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        PhoenixSoundsChannel = audio.play(PhoenixSounds)

        -- Call the glow function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", glow)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
        -- stop the phoenix sounds channel for this screen
        audio.stop(PhoenixSoundsChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    
    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
