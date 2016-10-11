# -*- encoding: utf-8 -*-


# == Options
# Window move/resize steps in pixel per keypress
set :increase_step, 5

# Window screen border snapping
set :border_snap, 10

# Default starting gravity for windows. Comment out to use gravity of
# currently active client
set :default_gravity, :center

# Make dialog windows urgent and draw focus
set :urgent_dialogs, false

# Honor resize size hints globally
set :honor_size_hints, false

# Enable gravity tiling for all gravities
set :gravity_tiling, false

# Enable click-to-focus focus model
set :click_to_focus, false

# Skip pointer movement on e.g. gravity change
set :skip_pointer_warp, false

# Skip pointer movement to urgent windows
set :skip_urgent_warp, false


# == Screen
screen 1 do
  top    [ :views, :spacer, :keychain, :spacer, :tray, :cpu, :memory, :pacman, :mpd, :clock ]
  bottom [ ]
end


# == Styles
# Style for all style elements
style :all do
  background  "#161719"
  icon        "#bcbcbc"
  border      "#212224", 1
  padding     2, 8, 0, 8
  font        "xft:anorexia-8"
end

# Style for the all views
style :views do
  foreground  "#727375"
  background  "#161719"

  # Style for the active views
  style :focus do
    foreground  "#727375"
    background  "#161719"
    padding     2, 8, 0, 8
    icon        "#a6e22e"
  end

  # Style for urgent window titles and views
  style :urgent do
    foreground  "#d3c6d7"
    background  "#161719"
  end

  # Style for occupied views (views with clients)
  style :occupied do
    padding     2, 8, 0, 8
    foreground  "#d3c6d7"
    background  "#161719"
    icon        "#e85b92"
  end
end

# Style for sublets
style :sublets do
  foreground  "#727375"
  icon        "#e85b92"
end

# Style for separator
style :separator do
  foreground  "#1f1f1f"
  separator   "|"
end

# Style for focus window title
style :title do
  foreground  "#fecf35"
end

# Style for active/inactive windows
style :clients do
  active    "#e85b92", 1
  inactive  "#161719", 1
  margin    0
  width     50
end

# Style for subtle
style :subtle do
  margin      2, 10, 0, 10
  panel       "#161719"
  background  "#0f0f0f"
  stipple     "#757575"
end


# == Gravities
# Top left
gravity :top_left,       [   0,   0,  50,  50 ]
gravity :top_left66,     [   0,   0,  50,  66 ]
gravity :top_left33,     [   0,   0,  50,  34 ]

# Top
gravity :top,            [   0,   0, 100,  50 ]
gravity :top66,          [   0,   0, 100,  66 ]
gravity :top33,          [   0,   0, 100,  34 ]

# Top right
gravity :top_right,      [  50,   0,  50,  50 ]
gravity :top_right66,    [  50,   0,  50,  66 ]
gravity :top_right33,    [  50,   0,  50,  33 ]

# Left
gravity :left,           [   0,   0,  50, 100 ]
gravity :left66,         [   0,   0,  66, 100 ]
gravity :left33,         [   0,   0,  33, 100 ]

# Center
gravity :center,         [   0,   0, 100, 100 ]
gravity :center66,       [  17,  17,  66,  66 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Right
gravity :right,          [  50,   0,  50, 100 ]
gravity :right66,        [  34,   0,  66, 100 ]
gravity :right33,        [  67,   0,  33, 100 ]

# Bottom left
gravity :bottom_left,    [   0,  50,  50,  50 ]
gravity :bottom_left66,  [   0,  34,  50,  66 ]
gravity :bottom_left33,  [   0,  67,  50,  33 ]

# Bottom
gravity :bottom,         [   0,  50, 100,  50 ]
gravity :bottom66,       [   0,  34, 100,  66 ]
gravity :bottom33,       [   0,  67, 100,  33 ]

# Bottom right
gravity :bottom_right,   [  50,  50,  50,  50 ]
gravity :bottom_right66, [  50,  34,  50,  66 ]
gravity :bottom_right33, [  50,  67,  50,  33 ]

# Gimp
gravity :gimp_image,     [  10,   0,  80, 100 ]
gravity :gimp_toolbox,   [   0,   0,  10, 100 ]
gravity :gimp_dock,      [  90,   0,  10, 100 ]

# == Grabs
# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4

# Select next and prev view */
grab "KP_Add",      :ViewNext
grab "KP_Subtract", :ViewPrev

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

# Kill current window
grab "W-S-k", :WindowKill

# Cycle between given gravities
grab "W-KP_7", [ :top_left,     :top_left66,     :top_left33     ]
grab "W-KP_8", [ :top,          :top66,          :top33          ]
grab "W-KP_9", [ :top_right,    :top_right66,    :top_right33    ]
grab "W-KP_4", [ :left,         :left66,         :left33         ]
grab "W-KP_5", [ :center,       :center66,       :center33       ]
grab "W-KP_6", [ :right,        :right66,        :right33        ]
grab "W-KP_1", [ :bottom_left,  :bottom_left66,  :bottom_left33  ]
grab "W-KP_2", [ :bottom,       :bottom66,       :bottom33       ]
grab "W-KP_3", [ :bottom_right, :bottom_right66, :bottom_right33 ]

# Exec programs
grab "W-Return", "urxvt"
grab "W-p", "gmrun"
grab "W-F1", "google-chrome"
grab "W-F2", "pidgin"
grab "W-F3", "gvim"

grab "W-F4", "urxvt -e weechat-curses"
grab "W-F5", "urxvt -e rtorrent"
grab "W-F6", "urxvt -e mutt"
grab "W-F7", "gimp"
grab "W-F8", "tuxguitar"
grab "W-F9", "urxvt -e htop"
grab "W-F10", "leafpad"
grab "W-F11", "libreoffice --writer"

# Run Ruby lambdas
#grab "S-F2" do |c|
#  puts c.name
#end

#grab "S-F3" do
#  PUTS sUbtlext::VERSION
#end


# == Tags
tag "terms" do
  match "xterm|[u]?rxvt|gnome-terminal"
  float true
end

tag "browser" do
    match "firefox|google-chrome"
    float true
    resize true
end

tag "media" do
  match "tuxguitar|gimp|nitrogen|gpicview|spacefm|mplayer|xarchiver|vlc"
  float true
end

tag "editor" do
  match  "leafpad|libreoffice"
  float  true
  resize true
end

tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "gravity" do
  gravity :center
end

tag "float" do
  match "display"
  float true
end

tag "flash" do
  match "<unknown>|plugin-container|exe|operapluginwrapper|npviewer.bin" 
  stick true
end

tag "games" do
  match "techinic-launcher|minecraft"
  float true
end

# == Views
view "Term" do
  match "terms"
  #icon "/home/goku/dzen/terminal.xbm"
end

view "Web" do   
  match "browser"
  #icon "/home/goku/dzen/world.xbm"
end

view "Media" do
  match "gimp_.*|media"
  #icon "/home/goku/dzen/tv.xbm"
end

view "Gamez" do
  match "games"
  #icon "/home/goku/dzen/misc.xbm"
end

# == Sublets
sublet :clock do
  interval      30
  format_string "%I:%M %p"
end

sublet :mpd do
  show_icons false
end

# == Hooks
on :start do
  Subtlext::Subtle.spawn "nitrogen --restore" 
end

on :start do
  Subtlext::Subtle.spawn "compton -cCGfF -o 0.38 -O 200 -I 200 -t 0.02 -l 0.02 -r 3.2 -D2 -m 0.88"
end

# vim:ts=2:bs=2:sw=2:et:fdm=marker
