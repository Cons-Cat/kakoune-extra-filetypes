##
## v.kak by Conscat
##

# https://vlang.io
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.(v|vsh) %{
    set-option buffer filetype v
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=v %{
    require-module v
    add-highlighter window/v ref v
}

hook global WinSetOption filetype=(?!v).* %{
    remove-highlighter window/v
}

hook global BufSetOption filetype=v %{
    set-option buffer comment_line '//'
}

provide-module v %§

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/v regions
add-highlighter shared/v/code default-region group

add-highlighter shared/v/back_string region '`' '`' fill string
add-highlighter shared/v/double_string region '"' (?<!\\)(\\\\)*" fill string
add-highlighter shared/v/single_string region "'" (?<!\\)(\\\\)*' fill string
add-highlighter shared/v/comment region -recurse /\* /\* \*/ fill comment
add-highlighter shared/v/comment_line region '//' $ fill comment

add-highlighter shared/v/code/ regex (\b(if|as|asm|assert|atomic|break|const|continue|else|embed|enum|fn|for|go|import|in|interface|is|lock|match|module|mut|or|pub|return|rlock|select|shared|sizeof|static|struct|type|typeof|union|__offsetof|free|unsafe|strlen|strncmp|malloc|goto|defer)\b|\$(if|else|for)|\[(deprecated|inline|heap|manualfree|live|direct_array_access|typedef|windows_stdcall|console|json:|raw)([^\]|(^\n)]*)\]) 0:keyword

add-highlighter shared/v/code/ regex %{-?([0-9]*\.(?!0[xX]))?\b([0-9_]+|0[xX][0-9a-fA-F]+)\.?([eE][+-]?[0-9]+)?\.*|none|true|false\b} 0:value
add-highlighter shared/v/code/ regex \b(chan|err|i8|u8|byte|i16|u16|int|u32|i64|u64|f32|f64|ptr|voidptr|r|size_t|map|rune|string)\b 0:type

add-highlighter shared/v/code/ regex \b(print|println|eprint|eprintln|exit|panic|print_backtrace|dump|rmdir_all|mkdir|exec|ls|mv)\b 0:builtin

add-highlighter shared/v/code/ regex (<|>|=|\+|-|\*|/|%|~|&|\|||\^|!|\?|:=) 0:operator

§