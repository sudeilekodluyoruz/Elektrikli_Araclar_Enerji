# Elektrikli Araçlar ve Elektrik Şebekesi – Düzeltilmiş Power BI paketi

Bu paket, gönderdiğin iki ham CSV ve mevcut DAX/Power Query taslağı temel alınarak yeniden hazırlanmıştır. Power BI Desktop dosyası (`.pbix`) bu ortamda doğrudan açılıp kaydedilemediği için paket, Power BI'da içeri alınacak temiz tabloları, Power Query sorgularını, DAX ölçülerini ve kurulum adımlarını içerir.

## Paket yapısı

- `data/FactEV.csv`: 2019-01 sonrası ülke bazında EV kayıtları; dört gerekli drivetrain kategorisi.
- `data/FactEnerji.csv`: EV veri setindeki ülkeler için 2019–2024 enerji/şebeke verileri.
- `data/DimUlke.csv`: 57 ülke için ülke, kıta, bölge ve üyelik bilgileri.
- `data/DimTarih.csv`: 2019-01-01 – 2026-12-31 günlük takvim.
- `data/DimYil.csv`: 2019–2026 yıl tablosu.
- `PowerQuery/`: Her tablo için ayrı Power Query M sorgusu.
- `DAX.md`: Ölçüler ve görsel alan eşleştirmeleri.
- `Dokumantasyon/VERI_DOGRULAMA.md`: Kaynak verilerden bağımsız hesaplanan kontrol değerleri.
- `Dokumantasyon/MODEL_KURULUM.md`: İlişkiler ve Power BI kurulum adımları.

## Hızlı kurulum

1. ZIP'i bilgisayarında sabit bir klasöre çıkar. Örnek: `C:\PowerBI\Elektrikli_Araclar_Enerji_TAM_PAKET`.
2. Power BI Desktop'ta **Veri al > Metin/CSV** ile `data` klasöründeki beş CSV'yi tek tek içeri aktar. CSV'ler virgül ayraçlı ve UTF-8 BOM kodlamalıdır.
3. Tablo adlarını `FactEV`, `FactEnerji`, `DimUlke`, `DimTarih`, `DimYil` olarak ayarla.
4. `Dokumantasyon/MODEL_KURULUM.md` içindeki ilişkileri kur.
5. `DAX.md` içindeki ölçüleri tek tek ekle.
6. `DimTarih[Tarih]` alanını tarih tablosu olarak işaretle.
7. `DimTarih[YilAy]` alanını `DimTarih[YilAySira]` ile sırala.
8. Mevcut rapor sayfasında görsel alanlarını `DAX.md` tablosuna göre düzelt.
9. Kontrol için 2023 yılını seç ve `VERI_DOGRULAMA.md` değerleriyle karşılaştır.

## Power Query kullanmak istersen

Hazır CSV'leri doğrudan içeri aktarmak en kolay yoldur. M sorgularını kullanacaksan:
- Power Query'de `KlasorYolu` adında metin parametresi oluştur.
- Parametreye ZIP'in çıkarıldığı ana klasörün tam yolunu ver.
- `PowerQuery` altındaki ilgili `.pq` dosyasının içeriğini yeni boş sorgunun Gelişmiş Düzenleyicisine ayrı ayrı yapıştır.
- Sorgu adını dosyadaki tablo adıyla aynı yap.

## Önemli veri kapsamı

- EV verisi 2019-01-01 ile 2026-10-01 arasını kapsar.
- Enerji verisi 2019–2024 arasındadır. 2025–2026 için enerji/karbon kartlarının boş kalması beklenir.
- FactEV, sadece ülke satırlarını ve dört drivetrain kategorisini içerir. Diğer araç türleri dışarıda bırakılmıştır.
- Kaynakta bu filtrelerle 57 ISO3 ülke bulunur. 2023 EV verisi 55 ülkeyi kapsar.
- Enerji verisi 2024 yılında 55 ülkeyi kapsar; bazı enerji alanlarında eksik değer olabilir.
- Aylık EV verisinde seçilen dört drivetrain için bu ham kaynakta aylık frekans kayıtları vardır. Orijinal dosyada başka drivetrain kategorilerinde üç aylık kayıtlar da bulunur.
- 2023 ülke toplamı kartı, ülke kayıtlarının toplamından hesaplanır; ülke yüzdelerinin basit ortalaması değildir.

## Mevcut PBIX hakkında

Bu paket mevcut `.pbix` dosyasını otomatik olarak değiştirmez. PBIX'in iç veri modelini Power BI Desktop'ta açıp bu tablolarla güncellemen ve görselleri eşleştirmen gerekir. Önce mevcut PBIX'in bir kopyasını al; orijinali koru.
