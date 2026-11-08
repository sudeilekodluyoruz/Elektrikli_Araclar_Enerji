# Power BI model kurulum rehberi

## 1. Tablolar ve ilişkiler

Model görünümünde aşağıdaki ilişkileri kur:

| Birincil tablo | Sütun | İlişkili tablo | Sütun | Kardinalite | Filtre yönü |
|---|---|---|---|---|---|
| DimUlke | ISO3 | FactEV | ISO3 | Birden çoğa (1:*) | Tek |
| DimUlke | ISO3 | FactEnerji | ISO3 | Birden çoğa (1:*) | Tek |
| DimTarih | Tarih | FactEV | Ay | Birden çoğa (1:*) | Tek |
| DimYil | Yil | DimTarih | Yil | Birden çoğa (1:*) | Tek |
| DimYil | Yil | FactEnerji | Yil | Birden çoğa (1:*) | Tek |

İlişkileri aktif bırak. FactEV ile FactEnerji arasında doğrudan ilişki kurma. Çift yönlü filtrelemeyi kullanma.

## 2. Tarih tablosu

1. `DimTarih` tablosunu seç.
2. **Tablo araçları > Tarih tablosu olarak işaretle > Tarih sütunu** seçeneğinden `Tarih` alanını seç.
3. `DimTarih[YilAy]` sütununu seçip **Sütuna göre sırala > YilAySira** yap.
4. Yıl dilimleyicisini `DimYil[Yil]` alanından oluştur. `DimTarih[Yil]` alanını yıl dilimleyicisi olarak kullanma.

## 3. Görsel alanları

### Harita
- Görsel: Azure Maps (tercih) veya dolu harita (kurum/tenant ayarları izin veriyorsa).
- Konum: `DimUlke[Ulke]`.
- Konum kategorisi: Ülke/Bölge.
- Renk/renk doygunluğu: `[EV Payı %]`.
- Araç ipucu: `[EV Kayıt]`, `[Karbon Yoğunluğu]`.
- Ülke isimleri belirsiz eşleşirse `DimUlke[ISO3]` alanını araç ipucuna ekle; konum alanı olarak ülke adını koru.

### Dağılım grafiği
- X ekseni: `[Karbon Yoğunluğu]`.
- Y ekseni: `[EV Payı %]`.
- Ayrıntılar (Details): `DimUlke[Ulke]`.
- Balon boyutu: `[EV Kayıt]`.
- Açıklama/Legend: boş bırak.
- ISO3'ü ikinci bir kategori/seri olarak ekleme.
- X ve Y eksenlerinin özetleme ayarlarını ölçü olarak bırak; her ülke bir nokta olmalı.

### Aylık BEV/PHEV çizgisi
- X ekseni: `DimTarih[YilAy]`.
- Y ekseni: `[BEV Kayıt]` ve `[PHEV Kayıt]`.
- X ekseni sıralaması `YilAySira` ile artan.
- Yıl dilimleyicisinden 2023 seçildiğinde yalnızca 2023 ayları görünmeli.

### Ülke tablosu
- Ülke: `DimUlke[Ulke]`.
- Değerler: `[EV Payı %]`, `[Karbon Yoğunluğu]`, `[EV Payı Değişim (puan)]`.
- Ülke satırlarının tekil kalması için ülke alanını DimUlke'den kullan.

## 4. Filtre davranışı

- Yıl: `DimYil[Yil]`.
- Kıta: `DimUlke[Kita]`.
- G20: `DimUlke[G20]`.
- G20 dilimleyicisinde `True/False` yerine okunabilir `Evet/Hayır` göstermek istersen DimUlke'ye Power Query'de veya DAX ile etiket sütunu ekleyebilirsin. İlk kurulumda Boolean alanı kullanmak daha güvenlidir.

## 5. Önemli kontrol

2025 veya 2026 seçildiğinde EV görselleri çalışabilir; enerji verisi 2024'te bittiği için enerji kartları boş görünür. Bu bir hata değildir. Kart başlığında enerji verisinin 2024'e kadar olduğu belirtilmesi kullanıcıyı yanıltmayı önler.
