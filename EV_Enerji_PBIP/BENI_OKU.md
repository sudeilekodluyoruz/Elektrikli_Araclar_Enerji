# Elektrikli Araçlar ve Elektrik Şebekesi – Power BI projesi (PBIP)

## .pbix dosyasını almak (4 adım)
1. Power BI Desktop'ı aç (güncel sürüm). Dosya > Aç > `Elektrikli_Araclar_Enerji.pbip`.
2. Veri gömülü olduğu için bir yol ayarı gerekmez. Açılışta **Yenile** (Refresh) de.
3. Beklenen kontrol (Yıl = 2023): EV Kayıt 13.178.040 · Toplam Kayıt 69.749.044 · EV Payı %18,9 · EV ülke sayısı 55.
4. Dosya > **Farklı kaydet** > tür olarak **.pbix** seç.

## Sayfalar
- Genel Bakış: Yıl/Kıta/G20 filtresi, 4 kart, ülke haritası, aylık BEV/PHEV çizgisi
- EV ve Şebeke İlişkisi: dağılım grafiği, ülke çubuk grafiği, ülke tablosu
- Elektrik Şebekesi: yenilenebilir/düşük karbon payı, karbon yoğunluğu (2019–2024)

## Paketten farklar
- `DimUlke`: `UlkeTR` (Türkçe ad), `G20Etiket/ABEtiket/OECDEtiket` (Evet/Hayır) eklendi; harita için HKG, TWN, VNM adları sadeleştirildi.
- `Yenilenebilir Pay` ve `Düşük Karbon Pay` ölçüleri % formatı için 100'e bölündü.
- Yıllık değişim ölçüleri 2026'da (Ocak–Ekim) geçen yılın aynı dönemiyle kıyaslar.
- Yeni ölçü: `EV Ülke Sayısı`.
- Yıl dilimleyicisi varsayılan olarak 2024 (hem EV hem enerji verisi tam yıl).

## Dikkat
- 2019–2022'de EV verisi 34–39 ülke, 2023'te 55 ülke kapsar. 2022→2023 artışı kısmen kapsam genişlemesidir.
- Rapor dosyaları Power BI Desktop olmadan üretildi. Bir görsel açılmazsa alanları `Paket_Dokumanlari/DAX.md` tablosuna göre yeniden bağla.
