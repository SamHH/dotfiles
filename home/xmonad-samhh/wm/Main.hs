{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Main (main) where

import           Color                       (Colorscheme (color0, color3),
                                              getColorscheme, hideous)
import qualified Data.Map                    as M
import qualified Key                         as K
import           Layout                      (layout, resetLayout)
import           Spawn                       (Spawn (..), toSpawnable)
import           StatusBar                   (statusBar)
import           Window                      (OnFullscreenDestroy (Exit),
                                              centreRect, disableFloat',
                                              enableFloat',
                                              getFullscreenEventHook,
                                              toggleFloat, toggleFullscreen',
                                              videoRect)
import           Workspace                   (workspaceName, workspaceSwitch,
                                              workspaceView)
import qualified Workspace
import           XMonad                      (ChangeLayout (NextLayout),
                                              IncMasterN (IncMasterN),
                                              Resize (Expand, Shrink),
                                              XConfig (XConfig, borderWidth, clickJustFocuses, focusFollowsMouse, focusedBorderColor, handleEventHook, keys, layoutHook, manageHook, modMask, normalBorderColor, terminal, workspaces),
                                              kill, launch, restart,
                                              sendMessage, spawn, windows,
                                              withFocused, (.|.))
import           XMonad.Actions.CopyWindow   (copyToAll, killAllOtherCopies)
import           XMonad.Config.Desktop       (desktopConfig)
import           XMonad.Hooks.InsertPosition (Focus (..), Position (..),
                                              insertPosition)
import           XMonad.Hooks.ManageDocks    (docks)
import           XMonad.Layout.ResizableTile (MirrorResize (MirrorExpand, MirrorShrink))
import qualified XMonad.StackSet             as W

main :: IO ()
main = launch . docks =<< statusBar . config =<< getColorscheme

appName :: String
appName = "xmonad-samhh-wm"

spawn' :: MonadIO m => Spawn -> m ()
spawn' = spawn . toSpawnable

config cs = desktopConfig
  { terminal = "alacritty"
  , modMask = K.modMask
  , focusFollowsMouse = False
  , clickJustFocuses = False
  , manageHook = insertPosition Below Newer
  , handleEventHook = getFullscreenEventHook Exit
  , workspaces = workspaceName <$> Workspace.workspaces
  , borderWidth = 3
  , normalBorderColor = maybe hideous color0 cs
  , focusedBorderColor = maybe hideous color3 cs
  , layoutHook = layout
  , keys = \cfg@XConfig {XMonad.modMask = super, XMonad.terminal = term} ->
      M.fromList $
        [ ((super, K.xK_Return), spawn term)
        , ((super .|. K.shiftMask, K.xK_q), kill)
        , ((super, K.xK_j), windows W.focusDown)
        , ((super, K.xK_k), windows W.focusUp)
        , ((super .|. K.shiftMask, K.xK_j), windows W.swapDown)
        , ((super .|. K.shiftMask, K.xK_k), windows W.swapUp)
        , ((super .|. K.shiftMask, K.xK_m), windows W.swapMaster)
        , ((super, K.xK_h), sendMessage MirrorShrink <> sendMessage MirrorShrink)
        , ((super, K.xK_l), sendMessage MirrorExpand <> sendMessage MirrorExpand)
        , ((super .|. K.shiftMask, K.xK_h), sendMessage Shrink)
        , ((super .|. K.shiftMask, K.xK_l), sendMessage Expand)
        , ((super, K.xK_r), resetLayout cfg)
        , ((super .|. K.shiftMask, K.xK_r), restart appName True)
        , ((super, K.xK_v), sendMessage NextLayout)
        , ((super, K.xK_f), toggleFullscreen')
        , ((super, K.xK_q), sendMessage . IncMasterN $ (-1))
        , ((super, K.xK_e), sendMessage . IncMasterN $ 1)
        , ((super, K.xK_s), withFocused . toggleFloat $ centreRect)
        , ((super, K.xK_a), windows copyToAll <> withFocused (enableFloat' videoRect))
        , ((super .|. K.shiftMask, K.xK_a), killAllOtherCopies <> withFocused disableFloat')
        , ((super, K.xK_o), spawn' CloseNotif)
        , ((super .|. K.shiftMask, K.xK_o), spawn' CloseAllNotifs)
        , ((K.nomod, K.xK_VolDown), spawn' DecVol)
        , ((K.nomod, K.xK_VolUp), spawn' IncVol)
        , ((super, K.xK_VolDown), spawn' DecVolMpv)
        , ((super, K.xK_VolUp), spawn' IncVolMpv)
        , ((K.nomod, K.xK_ToggleMute), spawn' ToggleMuteOutput)
        , ((super, K.xK_ToggleMute), spawn' ToggleMuteInput)
        , ((K.nomod, K.xK_MediaPrev), spawn' PlayPrevMpd)
        , ((K.nomod, K.xK_MediaTogglePlay), spawn' PauseMpd)
        , ((super, K.xK_MediaTogglePlay), spawn' PauseMpv)
        , ((K.nomod, K.xK_MediaNext), spawn' PlayNextMpd)
        , ((super, K.xK_w), spawn' NewWallpaper)
        , ((super, K.xK_p), spawn' TakeScreenshot)
        , ((super, K.xK_g), spawn' Apps)
        , ((super .|. K.shiftMask, K.xK_g), spawn' AllApps)
        , ((super, K.xK_t), spawn' WebSearch)
        , ((super, K.xK_d), spawn' Bookmarks)
        , ((super, K.xK_x), spawn' Passwords)
        , ((super, K.xK_n), spawn' Usernames)
        , ((super, K.xK_m), spawn' Emails)
        ]
          <> (workspaceView super <$> Workspace.workspaces)
          <> (workspaceSwitch super <$> Workspace.workspaces)
  }
