<?php
session_start();
require_once 'config.php';

$errors = [];
$success = false;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recupero e sanitizzazione dei dati
    $nome = filter_input(INPUT_POST, 'nome', FILTER_SANITIZE_STRING);
    $cognome = filter_input(INPUT_POST, 'cognome', FILTER_SANITIZE_STRING);
    $email = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    // Validazione
    if (empty($nome)) {
        $errors[] = "Il nome è obbligatorio";
    }
    if (empty($cognome)) {
        $errors[] = "Il cognome è obbligatorio";
    }
    if (empty($email) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "Inserisci un'email valida";
    }
    if (strlen($password) < 8) {
        $errors[] = "La password deve essere di almeno 8 caratteri";
    }
    if ($password !== $confirm_password) {
        $errors[] = "Le password non coincidono";
    }

    // Se non ci sono errori, procedi con la registrazione
    if (empty($errors)) {
        try {
            // Verifica se l'email esiste già
            $stmt = $pdo->prepare("SELECT id FROM utenti WHERE email = ?");
            $stmt->execute([$email]);
            
            if ($stmt->rowCount() > 0) {
                $errors[] = "Questa email è già registrata";
            } else {
                // Hash della password
                $hashed_password = password_hash($password, PASSWORD_DEFAULT);
                
                // Inserimento nel database
                $stmt = $pdo->prepare("INSERT INTO utenti (nome, cognome, email, password) VALUES (?, ?, ?, ?)");
                $stmt->execute([$nome, $cognome, $email, $hashed_password]);
                
                $success = true;
                $_SESSION['success_message'] = "Registrazione completata con successo!";
                header("Location: login.php");
                exit();
            }
        } catch (PDOException $e) {
            $errors[] = "Errore durante la registrazione: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrazione</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>Registrazione</h2>
        
        <?php if (!empty($errors)): ?>
            <div class="error-messages">
                <?php foreach ($errors as $error): ?>
                    <p class="error"><?php echo htmlspecialchars($error); ?></p>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" class="registration-form">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<?php echo isset($_POST['nome']) ? htmlspecialchars($_POST['nome']) : ''; ?>" required>
            </div>

            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" value="<?php echo isset($_POST['cognome']) ? htmlspecialchars($_POST['cognome']) : ''; ?>" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="form-group">
                <label for="confirm_password">Conferma Password:</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
            </div>

            <button type="submit" class="btn-register">Registrati</button>
        </form>

        <p class="login-link">Hai già un account? <a href="login.php">Accedi qui</a></p>
    </div>
</body>
</html>
