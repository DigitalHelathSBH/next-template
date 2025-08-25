# syntax=docker/dockerfile:1
FROM node:20-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps --no-audit --no-fund

FROM node:20-alpine AS build
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build /app/.next ./.next
# COPY --from=build /app/public ./public   # ถ้ามีค่อยใส่กลับ
COPY package.json ./
RUN npm install --omit=dev --legacy-peer-deps --no-audit --no-fund
EXPOSE 3000
CMD ["npm","run","start","--","-p","3000"]
