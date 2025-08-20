FROM node:20-alpine

WORKDIR /app

# ติดตั้ง deps ตาม lockfile ก่อน
COPY package*.json ./
RUN npm ci --omit=dev

# คัดลอกซอร์สแล้ว build
COPY . .
RUN npm run build

ENV NODE_ENV=production
EXPOSE 3000
# Next.js จะฟังในคอนเทนเนอร์ที่พอร์ต 3000
CMD ["npm", "start", "--", "-p", "3000"]
