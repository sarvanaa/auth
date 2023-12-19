<?php
header("Access-Control-Allow-Origin:*");
header("Access-Control-Allow-Headers: *");

$servername = "localhost";
$user = "root";
$pass = "";
$db = "example";
$conn = mysqli_connect($servername, $user, $pass, $db) or die('Not Connect');

$queryResult = mysqli_query($conn, "SELECT * FROM employee_sample_data");
$result = array();

while ($fetchData = mysqli_fetch_assoc($queryResult)) {
    $result[] = $fetchData;
}

// Send back data to Flutter
header('Content-Type: application/json'); // Set the content type
if ($result) {
    echo json_encode($result);
} else {
    echo json_encode(['error' => 'No data found']);
}
?>
