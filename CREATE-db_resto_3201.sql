CREATE DATABASE db_resto_3201

USE db_resto_3201

CREATE TABLE pegawai(
	id_pegawai VARCHAR(20) NOT NULL PRIMARY KEY,
	nama_pegawai VARCHAR(255) NOT NULL,
	jabatan VARCHAR(20) NOT NULL,
	alamat VARCHAR(255) NOT NULL,
	telepon VARCHAR(15) NOT NULL
);

CREATE TABLE menu(
	id_menu VARCHAR(20) NOT NULL PRIMARY KEY,
	jenis_menu VARCHAR(20) NOT NULL,
	nama_menu VARCHAR(100) NOT NULL,
	deskripsi VARCHAR(255) NOT NULL,
	harga MONEY
);

CREATE TABLE member(
	id_member VARCHAR(20) NOT NULL PRIMARY KEY,
	nama VARCHAR(255) NOT NULL,
	telepon VARCHAR(15) NOT NULL,
	total_point INT NOT NULL,
);

CREATE TABLE transaksi(
	id_transaksi INT NOT NULL PRIMARY KEY,
	tanggal_transaksi DATE NOT NULL,
	total_harga MONEY,
	obtained_point INT,
	id_member VARCHAR(20) NOT NULL
		FOREIGN KEY REFERENCES member(id_member),
	id_pegawai VARCHAR(20) NOT NULL
		FOREIGN KEY REFERENCES pegawai(id_pegawai)
);

CREATE TABLE ordered_menu(
	id_transaksi INT NOT NULL
		FOREIGN KEY REFERENCES transaksi(id_transaksi),
	id_menu VARCHAR(20) NOT NULL
		FOREIGN KEY REFERENCES menu(id_menu)
);
