<?php

$koneksi = mysqli_connect("localhost", "root", "", "uts_mobile2");

if ($koneksi) {

	// echo "Database berhasil Connect";

} else {
	echo "gagal Connect";
}