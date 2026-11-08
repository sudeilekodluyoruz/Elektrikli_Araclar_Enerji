# Veri doğrulama raporu

Bu kontrol değerleri gönderilen ham CSV dosyalarından Python/pandas ile bağımsız olarak yeniden hesaplandı. Power BI ölçülerinin doğruluğunu kontrol etmek için kullan.

## Temizlenmiş tablolar

| Kontrol | Sonuç |
|---|---:|
| FactEV satır sayısı | 16,763 |
| FactEV benzersiz ülke | 57 |
| FactEV tarih aralığı | 2019-01-01 – 2026-10-01 |
| FactEnerji satır sayısı | 340 |
| FactEnerji benzersiz ülke | 57 |
| FactEnerji yıl aralığı | 2019–2024 |
| DimUlke ülke sayısı | 59 |
| DimTarih satır sayısı | 2,922 günlük tarih |
| DimYil satır sayısı | 8 |

## 2023 kontrol değerleri

| Ölçüm | Ham kaynaktan hesaplanan değer |
|---|---:|
| BEV kayıt | 9,153,323 |
| PHEV kayıt | 4,024,717 |
| EV (BEV+PHEV) kayıt | 13,178,040 |
| Tüm aktarma organları kayıt | 69,749,044 |
| Ağırlıklı EV payı | 18.8935% |
| EV verisi bulunan ülke | 55 |
| EV + karbon verisi birlikte bulunan ülke | 53 |
| Ülke bazında EV payı / karbon yoğunluğu Pearson r | -0.3003 |

**EV payı hesabı:** 2023 EV toplam kayıt / 2023 tüm aktarma organları toplam kayıt. Ülke yüzdelerinin basit ortalaması değildir.

**Korelasyon hesabı:** Her ülke için 2023 EV kayıtları / tüm aktarma organları kayıtları oranı hesaplandı; bu oran, aynı ülkenin 2023 karbon yoğunluğuyla eşleştirildi. Eksik karbon yoğunluğu olan ülkeler dışarıda bırakıldı. Bu değer nedensellik göstermez.

## Beklenen Power BI kontrolü

1. `DimYil[Yil]` dilimleyicisinde 2023 seç.
2. `[EV Kayıt]` kartı **13.178.040** göstermeli.
3. `[Toplam Kayıt]` kartı **69.749.044** göstermeli.
4. `[EV Payı %]` kartı yaklaşık **18,89%** göstermeli.
5. Ülke tablosunda EV verisi bulunan ülke sayısı 55 olmalı.
6. Karbon yoğunluğu olan ülke sayısı, EV ile kesişimde 53 olmalı.
7. Dağılım grafiğinde karbon yoğunluğu boş olmayan ülkeler ayrı nokta olarak görünmeli.

Not: Ülke/kıta/G20 filtreleri seçildiğinde kartların bu alt kümeye göre değişmesi beklenir. Bu nedenle yukarıdaki kontrol değerleri, diğer dilimleyicilerde filtre seçimi yokken karşılaştırılmalıdır.
