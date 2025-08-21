import { cleanEnv, port, str } from "envalid";

export default cleanEnv(process.env, {
  PORT: port(),
  DATABASE_URL: str(),
  CLIENT_URL: str(),
});
