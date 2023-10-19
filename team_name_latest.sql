--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-1.pgdg18.04+1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: latest_team_name; Type: TABLE; Schema: public; Owner: thurston323
--

CREATE TABLE public.latest_team_name (
    fullname text,
    t_abbr text
);


ALTER TABLE public.latest_team_name OWNER TO thurston323;

--
-- Data for Name: latest_team_name; Type: TABLE DATA; Schema: public; Owner: thurston323
--

INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Atlanta Hawks', 'ATL');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Brooklyn Nets', 'BRK');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Boston Celtics', 'BOS');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Charlotte Hornets', 'CHO');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Chicago Bulls', 'CHI');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Cleveland Cavaliers', 'CLE');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Dallas Mavericks', 'DAL');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Denver Nuggets', 'DEN');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Detroit Pistons', 'DET');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Golden State Warriors', 'GSW');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Houston Rockets', 'HOU');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Indiana Pacers', 'IND');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Los Angeles Clippers', 'LAC');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Los Angeles Lakers', 'LAL');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Memphis Grizzlies', 'MEM');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Miami Heat', 'MIA');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Milwaukee Bucks', 'MIL');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Minnesota Timberwolves', 'MIN');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('New Orleans Pelicans', 'NOP');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('New York Knicks', 'NYK');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Oklahoma City Thunder', 'OKC');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Orlando Magic', 'ORL');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Philadelphia 76ers', 'PHI');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Phoenix Suns', 'PHO');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Portland Trail Blazers', 'POR');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Sacramento Kings', 'SAC');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('San Antonio Spurs', 'SAS');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Toronto Raptors', 'TOR');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Utah Jazz', 'UTA');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Washington Wizards', 'WAS');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Brooklyn Nets', 'NJN');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Charlotte Hornets', 'CHH');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Charlotte Hornets', 'CHA');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('New Orleans Pelicans', 'NOK');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('New Orleans Pelicans', 'NOH');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Memphis Grizzlies', 'VAN');
INSERT INTO public.latest_team_name (fullname, t_abbr) VALUES ('Oklahoma City Thunder', 'SEA');


--
-- PostgreSQL database dump complete
--

