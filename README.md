# `nvim-depoxy` 🐇

This is my [Vim][Vim]-to-[Neovim][Neovim] crossover config.

It's an `init.lua` and related config that I hacked together in 2025
after fifteen years of building a very custom `.vimrc` config.

(I feel a little late to the Neovim game, but considering how
many awesome Neovim features and plugins have emerged in the
past few years, perhaps I'm arriving at just the right time!)

## Setup

You really don't want to run this config!

Though if you wanted, you could symlink `~/.config/nvim-depoxy`
to this repo's `.config/nvim`, and then run
`NVIM_APPNAME=nvim-depoxy nvim` to use it.

- See [`:help NVIM_APPNAME`][NVIM_APPNAME] for details on managing
  and running multiple Neovim *distros* .

## Status

This project is mostly a reference project, and no further work
is planned  — I've since started a new Neovim distribution based
on the elegant, versatile, and feature-rich [LazyVim][LazyVim]
Neovim config.

- You can find my latest config at [`nvim-lazyb`][nvim-lazyb]:

    https://github.com/landonb/nvim-lazyb 🧸

- `nvim-lazyb` is mostly stock [LazyVim][LazyVim] with additional
  features I've pulled from this project — so if you use LazyVim,
  it'll look and feel like LazyVim, but with lots of *bonus* goodies.

### Old Vim Config

You'll also find a usable Vim config in this repo that (mostly) still
works, but there are no guarantees that it'll continue to work, as
I've stopped running Vim altogether.

## Roadmap

This project is unlikely to disappear completely, as it's still a
nice demonstration of the Vim config I used throughout the 2010s.

But all new Neovim development is being done to the newer
[`nvim-lazyb`][nvim-lazyb] distro.

See also a few [shell functions] and a Neovim launcher
(called [`gvim-open-kindness`][gvim-open-kindness]) that I use to
manage multiple Neovim instances, versions, and plugin distributions.

[Vim]: https://www.vim.org/

[Neovim]: https://neovim.io/

[LazyVim]: https://www.lazyvim.org/

[nvim-lazyb]: https://github.com/landonb/nvim-lazyb#🧸

[shell functions]: https://github.com/DepoXy/depoxy/blob/1.9.8/core/alias-vim.sh

[gvim-open-kindness]: https://github.com/DepoXy/gvim-open-kindness#🐬

[NVIM_APPNAME]: https://neovim.io/doc/user/starting.html#_nvim_appname

