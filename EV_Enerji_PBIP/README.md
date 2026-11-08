# Elektrikli Araçlar ve Elektrik Şebekesi ⚡🚗

Hangi ülkelerde yeni araçların büyük kısmı elektrikli? Ve bu ülkelerin elektriği gerçekten daha mı temiz?
Bu projede iki ayrı veri setini birleştirip bu soruya baktım: **aylık elektrikli araç (EV) kayıtları** ve **ülke bazlı elektrik üretiminin karbon yoğunluğu**. Analizi Python ile yaptım, sonuçları Power BI raporuna döktüm.

> Kısa cevap: Temiz şebekeli ülkelerde EV payı ortalamada daha yüksek, ama ilişki sanıldığı kadar güçlü değil. Detayı aşağıda 👇

## Öne çıkan sonuçlar

- Veri setindeki ülkelerde EV payı (BEV+PHEV) **2019'da %2,95 iken 2025'te %27,10**'a çıkmış.
- Karbon yoğunluğu ile EV payı arasındaki ilişki **2019–2024'ün altı yılında da negatif** (Spearman ρ −0,26 ile −0,46). 2024'te ρ = −0,31 (50 ülke): şebekesi temiz olan ülkelerde EV payı daha yüksek, ama bu ilişki orta-zayıf.
- **Çin her şeyi değiştiriyor.** 2024'te kayıt ağırlıklı EV payı, yüksek karbonlu şebekeli ülkelerde %31,3 görünüyor. Bunun sebebi tek ülke: Çin'i çıkarınca aynı oran %5,2'ye düşüyor. Bu yüzden ülke medyanı ve ülke düzeyi korelasyonu birlikte verdim.
- 2024'te EV payı en yüksek ülkeler Norveç (%90,5), İsveç (%57,0) ve Danimarka (%55,4). Türkiye'de pay 2023'te %6,9, 2024'te %11,1 ve 2025'te %21,0.

### Yıllara göre EV payı
![Yıllara göre EV payı](images/f1.png)

### Karbon yoğunluğu ve EV payı (2024)
![Dağılım grafiği](images/f3.png)

### Çin etkisi: ağırlıklı oran mı, ülke medyanı mı?
![Karbon grubuna göre EV payı](images/f4.png)

Diğer grafikler: [aylık BEV/PHEV](images/f2.png), [korelasyonun yıllara göre seyri](images/f5.png), [en yüksek 10 ülke](images/f6.png).

## Veri

| Dosya | İçerik |
|---|---|
| `data/FactEV.csv` | Ülke × ay × aktarma organı (BEV, PHEV, BEV+PHEV, tüm araçlar) için kayıt sayısı, 2019–2026 |
| `data/FactEnerji.csv` | Ülke × yıl için elektriğin karbon yoğunluğu, yenilenebilir ve düşük karbon payı, talep (2019–2024) |
| `data/DimUlke.csv` | ISO3, ülke adı (İngilizce ve Türkçe), kıta, G20/AB/OECD bilgisi |

Kaynaklar: Ember'ın aylık EV kayıt verisi ve Our World in Data enerji veri seti (ham dosyalardan temizlenmiş tablolar). Verilerin kullanım koşulları kaynaklarına aittir.

## Yöntem

1. Ham dosyalardan ülke satırları ve dört aktarma organı kategorisi seçildi, `EV = BEV + PHEV` tutarlılığı kontrol edildi.
2. **EV payı** = EV kayıt / tüm araç kayıtları (ülke yüzdelerinin ortalaması değil, toplamlar üzerinden).
3. Her yıl için ülke düzeyinde Pearson ve Spearman korelasyonu hesaplandı; karbon eşikleriyle üç ülke grubu kuruldu (<200, 200–449, ≥450 gCO₂/kWh).
4. Duyarlılık kontrolleri: Çin hariç, 2019'dan beri verisi olan 34 ülkelik sabit panel.
5. Sonuçlar Power BI modeline (yıldız şema, 5 tablo, 5 ilişki, 17 ölçü) aktarıldı.

## Power BI raporu

`powerbi/Elektrikli_Araclar_Enerji.pbip` dosyasını **Power BI Desktop** ile aç (Windows), **Yenile**'ye bas. Veri dosyanın içinde gömülü, yol ayarlamana gerek yok. İstersen *Dosya > Farklı kaydet* ile `.pbix` yapabilirsin.

Üç sayfa var: **Genel Bakış** (filtreler, kartlar, harita, aylık BEV/PHEV), **EV ve Şebeke İlişkisi** (dağılım grafiği, ülke tablosu), **Elektrik Şebekesi** (yenilenebilir/düşük karbon payı, karbon yoğunluğu).

> Harita görseli kapalı geliyorsa: *Dosya > Seçenekler > Güvenlik* bölümünden harita görsellerine izin ver.

## Analizi tekrar çalıştırmak

```bash
pip install -r requirements.txt
python analysis/analysis.py
```

## Sınırlılıklar (dürüst not)

- **2026 verisi eksik:** Ekim 2026'da sadece 6 ülke var, bu yüzden yıllık analizler 2019–2025'e dayanıyor.
- **Ülke kapsamı değişiyor:** EV verisi 2019'da 34, 2023'te 55 ülkeyi kapsıyor. Bu yüzden sabit panel sonucunu da verdim.
- **Enerji verisi 2024'te bitiyor.**
- Veri *yeni araç kayıtlarını* ölçüyor; filo büyüklüğünü veya gerçek şarj elektriğini değil.
- Sonuçlar ülke düzeyinde ve **nedensellik göstermez**: teşvikler, fiyatlar ve şarj altyapısı da EV payını belirliyor. İstatistiksel testler keşifsel kabul edilmeli (aynı ülkeler her yıl tekrar kullanılıyor).

## Yazar

Sude Nur Kılıç
