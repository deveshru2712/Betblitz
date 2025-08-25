import Navbar from "components/Navbar";

export default function Home() {
  return (
    <main className=" overflow-hidden">
      <Navbar />
      <div className="relative z-10">
        <h1 className="text-white">Your content goes here</h1>
      </div>
    </main>
  );
}
