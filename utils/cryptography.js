const { isNil, isNotEmpty, isNotNil, update, dec } = require("ramda");
const crypto = require("crypto");
const bcrypt = require("bcryptjs");
require("dotenv").config();

function encryptAES(text) {
    if (text == null || (typeof text !== "string" && !Buffer.isBuffer(text))) {
        console.error('Error: The "text" argument must be of type string or an instance of Buffer. Received:', text);
        return null;
    }

    const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
    const iv = Buffer.from(process.env.IV_KEY, "hex");

    const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
    cipher.setAutoPadding(true);

    let encrypted = cipher.update(text, "utf8", "hex");
    encrypted += cipher.final("hex");
    return encrypted;
}

function decryptAES(encrypted) {
    if (isNil(encrypted)) {
        console.error('Error: Encrypted data cannot be null');
        return null;
    }

    const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Konversi dari hex ke buffer
    const iv = Buffer.from(process.env.IV_KEY, "hex");

    if (aesKey.length !== 32) { // Pastikan panjang kunci sesuai untuk aes-256
        console.error('Error: Invalid AES key length. Must be 32 bytes.');
        return null;
    }

    if (iv.length !== 16) { // Pastikan panjang IV sesuai untuk AES
        console.error('Error: Invalid IV length. Must be 16 bytes.');
        return null;
    }

    const decipher = crypto.createDecipheriv("aes-256-cbc", aesKey, iv);
    decipher.setAutoPadding(true);

    let decrypted;
    try {
        decrypted = decipher.update(encrypted, "hex", "utf8");
        decrypted += decipher.final("utf8");
    } catch (error) {
        console.error('Decryption error:', error.message);
        return null; // Mengembalikan null jika terjadi error
    }

    return decrypted;
}

function encryptImageAES(filePath) {
    try {
        const imageBuffer = fs.readFileSync(filePath); // Membaca gambar dari path file
        const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Kunci AES dari environment
        const iv = Buffer.from(process.env.IV_KEY, "hex"); // IV dari environment

        const cipher = crypto.createCipheriv("aes-256-cbc", aesKey, iv);
        cipher.setAutoPadding(true);

        let encrypted = cipher.update(imageBuffer); // Mengenkripsi buffer gambar
        encrypted = Buffer.concat([encrypted, cipher.final()]);

        // Hasil enkripsi dikembalikan dalam format hex
        return encrypted.toString('hex');
    } catch (error) {
        console.error('Error encrypting image:', error.message);
        return null;
    }
}

function decryptImageAES(encryptedHex, outputFilePath) {
    try {
        const encryptedBuffer = Buffer.from(encryptedHex, 'hex'); // Mengonversi hex ke buffer
        const aesKey = Buffer.from(process.env.AES_KEY, "hex"); // Kunci AES dari environment
        const iv = Buffer.from(process.env.IV_KEY, "hex"); // IV dari environment

        const decipher = crypto.createDecipheriv("aes-256-cbc", aesKey, iv);
        decipher.setAutoPadding(true);

        let decrypted = decipher.update(encryptedBuffer); // Mendekripsi buffer
        decrypted = Buffer.concat([decrypted, decipher.final()]);

        // Menyimpan hasil dekripsi ke file
        fs.writeFileSync(outputFilePath, decrypted);
        return outputFilePath; // Mengembalikan path file yang didekripsi
    } catch (error) {
        console.error('Error decrypting image:', error.message);
        return null;
    }
}


async function hashBcrypt(text) {
    const salt = await bcrypt.genSalt(10);
    const hashed = await bcrypt.hash(text, salt);

    return hashed;
}

async function compareBcrypt(string, hash) {
    const result = await bcrypt.compare(string, hash);
    return result;
}

function formatPlainUserData(user) {
    const plainUserData = user.get({ plain: true });

    plainUserData.fullname = decryptAES(plainUserData.fullname);
    plainUserData.identity_number = decryptAES(plainUserData.identity_number);

    return plainUserData
}

module.exports = { encryptAES, decryptAES, encryptImageAES, decryptImageAES, hashBcrypt, compareBcrypt, formatPlainUserData };
