export default function Overlay() {
  return (
    <div className="fixed inset-0 w-full h-full bg-black pointer-events-none z-0">
      <div
        className="absolute top-0 right-0 w-full h-full opacity-80"
        style={{
          background:
            "radial-gradient(ellipse 40% 60% at 0% 10%, #2D2C6B, transparent 70%)",
        }}
      />
      <div
        className="absolute top-0 right-0 w-full h-full"
        style={{
          background:
            "radial-gradient(ellipse 40% 70% at 100% 50%, #2D2C6B, transparent 70%)",
        }}
      />
    </div>
  );
}
