const crypto = require('crypto');

function encryptAES(text) {
    const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
    const iv = Buffer.from(process.env.IV_KEY, "hex");

    const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);

    let encrypted = cipher.update(text, "utf8", "hex");
    encrypted += cipher.final("hex");
    return encrypted;
}

function decryptAES(encrypted) {
    const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
    const iv = Buffer.from(process.env.IV_KEY, "hex");

    const decipher = crypto.createDecipheriv("aes-256-cbc", aesKey, iv);

    let decrypted = decipher.update(encrypted, "hex", "utf8");
    decrypted += decipher.final("utf8");

    return decrypted;
}

module.exports = { encryptAES, decryptAES };