import { createAuthClient } from "better-auth/react";
export const authClient = createAuthClient({
  baseURL: "http://localhost:5050",
});

export const { useSession } = createAuthClient();

export const signIn = async (): Promise<void> => {
  await authClient.signIn.social({
    provider: "google",
    callbackURL: "/profile",
    newUserCallbackURL: "/",
  });
};

export const signOut = async (): Promise<void> => {
  try {
    await authClient.signOut({
      fetchOptions: {
        onSuccess: () => {
          if (typeof window !== "undefined") {
            window.location.href = "/";
          }
        },
      },
    });
  } catch (error) {
    console.log("Sign out failed", error);
    if (typeof window !== "undefined") {
      window.location.href = "/";
    }
  }
};
