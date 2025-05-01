return {
    s("namespace", {
        t("namespace "),
        i(1),
        t({ "", "{",""}), i(0), t({"", "} // "}), rep(1),
    }),
    s("guard", {
        t("#ifndef "),
        f(function(args, snip)
          local filename = snip.env.TM_FILENAME or "HEADER_H"
          return filename:upper():gsub("[^A-Z0-9]", "_") .. "_INCLUDED"
        end, {}),
        t({"", "#define "}),
        f(function(args, snip)
          local filename = snip.env.TM_FILENAME or "HEADER_H"
          return filename:upper():gsub("[^A-Z0-9]", "_") .. "_INCLUDED"
        end, {}),
        t({"", "", ""}),
        i(0),
        t({"", "", "#endif // "}),
        f(function(args, snip)
          local filename = snip.env.TM_FILENAME or "HEADER_H"
          return filename:upper():gsub("[^A-Z0-9]", "_") .. "_INCLUDED"
        end, {}),
    }),
}
