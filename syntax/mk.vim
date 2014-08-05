
if exists("b:current_syntax")
  finish
endif

syn include @sh syntax/sh.vim

unlet b:current_syntax
syn include @python syntax/python.vim

unlet b:current_syntax
syn include @perl syntax/perl.vim

unlet b:current_syntax
syn include @julia syntax/julia.vim

unlet b:current_syntax
syn include @r syntax/r.vim


" Rule
syn match mkTarget "^\S[^:=]\+" contains=mkWildcard,mkVariable,mkBracketVar,mkEscape
    \ nextgroup=mkRuleArguments,mkArgumentlessRulePrereqs
hi def link mkTarget String


" Recipe
syn region mkShRecipe start="^\s" end="^" skip="^\n" contained contains=@sh
syn region mkJuliaRecipe start="^\s" end="^" skip="^\n" contained contains=@julia
syn region mkPythonRecipe start="^\s" end="^" skip="^\n" contained contains=@python
syn region mkPerlRecipe start="^\s" end="^" skip="^\n" contained contains=@perl
syn region mkRRecipe start="^\s" end="^" skip="^\n" contained contains=@r


" Rule Arguments
syn region mkArgumentlessRulePrereqs start=":" end="^" skip="^\s\+" contained
    \ contains=mkWildcard,mkVariable,mkBracketVar,mkEscape,mkShRecipe
    \ nextgroup=mkShRecipe

syn region mkRulePrereqs start=":" end="$" skip="\\\n" contained
    \ contains=mkWildcard,mkVariable,mkBracketVar,mkEscape

syn region mkRuleArguments start=":[^:]\+:" end="^" contained
    \ contains=mkShellArgument,mkSimpleArgument

syn match mkSimpleArgument "[DENnQRUVXP]" contained
    \ nextgroup=mkSimpleArgument,mkShellArgument,mkArgumentEnd,mkArgumentlessRulePrereqs

syn match mkShellArgument "S" contained
    \ nextgroup=mkShellCommandSh,mkShellCommandJulia,mkShellCommandPython,mkShellCommandPerl,mkShellCommandR

syn region mkShellCommandSh matchgroup=mkShellCommandStart
    \ start="[^:]\+" end="^" skip="^\s\+" contains=mkRulePrereqs,mkShRecipe contained

syn region mkShellCommandJulia matchgroup=mkShellCommandStart
    \ start="julia" end="^" skip="^\s\+" contains=mkRulePrereqs,mkJuliaRecipe contained

syn region mkShellCommandPython matchgroup=mkShellCommandStart
    \ start="python" end="^" skip="^\s\+" contains=mkRulePrereqs,mkPythonRecipe contained

syn region mkShellCommandPerl matchgroup=mkShellCommandStart
    \ start="perl" end="^" skip="^\s\+" contains=mkRulePrereqs,mkPerlRecipe contained

syn region mkShellCommandR matchgroup=mkShellCommandStart
    \ start="R" end="^" skip="^\s\+" contains=mkRulePrereqs,mkRRecipe contained


hi def link mkSimpleArgument Type
hi def link mkShellArgument Type
hi def link mkShellCommandStart Structure


" Variables
syn match mkVariable "\$\w\+"
hi def link mkVariable Identifier

syn region mkBracketVar start="\${" end="}" contains=mkWildcard,mkAssignment,mkNamelistColon
hi def link mkBracketVar Identifier


" Namelist
syn match mkWildcard "%" contained
syn match mkNamelistColon ":" contained

hi def link mkWildcard Special
hi def link mkNamelistColon Function


" Comments
syn keyword mkTodo         contained TODO FIXME XXX
syn cluster mkCommentGroup contains=mkTodo
syn region mkComment start="#" end="$" contains=@mkCommentGroup,@Spell

hi def link mkComment Comment
hi def link mkTodo    Todo


" Includes
syn region mkInclude start="^<" end="$" contains=mkVariable
hi def link mkInclude Include

syn match mkEscape "\\."
hi def link mkEscape Special


let b:current_syntax = "mk"
