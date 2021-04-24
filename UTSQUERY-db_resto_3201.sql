--B.1.a : count
SELECT COUNT(id_menu) AS jml_makanan FROM menu WHERE jenis_menu='Food'

--B.1.b : avg
SELECT AVG(total_harga) AS total_rata2 FROM transaksi

--B.1.c : max
SELECT MAX(total_point) AS poin_tertinggi FROM member

--B.2 :subquery
SELECT * FROM member WHERE id_member NOT IN(SELECT id_member FROM transaksi)
SELECT * FROM member WHERE total_point IN (SELECT MAX(total_point) FROM member)

--B.3 : multiple join tables
SELECT 
	transaksi.tanggal_transaksi, member.id_member, member.nama, menu.nama_menu, menu.harga, menu.deskripsi
	FROM transaksi
	INNER JOIN member ON member.id_member = transaksi.id_member
	INNER JOIN ordered_menu ON ordered_menu.id_transaksi = transaksi.id_transaksi
	INNER JOIN menu ON ordered_menu.id_menu = menu.id_menu