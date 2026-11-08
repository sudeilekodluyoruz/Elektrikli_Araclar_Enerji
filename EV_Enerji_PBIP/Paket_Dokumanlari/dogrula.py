import pandas as pd
from pathlib import Path

ROOT = Path(__file__).resolve().parent
ev = pd.read_csv(ROOT / "data" / "FactEV.csv")
energy = pd.read_csv(ROOT / "data" / "FactEnerji.csv")

ev["Ay"] = pd.to_datetime(ev["Ay"])
y23 = ev[ev["Ay"].dt.year == 2023]

def total(kind):
    return y23.loc[y23["AracTuru"] == kind, "Kayit"].sum()

ev_reg = total("Electric vehicle (BEV+PHEV)")
all_reg = total("All drivetrains")

print("2023 EV kayıt:", int(ev_reg))
print("2023 toplam kayıt:", int(all_reg))
print("2023 EV payı (%):", round(ev_reg / all_reg * 100, 4))
print("2023 EV ülkesi:", y23["ISO3"].nunique())

country_ev = y23.pivot_table(
    index="ISO3", columns="AracTuru", values="Kayit", aggfunc="sum"
)
country_ev["EVPay"] = country_ev["Electric vehicle (BEV+PHEV)"] / country_ev["All drivetrains"]
e23 = energy[energy["Yil"] == 2023].set_index("ISO3")
check = country_ev[["EVPay"]].join(e23[["KarbonYogunlugu"]]).dropna()
print("EV + karbon verisi olan ülke:", len(check))
print("Pearson korelasyonu:", round(check["EVPay"].corr(check["KarbonYogunlugu"]), 4))
