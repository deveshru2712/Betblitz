"use client";
import dayjs from "dayjs";
import { motion } from "motion/react";

interface MatchTeam {
  name: string;
  flag: string;
}

export interface CricketMatch {
  id: number;
  team1: MatchTeam;
  team2: MatchTeam;
  venue: string;
  date: string;
  time: string;
  format: string;
  country: string;
}

const gradientPairs = [
  "from-blue-700 to-green-600",
  "from-green-700 to-green-500",
  "from-orange-600 to-orange-500",
];

const pickGradient = (id: number) => {
  const idx = Math.abs(id) % gradientPairs.length;
  return gradientPairs[idx];
};

const handleDuration = (id: number) => {
  return id * 0.3;
};

export default function Cards({
  id,
  team1,
  team2,
  venue,
  date,
  time,
  format,
  country,
}: CricketMatch) {
  const gradientDirection =
    id % 3 === 0
      ? "bg-gradient-to-br"
      : id % 3 === 1
        ? "bg-gradient-to-tr"
        : "bg-gradient-to-r";

  const gradientPair = pickGradient(id);

  return (
    <motion.div
      initial={{ opacity: 0, x: -1000, scale: 0.95 }}
      animate={{ opacity: 1, x: 0, scale: 1 }}
      transition={{ duration: handleDuration(id) }}
      className={[
        "w-[300px]",
        "rounded-2xl",
        "border border-white/10",
        "text-white",
        "px-5 py-4",
        "shadow-lg shadow-black/20",
        "hover:shadow-xl hover:shadow-black/30",
        "hover:-translate-y-1 hover:scale-[1.02]",
        "transition-all duration-300 cursor-pointer",
        gradientDirection,
        gradientPair,
      ].join(" ")}
    >
      <div className="flex flex-col gap-3">
        <div className="flex justify-center text-sm font-medium tracking-wide uppercase text-white/90">
          {format}
        </div>

        <div className="flex justify-around items-center text-lg font-semibold">
          <span className="drop-shadow-sm">{team1.name}</span>
          <span className="text-white/90">vs</span>
          <span className="drop-shadow-sm">{team2.name}</span>
        </div>

        <div className="flex flex-col items-center justify-center gap-1">
          <span className="text-xs flex items-center gap-1 text-white/90">
            <span>{venue},</span>
            {country}
          </span>
          <div className="flex items-center gap-2">
            <span className="text-sm font-medium drop-shadow-sm">
              {dayjs(`${date} ${time}`).format("MMM DD, YYYY h:mm A")}
            </span>
          </div>
        </div>
      </div>
    </motion.div>
  );
}
