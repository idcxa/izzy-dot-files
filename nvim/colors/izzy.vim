" Vim color file

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "izzy"

let s:dark_grey = [236, "#1b1b1b"]
let s:darkish_gray = [236, "#3d3b3d"]
let s:mid_gray = [102, "#878787"]
let s:default_white = [231, "#ff00ff"]
let s:magenta = [231, "#FF00FF"]

let s:lavender = [183, "#dfafff"]
let s:text2 = [225, "#ff00ff"]
let s:gray_purple = [146, "#9686C3"]

let s:pink = [218, "#ffafdf"]
let s:light_blue = [159, "#afffff"]
let s:mint = [158, "#FEC601"]
let s:light_yellow = [229, "#ffffaf"]

let s:dark_pink = [197, "#ff005f"]
let s:dark_green = [29, "#00875f"]
let s:dark_blue = [31, "#0087af"]

let s:bg = [236, "#161616"]
let s:text1 = [236, "#F0E6EF"]

let s:text2 = [236, "#FC7753"]
let s:text3 = [236, "#FFC759"]

let s:text4 = [159, "#D6EFFF"]



let s:none = ["NONE", ""]

function! <SID>set_hi(name, fg, bg, style)
  execute "hi " . a:name . " ctermfg=" . a:fg[0] . " ctermbg=" . a:bg[0] " cterm=" . a:style
  if a:fg[1] != ""
    execute "hi " . a:name . " guifg=" . a:fg[1]
  endif
  if a:bg[1] != ""
    execute "hi " . a:name . " guibg=" . a:bg[1]
  endif
  execute "hi " . a:name . " gui=" . a:style
endfun

call <SID>set_hi("Normal", s:text1, s:bg, "NONE")
call <SID>set_hi("Cursor", s:bg, s:text1, "NONE")
call <SID>set_hi("Visual", s:none, s:mid_gray, "NONE")
call <SID>set_hi("CursorLine", s:none, s:bg, "NONE")
call <SID>set_hi("CursorColumn", s:none, s:bg, "NONE")
call <SID>set_hi("ColorColumn", s:none, s:bg, "NONE")
call <SID>set_hi("LineNr", s:mid_gray, s:bg, "NONE")
call <SID>set_hi("VertSplit", s:mid_gray, s:mid_gray, "NONE")
call <SID>set_hi("MatchParen", s:text3, s:none, "italic")
hi MatchParen guifg=#ffafdf guibg=NONE gui=NONE
call <SID>set_hi("StatusLine", s:text1, s:mid_gray, "bold")
call <SID>set_hi("StatusLineNC", s:text1, s:mid_gray, "NONE")
call <SID>set_hi("Pmenu", s:text3, s:darkish_gray, "NONE")
call <SID>set_hi("PmenuSel", s:none, s:bg, "NONE")
call <SID>set_hi("IncSearch", s:bg, s:light_yellow, "NONE")
call <SID>set_hi("Search", s:none, s:none, "underline")
call <SID>set_hi("Directory", s:lavender, s:none, "NONE")
call <SID>set_hi("Folded", s:light_yellow, s:bg, "NONE")
call <SID>set_hi("TabLine", s:text1, s:bg, "NONE")
call <SID>set_hi("TabLineSel", s:text2, s:bg, "NONE")
call <SID>set_hi("TabLineFill", s:text1, s:bg, "NONE")

call <SID>set_hi("Define", s:gray_purple, s:none, "NONE")
call <SID>set_hi("DiffAdd", s:text1, s:dark_green, "bold")
call <SID>set_hi("DiffDelete", s:dark_pink, s:none, "NONE")
call <SID>set_hi("DiffChange", s:text1, s:bg, "NONE")
call <SID>set_hi("DiffText", s:text1, s:dark_blue, "bold")
call <SID>set_hi("ErrorMsg", s:text1, s:dark_pink, "NONE")
call <SID>set_hi("WarningMsg", s:text1, s:dark_pink, "NONE")

call <SID>set_hi("Boolean", s:lavender, s:none, "NONE")
call <SID>set_hi("Character", s:lavender, s:none, "NONE")
call <SID>set_hi("Comment", s:gray_purple, s:none, "NONE")
call <SID>set_hi("Conditional", s:text3, s:none, "NONE")
call <SID>set_hi("Constant", s:mint, s:none, "NONE")
call <SID>set_hi("Float", s:lavender, s:none, "NONE")
call <SID>set_hi("Function", s:text2, s:none, "NONE")
call <SID>set_hi("Identifier", s:text2, s:none, "NONE")
call <SID>set_hi("Keyword", s:text3, s:none, "NONE")
call <SID>set_hi("Label", s:light_yellow, s:none, "NONE")
call <SID>set_hi("NonText", s:text1, s:bg, "NONE")
call <SID>set_hi("Number", s:mint, s:none, "NONE")
call <SID>set_hi("Operator", s:text3, s:none, "NONE")
call <SID>set_hi("PreProc", s:text3, s:none, "NONE")
call <SID>set_hi("Special", s:text2, s:none, "NONE")
call <SID>set_hi("SpecialKey", s:text1, s:bg, "NONE")
call <SID>set_hi("Statement", s:text3, s:none, "NONE")
call <SID>set_hi("SpellBad", s:text3, s:none, "underline")
call <SID>set_hi("SpellCap", s:text4, s:none, "underline")
call <SID>set_hi("StorageClass", s:mint, s:none, "NONE")
call <SID>set_hi("String", s:text4, s:none, "NONE")
call <SID>set_hi("Tag", s:text3, s:none, "NONE")
call <SID>set_hi("Title", s:text1, s:none, "bold")
call <SID>set_hi("Todo", s:light_yellow, s:none, "inverse,bold")
call <SID>set_hi("Type", s:mint, s:none, "NONE")
call <SID>set_hi("Underlined", s:none, s:none, "underline")

call <SID>set_hi("rubyClass", s:text3, s:none, "NONE")
call <SID>set_hi("rubyFunction", s:text2, s:none, "NONE")
call <SID>set_hi("rubyInterpolationDelimiter", s:none, s:none, "NONE")
call <SID>set_hi("rubySymbol", s:text2, s:none, "NONE")
call <SID>set_hi("rubyConstant", s:mint, s:none, "NONE")
call <SID>set_hi("rubyStringDelimiter", s:text4, s:none, "NONE")
call <SID>set_hi("rubyBlockParameter", s:text3, s:none, "NONE")
call <SID>set_hi("rubyBlock", s:text1, s:none, "NONE")
call <SID>set_hi("rubyInstanceVariable", s:text3, s:none, "NONE")
call <SID>set_hi("rubyInclude", s:text3, s:none, "NONE")
call <SID>set_hi("rubyGlobalVariable", s:light_yellow, s:none, "NONE")
call <SID>set_hi("rubyRegexp", s:light_yellow, s:none, "NONE")
call <SID>set_hi("rubyRegexpDelimiter", s:light_yellow, s:none, "NONE")
call <SID>set_hi("rubyEscape", s:lavender, s:none, "NONE")
call <SID>set_hi("rubyControl", s:lavender, s:none, "NONE")
call <SID>set_hi("rubyRepeat", s:lavender, s:none, "NONE")
call <SID>set_hi("rubyConditional", s:text3, s:none, "NONE")
call <SID>set_hi("rubyClassVariable", s:light_yellow, s:none, "NONE")
call <SID>set_hi("rubyOperator", s:text3, s:none, "NONE")
call <SID>set_hi("rubyException", s:mint, s:none, "NONE")
call <SID>set_hi("rubyPseudoVariable", s:mint, s:none, "NONE")
call <SID>set_hi("rubyRailsUserClass", s:mint, s:none, "NONE")
call <SID>set_hi("rubyRailsARAssociationMethod", s:mint, s:none, "NONE")
call <SID>set_hi("rubyRailsARMethod", s:mint, s:none, "NONE")
call <SID>set_hi("rubyRailsRenderMethod", s:mint, s:none, "NONE")
call <SID>set_hi("rubyRailsMethod", s:mint, s:none, "NONE")
call <SID>set_hi("rubyArrayDelimiter", s:text3, s:none, "NONE")
call <SID>set_hi("rubyInterpolation", s:text2, s:none, "NONE")
call <SID>set_hi("rubyInterpolationDelimiter", s:text3, s:none, "NONE")

call <SID>set_hi("erubyDelimiter", s:none, s:none, "NONE")
call <SID>set_hi("erubyRailsMethod", s:mint, s:none, "NONE")

call <SID>set_hi("htmlTag", s:none, s:none, "NONE")
call <SID>set_hi("htmlEndTag", s:none, s:none, "NONE")
call <SID>set_hi("htmlTagName", s:none, s:none, "NONE")
call <SID>set_hi("htmlArg", s:none, s:none, "NONE")
call <SID>set_hi("htmlSpecialChar", s:lavender, s:none, "NONE")

call <SID>set_hi("javaScriptFunction", s:mint, s:none, "NONE")
call <SID>set_hi("javaScriptRailsFunction", s:mint, s:none, "NONE")
call <SID>set_hi("javaScriptBraces", s:none, s:none, "NONE")

call <SID>set_hi("yamlKey", s:text3, s:none, "NONE")
call <SID>set_hi("yamlAnchor", s:none, s:none, "NONE")
call <SID>set_hi("yamlAlias", s:none, s:none, "NONE")
call <SID>set_hi("yamlDocumentHeader", s:light_yellow, s:none, "NONE")
call <SID>set_hi("yamlPlainScalar", s:text4, s:none, "NONE")
call <SID>set_hi("yamlBlockCollectionItemStart", s:text3, s:none, "NONE")

call <SID>set_hi("cssURL", s:dark_pink, s:none, "NONE")
call <SID>set_hi("cssFunctionName", s:mint, s:none, "NONE")
call <SID>set_hi("cssColor", s:lavender, s:none, "NONE")
call <SID>set_hi("cssPseudoClassId", s:light_yellow, s:none, "NONE")
call <SID>set_hi("cssClassName", s:light_yellow, s:none, "NONE")
call <SID>set_hi("cssValueLength", s:lavender, s:none, "NONE")
call <SID>set_hi("cssCommonAttr", s:mint, s:none, "NONE")
call <SID>set_hi("cssBraces", s:none, s:none, "NONE")

call <SID>set_hi("jsThis", s:text3, s:none, "NONE")
call <SID>set_hi("jsBraces", s:text2, s:none, "NONE")
call <SID>set_hi("jsGlobalObjects", s:mint, s:none, "NONE")

call <SID>set_hi("coffeeCurly", s:lavender, s:none, "NONE")
call <SID>set_hi("coffeeObjAssign", s:text2, s:none, "NONE")

call <SID>set_hi("cjsxAttribProperty", s:lavender, s:none, "NONE")

call <SID>set_hi("markdownH1", s:text4, s:none, "NONE")
call <SID>set_hi("markdownH2", s:text4, s:none, "NONE")
call <SID>set_hi("markdownH3", s:text4, s:none, "NONE")
call <SID>set_hi("markdownH4", s:text4, s:none, "NONE")
call <SID>set_hi("markdownH5", s:text4, s:none, "NONE")
call <SID>set_hi("markdownH6", s:text4, s:none, "NONE")
call <SID>set_hi("markdownHeadingDelimiter", s:text4, s:none, "NONE")
call <SID>set_hi("markdownRule", s:text4, s:none, "NONE")

call <SID>set_hi("SyntasticError", s:bg, s:text3, "NONE")
call <SID>set_hi("SyntasticWarning", s:bg, s:text4, "NONE")

" https://github.com/kien/rainbow_parentheses.vim
if !exists("g:rbpt_colorpairs")
  let g:rbpt_colorpairs = [
        \ s:mint, s:text4, s:lavender, s:text3,
        \ s:mint, s:text4, s:lavender, s:text3,
        \ s:mint, s:text4, s:lavender, s:text3,
        \ s:mint, s:text4, s:lavender, s:text3,
        \ ]
endif

let s:one = [231, "#605770"]
let s:two = [231, "#000000"]
"let s:red = [231, "#87875f"]

call <SID>set_hi("BufferCurrent", s:text1, s:bg, "NONE")
call <SID>set_hi("BufferCurrentIndex", s:text3, s:bg, "NONE")
call <SID>set_hi("BufferCurrentMod", s:text1, s:bg, "NONE")
call <SID>set_hi("BufferCurrentSign", s:text3, s:bg, "NONE")
call <SID>set_hi("BufferCurrentTarget", s:magenta, s:bg, "bold")
call <SID>set_hi("BufferVisible", s:one, s:two, "NONE")
call <SID>set_hi("BufferVisibleIndex", s:one, s:two, "NONE")
call <SID>set_hi("BufferVisibleMod", s:text3, s:two, "NONE")
call <SID>set_hi("BufferVisibleSign", s:one, s:two, "NONE")
call <SID>set_hi("BufferVisibleTarget", s:magenta, s:two, "bold")
call <SID>set_hi("BufferInactive", s:two, s:one, "NONE")
call <SID>set_hi("BufferInactiveIndex", s:two, s:one, "NONE")
call <SID>set_hi("BufferInactiveMod", s:two, s:one, "NONE")
call <SID>set_hi("BufferInactiveSign", s:two, s:one, "NONE")
call <SID>set_hi("BufferInactiveTarget", s:magenta, s:one, "bold")
call <SID>set_hi("BufferTabpages", s:text3, s:one, "bold")
call <SID>set_hi("BufferTabpageFill", s:two, s:one, "NONE")
"hi BufferCurrentIcon  links to BufferCurrent
"hi BufferVisibleIcon  links to BufferVisible
"hi BufferInactiveIcon  links to BufferInactive
"hi BufferOffset    links to BufferTabpageFill
