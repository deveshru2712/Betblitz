import FeatureSection from "@/components/home/Features/FeatureSection";
import HeroSection from "@/components/home/Hero/HeroSection";
import Navbar from "@/components/Navbar";

export default function Home() {
  return (
    <div className="overflow-hidden">
      <Navbar />
      <div className="max-w-6xl mx-auto relative z-30 mt-35 md:mt-25 min-h-screen flex flex-col">
        <HeroSection />
        <FeatureSection />
        <div></div>
      </div>
    </div>
  );
}
