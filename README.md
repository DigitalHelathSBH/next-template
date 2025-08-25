# 🌟 next-template — Next.js + Docker + Nginx

[![Next.js](https://img.shields.io/badge/Next.js-black?logo=next.js&logoColor=white&style=for-the-badge)](#)
[![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?logo=typescript&logoColor=white&style=for-the-badge)](#)
[![Node.js 20+](https://img.shields.io/badge/Node.js-20+-339933?logo=node.js&logoColor=white&style=for-the-badge)](#)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white&style=for-the-badge)](#)

เทมเพลต **Next.js (TypeScript)** สำหรับดีพลอยบน **Docker** แล้วเชื่อมผ่าน **Nginx** ได้ทันที  
ภายในคอนเทนเนอร์ฟังที่ `3000` และ **map ออกโฮสต์ที่ `4001`**

---

## 🔎 สารบัญ
- [คุณสมบัติเด่น](#-คุณสมบัติเด่น)
- [สิ่งที่ต้องมี](#-สิ่งที่ต้องมี)
- [เริ่มต้นแบบเร็ว (Docker)](#-เริ่มต้นแบบเร็ว-docker)
- [ตั้งค่า Nginx (ตัวอย่าง)](#-ตั้งค่า-nginx-ตัวอย่าง)
- [อัปเดต/ดีพลอยรอบถัดไป](#-อัปเดตดีพลอยรอบถัดไป)
- [โครงสร้างโปรเจกต์](#-โครงสร้างโปรเจกต์)
- [สคริปต์ npm](#-สคริปต์-npm)
- [บันทึก/คำแนะนำ](#-บันทึกคำแนะนำ)

---

## ✨ คุณสมบัติเด่น
- ⚙️ **Docker multi-stage** พร้อมใช้งาน
- 🧭 รองรับ **reverse proxy ด้วย Nginx** (path prefix หรือ subdomain)
- 🧩 โครงสร้าง **Next.js app directory** มาตรฐาน
- 🚀 ใช้เป็น **เทมเพลตเริ่มโปรเจกต์ใหม่** ได้ทันที

---

## ✅ สิ่งที่ต้องมี
- Linux server ที่ติดตั้ง **Docker**
- สิทธิ์เข้าถึง GitHub repo (ถ้าเป็น private แนะนำใช้ **Personal Access Token**)
- (ทางเลือก) **Nginx** หากต้อง reverse proxy หลายโปรเจกต์

---

## 🚀 เริ่มต้นแบบเร็ว (Docker)
> เป้าหมาย: เปิดใช้งานที่ `http://<SERVER-IP>:4001`

```bash
# 1) โคลนโค้ด (แทนที่ <USERNAME> และ <PAT> หากเป็น private)
cd ~
git clone https://<USERNAME>:<PAT>@github.com/DigitalHelathSBH/next-template.git welcome
cd welcome

# 2) สร้างอิมเมจจาก Dockerfile ใน repo
docker build -t welcome .

# 3) รันคอนเทนเนอร์: host 4001 -> container 3000
docker run -d --name welcome -p 4001:3000 --restart unless-stopped welcome

# 4) ทดสอบ
curl -I http://127.0.0.1:4001/

## 🧭 ตั้งค่า Nginx (ตัวอย่าง)

<details>
<summary><b>A) ใช้ path prefix <code>/welcome</code></b></summary>

```nginx
server {
    listen 80;
    server_name <YOUR_IP_OR_DOMAIN>;

    gzip on;
    gzip_types text/plain application/json application/javascript text/css text/xml application/xml+rss;
    client_max_body_size 20m;

    location /welcome/ {
        proxy_pass         http://127.0.0.1:4001/;
        proxy_http_version 1.1;
        proxy_set_header   Host $host;
        proxy_set_header   X-Real-IP $remote_addr;
        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;
        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection "upgrade";
    }

    # (ทางเลือก) ส่งผู้ใช้จาก root ไปยัง /welcome/
    location = / { return 302 /welcome/; }
}

