return {
    s({trig="ifer", snippetType="autosnippet"}, {
        t({"if err != nil {", "\t"}),
        i(1),
        t({"", "}"})
    }),
    s({trig="func"}, {
        t("func "),i(1),t"(", i(2), t") ",
        c(3,{
            t"error ",
            sn(1, {t"(", i(1, "type"), t", error) "}),
            t""
        }),
        t({"{", "\t"}),
        i(0),
        t({"", "}"})
    }),
}
