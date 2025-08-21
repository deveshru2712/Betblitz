import "dotenv/config";
import express, { NextFunction, Request, Response } from "express";
import env from "./utils/validateEnv";
import { z } from "zod";
import cors from "cors";
import createHttpError, { isHttpError } from "http-errors";
import morgan from "morgan";

const app = express();

app.use(morgan("dev"));
app.use(
  cors({
    origin: env.CLIENT_URL,
    credentials: true,
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);
app.use(express.json());

app.get("/", (req, res) => {
  res.send("hii there");
});

app.use((req, res, next) => {
  next(createHttpError(404, "Page not found"));
});

app.use((error: unknown, req: Request, res: Response, next: NextFunction) => {
  let errorMessage = "Something went wrong";
  let statusCode = 500;

  // handling zod errors
  if (error instanceof z.ZodError) {
    const errors = z.prettifyError(error);

    console.log(errors);

    res
      .status(400)
      .json({ success: false, message: "Validation error", errors });
    return;
  }

  // handling http errors
  if (isHttpError(error)) {
    if ("status" in error && typeof error.status === "number") {
      statusCode = error.status;
    }
    errorMessage = error.message;
    console.log(error);
  }

  res.status(statusCode).json({
    success: false,
    message: errorMessage,
  });
  return;
});

app.listen(env.PORT, async () => {
  console.log("Server is running on the port:", env.PORT);
});
