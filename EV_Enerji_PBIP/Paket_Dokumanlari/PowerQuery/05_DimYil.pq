let
    Yillar = {2019..2026},
    Tablo = Table.FromList(Yillar, Splitter.SplitByNothing(), {"Yil"}),
    Tip = Table.TransformColumnTypes(Tablo, {{"Yil", Int64.Type}})
in
    Tip
