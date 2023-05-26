# **🅱️io**ni.nvim 
A **ti**ny **pl**ugin to **h**elp **pe**ople **r**ead **c**ode **fa**ster.
![image](https://github.com/HampusHauffman/bionic.nvim/assets/3845743/8ebb44af-9a59-43f6-b80a-4ea24c452f1a)
Screenshot is taken on `Kitty` terminal with `font_family FiraCode Nerd Font` and `dracula`as colortheme
## ⚡️ Requirements
A terminal and a font that supports **BOLD**
## 🚀 Usage
#### `:Bionic` Toggle current buffer
#### `:BionicOn` On current buffer
#### `:BionicOff` Off current buffer

## 📦 Installation
### [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
"HampusHauffman/bionic.nvim",
```
### [Packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use "HampusHauffman/bionic.nvim",
```
## ⚙️ Configuration
Currently there is no config options.
You can turn this on by default with an aucmd:
```lua
vim.cmd([[
  augroup BionicAutocmd
    autocmd!
    autocmd BufRead,BufNewFile * Bionic
  augroup END
]])
```

## 📝 Todo
* Add Configuration option
* Add vim docs for usage
