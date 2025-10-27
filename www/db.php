<?php
$host = '192.168.56.102'; // IP del VM db
$db   = 'prueba_db';
$user = 'vagrant';
$pass = 'vagrantpass';
$port = '5432';

$dsn = "pgsql:host=$host;port=$port;dbname=$db;";

try {
    $pdo = new PDO($dsn, $user, $pass, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    $stmt = $pdo->query('SELECT id, nombre, correo FROM personas');
    echo "<h1>Personas registradas</h1>";
    echo "<ul>";
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<li>" . htmlspecialchars($row['id']) . " - " . htmlspecialchars($row['nombre']) . " (" . htmlspecialchars($row['correo']) . ")</li>";
    }
    echo "</ul>";
} catch (PDOException $e) {
    echo "Error de conexión: " . htmlspecialchars($e->getMessage());
}
?>