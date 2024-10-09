; extends
((assignment left: (identifier ) @cap
             right: (string (string_content) @injection.content))
(#match? @injection.content "\s*INSERT")
(#set! injection.language "mysql")
)
