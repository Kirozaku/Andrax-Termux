#!/bin/bash
# Script to install ANDRAX non-root
# By Kethekman/Kirozaku
clear


folder="andrax-fs"
tarball="andrax.r5-build5.tar.xz"
cur=$(pwd)
bin="andrax.sh"

DOWNLOAD_URL="https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2/raw/master/compressed-core/andrax.r5-build5.tar.xz"

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
CYAN="\033[1;36m"
NC="\033[0m" 


spinner() {
    local pid=$1
    local msg=$2
    local spin='-\|/'
    local i=0
    echo -n -e "${CYAN}$msg ${NC}"
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %4 ))
        echo -n -e "\r${CYAN}$msg ${spin:$i:1}${NC}"
        sleep .1
    done
    echo -e "\r${GREEN}$msg OK    ${NC}"
}


show_banner() {
    echo -e "${RED}"
    echo "░█████╗░███╗░░██╗██████╗░██████╗░░█████╗░██╗░░██╗"
    echo "██╔══██╗████╗░██║██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝"
    echo "███████║██╔██╗██║██║░░██║██████╔╝███████║░╚███╔╝░"
    echo "██╔══██║██║╚████║██║░░██║██╔══██╗██╔══██║░██╔██╗░"
    echo "██║░░██║██║░╚███║██████╔╝██║░░██║██║░░██║██╔╝╚██╗"
    echo "╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝"
    echo -e " ${YELLOW}INSTALLER ANDRAX ON TERMUX WITHOUT ROOT${NC}"
    echo -e "       ${CYAN}>>> By Kethekman/Kirozaku <<<${NC}"
    echo ""
}


check_deps() {
    echo -e "${BLUE}[*] Checking dependencies...${NC}"
    local missing_deps=0
    
    if ! command -v proot &> /dev/null; then
        echo -e "${YELLOW}[!] 'proot' not found, installing...${NC}"
        pkg install proot -y
        if ! command -v proot &> /dev/null; then
            echo -e "${RED}[!] Failed to install 'proot'. Check your connection.${NC}"
            missing_deps=1
        else
            echo -e "${GREEN}[+] 'proot' installed successfully.${NC}"
        fi
    fi


    if ! command -v curl &> /dev/null; then
        echo -e "${YELLOW}[!] 'curl' not found, installing...${NC}"
        pkg install curl -y
        if ! command -v curl &> /dev/null; then
            echo -e "${RED}[!] Failed to install 'curl'. Check your connection.${NC}"
            missing_deps=1
        else
            echo -e "${GREEN}[+] 'curl' installed successfully.${NC}"
        fi
    fi
    
    if [ $missing_deps -eq 1 ]; then
        echo -e "${RED}[!] Failed to install dependencies. Script stopping.${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}[+] All dependencies (proot, curl) OK.${NC}"
    sleep 1
}

do_install() {
    echo -e "${BLUE}[*] Starting installation process...${NC}"
    
    if [ ! -f "$tarball" ]; then
        echo -e "${RED}[ Error ] File '$tarball' not found!${NC}"
        echo -e "${YELLOW}Installation process cancelled.${NC}"
        exit 1
    fi
    
    mkdir -p "$folder"

    echo -e "${YELLOW}Decompressing Rootfs, please be patient ...sabaaaar bos .ngopi aja dulu ☕😎${NC}"

    (proot --link2symlink tar -xJf "$cur/$tarball" -C "$folder") > /dev/null 2>&1 &
    spinner $! "Extracting $tarball..."

    if [ ! -d "$folder/root" ]; then
        echo -e "${RED}[!] Extraction FAILED!${NC}"
        echo -e "${YELLOW}Make sure '$tarball' is not corrupt and you have enough internal storage.${NC}"
        rm -rf "$folder" 
        exit 1
    fi

    echo -e "${BLUE}[*] writing launch script ($bin)...${NC}"
    cat > "$bin" <<- EOM
#!/bin/bash
# Launcher for ANDRAX
# Script BY Kethekman/Kirozaku
unset LD_PRELOAD
cd \$(dirname \$0)
proot \\
    --link2symlink \\
    -0 \\
    -r $folder \\
    -b /dev/ \\
    -b /proc/ \\
    -b /sys/ \\
    -b $folder/tmp:/tmp \\
    -b $HOME \\
    -w /root \\
    /usr/bin/env -i \\
    HOME=/root \\
    USER=root \\
    LOGNAME=root \\
    PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin \\
    TERM=\$TERM \\
    LANG=C.UTF_8 \\
    /usr/bin/env PATH=/usr/bin:/bin:/usr/sbin:/sbin ZDOTDIR=/home/andrax /bin/zsh --login -c "source /home/andrax/.zshrc; andrax; zsh"
EOM

    chmod +x "$bin"

    echo -e "${BLUE}[*] fixing shebang of andrax.sh${NC}" 
    termux-fix-shebang "$folder/usr/bin/*" > /dev/null 2>&1 &
    spinner $! "Running termux-fix-shebang..."

    echo ""
    echo -e "${GREEN}Installation successful 😎 next run the script 👉 ${YELLOW}./$bin${NC}"
    echo -e "${GREEN}Script BY Kethekman/Kirozaku 🗿${NC}" 
    echo ""
}


do_download() {
    echo -e "${BLUE}[*] Starting download from:${NC} ${CYAN}$DOWNLOAD_URL${NC}"
    
    curl -L "$DOWNLOAD_URL" -o "$tarball"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Download FAILED!${NC}"
        echo -e "${YELLOW}Check your internet connection or URL.${NC}"
        rm -f "$tarball" 
        exit 1
    fi
    
    echo -e "${GREEN}[+] Download Complete. File saved as: ${YELLOW}$tarball${NC}"
    do_install 
}

show_menu() {
    clear
    show_banner
    echo -e "${YELLOW}Select Installation Option:${NC}"
    echo -e "  ${GREEN}[ 1 ]${NC} Install from local file (${YELLOW}$tarball${NC})"
    echo -e "  ${GREEN}[ 2 ]${NC} Automatically download file, then Install"
    echo -e "  ${RED}[ 0 ]${NC} Cancel / Exit"
    echo ""
    read -p "Enter choice [1, 2, or 0]: " pilihan

    case $pilihan in
        1)
            echo -e "${BLUE}[*] Option 1 selected: Install from local file.${NC}"
            do_install
            ;;
        2)
            echo -e "${BLUE}[*] Option 2 selected: Download and Install.${NC}"
            do_download
            ;;
        0)
            echo -e "${YELLOW}[*] Installation cancelled. Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Invalid choice!${NC}"
            sleep 2
            show_menu
            ;;
    esac
}

check_deps
show_menu
