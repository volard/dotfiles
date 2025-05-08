---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
local c = xplr.config
---@diagnostic enable

-- ### Node Types -------------------------------------------------------------
--
-- This section defines how to deal with different kinds of nodes (files,
-- directories, symlinks etc.) based on their properties.
--
-- One node can fall into multiple categories. For example, a node can have the
-- *extension* `md`, and also be a *file*. In that case, the properties from
-- the more  specific category i.e. *extension* will be used.
--
-- This can be configured using the `c.node_types` Lua API.

-- The style for the directory nodes
--
-- Type: [Style](https://xplr.dev/en/style)
c.node_types.directory.style = {}

-- Metadata for the directory nodes.
-- You can set as many metadata as you want.
--
-- Type: nullable string
--
-- Example:
--
-- ```lua
-- c.node_types.directory.meta.foo = "foo"
-- c.node_types.directory.meta.bar = "bar"
-- ```
c.node_types.directory.meta.icon = ""

-- The style for the file nodes.
--
-- Type: [Style](https://xplr.dev/en/style)
c.node_types.file.style = {}

-- Metadata for the file nodes.
-- You can set as many metadata as you want.
--
-- Type: nullable string
--
-- Example:
--
-- ```lua
-- c.node_types.file.meta.foo = "foo"
-- c.node_types.file.meta.bar = "bar"
-- ```
c.node_types.file.meta.icon = ""

-- The style for the symlink nodes.
--
-- Type: [Style](https://xplr.dev/en/style)
c.node_types.symlink.style = {}

-- Metadata for the symlink nodes.
-- You can set as many metadata as you want.
--
-- Type: nullable string
--
-- Example:
--
-- ```lua
-- c.node_types.symlink.meta.foo = "foo"
-- c.node_types.symlink.meta.bar = "bar"
-- ```
c.node_types.symlink.meta.icon = ""

-- Metadata and style based on mime types.
-- It is possible to use the wildcard `*` to match all mime sub types. It will
-- be overwritten by the more specific sub types that are defined.
--
-- Type: mapping of the following key-value pairs:
--
-- * key: string
-- * value:
--   * key: string
--   * value: [Node Type](https://xplr.dev/en/node-type)
--
-- Example:
--
-- ```lua
c.node_types.mime_essence = {
	application = {
		-- application/*
		["*"] = { meta = { icon = "" }, style = { fg = "Yellow" } },

		-- application/pdf
		pdf = { meta = { icon = "" }, style = { fg = "Blue" } },

		-- application/zip
		zip = { meta = { icon = "" } },

		image = {
			["*"] = { meta = { icon = "" } },
		},

		text = {
			["*"] = { meta = { icon = "" } },
		},

		video = {
			["*"] = { meta = { icon = "" } },
		},
	},
}
-- ```
c.node_types.mime_essence = {}

--- devicons

-- not really correct way, but ok
local function red(x)
  return "\x1b[31m" .. x .. "\x1b[0m"
end

local function yellow(x)
  return "\x1b[33m" .. x .. "\x1b[0m"
end

local function blue(x)
  return "\x1b[34m" .. x .. "\x1b[0m"
end

local function white(x)
  return "\x1b[37m" .. x .. "\x1b[0m"
end


c.node_types.extension.COPYING = { meta = { icon = "" } }
c.node_types.extension.Rmd = { meta = { icon = "" } }
c.node_types.extension.ai = { meta = { icon = "" } }
c.node_types.extension.awk = { meta = { icon = "" } }
c.node_types.extension.bash = { meta = { icon = "" } }
c.node_types.extension.bat = { meta = { icon = "" } }
c.node_types.extension.bmp = { meta = { icon = "" } }
c.node_types.extension.c = { meta = { icon = "" } }
c.node_types.extension.cc = { meta = { icon = "" } }
c.node_types.extension.cfg = { meta = { icon = "" } }
c.node_types.extension.clj = { meta = { icon = "" } }
c.node_types.extension.cljc = { meta = { icon = "" } }
c.node_types.extension.cljs = { meta = { icon = "" } }
c.node_types.extension.cmake = { meta = { icon = "" } }
c.node_types.extension.coffee = { meta = { icon = "" } }
c.node_types.extension.conf = { meta = { icon = "" } }
c.node_types.extension.cp = { meta = { icon = "" } }
c.node_types.extension.cpp = { meta = { icon = "" } }
c.node_types.extension.csh = { meta = { icon = "" } }
c.node_types.extension.cson = { meta = { icon = "" } }
c.node_types.extension.css = { meta = { icon = "" } }
c.node_types.extension.cxx = { meta = { icon = "" } }
c.node_types.extension.d = { meta = { icon = "" } }
c.node_types.extension.dart = { meta = { icon = "" } }
c.node_types.extension.db = { meta = { icon = "" } }
c.node_types.extension.desktop = { meta = { icon = "" } }
c.node_types.extension.diff = { meta = { icon = "" } }
c.node_types.extension.dockerfile = { meta = { icon = "" } }
c.node_types.extension.dropbox = { meta = { icon = "" } }
c.node_types.extension.dump = { meta = { icon = "" } }
c.node_types.extension.edn = { meta = { icon = "" } }
c.node_types.extension.eex = { meta = { icon = "" } }
c.node_types.extension.ejs = { meta = { icon = "" } }
c.node_types.extension.elm = { meta = { icon = "" } }
c.node_types.extension.erb = { meta = { icon = "" } }
c.node_types.extension.erl = { meta = { icon = "" } }
c.node_types.extension.ex = { meta = { icon = "" } }
c.node_types.extension.exs = { meta = { icon = "" } }
c.node_types.extension.fish = { meta = { icon = "" } }
c.node_types.extension.fs = { meta = { icon = "" } }
c.node_types.extension.fsi = { meta = { icon = "" } }
c.node_types.extension.fsscript = { meta = { icon = "" } }
c.node_types.extension.fsx = { meta = { icon = "" } }
c.node_types.extension.gd = { meta = { icon = "" } }
c.node_types.extension.gemspec = { meta = { icon = "" } }
c.node_types.extension.git = { meta = { icon = "" } }
c.node_types.extension.glb = { meta = { icon = "" } }
c.node_types.extension.go = { meta = { icon = "" } }
c.node_types.extension.godot = { meta = { icon = "" } }
c.node_types.extension.gruntfile = { meta = { icon = "" } }
c.node_types.extension.gulpfile = { meta = { icon = "" } }
c.node_types.extension.h = { meta = { icon = "" } }
c.node_types.extension.haml = { meta = { icon = "" } }
c.node_types.extension.hbs = { meta = { icon = "" } }
c.node_types.extension.hh = { meta = { icon = "" } }
c.node_types.extension.hpp = { meta = { icon = "" } }
c.node_types.extension.hrl = { meta = { icon = "" } }
c.node_types.extension.hs = { meta = { icon = "" } }
c.node_types.extension.htm = { meta = { icon = "" } }
c.node_types.extension.html = { meta = { icon = "" } }
c.node_types.extension.hxx = { meta = { icon = "" } }
c.node_types.extension.ico = { meta = { icon = "" } }
c.node_types.extension.import = { meta = { icon = "" } }
c.node_types.extension.ini = { meta = { icon = "" } }
c.node_types.extension.java = { meta = { icon = "" } }
c.node_types.extension.jl = { meta = { icon = "" } }
c.node_types.extension.js = { meta = { icon = "" } }
c.node_types.extension.json = { meta = { icon = "" } }
c.node_types.extension.jsx = { meta = { icon = "" } }
c.node_types.extension.ksh = { meta = { icon = "" } }
c.node_types.extension.kt = { meta = { icon = "𝙆" } }
c.node_types.extension.leex = { meta = { icon = "" } }
c.node_types.extension.less = { meta = { icon = "" } }
c.node_types.extension.lhs = { meta = { icon = "" } }
c.node_types.extension.license = { meta = { icon = "" } }
c.node_types.extension.lock = { meta = { icon = red("") } }
c.node_types.extension.lua = { meta = { icon = blue("") } }
c.node_types.extension.markdown = { meta = { icon = "" } }
c.node_types.extension.mjs = { meta = { icon = "" } }
c.node_types.extension.ml = { meta = { icon = "λ" } }
c.node_types.extension.mli = { meta = { icon = "λ" } }
c.node_types.extension.mustache = { meta = { icon = "" } }
c.node_types.extension.nix = { meta = { icon = "" } }
c.node_types.extension.otf = { meta = { icon = "" } }
c.node_types.extension.pck = { meta = { icon = "" } }
c.node_types.extension.php = { meta = { icon = "" } }
c.node_types.extension.pl = { meta = { icon = "" } }
c.node_types.extension.pm = { meta = { icon = "" } }
c.node_types.extension.png = { meta = { icon = "" } }
c.node_types.extension.pp = { meta = { icon = "" } }
c.node_types.extension.procfile = { meta = { icon = "" } }
c.node_types.extension.ps1 = { meta = { icon = "" } }
c.node_types.extension.psb = { meta = { icon = "" } }
c.node_types.extension.psd = { meta = { icon = "" } }
c.node_types.extension.py = { meta = { icon = yellow("") } }
c.node_types.extension.pyc = { meta = { icon = "" } }
c.node_types.extension.pyd = { meta = { icon = "" } }
c.node_types.extension.pyo = { meta = { icon = "" } }
c.node_types.extension.r = { meta = { icon = "ﳒ" } }
c.node_types.extension.rake = { meta = { icon = "" } }
c.node_types.extension.rakefile = { meta = { icon = "" } }
c.node_types.extension.rb = { meta = { icon = "" } }
c.node_types.extension.rlib = { meta = { icon = "" } }
c.node_types.extension.rmd = { meta = { icon = "" } }
c.node_types.extension.rs = { meta = { icon = red("") } }
c.node_types.extension.rss = { meta = { icon = "" } }
c.node_types.extension.sass = { meta = { icon = "" } }
c.node_types.extension.scala = { meta = { icon = "" } }
c.node_types.extension.scss = { meta = { icon = "" } }
c.node_types.extension.sh = { meta = { icon = "" } }
c.node_types.extension.slim = { meta = { icon = "" } }
c.node_types.extension.sln = { meta = { icon = "" } }
c.node_types.extension.sql = { meta = { icon = "" } }
c.node_types.extension.styl = { meta = { icon = "" } }
c.node_types.extension.suo = { meta = { icon = "" } }
c.node_types.extension.svelte = { meta = { icon = "" } }
c.node_types.extension.swift = { meta = { icon = "" } }
c.node_types.extension.t = { meta = { icon = "" } }
c.node_types.extension.terminal = { meta = { icon = "" } }
c.node_types.extension.tex = { meta = { icon = "ﭨ" } }
c.node_types.extension.toml = { meta = { icon = white("") } }
c.node_types.extension.tres = { meta = { icon = "" } }
c.node_types.extension.ts = { meta = { icon = "" } }
c.node_types.extension.tsx = { meta = { icon = "" } }
c.node_types.extension.twig = { meta = { icon = "" } }
c.node_types.extension.vim = { meta = { icon = "" } }
c.node_types.extension.webmanifest = { meta = { icon = "" } }
c.node_types.extension.xcplayground = { meta = { icon = "" } }
c.node_types.extension.xul = { meta = { icon = "" } }
c.node_types.extension.yaml = { meta = { icon = "" } }
c.node_types.extension.yml = { meta = { icon = "" } }
c.node_types.extension.zsh = { meta = { icon = "" } }
c.node_types.extension["c++"] = { meta = { icon = "" } }
c.node_types.extension["f#"] = { meta = { icon = "" } }

-- Metadata and style based on extension.
--
-- Type: mapping of the following key-value pairs:
--
-- * key: string
-- * value: [Node Type](https://xplr.dev/en/node-type)
--
-- Example:
--
-- ```lua
c.node_types.extension.md = { meta = { icon = "" }, style = { fg = "Blue" } }
c.node_types.extension.rs = { meta = { icon = "🦀" } }
-- ```
c.node_types.extension = {}

-- Metadata and style based on special file names.
--
-- Type: mapping of the following key-value pairs:
--
-- * key: string
-- * value: [Node Type](https://xplr.dev/en/node-type)
--
-- Example:
--
-- ```lua
c.node_types.special["Cargo.toml"] = { meta = { icon = "" } }
c.node_types.special["Downloads"] = { meta = { icon = "" }, style = { fg = "Blue" } }
-- ```
c.node_types.special = {}
