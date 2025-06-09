## Guide

[Josean Martinez - 2024 Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM)
[Example plugins](https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim/lua/josean/plugins)

alpha - fancy startup message
auto-session - save window state
bufferline - better looking tabs
comment - motions for commenting and uncommenting lines
conform - formatting, such as goimports, prettier, stylua
copilot - AI code completion
dap - debugging
dressing - window popups look better
gitsigns - show in the gutter +/-/ delta for git
indent-blankline - show indent guides
lazygit - frontend for lazygit - git interface
linting - show linting issues go running linters
lsp-config - configures LSP servers, used with mason-lspconfig
lualine - info line at bottom of buffer
mason - installs supporting binaries
moonfly - color theme
nvim-cmp - completion
nvim-tree - file navigation
outline - show symbol browser on the side
surround - add/remove surrounding characters (like ')', '"', ']')
telescope - fuzzy find strings/files
telescope-heirarchy - show call heirarchy to current function
treesitter - better highlighting and indenting, and tree selection
trouble - easier to navigate issues
vim-maximizer - maximize a buffer
which-key - when hitting leader, gives hints and descriptions

## leader hotkey prefixes (will see completions via which-key)

## other key mappings

K - show docs
gd - goto definition
gt - telescope type definitions
gi - telescope implementations
gR - telecope references
<leader>rn - rename
] and [ d - next / previous diagnostic

use Ctrl-o and Ctrl-i to jump back from a jump (or back in), e.g `gd` then `Ctrl-o` then `Ctrl-i`

gc <motion> comment / uncomment

<C-space> expand selection based on syntax

ys <motion>) - surround with parenthesis
ds] - delete brackets
cs'" - change single to double quotes

During completion:
TAB and Shift-TAB - select
Esc - abort
Enter - accept selected

# Troubleshooting

Can MasonUninstallAll and restart to re-install binaries (sometimes does not auto install)
