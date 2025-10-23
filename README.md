# 📘 INSTALLER ANDRAX ON TERMUX WITHOUT ROOT

## 🔗 Download ANDRAX Core
[Download ANDRAX Core](https://drive.google.com/file/d/1RqW5LN2qev5euVSOczMbICV28F-Y_Mb8/view?usp=drivesdk)

---

![screenshot](https://raw.githubusercontent.com/Kirozaku/Andrax-Termux/main/1.jpg)

## ⚙️ How to Install ANDRAX on Termux

1. **Install required dependencies**
   ```bash
   pkg install curl
   ```

2. **Download the installation script**
   ```bash
   curl https://raw.githubusercontent.com/Kirozaku/Andrax-Termux/refs/heads/main/install-andrax.sh -o install-andrax.sh
   ```

3. **Run the installer**
   ```bash
   bash install-andrax.sh
   ```

---

## 🧩 Installation Options
- **Option 1:**  
  If you already have the file `andrax.r5-build5.tar.xz` in the same directory as `install-andrax.sh`, simply run the script directly.

- **Option 2:**  
  If you do not have the file `andrax.r5-build5.tar.xz`, the installer will automatically download and install it for you.

---

## 🚀 Launching ANDRAX
Once installation is complete, run the following command:
```bash
./andrax.sh
```

![screenshot](https://raw.githubusercontent.com/Kirozaku/Andrax-Termux/main/2.jpg)

---

## 🧠 Notes
- Ensure you have a stable internet connection during the automatic installation process.  
- Run Termux with storage permission using (`termux-setup-storage`) if required.  
- It is recommended to use the latest version of Termux for best compatibility.

---

📌 *Developed to simplify the installation process of ANDRAX in Termux environments.*
