-- Enable TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Create schema for API access
CREATE SCHEMA IF NOT EXISTS api;

-- Create the iotawatt table
CREATE TABLE api.iotawatt (
  timestamp TIMESTAMPTZ NOT NULL,
  device TEXT NOT NULL,
  sensor TEXT NOT NULL,
  power DOUBLE PRECISION,
  pf DOUBLE PRECISION,
  current DOUBLE PRECISION,
  v DOUBLE PRECISION
);

-- Create Timescale hypertable
SELECT create_hypertable('api.iotawatt', 'timestamp', if_not_exists => TRUE);

-- Anonymous role (optional for GET)
CREATE ROLE web_anon NOLOGIN;
GRANT USAGE ON SCHEMA api TO web_anon;
GRANT SELECT ON api.iotawatt TO web_anon;
GRANT INSERT, UPDATE, DELETE ON api.iotawatt TO web_anon;

-- Create authenticated user role
CREATE ROLE api_user NOLOGIN;
GRANT api_user TO ben;

-- Grant access to iotawatt table
GRANT USAGE ON SCHEMA api TO api_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON api.iotawatt TO api_user;