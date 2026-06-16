Query A — Insight Kualitas Layanan
A1. Distribusi Rating
sql-- Distribusi rating pelanggan
SELECT 
    rating,
    COUNT(*) AS jumlah_order,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS persentase
FROM orders
GROUP BY rating
ORDER BY rating;
Dari data: mayoritas rating 5 (69 order), rating 1 hanya 2 order.

A2. Proporsi Review Kosong vs Berisi
sql-- Proporsi review kosong vs berisi
SELECT
    CASE WHEN review IS NULL THEN 'Tanpa Review' ELSE 'Ada Review' END AS status_review,
    COUNT(*) AS jumlah,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS persentase
FROM orders
GROUP BY status_review;
Dari data: 74 order tanpa review, 16 ada review.

A3. Tag Paling Sering Muncul di Rating Rendah
sql-- Tag yang sering muncul pada rating rendah (rating <= 3)
SELECT
    ot.tag_name,
    COUNT(*) AS frekuensi
FROM orders o
JOIN order_tags ot ON o.order_id = ot.order_id
WHERE o.rating <= 3
GROUP BY ot.tag_name
ORDER BY frekuensi DESC;

A4. Tag Paling Sering Muncul Keseluruhan
sql-- Frekuensi semua tag (semua rating)
SELECT
    tag_name,
    COUNT(*) AS frekuensi,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM order_tags), 1) AS persentase
FROM order_tags
GROUP BY tag_name
ORDER BY frekuensi DESC;
Dari data: TASTE (63), PORTION (52), VALUE (50), FRESHNESS (45), HYGIENE (35), PACKAGING (32).

Query B — Insight Operasional
B1. Jam Delivery Paling Sering
sql-- Distribusi jam order
SELECT
    CAST(strftime('%H', order_datetime) AS INTEGER) AS jam,
    COUNT(*) AS jumlah_order
FROM orders
GROUP BY jam
ORDER BY jumlah_order DESC;
SQLite menggunakan strftime untuk ekstrak jam dari datetime.

B2. Pola Order Multi-Menu
sql-- Berapa banyak order yang pesan 1 menu vs lebih
SELECT
    jumlah_menu,
    COUNT(*) AS jumlah_order,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 1) AS persentase
FROM (
    SELECT order_id, COUNT(*) AS jumlah_menu
    FROM order_items
    GROUP BY order_id
) sub
GROUP BY jumlah_menu
ORDER BY jumlah_menu;

B3. Menu Paling Sering Dipesan
sql-- Top menu keseluruhan
SELECT
    menu_name,
    COUNT(*) AS frekuensi
FROM order_items
GROUP BY menu_name
ORDER BY frekuensi DESC
LIMIT 10;

B4. Menu di Order Buruk vs Baik
sql-- Menu yang muncul di rating rendah (<=3) vs rating tinggi (=5)
SELECT
    oi.menu_name,
    SUM(CASE WHEN o.rating <= 3 THEN 1 ELSE 0 END) AS muncul_di_order_buruk,
    SUM(CASE WHEN o.rating = 5  THEN 1 ELSE 0 END) AS muncul_di_order_baik
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY oi.menu_name
HAVING muncul_di_order_buruk > 0
ORDER BY muncul_di_order_buruk DESC;