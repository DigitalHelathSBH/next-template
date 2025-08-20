export default function Home() {
  return (
    <main>
      <h1>New App 🎉</h1>
      <p>Base path: {process.env.NEXT_PUBLIC_BASE_PATH || "/"}</p>
    </main>
  );
}