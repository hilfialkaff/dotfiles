--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad

import XMonad.Actions.PhysicalScreens
import XMonad.Actions.WindowGo
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Layout.Named
import XMonad.Layout.ResizableTile
import XMonad.Operations
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run
--import XMonad.Util.WorkspaceCompare

import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import Panel
import SpecialKeys
import WorkspaceCompare

myTopStatusBar :: String
myTopStatusBar = "/home/raijin/.xmonad/scripts/topstatusbar.sh"

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm -bg black -fg green -e /bin/zsh"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod1Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff00ff"

-- My XPKeymap for my XPConfig
myXPKeymap = M.insert (controlMask, xK_bracketleft) quit defaultXPKeymap

-- My XPConfig for shellPrompt. Used to launch applications.
myXPConfig = defaultXPConfig
    { position = Top
    , promptKeymap = myXPKeymap
    }

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    -- , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    -- launch shellPrompt
    , ((modm              , xK_p     ), shellPrompt myXPConfig)

    -- launch gmrun
    -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    ---- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    -- , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), do io killPanels; recompile False; restart "xmonad" True)

    -- Shrink mirror
    , ((modm .|. shiftMask, xK_h     ), sendMessage MirrorShrink)

    -- Expand mirror
    , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- Lower master volume.
    , ((0, xK_XF86AudioLowerVolume), spawn "amixer -q set Master 1dB-")

    -- Raise master volume.
    , ((0, xK_XF86AudioRaiseVolume), spawn "amixer -q set Master 1dB+")

    -- Locks the screen.
    , ((modm .|. shiftMask, xK_backslash), spawn "xlock")

    -- Takes screenshot
    , ((modm              , xK_Print), spawn "scrot /home/raijin/files/pictures/screen_%Y-%m-%d.png -d 1")

    -- Open mail.
    , ((modm, xK_o), raiseMaybe (runInTerm "-title mutt" "bash -c 'mutt'") (title =? "mutt"))

    -- Synchronize mail.
    , ((modm, xK_p), spawn "fetchmail")

    -- Open calendar.
    , ((modm, xK_c), raiseMaybe (runInTerm "-title calcurse" "bash -c 'calcurse'") (title =? "calcurse"))

    -- Pause/play music
    , ((modm              , xK_a), spawn "cmus-remote -u")

    -- Play next music
    , ((modm              , xK_d), spawn "cmus-remote -n")

    -- Play prev music
    , ((modm              , xK_s), spawn "cmus-remote -r")

    -- Play prev music
    , ((modm              , xK_z), spawn "cmus-remote -k 0")

    -- Synchronize mail.
    , ((modm, xK_v), spawn "virtualbox")

    ---- Use disper to extend screen to left, up, right, down
    , ((modm .|. controlMask, xK_Left), spawn "disper -e -t left && killall topstatusbar && xmonad --restart")
    , ((modm .|. controlMask, xK_Up), spawn "disper -e -t up && killall topstatusbar && xmonad --restart")
    , ((modm .|. controlMask, xK_Right), spawn "disper -e -t right && killall topstatusbar && xmonad --restart")
    , ((modm .|. controlMask, xK_Down), spawn "disper -e -t down && killall topstatusbar && xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    --
    -- Use physical screens
    [((modm .|. mask, key), f sc)
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $ named "[]=" tiled ||| named "TTT" (Mirror tiled) ||| named "[=]" Full
  where
     -- default tiling algorithm partitions the screen into two panes
     --tiled   = Tall nmaster delta ratio
     tiled   = ResizableTall nmaster delta ratio []

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll . concat $
    [ [className =? "feh"            --> doFloat]
    , [className =? "Gimp"           --> doFloat]
    , [resource  =? "desktop_window" --> doIgnore]
    , [resource  =? "kdesktop"       --> doIgnore]
    , [title     =? "mutt"           --> doRectFloat defaultFloatRect]
    , [title     =? "calcurse"           --> doRectFloat defaultFloatRect]
    , [title     =? "qemu"           --> doRectFloat defaultFloatRect]
    , [isFullscreen                  --> doFullFloat]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "1" | x <- my1Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "2" | x <- my2Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "3" | x <- my3Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "4" | x <- my4Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "5" | x <- my5Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "6" | x <- my6Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "7" | x <- my7Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "8" | x <- my8Shifts]
    , [(className =? x <||> title =? x <||> resource =? x) --> doShift "9" | x <- my9Shifts]
    ]
    where
        defaultFloatRect = W.RationalRect 0 0 0.5 0.5
        my1Shifts = ["htop"]
        my2Shifts = ["Skype"]
        my3Shifts = ["cmus", "spotify"]
        my4Shifts = ["Firefox"]
        my5Shifts = []
        my6Shifts = ["evince", "okular"]
        my7Shifts = []
        my8Shifts = []
        my9Shifts = []

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--

-- My PP to be used with DynamicLog.
myPP = defaultPP {
    ppSort = getSortByXineramaPhysicalRule
}

-- myLogHook pipes = dynamicLogWithPP myPP {
myLogHook pipes = dynamicLogWithPP $ defaultPP {
    ppOutput = (\s -> mapM_ (\pipe -> hPutStrLn pipe s) pipes),
    ppCurrent = dzenColor "yellow" "black",
    ppVisible = dzenColor "lightyellow" "",
    ppHidden = dzenColor "white" "",
    ppHiddenNoWindows = dzenColor "#444444"  "",
    ppUrgent = dzenColor "" "red",
    ppTitle = dzenColor "cyan" "" . shorten 50
}

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
	-- Trick Java so that it thinks XMonad is a non-reparenting WM.
	setWMName "LG3D"

    -- Start up programs
	spawn "~/.fehbg"
	spawn "/usr/bin/xterm -bg black -fg green -T wicd-curses wicd-curses"
	spawn "/usr/bin/xterm -bg black -fg green -T htop htop"
	spawn "/usr/bin/xterm -T spotify spotify"
	spawn "/usr/bin/firefox"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    pipes <- spawnPanels
    topStatusBar <- spawnPipe myTopStatusBar
    xmonad $ myXConfig pipes

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
myXConfig pipes = withUrgencyHook NoUrgencyHook defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        -- numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook pipes,
        startupHook        = myStartupHook
    }

--defaults = defaultConfig {
--      -- simple stuff
--        terminal           = myTerminal,
--        focusFollowsMouse  = myFocusFollowsMouse,
--        borderWidth        = myBorderWidth,
--        modMask            = myModMask,
--        numlockMask        = myNumlockMask,
--        workspaces         = myWorkspaces,
--        normalBorderColor  = myNormalBorderColor,
--        focusedBorderColor = myFocusedBorderColor,
--
--      -- key bindings
--        keys               = myKeys,
--        mouseBindings      = myMouseBindings,
--
--      -- hooks, layouts
--        layoutHook         = myLayout,
--        manageHook         = myManageHook,
--        handleEventHook    = myEventHook,
--        logHook            = myLogHook,
--        startupHook        = myStartupHook
--    }
