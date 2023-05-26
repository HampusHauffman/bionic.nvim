" Title:        Bionic
" Description:  A plugin for Bionic Reading

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 Bionic lua require("bionic").toggle()
command! -nargs=0 BionicOff lua require("bionic").off()
command! -nargs=0 BionicOn lua require("bionic").on()
