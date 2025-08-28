"use client";

import { CartesianGrid, Line, LineChart, XAxis } from "recharts";

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart";
import { Badge } from "@/components/ui/badge";
import { TrendingDown } from "lucide-react";

const chartData = [
  { over: "5", desktop: 186, mobile: 87 },
  { over: "8", desktop: 305, mobile: 163 },
  { over: "13", desktop: 237, mobile: 142 },
  { over: "17", desktop: 73, mobile: 195 },
  { over: "20", desktop: 209, mobile: 118 },
  // { over: "June", desktop: 214, mobile: 231 },
];

const chartConfig = {
  desktop: {
    label: "TeamA",
    color: "var(--chart-2)",
  },
  mobile: {
    label: "TeamB",
    color: "var(--chart-5)",
  },
} satisfies ChartConfig;

export function DottedMultiLineChart() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>
          Multi Line Chart
          <Badge
            variant="outline"
            className="text-red-500 bg-red-500/10 border-none ml-2"
          >
            <TrendingDown className="h-4 w-4" />
            <span>-5.2%</span>
          </Badge>
        </CardTitle>
        <CardDescription>January - June 2024</CardDescription>
      </CardHeader>
      <CardContent>
        <ChartContainer config={chartConfig}>
          <LineChart
            accessibilityLayer
            data={chartData}
            margin={{
              left: 12,
              right: 12,
            }}
          >
            <CartesianGrid vertical={false} />
            <XAxis
              dataKey="over"
              tickLine={false}
              axisLine={false}
              tickMargin={8}
              tickFormatter={(value) => value.slice(0, 3)}
            />
            <ChartTooltip
              cursor={false}
              content={<ChartTooltipContent hideLabel />}
            />
            <Line
              dataKey="desktop"
              type="linear"
              stroke="var(--color-desktop)"
              dot={false}
              strokeDasharray="4 4"
            />
            <Line dataKey="mobile" type="linear" stroke="var(--color-mobile)" />
          </LineChart>
        </ChartContainer>
      </CardContent>
    </Card>
  );
}
