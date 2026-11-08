let
    Kaynak = Csv.Document(
        File.Contents(KlasorYolu & "\data\DimUlke.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Baslik = Table.PromoteHeaders(Kaynak, [PromoteAllScalars=true]),
    Tip = Table.TransformColumnTypes(
        Baslik,
        {
            {"ISO3", type text}, {"Ulke", type text}, {"Kita", type text},
            {"EmberBolge", type text}, {"AB", type logical}, {"OECD", type logical},
            {"G20", type logical}, {"G7", type logical}, {"ASEAN", type logical}
        },
        "en-US"
    ),
    Tekil = Table.Distinct(Tip, {"ISO3"})
in
    Tekil
