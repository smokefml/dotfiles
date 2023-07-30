----------------------------------
--         ____ _   __ __       --
--        / __// \,' // /       --
--       / _/ / \,' // /_       --
--      /_/  /_/ /_//___/       --
----------------------------------

local vars = {}

-- {{{ Variable definitions
-- Global variables
vars.modkey = "Mod4"
-- Apps
vars.terminal = os.getenv("TERMINAL") or "alacritty"
vars.editor = os.getenv("EDITOR") or "nano"
vars.editor_cmd = vars.terminal .. " -e " .. vars.editor
vars.guieditor = "code --unity-launch"
vars.guifileexplorer = "pcmanfm-qt"
vars.musicplayer = "spotify-launcher"
-- Other values
-- export these variables and any other you might need
vars.weather_key = os.getenv("OPENWEATHER_KEY")
vars.weather_coordx = os.getenv("MYCOORDSX")
vars.weather_coordy = os.getenv("MYCOORDSY")
-- }}}
return vars
