    <?php

    header("Access-Control-Allow-Origin: header");
    header("Access-Control-Allow-Origin: *");
    include 'koneksi.php';

    if ($_SERVER['REQUEST_METHOD'] == "POST") {

        $response = array();
        $username = $_POST['username'];
        $nama = $_POST['nama'];
        $nobp = $_POST['nobp'];

        $email = $_POST['email'];

        $password = md5($_POST['password']);


        $cek = "SELECT * FROM tb_user WHERE username = '$username' OR email = '$email'";
        $result = mysqli_query($koneksi, $cek);

        if (mysqli_num_rows($result) > 0) {
            $response['value'] = 2;
            $response['message'] = "Username atau email telah digunakan";
            echo json_encode($response);
        } else {
            $insert = "INSERT INTO tb_user (username, nama, nobp, email, password, created) 
                   VALUES ('$username','$nama','$nobp', '$email', '$password', NOW())";

            if (mysqli_query($koneksi, $insert)) {
                $response['value'] = 1;
                $response['username'] = $username;
                $response['email'] = $email;
                $response['nama'] = $nama;
                $response['nobp'] = $nobp;

                $response['message'] = "Registrasi Berhasil";
                echo json_encode($response);
            } else {
                $response['value'] = 0;
                $response['message'] = "Gagal Registrasi";
                echo json_encode($response);
            }
        }
    }

    ?>