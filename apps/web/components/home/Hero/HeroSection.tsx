"use client";
import { DottedMultiLineChart } from "@/components/ui/dotted-multi-line";
import { motion } from "motion/react";

export default function HeroSection() {
  return (
    <div className="w-full pb-25">
      <div className="w-full flex flex-col md:flex-row px-4 sm:px-6 md:px-8">
        {/* text container */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 1, delay: 1 }}
          className="flex flex-col flex-1 md:py-20 py-6 sm:py-8 text-neutral-200 gap-3 sm:gap-4 md:gap-6"
        >
          <h1 className="font-bold text-3xl sm:text-4xl md:text-5xl leading-tight">
            Trade Sports Options Like a <span className="text-sec">Pro.</span>
          </h1>
          <p className="text-sm sm:text-base md:text-lg font-medium max-w-sm sm:max-w-md md:max-w-2xl leading-relaxed">
            Advanced sports options trading platform with real-time analytics,
            professional-grade tools, and lightning-fast execution. Join
            thousands of traders maximizing their sports knowledge.
          </p>

          {/* CTA buttons */}
          <div className="flex flex-col sm:flex-row gap-3 sm:gap-4 mt-4 sm:mt-6 md:mt-8">
            <button className="bg-sec hover:bg-sec/90 text-white font-semibold py-3 px-6 md:px-8 rounded-lg transition-colors duration-200 text-sm md:text-base">
              Start Trading
            </button>
            <button className="border border-neutral-600 hover:border-neutral-500 text-neutral-200 font-semibold py-3 px-6 md:px-8 rounded-lg transition-colors duration-200 text-sm md:text-base">
              Learn More
            </button>
          </div>
        </motion.div>

        {/* chart container */}
        <motion.div
          initial={{ x: 1000 }}
          animate={{ x: 0 }}
          transition={{ duration: 1, delay: 0.5 }}
          className="flex-1 md:py-16 py-6 sm:py-8 flex items-center justify-center md:ml-6"
        >
          <div className="w-full max-w-sm sm:max-w-md md:max-w-lg">
            <div className="aspect-square md:aspect-auto">
              <DottedMultiLineChart />
            </div>
          </div>
        </motion.div>
      </div>

      {/* Footer text */}
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 1, delay: 1.5 }}
        className="w-full px-4 sm:px-6 md:px-8 mt-8 md:mt-12"
      >
        <p className="text-xs sm:text-sm text-neutral-400 text-center max-w-3xl mx-auto">
          Sports options trading involves significant risk and may not be
          suitable for all investors. Past performance is not indicative of
          future results. Please review our terms of service and risk disclosure
          before engaging in any trading activities.
        </p>
      </motion.div>
    </div>
  );
}
