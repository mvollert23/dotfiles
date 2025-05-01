local function content_snippet()
    return {
        t("s(\""),
        i(1, "name"),
        t("\", {"),
        t({"", "    t(\""}),
        i(2, "text"),
        t("\"),"),
        t({"", "}),"})
    }
end
return {
    s("snippet", {
        unpack(content_snippet()),
    }),
    s("snippets", {
        t({"return {"}),
        sn(2, {
        unpack(content_snippet()),
        }),
        t({"", "}"}),
    }),
}

