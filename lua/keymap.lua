-- Visual mode mappings
vim.api.nvim_set_keymap('v', '<ESC>', '<C-c>:nohlsearch<CR>',
  { silent = true, noremap = true, desc = 'Clear search highlighting' })
vim.api.nvim_set_keymap('v', 'v', '$h', { noremap = true, desc = 'Move to end of line and one character back' })
vim.api.nvim_set_keymap('v', '<ESC>w', 'b', { noremap = true, desc = 'Move to previous word' })
vim.api.nvim_set_keymap('v', '<M-w>', 'b', { noremap = true, desc = 'Move to previous word' })
vim.api.nvim_set_keymap('v', '<ESC>e', '<Nop>', { noremap = true, desc = 'No operation' })
vim.api.nvim_set_keymap('v', '<ESC>e', 'e', { noremap = true, desc = 'Move to end of word' })
vim.api.nvim_set_keymap('v', '<M-e>', '<Nop>', { noremap = true, desc = 'No operation' })
vim.api.nvim_set_keymap('v', '<M-e>', 'e', { noremap = true, desc = 'Move to end of word' })
vim.api.nvim_set_keymap('v', '<TAB>', '>', { noremap = true, desc = 'Indent line' })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<', { noremap = true, desc = 'Unindent line' })
vim.api.nvim_set_keymap('v', 'n', [["vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>]],
  { silent = true, noremap = true, desc = 'Search for visually selected text' })
vim.api.nvim_set_keymap('v', '<S-y>', '"+y', { noremap = true, desc = 'Yank to system clipboard' })
vim.api.nvim_set_keymap('v', '<bar>', [["*y:vim /<C-r>*/ `git ls-files` <bar> cw<CR>]],
  { noremap = true, desc = 'Yank to system clipboard and search in git files' })

-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<ESC>', '<ESC><ESC>:nohlsearch<CR>',
  { silent = true, noremap = true, desc = 'Clear search highlighting' })
vim.api.nvim_set_keymap('n', '<ESC>s', '<ESC>:w!<CR>', { noremap = true, desc = 'Save file' })
vim.api.nvim_set_keymap('n', '<ESC>s<ESC>s', '<ESC>:wq!<CR>', { noremap = true, desc = 'Save and quit' })
vim.api.nvim_set_keymap('n', '<M-s>', '<ESC>:w!<CR>', { noremap = true, desc = 'Save file' })
vim.api.nvim_set_keymap('n', '<M-s><M-s>', '<ESC>:wq!<CR>', { noremap = true, desc = 'Save and quit' })
vim.api.nvim_set_keymap('n', '<C-q>', '<cmd>bd!<CR>', { noremap = true, desc = 'Close buffer' })
vim.api.nvim_set_keymap('n', '<C-w><C-w>', '<cmd>q!<CR>', { noremap = true, desc = 'Quit without saving' })
vim.api.nvim_set_keymap('n', '<Left>', '<C-w><Left>', { noremap = true, desc = 'Move to window on the left' })
vim.api.nvim_set_keymap('n', '<Right>', '<C-w><Right>', { noremap = true, desc = 'Move to window on the right' })
vim.api.nvim_set_keymap('n', '<Up>', '<C-w><Up>', { noremap = true, desc = 'Move to window above' })
vim.api.nvim_set_keymap('n', '<Down>', '<C-w><Down>', { noremap = true, desc = 'Move to window below' })
vim.api.nvim_set_keymap('n', '<M-w>', 'b', { noremap = true, desc = 'Move to previous word' })
vim.api.nvim_set_keymap('n', '<M-e>', 'w', { noremap = true, desc = 'Move to next word' })
vim.api.nvim_set_keymap('n', '<BS>', 'X', { noremap = true, desc = 'Delete character before cursor' })
vim.api.nvim_set_keymap('n', '<M-1>', '<C-x>', { noremap = true, desc = 'Decrement number under cursor' })
vim.api.nvim_set_keymap('n', '<M-2>', '<C-a>', { noremap = true, desc = 'Increment number under cursor' })
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, desc = 'Move down by visual line' })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, desc = 'Move up by visual line' })
vim.api.nvim_set_keymap('n', 'r', '<C-r>', { noremap = true, desc = 'Redo' })
vim.api.nvim_set_keymap('n', '<C-r>', 'r', { noremap = true, desc = 'Replace character under cursor' })
vim.api.nvim_set_keymap('n', '<F4>', '<cmd>setlocal relativenumber!<CR>',
  { silent = true, noremap = true, desc = 'Toggle relative line numbers' })

-- More normal mode mappings
vim.api.nvim_set_keymap('n', 'cn', '<cmd>cn<CR>',
  { silent = true, noremap = true, desc = 'Go to next item in quickfix list' })
vim.api.nvim_set_keymap('n', 'CN', '<cmd>cN<CR>',
  { silent = true, noremap = true, desc = 'Go to previous item in quickfix list' })
vim.api.nvim_set_keymap('n', 'cq', '<cmd>lcl<CR>', { silent = true, noremap = true, desc = 'Close location list' })
vim.api.nvim_set_keymap('n', 'w<TAB>', '<C-w>w', { noremap = true, desc = 'Switch to next window' })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, desc = 'Move to window on the left' })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, desc = 'Move to window below' })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, desc = 'Move to window above' })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, desc = 'Move to window on the right' })
vim.api.nvim_set_keymap('n', 'wl', '<ESC><C-w><<C-w><<C-w><<C-w><<C-w><',
  { noremap = true, desc = 'Decrease window width' })
vim.api.nvim_set_keymap('n', 'wh', '<ESC><C-w>><C-w>><C-w>><C-w>><C-w>>',
  { noremap = true, desc = 'Increase window width' })
vim.api.nvim_set_keymap('n', 'wj', '<ESC><C-w>+<C-w>+<C-w>+<C-w>+<C-w>+',
  { noremap = true, desc = 'Increase window height' })
vim.api.nvim_set_keymap('n', 'wk', '<ESC><C-w>-<C-w>-<C-w>-<C-w>-<C-w>-',
  { noremap = true, desc = 'Decrease window height' })
vim.api.nvim_set_keymap('n', '<M-o>', 'o<ESC>',
  { noremap = true, desc = 'Open new line below and return to normal mode' })
vim.api.nvim_set_keymap('n', 'wo', '<cmd>new<Space><cfile><CR>',
  { noremap = true, desc = 'Open new window with current file' })
vim.api.nvim_set_keymap('n', '<S-k>', 'k<S-j>', { noremap = true, desc = 'Move line up' })
vim.api.nvim_set_keymap('n', 'V', '<C-v>', { noremap = true, desc = 'Start visual block selection' })
vim.api.nvim_set_keymap('n', '<M-x>', '"', { noremap = true, desc = 'Start command-line mode with double quote' })
vim.api.nvim_set_keymap('n', '<F6>', 'mq', { noremap = true, desc = 'Set mark q at current cursor position' })
vim.api.nvim_set_keymap('n', '<F7>', '`q', { noremap = true, desc = 'Jump to mark q' })

-- Insert mode mappings
vim.api.nvim_set_keymap('i', '<ESC>', '<ESC>:nohlsearch<CR>',
  { silent = true, noremap = true, desc = 'Clear search highlighting' })
vim.api.nvim_set_keymap('i', '<M-v>', '<C-x><C-r>+', { noremap = true, desc = 'Paste from system clipboard' })
vim.api.nvim_set_keymap('i', '<M-1>', '<C-o><C-x>i', { noremap = true, desc = 'Decrease number under cursor' })
vim.api.nvim_set_keymap('i', '<M-2>', '<C-o><C-a>i', { noremap = true, desc = 'Increase number under cursor' })
vim.api.nvim_set_keymap('i', '<M-p>', '<C-o>pi', { noremap = true, desc = 'Paste from register' })
vim.api.nvim_set_keymap('i', '<ESC>p', '<C-o>pi', { noremap = true, desc = 'Paste from register' })
vim.api.nvim_set_keymap('i', '<M-w>', '<S-Left>', { noremap = true, desc = 'Move to start of word' })
vim.api.nvim_set_keymap('i', '<M-e>', '<S-Right>', { noremap = true, desc = 'Move to end of word' })

-- Command-line mode mappings
vim.api.nvim_set_keymap('c', '<ESC>w', '<S-Left>', { noremap = true, desc = 'Move to start of word' })
vim.api.nvim_set_keymap('c', '<M-w>', '<S-Left>', { noremap = true, desc = 'Move to start of word' })
vim.api.nvim_set_keymap('c', '<ESC>e', '<S-Right>', { noremap = true, desc = 'Move to end of word' })
vim.api.nvim_set_keymap('c', '<M-e>', '<S-Right>', { noremap = true, desc = 'Move to end of word' })
vim.api.nvim_set_keymap('c', '<ESC>d', '<C-w>', { noremap = true, desc = 'Delete word before cursor' })
vim.api.nvim_set_keymap('c', '<M-d>', '<C-w>', { noremap = true, desc = 'Delete word before cursor' })
vim.api.nvim_set_keymap('c', '<ESC>x', '<C-r>', { noremap = true, desc = 'Insert contents of a register' })
vim.api.nvim_set_keymap('c', '<M-x>', '<C-r>', { noremap = true, desc = 'Insert contents of a register' })
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %',
  { noremap = true, desc = 'Write to a file when sudo is needed' })

vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true, desc = 'Leave terminal mode' })

vim.api.nvim_set_keymap('n', '<M-C>', 'gcc', { silent = true, desc = 'Comment' })
vim.api.nvim_set_keymap('v', '<M-C>', 'gc', { silent = true, desc = 'Comment' })
