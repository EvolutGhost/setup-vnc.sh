#!/bin/bash
echo "==============================================="
echo " 🛠️ Configurando XFCE4 + VNC no Kali Linux..."
echo "==============================================="

# Atualiza pacotes
sudo apt update && sudo apt upgrade -y

# Instala ambiente gráfico XFCE e utilitários
sudo apt install xfce4 xfce4-goodies dbus-x11 tigervnc-standalone-server -y

# Cria diretório do VNC se não existir
mkdir -p ~/.config/tigervnc

# Cria o script xstartup correto
cat > ~/.config/tigervnc/xstartup << 'EOF'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
xrdb $HOME/.Xresources
dbus-launch startxfce4 &
EOF

# Dá permissão de execução
chmod +x ~/.config/tigervnc/xstartup

# Remove possíveis travas antigas
vncserver -kill :1 >/dev/null 2>&1
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Inicia o servidor VNC
vncserver :1 -geom
