<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $username = $_POST['email'];
    $password = md5($_POST['password']);

    $cek = "SELECT * FROM tb_user WHERE email = '$username' AND password = '$password'";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = "berhasil login";
        $response['username'] = $result['username'];
        $response['nama'] = $result['nama'];
        $response['nobp'] = $result['nobp'];
        $response['email'] = $result['email'];
        $response['id_user'] = $result['id_user'];
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal login";
        echo json_encode($response);
    }
}