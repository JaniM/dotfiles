" vim: foldmethod=indent

set nohlsearch
set number numberwidth=2
set expandtab shiftwidth=2 softtabstop=2 tabstop=4
set splitright splitbelow
set shell=/usr/bin/fish
let maplocalleader = " "
let mapleader = ","
inoremap jj <Esc>

" Always show some lines around the cursor
set scrolloff=5

" Plugin loader docs https://github.com/junegunn/vim-plug
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'gruvbox-community/gruvbox'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled = 0

  Plug 'roman/golden-ratio'

  " Focus mode
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
    map <C-n> :NERDTreeToggle<CR>
    nmap ,n :NERDTreeFind<CR>
    augroup nerdtree
      autocmd!
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    augroup END
    " Close vim if only nerdtree is open

  Plug 'tpope/vim-fugitive' " Git

  Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<c-space>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"

  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'

  " TS & TSX syntax files
  " TODO: these seem kinda terrible, find better ones?
  Plug 'HerringtonDarkholme/yats'
  " Plug 'peitalin/vim-jsx-typescript'

  " Python folding rules
  Plug 'tmhedberg/SimpylFold'

  " Markdown
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  function! BuildMdComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      if has('nvim')
        !cargo +stable build --release --locked
      else
        !cargo +stable build --release --locked --no-default-features --features json-rpc
      endif
    endif
  endfunction

  Plug 'euclio/vim-markdown-composer', { 'do': function('BuildMdComposer') }

  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Productivity
  Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'
  Plug 'jceb/vim-orgmode'
  Plug 'mattn/calendar-vim'
  Plug 'vim-scripts/utl.vim'
  Plug 'vim-scripts/repeat.vim'
  Plug 'vim-scripts/speeddating.vim'
call plug#end()

filetype plugin indent on

set background=dark    " Setting dark mode
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_warnings = 1
let g:gruvbox_italic=1
" set termguicolors
colorscheme gruvbox

" Transparent background
hi Normal guibg=NONE ctermbg=NONE
let g:fzf_colors = { 'bg': ['fg', 'NONE'] }

let g:goyo_width = 120
let g:goyo_height = "85%"
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
augroup goyo_lime
  autocmd!
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight! | hi Normal guibg=NONE ctermbg=NONE
augroup END

" COC configs
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  " inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)zz
  nmap <silent> gD <C-w><C-v><Plug>(coc-definition)zz
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gY <C-w><C-v><Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup coc
    autocmd!
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --color=always --smart-case --glob "!package-lock.json" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': ['-n3..', '-d:']}), <bang>0)

" let g:fzf_layout = { 'window': 'belowright 20new' }
let g:fzf_buffers_jump = 1

nnoremap <Leader>f :Files<Return>
nnoremap <C-p> :Files<Return>
nnoremap <Leader>l :BLines<Return>
nnoremap <Leader>s :Rg<Return>
nnoremap <Leader>. :Buffers<Return>
nnoremap <C-j> <PageDown>
nnoremap <C-k> <PageUp>
nnoremap <Leader>g :Goyo<Return>
xmap <Leader>k <Plug>(Limelight)
nmap <Leader>k <Plug>(Limelight)
nmap <Leader>kk :Limelight!!<Return>
nmap <Leader>e <Plug>(coc-diagnostic-next)
nnoremap <Leader>bgt :hi Normal guibg=NONE ctermbg=NONE<CR>
nnoremap <Leader>bgo :colorscheme gruvbox<CR>
nnoremap <Leader>vc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <Leader>vf :vsp ~/.config/nvim/ftplugin<CR>
nnoremap - :
vnoremap > >gv
vnoremap < <gv
nnoremap <C-left> <C-w>h
nnoremap <C-right> <C-w>l
nnoremap <C-up> <C-w>k
nnoremap <C-down> <C-w>j
nnoremap <Leader>G :vert Gstatus<CR>
nnoremap <C-h> :help <C-r><C-w><CR>
nnoremap <F2> :w<CR>
inoremap <F2> <C-o>:w<CR>
nmap w <Plug>(easymotion-w)
nmap b <Plug>(easymotion-b)

augroup general_style
  autocmd!
  " Get rid of trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd BufWritePost init.vim source ~/.config/nvim/init.vim
augroup END

" Python
let g:SimpylFold_docstring_preview = 1

" Markdown

" Open links in a vsplit
let g:vim_markdown_edit_url_in = 'vsplit'

let g:markdown_composer_autostart=0
let g:markdown_composer_browser=$HOME."/scripts/firefox-window"
let g:markdown_composer_custom_css=['http://thomasf.github.io/solarized-css/solarized-dark.min.css']
let g:markdown_composer_syntax_theme='solarized-dark'

" Orgmode
" This is broken https://github.com/jceb/vim-orgmode/issues/293
let g:org_agenda_files = ['~/org/*.org']
