INSERT INTO pegawai VALUES 
	('PEG-001','Alfa','Manajer','Jl.Pertama','+62000000001'),
	('PEG-002','Bravo','Front Desk','Jl.Kedua','+62000000002'),
	('PEG-003','Charlie','Chef','Jl.Ketiga','+62000000003'),
	('PEG-004','Delta','Chef','Jl.Keempat','+62000000004'),
	('PEG-005','Echo','Chef','Jl.Kelima','+62000000005'),
	('PEG-006','Foxtrot','Cleaning Service','Jl.Keenam','+62000000006'),
	('PEG-007','Golf','Waiter','Jl.Ketujuh','+62000000007'),
	('PEG-008','Hotel','Waiter','Jl.Kedelapan','+62000000008'),
	('PEG-009','India','Waiter','Jl.Kesembilan','+62000000009'),
	('PEG-010','Juliett','Waiter','Jl.Kesepuluh','+62000000010')

INSERT INTO menu VALUES
	('MENU-001','Food','Nasi Goreng','Nasi yang digoreng',12000),
	('MENU-002','Food','Nasi Bakar','Nasi yang dibakar',15000),
	('MENU-003','Food','Nasi Rebus','Nasi yang direbus',10000),
	('MENU-004','Food','Telur Goreng','Telur yang digoreng',6000),
	('MENU-005','Food','Tempe Goreng','Tempe yang digoreng',4000),
	('MENU-101','Drink','Teh','Minuman teh',3000),
	('MENU-102','Drink','Jeruk','Minuman jeruk',4000),
	('MENU-103','Drink','Susu','Ya susu',6000),
	('MENU-104','Drink','Kopi','Olahan kopi dalam minuman',5000),
	('MENU-105','Drink','Yogurt','Rasanya asam tapi enak',8000),
	('MENU-201','Dessert','Agar-agar','Merknya nutrijel, agak alot',3000),
	('MENU-202','Dessert','Pudding','Lembut & manis kok',5000),
	('MENU-301','Fruit','Pisang','Kuning dan panjang',4000),
	('MENU-302','Fruit','Semangka','Semangat kakak :D',3000)

INSERT INTO member VALUES
	('MEM-0000', 'Not a member', '0', 0),
	('MEM-0001', 'Jonathan Joestar', '+11111', 0),
	('MEM-0002', 'Joseph Joestar', '+22222', 0),
	('MEM-0003', 'Jotaro Kujo', '+33333', 0),
	('MEM-0004', 'Josuke Higashikata', '+44444', 0),
	('MEM-0005', 'Giorno Giovanna', '+55555', 0),
	('MEM-0006', 'Jolyne Kujo', '+66666', 0),
	('MEM-0007', 'Johnny Joestar', '+77777', 0),
	('MEM-0008', 'Dio Brando', '+88888', 0),
	('MEM-0009', 'Diego Brando', '+99999', 0),
	('MEM-0010', 'Roronoa Zoro', '+101010', 0)

INSERT INTO transaksi VALUES
	(1,'2021-1-4',0,0,'MEM-0010','PEG-007'),
	(2,'2021-2-4',0,0,'MEM-0009','PEG-008'),
	(3,'2021-3-4',0,0,'MEM-0000','PEG-009'),
	(4,'2021-4-4',0,0,'MEM-0007','PEG-010'),
	(5,'2021-5-4',0,0,'MEM-0006','PEG-010'),
	(6,'2021-6-4',0,0,'MEM-0000','PEG-009'),
	(7,'2021-7-4',0,0,'MEM-0004','PEG-008'),
	(8,'2021-8-4',0,0,'MEM-0003','PEG-007'),
	(9,'2021-9-4',0,0,'MEM-0002','PEG-010'),
	(10,'2021-10-4',0,0,'MEM-0000','PEG-009')

INSERT INTO ordered_menu VALUES
	(1,'MENU-001'),(1,'MENU-105'),
	(2,'MENU-002'),(2,'MENU-104'),(2,'MENU-202'),
	(3,'MENU-003'),(3,'MENU-103'),(3,'MENU-004'),
	(4,'MENU-004'),(4,'MENU-102'),(4,'MENU-004'),(4,'MENU-201'),
	(5,'MENU-005'),(5,'MENU-101'),(5,'MENU-103'),(5,'MENU-202'),(5,'MENU-002'),
	(6,'MENU-101'),(6,'MENU-201'),(6,'MENU-105'),(6,'MENU-101'),
	(7,'MENU-102'),(7,'MENU-202'),(7,'MENU-002'),
	(8,'MENU-103'),(8,'MENU-202'),(8,'MENU-003'),
	(9,'MENU-104'),(9,'MENU-201'),
	(10,'MENU-105'),(10,'MENU-201')

--UPDATE Total biaya dan poin
DECLARE	@var INT = 1
DECLARE @memId VARCHAR(20)
WHILE @var <= 10
BEGIN
	UPDATE transaksi SET 
	total_harga=
	(
		SELECT TOP 1 SUM(menu.harga)
		FROM ordered_menu
		INNER JOIN menu ON ordered_menu.id_menu = menu.id_menu
		WHERE ordered_menu.id_transaksi = @var
		GROUP BY ordered_menu.id_transaksi
	)
	WHERE id_transaksi=@var

	UPDATE transaksi SET 
	obtained_point=
	(
		total_harga/1000
	)
	WHERE id_transaksi=@var
	
	SET @memId =(
		SELECT TOP 1 transaksi.id_member
		FROM transaksi
		WHERE transaksi.id_transaksi = @var
		GROUP BY id_member)

	UPDATE member SET 
	total_point=
	(
		SELECT SUM(transaksi.obtained_point)
		FROM transaksi
		WHERE transaksi.id_transaksi = @var
		GROUP BY id_member
	)
	WHERE id_member = @memId
	
	SET @var = @var+1;
END
