const Overlay = () => {
  return (
    <div className="min-h-screen w-full relative bg-black">
      <div className="flex justify-between items-center h-screen">
        {/* Smaller circle gradient - now with higher z-index */}

        <div
          className="absolute top-0 right-0 w-full h-full z-20 opacity-80"
          style={{
            background:
              "radial-gradient(ellipse 40% 60% at 0% 10%, #2D2C6B, transparent 70%)",
          }}
        ></div>

        {/* Bigger circle gradient */}
        <div
          className="absolute top-0 right-0 w-full h-full z-10"
          style={{
            background:
              "radial-gradient(ellipse 40% 70% at 100% 50%, #2D2C6B, transparent 70%)",
          }}
        />
      </div>
    </div>
  );
};

export default Overlay;
