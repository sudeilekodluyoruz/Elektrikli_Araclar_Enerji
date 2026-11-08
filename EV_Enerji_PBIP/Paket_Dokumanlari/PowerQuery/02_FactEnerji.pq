let
    Kaynak = Csv.Document(
        File.Contents(KlasorYolu & "\data\FactEnerji.csv"),
        [Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.Csv]
    ),
    Baslik = Table.PromoteHeaders(Kaynak, [PromoteAllScalars=true]),
    Tip = Table.TransformColumnTypes(
        Baslik,
        {
            {"ISO3", type text}, {"Yil", Int64.Type}, {"Nufus", type number},
            {"KarbonYogunlugu", type number}, {"YenilenebilirPay", type number},
            {"DusukKarbonPay", type number}, {"FosilPay", type number},
            {"ElektrikUretimiTWh", type number}, {"ElektrikTalebiTWh", type number},
            {"GunesPay", type number}, {"RuzgarPay", type number}, {"KomurPay", type number}
        },
        "en-US"
    )
in
    Tip
