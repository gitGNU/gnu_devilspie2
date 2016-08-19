-- Support Awesome 3.5 WM

local posix	= require("posix");
local os		= require("os");

local awesome = "/usr/bin/awesome-client"
if not posix.stat(awesome, "type") == "file" then
	awesome = nil;
end

-- Check for tiling mode
function is_tiling()
	if awesome then
		return true;
	end
	return false;
end

-- Make window floating 
-- Parameters: state - true to make window floating, else make window tiled
function set_tile_floating( state )
	if not awesome then
		return nil;
	end

	if state then state = "true" else state = "false" end

	local xid = get_window_xid();

	local command = "echo ";
	command = command .. "'";
	command = command .. " local naughty    = require(\"naughty\");";
	command = command .. " local awcl       = require(\"awful.client\");";
	command = command .. " local client     = require(\"client\");";
	command = command .. " for k, c in pairs( client.get() ) do";
	command = command .. "     if c.window == " .. xid .. " then";
	command = command .. "         awcl.floating.set(c, " .. state .. ");";
	command = command .. "    end";
	command = command .. " end";
	command = command .. "'";
	command = command .. " | ";
	command = command .. awesome;

	debug_print("Awesome floating: " .. command);
	return os.execute( command );
end
