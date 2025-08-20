import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // กำหนด basePath จาก ENV เวลา clone ไปใช้ใหม่ก็เปลี่ยนได้โดยไม่แก้โค้ด
  basePath: process.env.NEXT_PUBLIC_BASE_PATH || "",
  trailingSlash: true
};

export default nextConfig;
