# bittorrent-tracker
bittorrent-tracker docker  
cd ~  
git clone https://github.com/buzzkillb/bittorrent-tracker  
cd bittorrent-tracker 

docker build -t tracker .  

docker run -d --name bittorrent-tracker --restart=unless-stopped -p 6969:8000 -p 6969:8000/udp tracker
