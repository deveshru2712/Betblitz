"use client";

import { Button } from "components/ui/button";
import Image from "next/image";
import Link from "next/link";
import { MenuIcon, X } from "lucide-react";
import { useState } from "react";

export default function Navbar() {
  const [isClicked, setIsClicked] = useState(false);

  const handleClick = () => {
    setIsClicked((prev) => !prev);
  };

  const closeMenu = () => {
    setIsClicked(false);
  };

  return (
    <div
      className={`w-full ${isClicked ? "bg-black" : "bg-transparent"} backdrop-blur-md fixed z-50 px-4 sm:px-8 py-6`}
    >
      <nav className="max-w-6xl mx-auto text-neutral-200 flex justify-between items-center">
        <Link
          href={"/"}
          className="flex gap-2 items-center"
          onClick={closeMenu}
        >
          <Image src={"/logo.png"} alt="BetBlitz" height={28} width={28} />
          <h2 className="text-xl font-bold">BetBlitze</h2>
        </Link>

        <div className="hidden items-center justify-between space-x-10 font-medium md:flex">
          <ul className="flex items-center space-x-6">
            <li>
              <Link
                href={"/markets"}
                className="hover:text-sec text-neutral-200 transition-colors duration-300 cursor-pointer"
              >
                Markets
              </Link>
            </li>

            <li>
              <Link
                href={"/features"}
                className="hover:text-sec text-neutral-200 transition-colors duration-300 cursor-pointer"
              >
                Features
              </Link>
            </li>

            <li>
              <Link
                href={"/reviews"}
                className="hover:text-sec text-neutral-200 transition-colors duration-300 cursor-pointer"
              >
                Reviews
              </Link>
            </li>

            <li>
              <Link
                href={"/leaderboard"}
                className="hover:text-sec text-neutral-200 transition-colors duration-300 cursor-pointer"
              >
                Leaderboard
              </Link>
            </li>
          </ul>

          <Button className="bg-main hover:bg-main/90 font-medium transition-colors duration-300 cursor-pointer">
            Login
          </Button>
        </div>

        {/* Mobile menu button*/}
        <button
          className="block md:hidden text-white hover:text-sec transition-all duration-300 p-2 bg-black/20 rounded-md backdrop-blur-sm border border-white/20 hover:bg-black/40"
          onClick={handleClick}
          aria-label="Toggle menu"
        >
          {isClicked ? <X size={24} /> : <MenuIcon size={24} />}
        </button>
      </nav>

      {/* Mobile menu */}
      {isClicked && (
        <div className="fixed z-50 top-[88px] left-0 right-0 bg-black md:hidden min-h-[300px] shadow-2xl">
          <div className="px-4 py-8 max-w-6xl mx-auto">
            <ul className="flex flex-col space-y-3 mb-4">
              <li>
                <Link
                  href={"/markets"}
                  className="active:text-sec text-white transition-colors duration-300 cursor-pointer text-lg block py-3 px-2 hover:bg-neutral-900 rounded-md"
                  onClick={closeMenu}
                >
                  Markets
                </Link>
              </li>

              <li>
                <Link
                  href={"/features"}
                  className="active:text-sec text-white transition-colors duration-300 cursor-pointer text-lg block py-3 px-2 hover:bg-neutral-900 rounded-md"
                  onClick={closeMenu}
                >
                  Features
                </Link>
              </li>

              <li>
                <Link
                  href={"/reviews"}
                  className="active:text-sec text-white transition-colors duration-300 cursor-pointer text-lg block py-3 px-2 hover:bg-neutral-900 rounded-md"
                  onClick={closeMenu}
                >
                  Reviews
                </Link>
              </li>

              <li>
                <Link
                  href={"/leaderboard"}
                  className="active:text-sec text-white transition-colors duration-300 cursor-pointer text-lg block py-3 px-2 hover:bg-neutral-900 rounded-md"
                  onClick={closeMenu}
                >
                  Leaderboard
                </Link>
              </li>
            </ul>

            <Button
              className="bg-main hover:bg-main/90 font-medium transition-colors duration-300 cursor-pointer w-full py-3 text-lg"
              onClick={closeMenu}
            >
              Login
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
