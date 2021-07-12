FROM node:12
RUN npm install -g bittorrent-tracker
EXPOSE 8000
CMD ["bittorrent-tracker"]
