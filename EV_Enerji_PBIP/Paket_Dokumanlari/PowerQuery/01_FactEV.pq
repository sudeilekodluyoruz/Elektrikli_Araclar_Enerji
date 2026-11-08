let
    Kaynak = Csv.Document(
        File.Contents(KlasorYolu & "\data\FactEV.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Baslik = Table.PromoteHeaders(Kaynak, [PromoteAllScalars=true]),
    Tip = Table.TransformColumnTypes(
        Baslik,
        {
            {"ISO3", type text},
            {"Ay", type date},
            {"Frekans", type text},
            {"AracTuru", type text},
            {"Kayit", Int64.Type},
            {"PayYuzde", type number}
        },
        "en-US"
    )
in
    Tip
