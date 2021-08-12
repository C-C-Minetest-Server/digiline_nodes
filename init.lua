--[[
This file is a part of digiline_nodes.

Copyright (C) 2021 Cato Yiu and other contributers

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]
local MN = minetest.get_current_modname()
local MP = minetest.get_modpath(MN)
local S = minetest.get_translator(MN)
digiline_nodes = {}
local _dn = digiline_nodes
function _dn.register_digiline_node(mod,node)
  local nodename = mod .. ":" .. node
  local digi_nodename = MN .. ":" .. mod .. "__" .. node
  local ndef = minetest.registered_nodes[nodename]
  if not(ndef) then
    minetest.log("warning","Not registering `" .. nodename ..
      "`'s digiline node since it does not exist")
    return
  end
  local digi_ndef = table.copy(ndef)
  digi_ndef.description = S("Digiline Condused @1",ndef.description or nodename)
  if ndef.long_description then
    digi_ndef.long_description = S("Digiline condused version of @1",ndef.long_description)
  end
  digi_ndef.digiline = {
    wire = {
      rules = {
        {x = 1, y = 0, z = 0},
        {x =-1, y = 0, z = 0},
        {x = 0, y = 1, z = 0},
        {x = 0, y =-1, z = 0},
        {x = 0, y = 0, z = 1},
        {x = 0, y = 0, z =-1}
      }
    }
  }
  digi_ndef.is_ground_content = false
  if not digi_ndef.group then digi_ndef.group = {} end
  digi_ndef.group.digiline_node = 1
  minetest.register_node(digi_nodename,digi_ndef)
end

local domod = function(mn)
  dofile(MP .. "/mods/" .. mn .. ".lua")
end
if minetest.get_modpath("default") then
  domod("default")
end
if minetest.get_modpath("ethereal") then
  domod("ethereal")
end
