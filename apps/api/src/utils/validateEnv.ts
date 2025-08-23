import { cleanEnv, port, str } from "envalid";

export default cleanEnv(process.env, {
  PORT: port(),
  DATABASE_URL: str(),
  GOOGLE_CLIENT_ID: str(),
  GOOGLE_CLIENT_SECRET: str(),
  BETTER_AUTH_SECRET: str(),
  BETTER_AUTH_URL: str(),
});
