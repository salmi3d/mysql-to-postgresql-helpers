--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.1
-- Dumped by pg_dump version 9.2.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: helpers; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA helpers;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: exec(text); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.exec(text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
begin
execute $1;
end;
$_$;


--
-- Name: field(bigint, bigint[]); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.field(bigint, VARIADIC bigint[]) RETURNS bigint
    LANGUAGE sql STRICT
    AS $_$
 SELECT n FROM (
    SELECT row_number() OVER () AS n, x FROM unnest($2) x
) numbered WHERE numbered.x = $1;
$_$;


--
-- Name: from_days(integer); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.from_days(integer) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
select '0001-01-01'::timestamp + ($1 || ' days')::interval as result
$_$;


--
-- Name: from_unixtime(integer); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.from_unixtime(integer) RETURNS timestamp without time zone
    LANGUAGE sql
    AS $_$
SELECT
$1::abstime::timestamp without time zone AS result
$_$;


--
-- Name: ifnull(integer, integer); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.ifnull(integer, integer) RETURNS integer
    LANGUAGE sql
    AS $_$
select coalesce($1, $2) as result
$_$;


--
-- Name: ifnull(bigint, bigint); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.ifnull(bigint, bigint) RETURNS bigint
    LANGUAGE sql
    AS $_$
select coalesce($1, $2) as result
$_$;


--
-- Name: ifnull(text, text); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.ifnull(text, text) RETURNS text
    LANGUAGE sql
    AS $_$
select coalesce($1, $2) as result
$_$;


--
-- Name: to_days(timestamp without time zone); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.to_days(timestamp without time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
  select date_part('day', $1 - '0001-01-01')::int4 as result
$_$;


--
-- Name: unix_timestamp(); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.unix_timestamp() RETURNS integer
    LANGUAGE sql
    AS $$
SELECT
ROUND(EXTRACT( EPOCH FROM abstime(now()) ))::int4 AS result;
$$;


--
-- Name: unix_timestamp(timestamp with time zone); Type: FUNCTION; Schema: helpers; Owner: -
--

CREATE FUNCTION helpers.unix_timestamp(timestamp with time zone) RETURNS integer
    LANGUAGE sql
    AS $_$
SELECT
  ROUND(EXTRACT( EPOCH FROM ABSTIME($1) ))::int4 AS result;
$_$;


--
-- PostgreSQL database dump complete
--
