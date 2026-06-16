# Customer Experience Analysis – GoFood Delivery Review

## Latar Belakang
Analisis review pelanggan dari 1 restoran (Nasi Goreng Polonia) 
pada platform GoFood, periode Oktober 2024 hingga januari 2025.

## Dataset
- 220 baris raw → dinormalisasi menjadi 3 tabel relasional
- 90 order unik | 149 item menu | 137 tag feedback

## Struktur Database
- orders       → 90 baris (level pengalaman pelanggan)
- order_items  → 149 baris (level menu per order)
- order_tags   → 137 baris (level feedback tag per order)

## Insight yang Dianalisis
A. Kualitas Layanan
   - Distribusi rating pelanggan
   - Proporsi review kosong vs berisi
   - Tag yang sering muncul pada rating rendah

B. Operasional
   - Jam delivery paling sering
   - Pola order multi-menu
   - Menu yang sering muncul di order buruk vs baik

## Tools
- Python (pandas) — normalisasi data
- SQLite + DB Browser for SQLite — database dan query
