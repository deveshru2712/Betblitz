-- CreateEnum
CREATE TYPE "public"."KycStatus" AS ENUM ('PENDING', 'VERIFIED', 'REJECTED');

-- CreateEnum
CREATE TYPE "public"."SeriesType" AS ENUM ('TEST', 'ODI', 'T20I', 'IPL', 'OTHER');

-- CreateEnum
CREATE TYPE "public"."MatchFormat" AS ENUM ('TEST', 'ODI', 'T20', 'T10');

-- CreateEnum
CREATE TYPE "public"."MatchStatus" AS ENUM ('SCHEDULED', 'LIVE', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "public"."ResultType" AS ENUM ('NORMAL', 'TIE', 'NO_RESULT');

-- CreateEnum
CREATE TYPE "public"."TossDecision" AS ENUM ('BAT', 'BOWL');

-- CreateEnum
CREATE TYPE "public"."MarketCategory" AS ENUM ('MATCH_RESULT');

-- CreateEnum
CREATE TYPE "public"."OutcomeType" AS ENUM ('TEAM_WIN');

-- CreateEnum
CREATE TYPE "public"."TradeType" AS ENUM ('BACK', 'LAY');

-- CreateEnum
CREATE TYPE "public"."TradeStatus" AS ENUM ('PENDING', 'MATCHED', 'PARTIALLY_MATCHED', 'CANCELLED', 'SETTLED');

-- CreateEnum
CREATE TYPE "public"."TransactionType" AS ENUM ('DEPOSIT', 'WITHDRAWAL', 'REFUND', 'TRADE_SETTLEMENT');

-- CreateEnum
CREATE TYPE "public"."TransactionStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "public"."PlayerType" AS ENUM ('BATSMAN', 'BOWLER', 'ALLROUNDER', 'WICKETKEEPER');

-- CreateTable
CREATE TABLE "public"."user" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL,
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."session" (
    "id" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "userId" TEXT NOT NULL,

    CONSTRAINT "session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."account" (
    "id" TEXT NOT NULL,
    "accountId" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "accessToken" TEXT,
    "refreshToken" TEXT,
    "idToken" TEXT,
    "accessTokenExpiresAt" TIMESTAMP(3),
    "refreshTokenExpiresAt" TIMESTAMP(3),
    "scope" TEXT,
    "password" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."verification" (
    "id" TEXT NOT NULL,
    "identifier" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3),
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "verification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_profiles" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "full_name" VARCHAR(100),
    "phone_number" VARCHAR(20),
    "wallet_balance" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "kyc_status" "public"."KycStatus" NOT NULL DEFAULT 'PENDING',
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."teams" (
    "id" TEXT NOT NULL,
    "team_name" VARCHAR(100) NOT NULL,
    "country" VARCHAR(50),
    "team_logo_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."series" (
    "id" TEXT NOT NULL,
    "series_name" VARCHAR(200) NOT NULL,
    "series_type" "public"."SeriesType" NOT NULL,
    "start_date" DATE,
    "end_date" DATE,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "series_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."matches" (
    "id" TEXT NOT NULL,
    "series_id" TEXT,
    "team_a_id" TEXT NOT NULL,
    "team_b_id" TEXT NOT NULL,
    "match_format" "public"."MatchFormat" NOT NULL,
    "match_date" TIMESTAMP(3) NOT NULL,
    "venue" VARCHAR(200),
    "match_status" "public"."MatchStatus" NOT NULL DEFAULT 'SCHEDULED',
    "winner_team_id" TEXT,
    "result_type" "public"."ResultType",
    "toss_winner_id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "matches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."market_types" (
    "id" TEXT NOT NULL,
    "market_name" VARCHAR(100) NOT NULL,
    "market_category" "public"."MarketCategory" NOT NULL DEFAULT 'MATCH_RESULT',
    "description" TEXT DEFAULT 'Bet on which team will win the match',
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "market_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."markets" (
    "id" TEXT NOT NULL,
    "match_id" TEXT NOT NULL,
    "market_type_id" TEXT NOT NULL,
    "market_title" VARCHAR(200) NOT NULL,
    "market_description" TEXT,
    "is_suspended" BOOLEAN NOT NULL DEFAULT false,
    "settlement_time" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "markets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."market_outcomes" (
    "id" TEXT NOT NULL,
    "market_id" TEXT NOT NULL,
    "outcome_name" VARCHAR(200) NOT NULL,
    "outcome_type" "public"."OutcomeType" NOT NULL DEFAULT 'TEAM_WIN',
    "team_id" TEXT NOT NULL,
    "is_winner" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "market_outcomes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."odds" (
    "id" TEXT NOT NULL,
    "outcome_id" TEXT NOT NULL,
    "back_price" DECIMAL(6,2) NOT NULL,
    "lay_price" DECIMAL(6,2) NOT NULL,
    "back_volume" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "lay_volume" DECIMAL(12,2) NOT NULL DEFAULT 0,
    "last_traded_price" DECIMAL(6,2),
    "total_matched" DECIMAL(15,2) NOT NULL DEFAULT 0,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "odds_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."trades" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "outcome_id" TEXT NOT NULL,
    "trade_type" "public"."TradeType" NOT NULL,
    "stake_amount" DECIMAL(10,2) NOT NULL,
    "odds" DECIMAL(6,2) NOT NULL,
    "potential_profit" DECIMAL(10,2) NOT NULL,
    "potential_loss" DECIMAL(10,2) NOT NULL,
    "trade_status" "public"."TradeStatus" NOT NULL DEFAULT 'PENDING',
    "matched_amount" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "profit_loss" DECIMAL(10,2),
    "placed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "matched_at" TIMESTAMP(3),
    "settled_at" TIMESTAMP(3),

    CONSTRAINT "trades_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."wallet_transactions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "transaction_type" "public"."TransactionType" NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "balance_before" DECIMAL(10,2) NOT NULL,
    "balance_after" DECIMAL(10,2) NOT NULL,
    "reference_id" TEXT,
    "description" TEXT,
    "status" "public"."TransactionStatus" NOT NULL DEFAULT 'COMPLETED',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wallet_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_positions" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "market_id" TEXT NOT NULL,
    "outcome_id" TEXT NOT NULL,
    "total_back_stake" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "total_lay_stake" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "average_back_odds" DECIMAL(6,2),
    "average_lay_odds" DECIMAL(6,2),
    "potential_profit" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "potential_loss" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "current_pnl" DECIMAL(10,2) NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_positions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."players" (
    "id" TEXT NOT NULL,
    "player_name" VARCHAR(100) NOT NULL,
    "team_id" TEXT,
    "player_type" "public"."PlayerType" NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."match_stats" (
    "id" TEXT NOT NULL,
    "match_id" TEXT NOT NULL,
    "team_id" TEXT NOT NULL,
    "runs_scored" INTEGER NOT NULL DEFAULT 0,
    "wickets_lost" INTEGER NOT NULL DEFAULT 0,
    "overs_played" DECIMAL(4,1) NOT NULL DEFAULT 0,
    "extras" INTEGER NOT NULL DEFAULT 0,
    "innings_number" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "match_stats_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "public"."user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "session_token_key" ON "public"."session"("token");

-- CreateIndex
CREATE UNIQUE INDEX "user_profiles_user_id_key" ON "public"."user_profiles"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "user_positions_user_id_outcome_id_key" ON "public"."user_positions"("user_id", "outcome_id");

-- AddForeignKey
ALTER TABLE "public"."session" ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."account" ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_profiles" ADD CONSTRAINT "user_profiles_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."matches" ADD CONSTRAINT "matches_series_id_fkey" FOREIGN KEY ("series_id") REFERENCES "public"."series"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."matches" ADD CONSTRAINT "matches_team_a_id_fkey" FOREIGN KEY ("team_a_id") REFERENCES "public"."teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."matches" ADD CONSTRAINT "matches_team_b_id_fkey" FOREIGN KEY ("team_b_id") REFERENCES "public"."teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."matches" ADD CONSTRAINT "matches_winner_team_id_fkey" FOREIGN KEY ("winner_team_id") REFERENCES "public"."teams"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."matches" ADD CONSTRAINT "matches_toss_winner_id_fkey" FOREIGN KEY ("toss_winner_id") REFERENCES "public"."teams"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."markets" ADD CONSTRAINT "markets_match_id_fkey" FOREIGN KEY ("match_id") REFERENCES "public"."matches"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."markets" ADD CONSTRAINT "markets_market_type_id_fkey" FOREIGN KEY ("market_type_id") REFERENCES "public"."market_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."market_outcomes" ADD CONSTRAINT "market_outcomes_market_id_fkey" FOREIGN KEY ("market_id") REFERENCES "public"."markets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."market_outcomes" ADD CONSTRAINT "market_outcomes_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."odds" ADD CONSTRAINT "odds_outcome_id_fkey" FOREIGN KEY ("outcome_id") REFERENCES "public"."market_outcomes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."trades" ADD CONSTRAINT "trades_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."trades" ADD CONSTRAINT "trades_outcome_id_fkey" FOREIGN KEY ("outcome_id") REFERENCES "public"."market_outcomes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."wallet_transactions" ADD CONSTRAINT "wallet_transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_positions" ADD CONSTRAINT "user_positions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_positions" ADD CONSTRAINT "user_positions_market_id_fkey" FOREIGN KEY ("market_id") REFERENCES "public"."markets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_positions" ADD CONSTRAINT "user_positions_outcome_id_fkey" FOREIGN KEY ("outcome_id") REFERENCES "public"."market_outcomes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."players" ADD CONSTRAINT "players_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_stats" ADD CONSTRAINT "match_stats_match_id_fkey" FOREIGN KEY ("match_id") REFERENCES "public"."matches"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."match_stats" ADD CONSTRAINT "match_stats_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
