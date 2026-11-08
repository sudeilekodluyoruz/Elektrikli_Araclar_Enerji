let
    Baslangic = #date(2019, 1, 1),
    Bitis = #date(2026, 12, 31),
    Tarihler = List.Dates(
        Baslangic,
        Duration.Days(Bitis - Baslangic) + 1,
        #duration(1, 0, 0, 0)
    ),
    Tablo = Table.FromList(Tarihler, Splitter.SplitByNothing(), {"Tarih"}),
    Tip = Table.TransformColumnTypes(Tablo, {{"Tarih", type date}}),
    Yil = Table.AddColumn(Tip, "Yil", each Date.Year([Tarih]), Int64.Type),
    AyNo = Table.AddColumn(Yil, "AyNo", each Date.Month([Tarih]), Int64.Type),
    AyAdi = Table.AddColumn(AyNo, "AyAdi", each Date.MonthName([Tarih], "tr-TR"), type text),
    AyBaslangic = Table.AddColumn(AyAdi, "AyBaslangic", each Date.StartOfMonth([Tarih]), type date),
    Ceyrek = Table.AddColumn(AyBaslangic, "Ceyrek", each "Q" & Text.From(Date.QuarterOfYear([Tarih])), type text),
    YilAy = Table.AddColumn(Ceyrek, "YilAy", each Date.ToText([Tarih], "yyyy-MM"), type text),
    YilAySira = Table.AddColumn(YilAy, "YilAySira", each [Yil] * 100 + [AyNo], Int64.Type)
in
    YilAySira
