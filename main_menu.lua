-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Bassim
-- Date: May 4, 2018
-- Description: This is the main menu, displaying the credits, instructions & play buttons.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local creditsButton
local instructionsButton
local backgroundMusic = audio.loadSound("Sounds/Phoenix Call.mp3")
local backgroundMusicChannel
-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "credits_screen", {effect = "flipFadeOutIn", time = 500})
end 
-----------------------------------------------------------------------------------------
local function InstructionsTransition( )       
    composer.gotoScene( "instructions_screen", {effect = "flipFadeOutIn", time = 500})
end 
-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "zoomInOutFade", time = 1000})
end    

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------
    -- BACKGROUND IMAGE & STATIC OBJECTS
    -----------------------------------------------------------------------------------------

    -- Insert the background image and set it to the center of the screen
    bkg_image = display.newImage("Images/MainMenuBassimH.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    --display the name of the game
    frinja = display.newText( "FRINJA", display.contentWidth/2, 100, nil, 80 )
    frinja:setTextColor(255/255, 0/255, 0/255)

    frinja2 = display.newText( "FRINJA", display.contentWidth/2, 110, nil, 80 )
    frinja2:setTextColor(0/255, 255/255, 0/255)

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert(frinja)
    sceneGroup:insert(frinja2)

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
            -- Set its position on the screen relative to the screen size
            x = 500, 
            y = 250, 

            width = 300,
            height = 150,


            -- Insert the images here
            defaultFile = "Images/PlayButtonUnpressedRyomaS.png",
            overFile = "Images/PlayButtonPressedRyomaS.png",

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition          
        } )

    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 500,
            y = 650,

            width = 300,
            height = 150,


            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedRyomaS.png",
            overFile = "Images/CreditsButtonPressedRyomaS.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    -- ADD INSTRUCTIONS BUTTON WIDGET
     instructionsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 500,
            y = 450,

            width = 300,
            height = 150,

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedBassimH.png",
            overFile = "Images/InstructionsButtonPressedBassimH.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } ) 
    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert(instructionsButton)
    

end -- function scene:create( event )   



-----------------------------------------------------------------------------------------

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

    -- Called when the scene is now on screen.
    -- Insert code here to make the scene come alive.
    -- Example: start timers, begin animation, play audio, etc.
    elseif ( phase == "did" ) then  
     backgroundMusicChannel = audio.play(backgroundMusic)     
        

    end

end -- function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        audio.stop(backgroundMusicChannel)
    end

end -- function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

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