module Panel
( spawnPanels
, killPanels
) where

import Data.List(intercalate)
import System.IO(Handle)

import Graphics.X11.Xlib
import Graphics.X11.Xinerama

import XMonad
import XMonad.Util.Run(spawnPipe)

data DzenFlags = DzenFlags {
    dzen_x :: Integer,
    dzen_y :: Integer,
    dzen_w :: Integer,
    dzen_fn :: String,
    dzen_fg :: String,
    dzen_bg :: String,
    dzen_ta :: String,
    dzen_extra :: String
}

defaultDzenFlags = DzenFlags {
    dzen_x = 0,
    dzen_y = 0,
    dzen_w = 1366,
    dzen_fn = "-*-fixed-*-*-*-*-12-*-*-*-*-*-*-*",
    dzen_fg = "cyan",
    dzen_bg = "black",
    dzen_ta = "l",
    dzen_extra = ""             -- This should only single quotes in it.
}

dzen :: DzenFlags -> String
dzen conf = intercalate " "
    [ "dzen2"
    , "-x"  , show $ dzen_x conf
    , "-y"  , show $ dzen_y conf
    , "-w"  , show $ dzen_w conf
    , "-fn" , singleQuote $ dzen_fn conf
    , "-fg" , dzen_fg conf
    , "-bg" , dzen_bg conf
    , "-ta" , dzen_ta conf
    , dzen_extra conf
    ]

singleQuote :: String -> String
singleQuote s = "'" ++ s ++ "'"

doubleQuote :: String -> String
doubleQuote s = "\"" ++ s ++ "\""

rectToDynamicLogDzen :: Rectangle -> String
rectToDynamicLogDzen (Rectangle x y w h) = dzen defaultDzenFlags {
    dzen_x = round (fromIntegral x),
    dzen_y = round (fromIntegral y),
    dzen_w = round (fromIntegral w / 2),
    dzen_ta = "l"
}

rectToMonitorDzen :: Rectangle -> String
rectToMonitorDzen (Rectangle x y w h) = dzen defaultDzenFlags {
    dzen_x = round (fromIntegral x + fromIntegral w / 2),
    dzen_y = round (fromIntegral y),
    dzen_w = round (fromIntegral w / 2),
    dzen_ta = "r"
}

getScreens :: IO [Rectangle]
getScreens = do
    d <- openDisplay ""
    screens <- getScreenInfo d
    closeDisplay d
    return screens

spawnPanels :: IO [Handle]
spawnPanels = do
    screens <- getScreens
    -- let outplexArgs = map (doubleQuote . rectToMonitorDzen) screens
    -- spawn $ "conky -c ~/.conky/monitor | outplex " ++ intercalate " " outplexArgs ++ " > /dev/null"
    -- spawn $ "/home/aurum/downloads/topstatusbar.sh"
    mapM (spawnPipe . rectToDynamicLogDzen) screens

killPanels :: IO ()
killPanels = do
    spawn "killall conky"
    return ()
