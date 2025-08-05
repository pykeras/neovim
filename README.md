# Neovim Configuration Guide

**Update: August 5, 2025**
> - New: Added support for Flash, a fast navigation/search plugin
> - New: Added Themery for quickly switching between installed themes
  
**Update: August 2, 2025**  

> - New: Now includes support for JavaScript, HTML, CSS, and Tailwind-CSS!
> - Fixed: Mypy inline diagnostics now display correctly in the editor. This was resolved by ensuring the Neovim LSP client and diagnostic settings are properly configured to show virtual text for type-checking feedback.


_This is a **starter configuration** for Neovim, featuring a curated selection of the most useful plugins for **Python**, **Rust** and **JavaScript** development. It's lightweight and highly customizable, suitable for both beginners and advanced users._

![main environment](./images/main.png)

![rust coding](./images/coding.png)

_A basic set of key mappings is included and located in `lua/keymaps.lua`. You can review and customize these mappings to align with your personal preferences._

## Prerequisites

Before proceeding, ensure you meet the following requirements:

Neovim Version: `v0.11.0 - v.11.3`  
Operating System: `Rocky Linux 9.4`, `PopOS 22.04`, `Debian 12.9`, `Android with termux`

## Dependencies:

Ensure the following dependencies are installed for a seamless experience:

- **Ripgrep** (for Telescope):

  ```bash
  sudo dnf install ripgrep
  ```

- **Python venv** (for Python-based plugins):  
  Replace `<minor>` with your Python minor version:

  ```bash
  sudo dnf install python3.<minor>-venv
  ```

- **Clipboard provider** (e.g., xclip):

  ```bash
  sudo dnf install xclip
  ```

- **Node.js & npm** (for LSP support via `nvm`):  
  [Install nvm from GitHub](https://github.com/nvm-sh/nvm).

- **Prettier** (for yaml,js,... formatting)
  ```bash
  npm install -g prettier
  ```

## How to install:

  ```bash
  $ cd ~/.config/nvim
  $ git clone git@github.com:pykeras/neovim.git .
  $ nvim
  ```


## Useful Commands

- **Check Telescope health:**  

  ```vim
  :checkhealth telescope
  ```

- **Save without formatting:**

  ```vim
  :noautocmd write
  ```

- **Install formatters, debuggers, etc. (via Mason):**
  ```vim
  :Mason
  ```


---

## Key Bindings

**Leader Key `<leader>`:**
The leader key is mapped to the spacebar (<Space>).

### General

- **Which Key (Help Menu):** Press `<leader>` to see available shortcuts.
- **Copy to clipboard:** `<leader>y`
- **Paste from clipboard:** `<leader>p`
- **Easier switching between splits:**
  - _Move to the left split:_ `<C-h>`
  - _Move to the right split:_ `<C-l>`
  - _Move to the upper split:_ `<C-k>`
  - _Move to the lower split:_ `<C-j>`
- **Toggle relative line numbers:** `<leader>rl`
- __Clear search highlights:__ `Esc`
- __Escape insert mode:__ `jj`
- **Close all splits except current:** `<leader>qo`

---

### Theme selection
_The default theme is set to `kanagawa-wave`; feel free to change it._
- Theme switcher menu: `tsm`
- Next theme: `tn`
- Previous theme: `tp`

---

### Virtual Environment Selector (Python)

_By default if you have `.venv` in project directory this setup will use that otherwise:_

- **Open selector**: `<leader>vs`
- **Select cached venv**: `<leader>vc`

---

### Debugging

_For python make sure you run `pip install debugpy` in the virtualenv detected/selected._

- **Step into:** `<F2>`
- **Step over:** `<F3>`
- **Step out:** `<F4>`
- **Continue/Start debugging:** `<F5>`
- **Toggle breakpoint:** `<Leader>b`
- **Set conditional breakpoint:** `<F6>`
- **Terminate debugger:** `<F7>`
- **Run last debugging session:** `<F8>`

---

### Flash (Navigation)

- **Flash jump (normal/visual/operator):** `s`
- **Flash Treesitter jump (normal/visual/operator)**: `S`
- **Remote Flash (operator mode):** `r`
- **Treesitter search (operator/visual mode):** `R`
- **Toggle Flash search (command-line mode):** `<C-s>`

---

### Rustaceanvim
* **Show testable functions:** `<leader>rdt`

---

### Telescope

- **Search files:** `<leader>ff`
- **Live grep files:** `<leader>fg`
- __Show TODOs (Telescope):__ `<leader>tt`
- __Show TODOs (loclist):__ `<leader>tl`

---

### NeoTree (File Explorer)

- **Open/Close NeoTree:** `<leader>e`
- __Reveal file in NeoTree:__ `<leader>E`
- __NeoTree filesystem:__ `<leader>nf`
- __Git status NeoTree:__ `<leader>gs`

---

### LSP Configuration

- **Hover documentation:** `K`
- **Go to definition:** `gd`
- **Go to definition (vertical split):** `<leader>gdv`
- **Go to definition (horizontal split):** `<leader>gds`
- **Peek definition:** `<leader>gdp`
- **Code actions:** `<leader>ca`
- **Show method signature (Insert mode):** `<C-k>`

---

### None-ls (Formatting)

- **File global formatting:** `<leader>gf`

---

### Bufferline (Tabs)

- **Select buffer:** `<leader>bs`
- **Cycle next buffer:** `<Tab>`
- **Cycle previous buffer:** `<S-Tab>`
- **Move buffer left:** `<leader>bl`
- **Move buffer right:** `<leader>br`
- **Close buffer:** `<leader>bx`
- **Close all other buffers:** `<leader>bxa`

---

### Commenting

- **Single line comment:** `ctrl+/`
- **Multi-line comment (visual selection):** `ctrl+/`

---

### Git Integration

- **Preview hunk (change):** `<leader>gp`
- **Git blame:** `<leader>gb`
- **Git log (oneline graph, custom):** `<leader>gl`
- __Git difference (file):__ `<leader>gfd` 

---

### Undo Tree

- **Open/Close undo tree:** `<leader>u`

---

### Session Management (Persisted)

- **Save session:** `<leader>ss`
- **List sessions:** `<leader>sl`
- **Delete session:** `<leader>sd`

---

### CodeSnap

- **Save to clipboard:** `<leader>cc`
- **Save to `~/Pictures`:** `<leader>cs`

---

### ToggleTerminal

- **Open/Close terminal:** `ctrl+\`
- **Open terminal below:** `<leader>th`
- **Open floating terminal:** `<leader>tf`
- **Send current line to terminal (run command from docs):** `<leader>tst`

---

### UFO (Folding)

- **Fold all:** `zR`
- **Unfold all:** `zM`
- **Toggle fold under cursor:** `za`

---

### Spelling

- **Display suggestions:** `z=`
- **Add word to dictionary:** `zg`

---

### Noice (Message Management)

- **Dismiss message:** `<leader>nd`
- **List messages:** `<leader>nl`

---

### Tabular (CSV/TSV View)

- **View CSV as table:** `<leader>csv`
- **View TSV as table:** `<leader>tsv`

---

## Optional Features

### AI Integration (Avante)

- Ensure **LuaJIT** is installed.
- Rename `~/.config/nvim/lua/plugins/avante` to `avante.lua` for `Ollama`.

---
