import Cards from "@/components/home/Features/Cards";
import { cricketMatches } from "@/constant";

export default function Page() {
  return (
    <div className="w-full h-screen">
      <div className="h-full">
        <div className="max-w-6xl mx-auto py-20">
          <div className="flex items-center flex-col gap-10">
            {cricketMatches?.length > 0 &&
              cricketMatches.map((match) => (
                <Cards key={match.id} {...match} />
              ))}
          </div>
        </div>
      </div>
    </div>
  );
}
