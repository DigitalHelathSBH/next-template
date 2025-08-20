/** @type {import('next').NextConfig} */
const nextConfig = {
  // ใช้รากเว็บภายในคอนเทนเนอร์ แล้วให้ Kong ตัด path ให้
  basePath: "",
  trailingSlash: false,
};
export default nextConfig;