"use client";
import { cricketMatches } from "@/constant";
import Cards from "./Cards";
import Image from "next/image";
import { motion } from "motion/react";

export default function FeatureSection() {
  return (
    <main
      id="#market"
      className="w-full flex flex-col md:flex-row px-4 sm:px-6 md:px-8 pb-25"
    >
      <div className="w-full flex flex-col gap-5">
        <span className="w-full">
          <h2 className="text-center font-bold text-5xl">Upcoming Matches</h2>
        </span>
        <div className="min-h-[500px] mx-auto w-3/4 mt-10">
          <div className="flex md:flex-row gap-10 md:gap-0 flex-col justify-between items-center">
            <div className="flex flex-col gap-10">
              {cricketMatches &&
                cricketMatches.length > 0 &&
                cricketMatches.map((match) => (
                  <Cards key={match.id} {...match} />
                ))}
            </div>

            <div className="flex flex-col items-center">
              <motion.div
                initial={{ rotate: 0, scale: 0.9, opacity: 0 }}
                animate={{ rotate: 10, scale: 1, opacity: 100 }}
                transition={{ duration: 0.7 }}
              >
                <Image
                  alt="cricket"
                  src={"/player.png"}
                  height={250}
                  width={250}
                />
              </motion.div>

              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.8, delay: 0.3 }}
                className="mt-6 text-center"
              >
                <h3 className="text-xl font-semibold text-gray-100 mb-2">
                  Cricket Fever
                </h3>
                <p className="text-gray-300 text-left max-w-xs">
                  Experience the thrill of cricket with live updates, match
                  highlights, and exclusive content from your favorite teams and
                  players.
                </p>
              </motion.div>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
