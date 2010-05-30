
Plugin.define do
  name    "help"
  version "1.0"
  file    "lib", "help_plugin"
  object  "Redcar::Help"
  dependencies "redcar", ">0"
end
