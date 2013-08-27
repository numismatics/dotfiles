import XMonad
import XMonad.Core
import XMonad.Layout
import XMonad.Layout.IM
import XMonad.Layout.Gaps
import XMonad.Layout.Named
import XMonad.Layout.Tabbed
import XMonad.Layout.OneBig
import XMonad.Layout.Master
import XMonad.Layout.Reflect
import XMonad.Layout.MosaicAlt
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.SimplestFloat
import XMonad.Layout.NoBorders (noBorders,smartBorders,withBorder)
import XMonad.Layout.ResizableTile
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Minimize
import XMonad.Layout.Maximize
import XMonad.Layout.WindowNavigation

import XMonad.Util.Loggers

import XMonad.Hooks.DynamicHooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Util.Timer
import XMonad.Util.Cursor
import XMonad.Util.EZConfig

import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize

import Data.IORef
import Data.Monoid
import Data.List

import Graphics.X11.ExtraTypes.XF86

import System.Exit
import System.IO (Handle, hPutStrLn)
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified XMonad.Util.ExtensibleState as XS

main :: IO ()
main = do  
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"   
  xmonad $ defaultConfig   
    { manageHook = manageScratchPad <+> manageDocks <+> manageHook defaultConfig  
    , layoutHook = avoidStruts $ layoutHook defaultConfig  
    , terminal = "urxvt" 
    , workspaces = myWorkspaces 
    , logHook = logHook defaultConfig <+> dynamicLogWithPP xmobarPP { ppOutput = hPutStrLn xmproc }
    }
    `additionalKeysP`
    [ ("M-g", goToSelected defaultGSConfig)
    , ("M-d", scratchPad)
    ]

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["α", "β" ,"γ", "δ", "ε", "ζ", "η", "θ", "ι"]

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect (0) (1/50) (1) (3/4))
scratchPad = scratchpadSpawnActionCustom "xterm -bg black -fg white -cr green -name scratchpad"
