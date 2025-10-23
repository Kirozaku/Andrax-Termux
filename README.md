# 📘 INSTALLER ANDRAX ON TERMUX WITHOUT ROOT

## 🔗 Link Download ANDRAX Core
[Download ANDRAX Core](https://drive.google.com/file/d/1RqW5LN2qev5euVSOczMbICV28F-Y_Mb8/view?usp=drivesdk)

---

## ⚙️ Cara Install ANDRAX di Termux

1. **Instal dependensi dasar**
   ```bash
   pkg install curl
   ```

2. **Unduh script instalasi**
   ```bash
   curl https://raw.githubusercontent.com/Kirozaku/Andrax-Termux/refs/heads/main/install-andrax.sh -o install-andrax.sh
   ```

3. **Jalankan installer**
   ```bash
   bash install-andrax.sh
   ```

---

## 🧩 Opsi Instalasi
- **Opsi 1:**  
  Jika Anda **sudah memiliki file `andrax.r5-build5.tar.xz`** di direktori yang sama dengan `install-andrax.sh`, jalankan langsung script tersebut.
  
- **Opsi 2:**  
  Jika **belum memiliki file `andrax.r5-build5.tar.xz`**, installer akan **mengunduh dan menginstal secara otomatis**.  

---

## 🚀 Menjalankan ANDRAX
Setelah proses instalasi selesai, jalankan perintah berikut:
```bash
./andrax.sh
```

---

## 🧠 Catatan
- Pastikan koneksi internet stabil saat proses instalasi otomatis.  
- Jalankan Termux dengan izin penyimpanan (`termux-setup-storage`) jika diperlukan.  
- Direkomendasikan menggunakan versi Termux terbaru agar kompatibilitas lebih baik.

---

📌 *Dikembangkan untuk mempermudah proses instalasi ANDRAX di lingkungan Termux.*
