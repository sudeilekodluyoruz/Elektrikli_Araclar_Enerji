# DAX ölçüleri – Elektrikli Araçlar ve Elektrik Şebekesi

> Ölçüleri Power BI'da **Modelleme > Yeni ölçü** ile tek tek ekle. Tablo adlarının aşağıdaki gibi olduğundan emin ol: `FactEV`, `FactEnerji`, `DimUlke`, `DimTarih`, `DimYil`.

## 1. Temel kayıt ölçüleri

```DAX
EV Kayıt =
CALCULATE(
    SUM(FactEV[Kayit]),
    FactEV[AracTuru] = "Electric vehicle (BEV+PHEV)"
)
```

```DAX
BEV Kayıt =
CALCULATE(
    SUM(FactEV[Kayit]),
    FactEV[AracTuru] = "Battery electric"
)
```

```DAX
PHEV Kayıt =
CALCULATE(
    SUM(FactEV[Kayit]),
    FactEV[AracTuru] = "Plug-in hybrid"
)
```

```DAX
Toplam Kayıt =
CALCULATE(
    SUM(FactEV[Kayit]),
    FactEV[AracTuru] = "All drivetrains"
)
```

```DAX
EV Payı % =
DIVIDE([EV Kayıt], [Toplam Kayıt])
```

**Önemli:** `Battery electric`, `Plug-in hybrid`, `Electric vehicle (BEV+PHEV)` ve `All drivetrains` satırları aynı veri içinde ayrı kategorilerdir. Hepsini filtresiz toplama; EV ve toplam ölçülerinde yukarıdaki kategori filtrelerini koru.

## 2. Elektrik şebekesi ölçüleri

```DAX
Karbon Yoğunluğu =
AVERAGE(FactEnerji[KarbonYogunlugu])
```

```DAX
Yenilenebilir Pay =
AVERAGE(FactEnerji[YenilenebilirPay])
```

```DAX
Düşük Karbon Pay =
AVERAGE(FactEnerji[DusukKarbonPay])
```

```DAX
Elektrik Talebi TWh =
SUM(FactEnerji[ElektrikTalebiTWh])
```

Bu ortalamalar ülke bazında eşit ağırlıklı ortalamadır; nüfusa veya elektrik üretimine göre ağırlıklandırılmış değildir. Kart başlığında gerekirse “Ülkelerin ortalama …” ifadesini kullan.

## 3. Önceki yıl ve değişim ölçüleri

Aşağıdaki ölçülerde yıl dilimleyicisinin `DimYil[Yil]` alanından geldiği varsayılır. `DimYil` filtresi önce kaldırılır, sonra tarih bağlamı bir yıl geriye kaydırılır.

```DAX
EV Kayıt Geçen Yıl =
CALCULATE(
    [EV Kayıt],
    REMOVEFILTERS(DimYil),
    DATEADD(DimTarih[Tarih], -1, YEAR)
)
```

```DAX
EV Kayıt Yıllık Değişim % =
DIVIDE(
    [EV Kayıt] - [EV Kayıt Geçen Yıl],
    [EV Kayıt Geçen Yıl]
)
```

```DAX
EV Payı Geçen Yıl =
CALCULATE(
    [EV Payı %],
    REMOVEFILTERS(DimYil),
    DATEADD(DimTarih[Tarih], -1, YEAR)
)
```

```DAX
EV Payı Değişim (puan) =
([EV Payı %] - [EV Payı Geçen Yıl]) * 100
```

Biçimlendirme:
- `EV Payı %`, `EV Kayıt Yıllık Değişim %`, `EV Payı Geçen Yıl`: Yüzde.
- `EV Payı Değişim (puan)`: Ondalık sayı, 2 basamak. Bu ölçü yüzde değil, yüzde puan farkıdır.
- `EV Kayıt`, `BEV Kayıt`, `PHEV Kayıt`, `Toplam Kayıt`: Tam sayı / binlik ayraç.

## 4. Karbon yoğunluğuna göre ülke grupları (isteğe bağlı)

Aşağıdaki 200 ve 450 eşikleri proje için seçilmiş analitik eşiklerdir; evrensel veya resmî sınıflandırma değildir.

```DAX
Temiz Şebekeli EV Payı % =
VAR TemizUlke =
    FILTER(
        VALUES(DimUlke[ISO3]),
        CALCULATE([Karbon Yoğunluğu]) < 200
    )
RETURN
    CALCULATE(
        [EV Payı %],
        KEEPFILTERS(TemizUlke)
    )
```

```DAX
Yüksek Karbonlu Şebekeli EV Payı % =
VAR YuksekKarbonluUlke =
    FILTER(
        VALUES(DimUlke[ISO3]),
        CALCULATE([Karbon Yoğunluğu]) >= 450
    )
RETURN
    CALCULATE(
        [EV Payı %],
        KEEPFILTERS(YuksekKarbonluUlke)
    )
```

## 5. Görsellerde kullanılacak alanlar

| Görsel | Alan / ölçü |
|---|---|
| Yıl dilimleyici | `DimYil[Yil]` |
| Kıta dilimleyici | `DimUlke[Kita]` |
| G20 dilimleyici | `DimUlke[G20]` |
| EV Payı kartı | `[EV Payı %]` |
| EV Kayıt kartı | `[EV Kayıt]` |
| Karbon kartı | `[Karbon Yoğunluğu]` |
| Düşük Karbon kartı | `[Düşük Karbon Pay]` |
| Harita konum | `DimUlke[Ulke]` |
| Harita renk değeri | `[EV Payı %]` |
| Dağılım X | `[Karbon Yoğunluğu]` |
| Dağılım Y | `[EV Payı %]` |
| Dağılım ayrıntı | `DimUlke[Ulke]` |
| Dağılım boyut | `[EV Kayıt]` |
| Aylık çizgi X | `DimTarih[YilAy]` |
| Aylık çizgi Y | `[BEV Kayıt]` ve `[PHEV Kayıt]` |
| Ülke tablosu | `DimUlke[Ulke]`, `[EV Payı %]`, `[Karbon Yoğunluğu]`, `[EV Payı Değişim (puan)]` |

Dağılım grafiğinde aynı anda hem ülkeyi hem ISO3'ü ayrı seri/legend alanlarına koyma. Ülke alanını **Ayrıntılar (Details)** alanına koy; ISO3'e gerek yok.

Aylık çizgi grafiğinde eksen sıralaması için `DimTarih[YilAy]` sütununu `DimTarih[YilAySira]` ile sırala. Grafikte 2023 yılı seçiliyken 2023 ayları görünür.
