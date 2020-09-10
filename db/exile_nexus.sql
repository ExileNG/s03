--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

--
-- Name: exile_nexus; Type: SCHEMA; Schema: -; Owner: exileng
--

CREATE SCHEMA exile_nexus;


ALTER SCHEMA exile_nexus OWNER TO exileng;

--
-- Name: sch_cleanup(); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sch_cleanup() RETURNS void
    LANGUAGE sql
    AS $$delete from log_logins where datetime < now()-interval '2 month';$$;


ALTER FUNCTION exile_nexus.sch_cleanup() OWNER TO exileng;

--
-- Name: sp_account_create(character varying, character varying, character varying, integer, inet); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_create(_username character varying, _password character varying, _email character varying, _lcid integer, _registration_ip inet) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- create a new user

--  param1: name

--  param2: password

--  param3: email

--  param4: lcid

--  param5: registration address

DECLARE

	userid int4;

BEGIN

	userid := nextval('users_id_seq');

	-- try to insert a new user

	BEGIN

		INSERT INTO users(id, username, password, email, lcid, registration_ip)

		VALUES(userid, $1, sp_account_hashpassword($2), $3, $4, $5);

		RETURN userid;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN NULL;

	END;

	-- check if the error comes from a duplicated login

	PERFORM 1 FROM users WHERE lower(username)=lower($1) LIMIT 1;

	IF FOUND THEN

		RETURN -1;

	END IF;

	-- check if the error comes from a duplicated email

	PERFORM 1 FROM users WHERE lower(email)=lower($3) LIMIT 1;

	IF FOUND THEN

		RETURN -2;

	END IF;

	-- check if the error comes from a duplicated registration address

	PERFORM 1 FROM users WHERE registration_ip=$5 LIMIT 1;

	IF FOUND THEN

		RETURN -3;

	END IF;

	RETURN -4;

END;$_$;


ALTER FUNCTION exile_nexus.sp_account_create(_username character varying, _password character varying, _email character varying, _lcid integer, _registration_ip inet) OWNER TO exileng;

--
-- Name: sp_account_email_change(integer, character varying, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_email_change(_userid integer, _password character varying, _email character varying) RETURNS SETOF character varying
    LANGUAGE plpgsql
    AS $$DECLARE

	key character varying;

BEGIN

	SELECT INTO key MD5(password || _email) FROM users WHERE id=_userid AND password=sp_account_hashpassword(_password);

	IF FOUND THEN

		RETURN NEXT key;

	END IF;

	RETURN;

END;$$;


ALTER FUNCTION exile_nexus.sp_account_email_change(_userid integer, _password character varying, _email character varying) OWNER TO exileng;

--
-- Name: sp_account_email_validate(integer, character varying, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_email_validate(_userid integer, _email character varying, _key character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET email=_email WHERE id=_userid AND MD5(password || _email) = _key;

	RETURN FOUND;

END;$$;


ALTER FUNCTION exile_nexus.sp_account_email_validate(_userid integer, _email character varying, _key character varying) OWNER TO exileng;

--
-- Name: sp_account_hashpassword(character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_hashpassword(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$SELECT MD5('seed' || MD5($1));$_$;


ALTER FUNCTION exile_nexus.sp_account_hashpassword(character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_account_hashpassword(character varying); Type: COMMENT; Schema: exile_nexus; Owner: exileng
--

COMMENT ON FUNCTION exile_nexus.sp_account_hashpassword(character varying) IS 'Return the password hash for the given parameter';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.users (
    id integer NOT NULL,
    username character varying(16) DEFAULT ''::character varying NOT NULL,
    password character varying(40) DEFAULT ''::character varying NOT NULL,
    email character varying(50) DEFAULT ''::character varying NOT NULL,
    lcid integer DEFAULT 1036 NOT NULL,
    registered timestamp without time zone DEFAULT now() NOT NULL,
    registration_ip inet DEFAULT '0.0.0.0'::inet NOT NULL,
    last_visit timestamp without time zone DEFAULT now() NOT NULL,
    last_universeid integer,
    privilege_see_hidden_universes boolean DEFAULT false NOT NULL,
    ad_code character varying,
    ad_last_display timestamp with time zone DEFAULT now() NOT NULL,
    cheat_detected timestamp with time zone,
    mail_sent boolean DEFAULT true NOT NULL
);


ALTER TABLE exile_nexus.users OWNER TO exileng;

--
-- Name: sp_account_login(character varying, character varying, inet, character varying, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_login(_username character varying, _password character varying, _address inet, _address_forward character varying, _browser character varying) RETURNS SETOF exile_nexus.users
    LANGUAGE plpgsql
    AS $_$-- sp_account_login

-- login a user with his username/password, return user row

-- param1: username

-- param2: password

-- param3: remote address

-- param4: forwarded address

-- param5: browser

DECLARE

	r_user exile_nexus.users;

	_success boolean;

	--t timestamp;

	--other_userid int4;

	--connection_id int8;

BEGIN

	SELECT INTO r_user *

	FROM users

	WHERE lower(username)=lower(_username) LIMIT 1;

	_success := false;

	-- return user row if user was found

	IF FOUND AND (r_user.password=sp_account_hashpassword(_password)) THEN

		_success := true;

		r_user.password := '';

		--t := now();

		-- update lastlogin column

		UPDATE users SET last_visit=now() WHERE id=r_user.id;

		-- update registration_ip if none is set (old accounts)

		IF r_user.registration_ip = inet '0.0.0.0' THEN

			UPDATE users SET registration_ip = _address WHERE id=r_user.id;

		END IF;

/*

		UPDATE users_connections SET

			disconnected = LEAST(t, r_user.lastactivity+INTERVAL '1 minutes')

		WHERE userid=r_user.id AND disconnected IS NULL;

*/

/*

		connection_id := nextval('public.users_connections_id_seq');

		-- save clients address/brower info

		INSERT INTO users_connections(id, userid, address, forwarded_address, browser, browserid)

		VALUES(connection_id, r_user.id, sp__atoi($3), substr($4, 1, 64), substr($5, 1, 128), $6);

		-- add multiaccount warnings

		IF r_user.privilege = 0 THEN

			INSERT INTO log_multi_account_warnings(id, withid)

			SELECT DISTINCT ON (userid) connection_id, id FROM users_connections WHERE datetime > now()-INTERVAL '30 minutes' AND address=sp__atoi($3) AND userid <> r_user.id;

		END IF;

*/

		RETURN NEXT r_user;

	END IF;

	-- log the login attempt

	INSERT INTO log_logins(username, userid, address, forwarded_address, browser, success)

	VALUES(_username, r_user.id, _address, substr(_address_forward, 1, 64), substr(_browser, 1, 128), _success);

	RETURN;

END;$_$;


ALTER FUNCTION exile_nexus.sp_account_login(_username character varying, _password character varying, _address inet, _address_forward character varying, _browser character varying) OWNER TO exileng;

--
-- Name: sp_account_password_change(integer, character varying, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_password_change(_userid integer, _oldpassword character varying, _newpassword character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET password=sp_account_hashpassword(_newpassword) WHERE id=_userid AND password=sp_account_hashpassword(_oldpassword);

	RETURN FOUND;

END;$$;


ALTER FUNCTION exile_nexus.sp_account_password_change(_userid integer, _oldpassword character varying, _newpassword character varying) OWNER TO exileng;

--
-- Name: sp_account_password_set(integer, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_password_set(_userid integer, _newpassword character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET password=sp_account_hashpassword(_newpassword) WHERE id=_userid;

	RETURN FOUND;

END;$$;


ALTER FUNCTION exile_nexus.sp_account_password_set(_userid integer, _newpassword character varying) OWNER TO exileng;

--
-- Name: sp_account_universes_set(integer, integer); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_account_universes_set(_userid integer, _universeid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET last_universeid=_universeid WHERE id=_userid;

	RETURN FOUND;

END;$$;


ALTER FUNCTION exile_nexus.sp_account_universes_set(_userid integer, _universeid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_account_universes_set(_userid integer, _universeid integer); Type: COMMENT; Schema: exile_nexus; Owner: exileng
--

COMMENT ON FUNCTION exile_nexus.sp_account_universes_set(_userid integer, _universeid integer) IS 'Set the last universe used by the user';


--
-- Name: sp_ad_displayed(integer, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_ad_displayed(_user_id integer, _code character varying) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE exile_nexus.users SET ad_code=null, ad_last_display=now() + INTERVAL '2 hours' WHERE id=$1 AND ad_code=$2;$_$;


ALTER FUNCTION exile_nexus.sp_ad_displayed(_user_id integer, _code character varying) OWNER TO exileng;

--
-- Name: sp_ad_get_code(integer); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_ad_get_code(_user_id integer) RETURNS character varying
    LANGUAGE sql
    AS $_$UPDATE exile_nexus.users SET ad_code=MD5('random' || $1 || random()*10000) WHERE id=$1 AND ad_code IS NULL AND ad_last_display < now();

SELECT ad_code FROM exile_nexus.users WHERE id=$1;$_$;


ALTER FUNCTION exile_nexus.sp_ad_get_code(_user_id integer) OWNER TO exileng;

--
-- Name: sp_cleanup(); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_cleanup() RETURNS void
    LANGUAGE sql
    AS $$DELETE FROM exile_nexus.log_logins WHERE datetime < now() - interval '2 months';$$;


ALTER FUNCTION exile_nexus.sp_cleanup() OWNER TO exileng;

--
-- Name: sp_fix_accents(); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_fix_accents() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	update db_buildings SET

		label = replace(replace(replace(replace(replace(replace(label, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô'),

		description = replace(replace(replace(replace(replace(replace(description, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô');

	update db_research SET

		label = replace(replace(replace(replace(replace(replace(label, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô'),

		description = replace(replace(replace(replace(replace(replace(description, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô');

	update db_ships SET

		label = replace(replace(replace(replace(replace(replace(label, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô'),

		description = replace(replace(replace(replace(replace(replace(description, 'Ã ', 'à'), 'Ã©', 'é'), 'Ã¨', 'è'), 'Ãª', 'ê'), 'Ã¢', 'â'), 'Ã´', 'ô');

END;$$;


ALTER FUNCTION exile_nexus.sp_fix_accents() OWNER TO exileng;

--
-- Name: sp_job_update(character varying, integer, character varying); Type: FUNCTION; Schema: exile_nexus; Owner: exileng
--

CREATE FUNCTION exile_nexus.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

END;$$;


ALTER FUNCTION exile_nexus.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) OWNER TO exileng;

--
-- Name: awards; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.awards (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE exile_nexus.awards OWNER TO exileng;

--
-- Name: awards_id_seq; Type: SEQUENCE; Schema: exile_nexus; Owner: exileng
--

CREATE SEQUENCE exile_nexus.awards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_nexus.awards_id_seq OWNER TO exileng;

--
-- Name: awards_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_nexus; Owner: exileng
--

ALTER SEQUENCE exile_nexus.awards_id_seq OWNED BY exile_nexus.awards.id;


--
-- Name: banned_domains; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.banned_domains (
    domain character varying(64) NOT NULL
);


ALTER TABLE exile_nexus.banned_domains OWNER TO exileng;

--
-- Name: TABLE banned_domains; Type: COMMENT; Schema: exile_nexus; Owner: exileng
--

COMMENT ON TABLE exile_nexus.banned_domains IS 'List of banned mail domains';


--
-- Name: log_logins; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.log_logins (
    id bigint NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    username character varying,
    userid integer,
    address inet,
    forwarded_address character varying,
    browser character varying(128),
    success boolean NOT NULL
);


ALTER TABLE exile_nexus.log_logins OWNER TO exileng;

--
-- Name: log_logins_id_seq; Type: SEQUENCE; Schema: exile_nexus; Owner: exileng
--

CREATE SEQUENCE exile_nexus.log_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_nexus.log_logins_id_seq OWNER TO exileng;

--
-- Name: log_logins_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_nexus; Owner: exileng
--

ALTER SEQUENCE exile_nexus.log_logins_id_seq OWNED BY exile_nexus.log_logins.id;


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: exile_nexus; Owner: exileng
--

CREATE SEQUENCE exile_nexus.news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_nexus.news_id_seq OWNER TO exileng;

--
-- Name: news; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.news (
    id integer DEFAULT nextval('exile_nexus.news_id_seq'::regclass) NOT NULL,
    url character varying(128) NOT NULL,
    xml text DEFAULT ''::text NOT NULL
);


ALTER TABLE exile_nexus.news OWNER TO exileng;

--
-- Name: universes_id_seq; Type: SEQUENCE; Schema: exile_nexus; Owner: exileng
--

CREATE SEQUENCE exile_nexus.universes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_nexus.universes_id_seq OWNER TO exileng;

--
-- Name: universes; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.universes (
    id integer DEFAULT nextval('exile_nexus.universes_id_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    visible boolean DEFAULT false NOT NULL,
    login_enabled boolean DEFAULT false NOT NULL,
    players_limit integer DEFAULT 0 NOT NULL,
    registration_until timestamp without time zone DEFAULT now(),
    ranking_enabled boolean DEFAULT false NOT NULL,
    created timestamp without time zone DEFAULT now(),
    description text DEFAULT ''::text NOT NULL,
    url character varying DEFAULT ''::character varying NOT NULL,
    start_time timestamp without time zone,
    stop_time timestamp without time zone,
    has_fastconnect boolean DEFAULT true NOT NULL
);


ALTER TABLE exile_nexus.universes OWNER TO exileng;

--
-- Name: COLUMN universes.created; Type: COMMENT; Schema: exile_nexus; Owner: exileng
--

COMMENT ON COLUMN exile_nexus.universes.created IS 'timestamp when server was created';


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: exile_nexus; Owner: exileng
--

CREATE SEQUENCE exile_nexus.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_nexus.users_id_seq OWNER TO exileng;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_nexus; Owner: exileng
--

ALTER SEQUENCE exile_nexus.users_id_seq OWNED BY exile_nexus.users.id;


--
-- Name: users_successes; Type: TABLE; Schema: exile_nexus; Owner: exileng
--

CREATE TABLE exile_nexus.users_successes (
    user_id integer NOT NULL,
    success_id integer NOT NULL,
    universe_id integer NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_nexus.users_successes OWNER TO exileng;

--
-- Name: awards id; Type: DEFAULT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.awards ALTER COLUMN id SET DEFAULT nextval('exile_nexus.awards_id_seq'::regclass);


--
-- Name: log_logins id; Type: DEFAULT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.log_logins ALTER COLUMN id SET DEFAULT nextval('exile_nexus.log_logins_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.users ALTER COLUMN id SET DEFAULT nextval('exile_nexus.users_id_seq'::regclass);


--
-- Data for Name: awards; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--

INSERT INTO exile_nexus.awards VALUES (1, 'pioneer');
INSERT INTO exile_nexus.awards VALUES (2, 'winner');
INSERT INTO exile_nexus.awards VALUES (3, 'richest');


--
-- Data for Name: banned_domains; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--

INSERT INTO exile_nexus.banned_domains VALUES ('@jetable.org$');
INSERT INTO exile_nexus.banned_domains VALUES ('@modmailcom.com$');
INSERT INTO exile_nexus.banned_domains VALUES ('@mailinator.com$');


--
-- Data for Name: log_logins; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--



--
-- Data for Name: news; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--

INSERT INTO exile_nexus.news VALUES (1, 'http://forum.exil.pw/extern.php?action=new&fid=5,4&type=rss', '<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<atom:link href="http://forum.exil.pw/extern.php?action=new&amp;fid=5,4&amp;type=rss" rel="self" type="application/rss+xml" />
		<title><![CDATA[Exile - Forum]]></title>
		<link>http://forum.exil.pw/index.php</link>
		<description><![CDATA[Les sujets les plus récents sur Exile - Forum.]]></description>
		<lastBuildDate>Sat, 02 Apr 2011 08:25:26 +0000</lastBuildDate>
		<generator>FluxBB</generator>
		<item>
			<title><![CDATA[Fermeture définitive du jeu le 15 avril 2011]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9535</link>
			<description><![CDATA[<p>Après plus de 6 ans, l&#039;aventure se termine, Exile prendra fin ce 15 avril 2011.<br />A cette date, les serveurs ne seront plus accessibles.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Sat, 02 Apr 2011 08:25:26 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9535</guid>
		</item>
		<item>
			<title><![CDATA[Maintenance logicielle (03/07/10)]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9277</link>
			<description><![CDATA[<p>Une mise à jour logicielle de Postgresql sera effectuée sur le serveur de base de données samedi 3 juillet à partir de 11h et pour 1h-1h30 environ.</p>]]></description>
			<author><![CDATA[dummy@example.com (Chob)]]></author>
			<pubDate>Thu, 01 Jul 2010 09:45:51 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9277</guid>
		</item>
		<item>
			<title><![CDATA[[s01, s02, s03] Reposez en paix]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8931</link>
			<description><![CDATA[<p>Les serveurs s01, s02, s03 sont à présent fermés, nous vous invitons à continuer l&#039;aventure sur le serveur Genesis.</p><p>Bon jeu à tous.</p>]]></description>
			<author><![CDATA[dummy@example.com (Chob)]]></author>
			<pubDate>Thu, 01 Apr 2010 09:40:39 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8931</guid>
		</item>
		<item>
			<title><![CDATA[Petite maintenance, mise à jour]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8840</link>
			<description><![CDATA[<p>Petite maintenance en cours, mise à jour du serveur sql.</p><p>Ça ne devrait pas prendre plus de 10-15 minutes (si tout va bien).</p>]]></description>
			<author><![CDATA[dummy@example.com (Chob)]]></author>
			<pubDate>Tue, 23 Mar 2010 14:43:10 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8840</guid>
		</item>
		<item>
			<title><![CDATA[Ouverture Génésis]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8823</link>
			<description><![CDATA[<p>Le nouveau serveur Génésis ouvre ses portes pour le week end dès ce vendredi 21H si tout se passe bien.</p><p>Apres le week end un reset sera opéré et si tout est en ordre l&#039;ouverture définitive se fera le lundi 22 mars.</p>]]></description>
			<author><![CDATA[dummy@example.com (El Matador)]]></author>
			<pubDate>Fri, 19 Mar 2010 00:20:49 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8823</guid>
		</item>
		<item>
			<title><![CDATA[Une page se tourne]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8770</link>
			<description><![CDATA[<p>Les serveurs s01, s02 et s03 vont fermer, les nouvelles inscriptions ne sont plus possibles et les fossoyeurs ont commencé leur boulot : annihiler toutes les planètes.</p><p>Un nouveau serveur ouvrira ses portes très bientôt.</p><p>Ce nouveau serveur sera composé de plus de 200 000 planètes colonisables et donnera la possibilité à tout le monde de repartir sur un pied d&#039;égalité.<br />Sur les 100 régions de départ, 4 seront réservées aux nouveaux joueurs avec un maximum de 2 planètes colonisées dans celles-ci.<br />Les limites de planète et commandant passeront respectivement à 100 et 10.<br />Toutes les modifications prévues pour ce serveur sont visibles à cette adresse : <a href="http://forum.exile.fr/viewtopic.php?pid=162512#p162512" rel="nofollow">http://forum.exile.fr/viewtopic.php?pid=162512#p162512</a></p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Sun, 21 Feb 2010 14:04:13 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8770</guid>
		</item>
		<item>
			<title><![CDATA[Maintenance Samedi]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8745</link>
			<description><![CDATA[<p>Une maintenance aura lieu samedi à partir de 14h00 pour une durée indéterminée.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Thu, 11 Feb 2010 20:09:41 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8745</guid>
		</item>
		<item>
			<title><![CDATA[Mise à jour du 23/01/2010]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8685</link>
			<description><![CDATA[<p>Une petite mise à jour a été effectuée, voici les détails :</p><p><strong>PNA</strong><br /> - Les PNAs sont désormais limités à 15, il se peut que ce nombre baisse encore plus tard<br /> - PNA : vision planètes, cette option permet de partager ou non la position de vos planètes avec les autres alliances (vrai par défaut)<br /> - PNA : partage radar, permet de partager vos radars avec les autres alliances</p><p><strong>Grades</strong><br /> - Utiliser les radars de l&#039;alliance : les membres ne possédant pas ce droit ne peuvent pas voir la position de leurs alliés ni voir les déplacements de flottes via les radars de l&#039;alliance et des alliances en PNA partageant leur vue radar (vous me suivez ?)<br /> - Commander les flottes partagées : les joueurs d&#039;une alliance pourront partager leur flottes à leur alliance et les membres ayant le droit de commander les flottes partagées pourront les contrôler : déplacer, changer le mode d&#039;attaque, sauter, envahir, déployer un vaisseau</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Sat, 23 Jan 2010 16:25:37 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8685</guid>
		</item>
		<item>
			<title><![CDATA[Nous avons besoin de vos talents de beta testeurs!]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8342</link>
			<description><![CDATA[<p>Pour tester un nouveau type de jeu - différent d&#039;Exile - nous avons besoin de joueurs pour éprouver le système, trouver des bugs, suggestions etc...</p><p>Vous êtes donc les bienvenus pour le tester à vos risques et périls.</p><p>PS : le serveur peut s&#039;arrêter, avoir des bugs, planter, le jeu peut manquer d&#039;info etc ... c&#039;est normal, c&#039;est une béta, rien de définitif, c&#039;est pour tester le moteur!</p><p>Rendez vous sur : <a href="http://tcg.exile.fr/play/index.aspx" rel="nofollow">http://tcg.exile.fr/play/index.aspx</a></p><p>La suite dans la partie Beta test du forum : <a href="http://forum.exile.fr/viewtopic.php?id=8341" rel="nofollow">http://forum.exile.fr/viewtopic.php?id=8341</a></p>]]></description>
			<author><![CDATA[dummy@example.com (Chob)]]></author>
			<pubDate>Fri, 05 Jun 2009 13:28:51 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8342</guid>
		</item>
		<item>
			<title><![CDATA[Maintenance - Mardi 26/05/2009]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8323</link>
			<description><![CDATA[<p>Une maintenance sera effectuée sur le serveur de base de données demain à partir de 10h pour une durée d&#039;une heure environ.</p>]]></description>
			<author><![CDATA[dummy@example.com (Chob)]]></author>
			<pubDate>Mon, 25 May 2009 21:03:18 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8323</guid>
		</item>
		<item>
			<title><![CDATA[A venir]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8284</link>
			<description><![CDATA[<p>Voici une liste des changements à venir, un petit &quot;FAIT&quot; sera ajouté à la suite de chaque ligne quand le changement aura été fait.</p><p>- Les flottes ayant une capacité de saut suffisante peuvent sauter sans vortex vers une même destination. Un total de 5000 de signature peut sauter vers une même destination. <strong>FAIT</strong></p><p>- Un rapport sera envoyé à l&#039;alliance souveraine d&#039;une galaxie au moment où une flotte arrive par saut.</p><p>- Limitation des vaisseaux posés sur chaque planète :<br />&#160; - Colonie : +10000 de signature posée<br />&#160; - Cité : +15000 de signature posée<br />&#160; - Métropole : +25000 de signature posée</p><p>- Nouveau bâtiment pour entreposer des vaisseaux ajoutant +25000 de signature pour 2 terrains</p><p>- Tous les vaisseaux peuvent de nouveau être posés. <strong>FAIT</strong></p><p>- La signature des vaisseaux au sol est uniquement visible par le propriétaire de la planète</p><p>- La construction des vaisseaux s&#039;arrête si la limite des vaisseaux posés sur la colonie est atteinte.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Sun, 03 May 2009 10:02:36 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8284</guid>
		</item>
		<item>
			<title><![CDATA[Baisse coût de déplacement de flottes et des guerres]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8250</link>
			<description><![CDATA[<p>Le coût des guerres a baissé de 20%.<br />Le coût des déplacement des flottes a baissé de moitié pour les sauts intergalactiques et a été divisé par 3 pour les déplacements dans une même galaxie.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Thu, 16 Apr 2009 12:31:58 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8250</guid>
		</item>
		<item>
			<title><![CDATA[Petite mise à jour]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8205</link>
			<description><![CDATA[<p>Les colonies ont désormais une capacité de 100k en minerai et hydrocarbure, 1k de soldats et scientifiques, produisent 2500 crédits / jour et peuvent former 10 scientifiques et 50 soldats par heure.<br />Les réserves (50k de capacité) ne peuvent plus être construites.<br />Augmentation du coût d&#039;entretien des satellites solaires.<br />Baisse sensible du coût de formation des scientifiques et soldats.<br />Ajout de l&#039;affichage de la production de crédits et prestige dans la page des planètes.<br />Les nouveaux joueurs commenceront avec les recherches pour construire sondes, chasseurs et centrale géothermique.<br />Plus quelques autres petites modifications sur les bâtiments militaires et scientifiques.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Wed, 08 Apr 2009 13:44:29 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8205</guid>
		</item>
		<item>
			<title><![CDATA[Changements récents]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8094</link>
			<description><![CDATA[<p>Les Usines de Produits Manufacturés (UPM) font leur apparition sur le s01, s02 et s03, vous pourrez miser sur une production de crédits relativement stable mais vous aurez besoin d&#039;un apport en énergie non négligeable pour les faire tourner.</p><p>Le prix des ressources est désormais variable (voir <a href="http://forum.exile.fr/viewtopic.php?pid=142375#p142375)" rel="nofollow">http://forum.exile.fr/viewtopic.php?pid=142375#p142375)</a>. Ceci affecte aussi le prix de revente sur vos planètes et le prix auquel vous achetez les ressources auprès de la guilde marchande (environ 20% plus cher que le prix de vente).</p><p>Le financement des joueurs dans les nouvelles galaxies protégés ne seront plus possibles : l&#039;envoie d&#039;argent à une nation dans une galaxie protégé à partir d&#039;une autre galaxie n&#039;est plus possible. De plus, il n&#039;est plus possible de former d&#039;alliance intergalaxie quand ces galaxies sont encore protégées.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Mon, 02 Mar 2009 14:15:35 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8094</guid>
		</item>
		<item>
			<title><![CDATA[Prix de ventes à la Guilde Marchande]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=8050</link>
			<description><![CDATA[<p>Le prix auquel la Guilde Marchande achète les ressources est désormais indiqué dans la carte de la galaxie.<br />Ce prix variera suivant l&#039;occupation de la galaxie de 50% pour le plus bas à 100% du prix actuel. Les galaxies ayant le plus de planètes colonisées auront un prix plus intéressant que les galaxies moins colonisées.</p><p>Cette modification sera effective à partir de la semaine prochaine.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Mon, 16 Feb 2009 13:41:49 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=8050</guid>
		</item>
	</channel>
</rss>
');
INSERT INTO exile_nexus.news VALUES (2, 'http://forum.exil.pw/extern.php?action=new&fid=17&type=rss', '<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<atom:link href="http://forum.exil.pw/extern.php?action=new&amp;fid=17&amp;type=rss" rel="self" type="application/rss+xml" />
		<title><![CDATA[Exile - Forum / Discussion]]></title>
		<link>http://forum.exil.pw/index.php</link>
		<description><![CDATA[Les sujets les plus récents sur Exile - Forum.]]></description>
		<lastBuildDate>Fri, 08 Apr 2011 20:34:37 +0000</lastBuildDate>
		<generator>FluxBB</generator>
		<item>
			<title><![CDATA[Galactic horizon]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9554</link>
			<description><![CDATA[<p>bonjour a toute et a tous je suis inferno je suis un joueur de galactic horizon , j&#039;ai appris que exil allais fermer et donc que certain d&#039;entre vous cherche un nouveau jeu. </p><p>déjà 7 joueur d&#039;éxile sont venu et commence a se prendre au jeu , j&#039;ai également entendu dire que certain ne venais pas a cause du compte prémium donc juste pour vous dire le compte prémium sur GH ne sert strictement a rien ou du moin il ne sert absolument pas a etre parmis les meilleur du classement il sert uniquement a faire de la prospection ( gain d&#039;or et de temps en temps de quelque troupe ou vaisseaux a la capacité d&#039;attaque ridicul assez efficace en def mais avant d&#039;en avoir une armée complete bah c pas gagner ) il sert a savoir ce qui se passe dans la galaxie ( nouveau joueur , déclaration de guerre , fin de guerre, il y a une invasion a tel endroit , une nouvelle alliance c&#039;est crée) et a réduire le temps pour effectuer une invasion. Pour ma part je suis 18eme sur GH et j&#039;ai eu le compte prémium qu&#039;une seul fois pendant 3 mois sur 2ans que je suis sur GH.</p><p>ensuite si vous venez vous ne serez absolument pas délaisser des joueurs viendront vers vous pour vous aider ( j&#039;ai personellement pris 4 et bientot 5 joueur d&#039;exil sous mon aile) et si vous voulez je peux vous orienté vers des personne pour vous aider.</p><p>voila c&#039;était juste pour vous inciter a venir que vous n&#039;ayé pu peur de venir sur GH bonne continuation a tous et peut etre a bientot sur GH <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /></p>]]></description>
			<author><![CDATA[dummy@example.com (inferno94)]]></author>
			<pubDate>Fri, 08 Apr 2011 20:34:37 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9554</guid>
		</item>
		<item>
			<title><![CDATA[je veux etre respo, et meme pas pour viré Kaito]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9553</link>
			<description><![CDATA[<p>Voila j&#039;ai été invité dans le fan club de quelqu&#039;un en pensant que c&#039;été le mien, imaginé la surprise, un fan club et meme pas le mien, je comprend que vous aussi vous comprenez pas, mais il y a pire :</p><p>Je veux en etre le respo, et c&#039;est la que vous entrez n scene, aidé moi a faire le forcing pour que je puisse devenir responsable, tous a vos loging et voté pour Groland </p><p>ps : grace a vous je pourra viré kaito</p>]]></description>
			<author><![CDATA[dummy@example.com (Groland)]]></author>
			<pubDate>Thu, 07 Apr 2011 21:28:27 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9553</guid>
		</item>
		<item>
			<title><![CDATA[[Genesis]Rassemblement Final et Général]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9551</link>
			<description><![CDATA[<div class="quotebox"><cite>GhostDog a écrit&#160;:</cite><blockquote><div><div class="quotebox"><cite>vegeta a écrit&#160;:</cite><blockquote><div><p>bon , pour les alliance qui desire organiser un petage massif de plusieur centaines de million de sig , et faire beuger le serveur ^^<br />et finir le serveur sur un seul salon </p><p>rendez vous en <strong><span class="bbu">44.59.13</span></strong> avant le 15 Avril <br />--------------------------------------------------</p><p>toute flotes , ou alliance voulant franchire les frontiere jouets pour cette petite fete , doit etre en mode riposte , et signaler leurs arrivée par mp a un des respo jouets </p><p>PS , aucune flotes ne sera interceptée , et n&#039;oublier pas , le mode riposte sur le lieu de rdv</p></div></blockquote></div><p>Héééé mais c&#039;est chez moi !!!</p></div></blockquote></div><p>Bon les gens , comme vous voyez, les jouets ont accéptés d&#039;organiser un crash général chez eux , pour les gens qui sont intéressés , commencez à envoyer vos flottes vers le centre, précisement le <span class="bbu"><strong>44.59.13</strong></span> ,noubliez pas de les mettre en mode riposte et contacter les respo jouets avant de franchir leurs frontiers , Lorsqu&#039;on serait labas , on se mettra tous sur le salon Exile pour vivre le dérnier combat sur exile .</p><br /><p>Essayez de le faire vite (et surtout les gens qui sont sur les bordures de la Galaxie) avant que Duke nous fume en plein air <img src="http://forum.exil.pw/img/smilies/tongue.png" alt="tongue" /> .</p><p>Ps : n&#039;envahissez pas la planéte à GhostDog , c&#039;est la dérniére qu&#039;il posséde <img src="http://forum.exil.pw/img/smilies/big_smile.png" alt="big_smile" />&#160; <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /> .</p>]]></description>
			<author><![CDATA[dummy@example.com (chantrix)]]></author>
			<pubDate>Thu, 07 Apr 2011 16:18:37 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9551</guid>
		</item>
		<item>
			<title><![CDATA[meule d''or a dit]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9550</link>
			<description><![CDATA[<p>salutations .</p><p>Bon, d&#039;accord exile se termine.</p><p>cela dit, un modo en fin de serveur qui ban soul parce qu&#039;il le &quot;gave&quot; c&#039;est pathétique...</p><p>Serais tu frustré à ce point ?</p><br /><p>cf:<br />&quot;merci a meule d&#039;or de nous démontrer toute sa partialité légendaire&quot;</p><p>il reviendra de toute façon et tu ne pourras l&#039;empêcher .....</p>]]></description>
			<author><![CDATA[dummy@example.com (oxidours)]]></author>
			<pubDate>Thu, 07 Apr 2011 07:42:49 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9550</guid>
		</item>
		<item>
			<title><![CDATA[Duke, Duke: une explication, un bilan, une synthèse, une oraison, STP?]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9549</link>
			<description><![CDATA[<p>Duke, est-ce vrai que tu as 4 bras et 7 paires d&#039;yeux? <img src="http://forum.exil.pw/img/smilies/yikes.png" alt="yikes" /></p><p>Es-tu humain?<br />Si oui, quel style de SM pratiques-tu? Y-a-t-il encore des places disponibles? <img src="http://forum.exil.pw/img/smilies/tongue.png" alt="tongue" /></p><p>As-tu bien récupéré toute l&#039;énergie que nous avons gaspillé pour ce maudit jeu? <img src="http://forum.exil.pw/img/smilies/mad.png" alt="mad" /></p><p>Que vas-tu retenir de l&#039;expérience Exile? <img src="http://forum.exil.pw/img/smilies/cool.png" alt="cool" /></p><p>Garderas-tu un bon souvenir du forum?&#160; <img src="http://forum.exil.pw/img/smilies/roll.png" alt="roll" /></p><br /><br /><p>STP, ne nous laisse pas crever sans savoir...&#160; :cry:</p><p>DUKE, DUKE, DUKe, Duke, Duk.......................................</p>]]></description>
			<author><![CDATA[dummy@example.com (Jobastre)]]></author>
			<pubDate>Wed, 06 Apr 2011 12:31:04 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9549</guid>
		</item>
		<item>
			<title><![CDATA[Groland !]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9547</link>
			<description><![CDATA[<p>C&#039;est kiffant Groland !</p><br /><br /><p>Le Groland, au travers des émissions, parodie l&#039;actualité française et internationale.</p><p>Certains voient dans ce pays imaginaire ? qui a la particularité d&#039;avoir une frontière commune avec tous les pays du monde ? une parodie de la Principauté de Monaco, arguant notamment que Christian Borde a fait ses débuts télévisuels à TMC.<br />Le président[modifier]<br />Christophe Salengro</p><p>Le président, interprété par Christophe Salengro, est une caricature du président français.</p><br /><p>Le Groland est francophone, mais là encore, le côté parodique se fait ressentir avec des slogans tels que : « Viendez au Groland ! » ou bien telle que la devise nationale grolandaise : « Groland, je mourrirai pour toi ![1]» en mauvais français. L&#039;organisation politique est la même que celle de la France, à l&#039;exception de quelques ministères fictifs. Le Groland possède son propre drapeau, ses propres plaques d&#039;immatriculation, ses propres passeports, cartes d&#039;identités, noms de villes (Groville, Mufflins?), etc.</p><p>&#160; &#160; </p><br /><p>Des ossements de majorettes, datant du crétacé inférieur, ont été retrouvés sur les terres du Groland. D&#039;abord duché dépourvu de nom, le Groland était peuplé par des barbares hirsutes et païens. Le pays s&#039;affranchit en l&#039;an 1695 de la domination des « austro-boche ». Le nom Groland apparait officiellement en 1707, après une fête traditionnelle appelée la Beuverie . C&#039;est au cours de cette fête que le Duc Platisphile Ier de Salengro hurla sur son trône à minuit : « Euj fait qu&#039;est-ce que je voul, car céans c&#039;est Salengroland ! ». L&#039;assistance ayant mal entendu les paroles du Duc ivre mort, en déduit alors qu&#039;il avait nommé son duché « Groland », et elle chanta aussitôt à l&#039;unisson : « Vive Groland !!! ». Envahie par la France, la province acquiert son indépendance en 1858, après le refus de Napoléon III de subventionner plus longtemps un pays inculte et sans valeur stratégique. Grâce à l&#039;influence de Jean-Edouard Trouabal, conseiller président de Patimbert II de Salengro, le Groland met en place son régime de Présipauté, sa constitution ainsi que son système de suffrage uni-personnel, en l&#039;espace d&#039;une nuit de beuverie, du 13 au 14 juillet 1889 dans le château grovillois du Duc. C&#039;est ainsi que la fête nationale grolandaise a lieu, par une remarquable coïncidence, le 14 juillet.</p><p>La Présipauté de Groland se fédère autour de valeurs communes, symbolisées par sa devise, la suppression des églises et de l&#039;État ainsi que par ses trois grands principes : « Joie, hospitalité, lâcheté ». A la mort de Nathanaël IV, président de 1909 à 1942, la petite autocratie change de doctrine. Sous l&#039;égide de Gunthar I, sympatisant hitlérien, le pays devient « serpillère », d&#039;après le mot du général de Gaulle. Le pays ouvre alors ses bras à l&#039;envahisseur nazi, qui y trouve plusieurs avantages. Les Juifs et Tziganes cachés dans les campagnes subissent un sort funeste, dès la mise en place en Avril 1943 des décrets racistes de l&#039;évanescent « Ministère des Problèmes eud&#039;Rastaquouères ». A l&#039;arrivée des Alliés en 1945, les oriflammes nazis et les décrets inhumains sont brûlés. Les Américains sont accueillis à bras ouverts, et, le 10 février 1944, Gunthar I finit éventré, écartelé, désossé et brûlé. Lui succède alors Mamie Quéquette (décédée en 1993).</p><p>Après le décès de Mamie Quéquette en 1993, Christophe Salengro devient président. On change la musique de l&#039;hymne national, la télévision par satellite fait son apparition, avec comme chaîne phare CANAL International. Le président doit cependant faire face à la mondialisation, au chômage, etc.</p>]]></description>
			<author><![CDATA[dummy@example.com (Tobi)]]></author>
			<pubDate>Tue, 05 Apr 2011 18:34:41 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9547</guid>
		</item>
		<item>
			<title><![CDATA[For me For me Four me dable]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9546</link>
			<description><![CDATA[<p>TOBI créé un sujet sur comment tu Kifferé etre Groland <img src="http://forum.exil.pw/img/smilies/big_smile.png" alt="big_smile" /></p>]]></description>
			<author><![CDATA[dummy@example.com (Groland)]]></author>
			<pubDate>Tue, 05 Apr 2011 18:28:22 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9546</guid>
		</item>
		<item>
			<title><![CDATA[Aux Armes mes NOOB]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9545</link>
			<description><![CDATA[<p>Un usurpateur qui se prend pour Duke veux fermer exile?</p><p>pour ceux qui pense que c&#039;est un poisson d&#039;avril tappé 1</p><p>pour ceux qui pense que Duke va oublié de fermé l&#039;acces a exile tappé 2</p><p>pour ceux qui pense que je suis plus beau que baron tappé 4</p><p>pour ceux qui pense que pense que exile ca sent le sapin tappé 5</p><p>pour ceux qui se demande pourquoi j&#039;ai oublié le 3 tappé 3</p>]]></description>
			<author><![CDATA[dummy@example.com (Groland)]]></author>
			<pubDate>Mon, 04 Apr 2011 22:54:14 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9545</guid>
		</item>
		<item>
			<title><![CDATA[[Genesis]Finir en beauté]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9544</link>
			<description><![CDATA[<p>Salut tout le monde <img src="http://forum.exil.pw/img/smilies/smile.png" alt="smile" /> .</p><p>Comme on le sait tous maintenant , notre jeu adoré va fermer ses portes <img src="http://forum.exil.pw/img/smilies/sad.png" alt="sad" /> , l&#039;aventure est fini :cry: , de ce fait , je vous propose de le finir en beauté() , en se rassemblant tous dans l&#039;un des secteurs centraux , puis on donne lieu à un moment de feu d&#039;artifice sur l&#039;un de ses planètes .</p>]]></description>
			<author><![CDATA[dummy@example.com (chantrix)]]></author>
			<pubDate>Mon, 04 Apr 2011 22:15:02 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9544</guid>
		</item>
		<item>
			<title><![CDATA[[x02] po(s)t de départ]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9541</link>
			<description><![CDATA[<p>Etant donné qu&#039; exile va bientot ferme ses portes , je me tape aussi ( comme pas mal d&#039;autre , mon post de départ (care ,&#160; pavé césar ))</p><p>en premier , je remercie bien entendu duke pour avoir créer ce jeu</p><p>ensuite , on va faire par serveur , sa sera plus simple <img src="http://forum.exil.pw/img/smilies/tongue.png" alt="tongue" /></p><br /><p>S01 : <br />début avec le compte [CO] Shimrra , puis reprise du compte de [CO]Galalua ( bilnabar doit encore s&#039;en souvenir <img src="http://forum.exil.pw/img/smilies/yikes.png" alt="yikes" /> ) c&#039;est la que j&#039;ai fait la connaissance avec les LOI ( pouille et aroukai , notamment )&#160; et que l&#039;on s&#039;est recu les EDEN dans la gueule ( fils de leur maman )donc , tous GO .<br />création&#160; du compte POIR shimrra , wing de la POM , alliance formé pour se venger des EDEN . j&#039;ai fait la connaissance de roi momo ( quel lache rien celui la <img src="http://forum.exil.pw/img/smilies/smile.png" alt="smile" /> )</p><p>&#160; guerre en G31 , POIR vs SMII . puis la machine s&#039;emballe , SMII rameute ses alliés , et POM vient nous sauver . pour la petite histoire , on peut le dire maintenant , on avait fait un faux screen de jump avec de fausses coordonnées . et vous avez foncé dans le piege , sur l&#039;ordre mémorable d&#039;artimus , chef des SMII : branlement de combat , ils arrivent . merci a kefta , a pupuce , a alfred ( tu vois , je me souviens meme de ton prénom , SAS <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /> )a bachi ( quel modé casse couille celui la <img src="http://forum.exil.pw/img/smilies/tongue.png" alt="tongue" /> ) au grand RIKER , et a notre géopoliticien GJ2 préféré , davout .</p><p>ensuite , création du compte en G40 , pour reformer POIR . et paf , on retombe sur roi momo et sa clique , renommé G4.0 .<br />donc , guerre toujours avec eux ( demandez pas pourquoi , je ne sais meme pas .)POM accourt , mais, trop confiant , lache des attaques sectorielles sans sonder . la punition est donné par les alliés de G4.0 et les SMx . ( dédicase a alpha14 en passant , un gay que j&#039;adore )</p><p>au meme moment , formation de la LIG 5 . la LIG doit faire de suite un choix : aider POM/LIG5 contre les SMx , ou aider IMP/JENA/HOG contre LOL/SF/chaos.</p><p>l&#039;aide au HOG est voté .. et la LIG pete en 1 nuit , sur fond de désaccord )<br />je rejoint donc HOG pour les aide avec le compte de Aubade , attaque sans pitié les LOL3 de la G29 ( merci a eux pour leur grande sympathie et leur fair play , c&#039;était l&#039;une de mes guerres les plus plaisantes a jouer . empereur nain en tete des LOL3 )puis leur renfort arrivent , donc , on prend la poudre d&#039;escampette .</p><p>on rejoint le bastion HOG , et je recois des infos comme quoi on risque de se faire attaquer . et la , chose a ne pas faire , on me file l&#039;acces a un compte ennemi , on avoir des infos . je m&#039;y suis rendu plusieurs fois , et boom , en écriture rouge : banni pour multicompte .</p><p>suite a mes connaissances , je récupere le compte de UNK chklang , puis le compte de [EVEN]sexygirlspqr , pas mal de combat fait avec ce compte la , merci au chaos ( epervier007 en tete ) et au EVEN ( mordhor /meule d&#039;or ) de m&#039;avoir fait confiance .<br />---------------------</p><p>S02 .<br />si une image pouvais symboliser ce serveur , sa serai sans doute un : <img src="http://forum.exil.pw/img/smilies/big_smile.png" alt="big_smile" /></p><p>début peu convaincant avec les SHA , delete , création en G5 , delete , création en G9 ( ou je revois roi momo T_T . résultat , on se fout sur la gueule )delete , création en G5 . farm farm farm . puis , l&#039;un des chefs des alliers demande une fusion , il l&#039;obtient .et devient le chef de la fusion . le courant ne passe pas&#160; . devant les post enflammer sur les salons ( et je le dis encore , non , vouloir attaquer la G9 en pensant qu&#039;elle n&#039;a que 2M , c&#039;est du noobisme a l&#039;état brut ) je me retrouve pourchasser par un dingue nommé lenigma et son alliance .&#160; des anciens alliers : thorgal , tranquille , pépémoka , alpha14 me suivent . et avec leur aide , nous arrivons a repousser ses fous de la G17 , les cantonnants a la G5 .puis ... l&#039;on rejoint ACE2 . le bonheur . une team de motivés : herbivor , groland ( gaffe , si quelqu&#039;un veut vous vendre une vds , c&#039;est lui )draak145 ,jak la ache . bref , que des bons joueurs qui en veulent . avec nos alliés ( MERC et CAS , notre wing ) nous échangeons des tirs contre FE et LPR . apres maintes combat , le bataille finale est remporté .<a href="http://forum.exile.fr/viewtopic.php?id=8576" rel="nofollow">http://forum.exile.fr/viewtopic.php?id=8576</a></p><p>puis ,quelque temps apres, suite a une tres bonne entente avec nos adversaires et nos alliers , étant donné que le serveur va fermer . nous décidons de faire un serveur 2 vs ACE2/CAS ... et nous l&#039;avons gagné \\0/</p><p>-------------------</p><p>S03 <br />un serveur qui me fait et sourire et grimacer .</p><p>grimacer a cause d&#039;un multi .<br />sourire car meme a 3 ou 4 , et meme a la fin 5 galaxie , nous avons tenu bon .<br />merci du fond du coeur a tout les MYTH , LOT puis DEV qui m&#039;ont suivi dans cette folle aventure .</p><p>-----------------------<br />Génésis .&#160; déja , pour ce serveur , je voudrais demander pardon aux alliances : MECC , LEGO , DIE et PLAY .<br />sinon , je l&#039;ai dit des le début pour ce serveur , je n&#039;ai jamais apprécié le partage de flotte .donc , pas grand chose a dire</p><p>-------------------------<br />X02 .<br />le meilleur pour la fin .une boucherie . CODE .<br />trois semaine apres le début du serveur , nous faisions route vers la G1 . nous la prenons sans grande difficulté ( manipulation d&#039;info avec a la barre lina inverse et moi meme , de 12M sur vortex G1 , on a trouvé meme pas 1M&#160; <img src="http://forum.exil.pw/img/smilies/big_smile.png" alt="big_smile" /> ... alors que la G1 était en guerre interne .)&#160; nous récupérons la bas nekron , tranquille et ma chere julia .</p><p>puis la G3 s&#039;allie avec l&#039;alliance guerriere de la G5 , les PAX , et ensemble , CTH et PAX , choisirent de nous attaquer en G2 . avec l&#039;aide de CODE Alkar , puis de CODE eynkil , nous les harrassons avec des flottes dérisoires , dans le secteur ou ils attaquaient .pour info , ils ont débarqué 80M environ .&#160; ils en ont perdu environ 7 ou 8M pour prendre 4 secteur .&#160; puis , les unités produites en G2 , en G1 et nos flottes meres font jonction . et explosent les flottes PAX/CTH et un BOU ( G5 ) venu en vautour . des lors , la G4 , dirigé par mordhor ( alliance d&#039;alcoolo , les VINS ) signe un pacte d&#039;entente avec nous : ils attaquent la G5 , et nous attaquons la G3 . les VINS se font shooter a l&#039;arrivé ( d&#039;ailleurs ,&#160; je me rappelle du premier RC que l&#039;on a attendu pendant + d&#039;une heure ) et nous rentrons comme dans du beurre dans la G3 .nous commencons a l&#039;attaquer , a l&#039;entamer , mais duke nous signal que le serveur va fermer , pour laisser place au S03 . nous decidons de feter noel en G5&#160; ( snif , ils n&#039;ont pas voulu le feter avec nous&#160; ) nous leur prenons quelques planetes au passage&#160; .</p><br /><br /><p>donc , je voudrais remercier . tout les joueurs d&#039;exile , son créateur . <br />l&#039;équipe SR/CODE . l&#039;équipe MYTH/LOT/DEV .&#160; POM/POIR .&#160; &#160;UNK/EVEN . ACE2 .<br />merci a tous pour avoir jouer a exile .</p><br /><p>et bravo encore a EL matador pour son gamin .&#160; et que ta gosse n&#039;oublie pas : kirk , c&#039;est un boulet .</p>]]></description>
			<author><![CDATA[dummy@example.com (CODE Amiral)]]></author>
			<pubDate>Sun, 03 Apr 2011 00:25:59 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9541</guid>
		</item>
		<item>
			<title><![CDATA[Les multi, les doublons, les taupes et les salopards de tout genre :D]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9540</link>
			<description><![CDATA[<p>(sur une idée d&#039;un membre d&#039;exile):</p><br /><p>Défoulez vous !</p><p>La fin approchant, l&#039;apocalypse étant annoncé, vous avez le droit de dire ce que vous êtes, avez été, avez fait croire, les multi que vous avez utilisé et les pièges foireux que vous avez lancé.</p><p>Le tout dans un esprit de camaraderie je tiens à le préciser !!!</p><p>Même si on apprend que x ou y avait 10 comptes, merci de le prendre désormais avec le sourire...</p><p>Personnellement ce n&#039;est pas un secret pour certain que j&#039;ai eu une courte période ou j&#039;étais Selenia en même temps qu&#039;Anubis... Puis anubis en même temps que Rakh...</p><br /><p>Mais jamais en temps de guerre ni pour gérer des flottes, juste pour ne pas recommencer à zero et transporter avec moi hydro/minerai etc <img src="http://forum.exil.pw/img/smilies/big_smile.png" alt="big_smile" /></p><p>Concernant les trahisons, j&#039;ai juste une fois tenté de faire croire a mon ami imperorator (&#160; salut Impe <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /> ) que je trahissais mon camp afin de retarder son entrée en guerre et lui fournir de faux rapport de combats et résumés de flottes ( Mais ce n&#039;est pas une nouvelle pour lui).</p><p>Rien de sérieux donc, mais je crois qu&#039;on va en apprendre de belles...</p><p>Tout est d&#039;office excusé...</p><p>Lâchez-vous, gentiment, il n&#039;y a plus rien à perdre desormais <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /></p>]]></description>
			<author><![CDATA[dummy@example.com (anubis-LDA)]]></author>
			<pubDate>Sat, 02 Apr 2011 21:34:24 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9540</guid>
		</item>
		<item>
			<title><![CDATA[Et maintenant...]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9539</link>
			<description><![CDATA[<p>Petit sujet tout bête (à la demande d&#039;un ami).</p><br /><p>Beaucoup d&#039;entre nous se connaissent, beaucoup ont envie de continuer de jouer ensemble (ce qui ne signifie pas forcement dans le même camps <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" />&#160; ) et de se retrouver sur un jeu qui nous plaise.</p><p>Aussi, je vous invite à proposer les jeux pouvant se rapprocher de ce qu&#039;est Exile (ou ce qu&#039;il fut).</p><p>A la fin il est clair que chacun choisira, mais cela permet de nous retrouver nombreux sur les meilleurs jeux (et montrer à tous, ce que valent les ex-exiliens <img src="http://forum.exil.pw/img/smilies/wink.png" alt="wink" /> ) </p><br /><p>Je me lance avec </p><p>- <a href="http://www.og" rel="nofollow">http://www.og</a>@me.fr/</p><p>- <a href="http://www.weymery.com/" rel="nofollow">http://www.weymery.com/</a></p><p>- <a href="http://www.apocalypsis.org" rel="nofollow">http://www.apocalypsis.org</a></p><p>et je mets à jour au fur et a mesure que les propositions tombent :</p><p>- <a href="http://www.projetgenesis.com/" rel="nofollow">http://www.projetgenesis.com/</a></p><p>- <a href="http://www.celestus.fr/" rel="nofollow">http://www.celestus.fr/</a></p><p>- <a href="http://www.empireuniverse2.fr/" rel="nofollow">http://www.empireuniverse2.fr/</a></p><p>- <a href="http://www.galactic-horizon.com/" rel="nofollow">http://www.galactic-horizon.com/</a></p><p>- <a href="http://www.fatal-destiny.com/" rel="nofollow">http://www.fatal-destiny.com/</a></p><p>- <a href="http://www.star-tactics.com/game/login.php" rel="nofollow">http://www.star-tactics.com/game/login.php</a></p><p>- <a href="http://www.gate4wars.com/" rel="nofollow">http://www.gate4wars.com/</a></p><p>- <a href="http://fallengalaxy.eu/" rel="nofollow">http://fallengalaxy.eu/</a></p><p>- <a href="http://nemexia.fr/" rel="nofollow">http://nemexia.fr/</a></p><br /><p>A vous... tout est bon a étudier (mais juste les jeux sur navigateur, gratuits, et se déroulant dans l&#039;espace)</p><p>et les gagnants (pour le moment !)&#160; sont....</p><br /><p><a href="http://www.projetgenesis.com/" rel="nofollow">http://www.projetgenesis.com/</a>&#160; &#160; -&#160; &#160;univers : Hybrid</p><p>Plusieurs alliances déjà créées par les exiliens :</p><p>[EXILE] &quot;Les Exilien&quot;&#160; (oui ils ont oublié le S... lol ce sera modifié)<br />[SPQR] &quot;Les legions d Exile&quot;<br />[NOOB]</p><p>ET pour ceux que PG à rebuté :</p><p><a href="http://www.spacepioneers2.fr/" rel="nofollow">http://www.spacepioneers2.fr/</a><br />[VOV] et autres à prévoir</p><br /><p>Pour rester en contact par le biais de la mailing-list, s&#039;inscrire sur :</p><p><a href="http://atod.fr" rel="nofollow">http://atod.fr</a></p>]]></description>
			<author><![CDATA[dummy@example.com (anubis-LDA)]]></author>
			<pubDate>Sat, 02 Apr 2011 21:27:55 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9539</guid>
		</item>
		<item>
			<title><![CDATA[Merci tout simplement]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9538</link>
			<description><![CDATA[<p>Etant donné que la fin des temps exiliens approche et que nous serons tous de nouveau des exilés, errant de serveur en serveur en quête du jeu qui nous tiendra en haleine et causera nombre de nuits blanches, je me suis dit que finalement je posterai enfin un petit message sur le forum.</p><p>je fais partie de cette majorité silencieuse qui est présente sur ce jeu depuis un bon moment, et qui bon gré mal gré au fil des modifications plus ou moins positives a toujours persévèré et n&#039;a jamais eu ni le courage ni l&#039;envie d&#039;arrêter....et pourtant Genesis est passé par là.&#160; (ben oui je suis un nostalgique du S01...comme beaucoup)</p><p>Je n&#039;ai jamais critiqué les respos de ce jeu...tout simplement car je ne trouvais pas qu&#039;il était normal de venir s&#039;offusquer en public de la moindre chose sur un jeu gratuit, se plaignant sans arrêt et critiquant la moindre modification.</p><p>Comme beaucoup j&#039;ai été dégouté par ceux qui s&#039;adonnaient à la pratique du multi, au sitting de compte, ou bien encore à l&#039;utilisation de script...mais en fin de compte j&#039;ai finalement éprouvé de la tristesse pour ces mêmes personnes qui n&#039;y ont pas gagné grand chose et ont en cours de route perdu la raison pour laquelle ils étaient venus ici en premier lieu : le plaisir de jouer.</p><p>Mais en dépit de tout cela, j&#039;étais toujours là et je continuais à jouer.</p><p>Voilà, la fin est proche...et on ne voit même pas arriver les flottes de fossoyeurs.....tout se perd.</p><p>Il ne me reste plus qu&#039;à dire un grand merci à Duke pour ce jeu magnifique sur lequel j&#039;aurais passé d&#039;excellents moments, et plutot que de perdre un temps fou à envoyer des mp, un grand merci aussi et surtout à tous ceux et toutes celles dont j&#039;ai croisé le chemin au sein d&#039;alliances extraordinaires, mais aussi sur le champs de bataille ou dans les couloirs sombres de la diplomatie.<br />:beer:</p><p>Bonne continuations à toutes et à tous et si vous connaissez un jeu proche de celui-ci, faites moi signe que j&#039;aille vite m&#039;y inscrire.</p>]]></description>
			<author><![CDATA[dummy@example.com (Lanceor)]]></author>
			<pubDate>Sat, 02 Apr 2011 21:25:04 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9538</guid>
		</item>
		<item>
			<title><![CDATA[Au revoir de Kira (genesis)/ewok59 (s01)]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9537</link>
			<description><![CDATA[<p><span style="color: antiquewhite">Bonjour à tous,</p><p>Comme l&#039;a annoncé le développeur du jeu, Exile s&#039;arrête définitivement le 15 avril de l&#039;an de grâce 2011.</p><p>Je voulais en profiter pour saluer de façon solennelle toutes les personnes que j&#039;ai croisé et qui ont fait et font ce qu&#039;est ce jeu; car l&#039;intérêt principal d&#039;Exile provient de l&#039;interaction entre les joueurs.</p><p>En effet, je garderai d&#039;excellents souvenirs du s01, serveur sur lequel j&#039;ai débuté et que je trouvais parfait, tant au niveau de l&#039;ambiance, des joueurs, et du mode de développement. genesis est différent, mais je m&#039;y suis bien amusé également, pendant mes périodes d&#039;activité ig.<br /></span><br /><span style="color: red">s01</span><br /><span style="color: royalblue"><br />- Je remercie tous mes compagnons d&#039;armes de la galaxie 33 avec une attention particulière pour dragoni (mad una), Oceania, zazouid, Numancia, Numancia2, cosaque.<br />- Je remercie tous mes alliés du CHAOS des alliances EVEN, RIP, DOC, etc., avec une attention particulière pour Blackangel, gorilla, Lorenzo, WaigaNdaroK, Mordhor, Flagg, Marneus Calg, Peio, Entropie, Kirk, et j&#039;en oublie des dizaines..<br />- Je remercie tous mes ennemis [HOG], [LOLx], [GOA], [S23A], etc., avec une attention particulière pour Vukodlak, Asylum, tous les LOL, HOG, GOA et S23A que j&#039;ai apprécié combattre.<br /></span><br /><span style="color: red">genesis</span><br /><span style="color: royalblue"><br />- Je remercie tous mes alliés UNA/UNA2 avec une attention particulière pour Flagg, Dark Devil, Gandhi, Bayon, Les amazones, Peio, WaigaNdaroK, gorilla, Kirk, lorenzo, mad una, Meule dor.<br />- Je remercie également [CRIM] Mike Hammer et [LOG] Celeste.<br />- Je remercie également mes ennemis jouets [MECC], [DIE], [KIKI], [TOYS] ... non ne vous inquiétez pas je ne vais pas tous les citer ^^<br />Je n&#039;ai pas d&#039;attention particulière envers eux car malheureusement je ne connais pas bien mes ennemis, contrairement au s01.<br /></span><br /><span style="color: antiquewhite"><br />Voilà merci à vous et merci Exile.</p><p>Bonne continuation!<br /></span></p>]]></description>
			<author><![CDATA[dummy@example.com (dmm)]]></author>
			<pubDate>Sat, 02 Apr 2011 10:38:10 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9537</guid>
		</item>
		<item>
			<title><![CDATA[Fin d''exile]]></title>
			<link>http://forum.exil.pw/viewtopic.php?id=9536</link>
			<description><![CDATA[<p>Après plus de 6 ans, l&#039;aventure se termine, Exile prendra fin ce 15 avril 2011.<br />A cette date, les serveurs ne seront plus accessibles.</p><br /><p>Merci à tous les joueurs qui ont fait vivre Exile pendant toutes ces années.<br />Non, ce n&#039;est pas un poisson d&#039;avril.</p>]]></description>
			<author><![CDATA[dummy@example.com (Duke)]]></author>
			<pubDate>Sat, 02 Apr 2011 08:27:08 +0000</pubDate>
			<guid>http://forum.exil.pw/viewtopic.php?id=9536</guid>
		</item>
	</channel>
</rss>
');


--
-- Data for Name: universes; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--

INSERT INTO exile_nexus.universes VALUES (8, 's03', true, true, 5000, '2019-04-01 03:00:00', true, '2019-03-28 19:00:00', '', 'http://s03.monexile.lan', '2019-04-01 17:00:00', NULL, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--

INSERT INTO exile_nexus.users VALUES (1, 'Les fossoyeurs', 'A', 'fos@exile', 1036, '2006-09-01 00:00:00', '0.0.0.0', '2006-09-01 00:00:00', NULL, false, NULL, '2009-01-16 12:48:43.861+00', NULL, true);
INSERT INTO exile_nexus.users VALUES (2, 'Nation oubliée', 'A', 'no@exile', 1036, '2006-09-01 00:00:00', '0.0.0.0', '2006-09-01 00:00:00', NULL, false, NULL, '2009-01-16 12:48:43.861+00', NULL, true);
INSERT INTO exile_nexus.users VALUES (3, 'Guilde marchande', 'A', 'gm@exile', 1036, '2006-09-01 00:00:00', '0.0.0.0', '2006-09-01 00:00:00', NULL, false, NULL, '2009-01-16 12:48:43.861+00', NULL, true);
INSERT INTO exile_nexus.users VALUES (4, 'Nation rebelle', 'A', 'nr@exile', 1036, '2006-09-01 00:00:00', '0.0.0.0', '2006-09-01 00:00:00', NULL, false, NULL, '2009-01-16 12:48:43.861+00', NULL, true);
INSERT INTO exile_nexus.users VALUES (5, 'Admin', 'e2bca96725ac434bbe3b6345fcc404c1', 'admin@exile', 1036, '2006-09-05 11:55:29.829568', '0.0.0.0', '2019-03-29 16:14:22.161', 10, true, NULL, '2010-03-21 11:05:52.88+00', NULL, true);


--
-- Data for Name: users_successes; Type: TABLE DATA; Schema: exile_nexus; Owner: exileng
--



--
-- Name: awards_id_seq; Type: SEQUENCE SET; Schema: exile_nexus; Owner: exileng
--

SELECT pg_catalog.setval('exile_nexus.awards_id_seq', 3, true);


--
-- Name: log_logins_id_seq; Type: SEQUENCE SET; Schema: exile_nexus; Owner: exileng
--

SELECT pg_catalog.setval('exile_nexus.log_logins_id_seq', 958516, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: exile_nexus; Owner: exileng
--

SELECT pg_catalog.setval('exile_nexus.news_id_seq', 21, true);


--
-- Name: universes_id_seq; Type: SEQUENCE SET; Schema: exile_nexus; Owner: exileng
--

SELECT pg_catalog.setval('exile_nexus.universes_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: exile_nexus; Owner: exileng
--

SELECT pg_catalog.setval('exile_nexus.users_id_seq', 80887, true);


--
-- Name: awards awards_name_key; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.awards
    ADD CONSTRAINT awards_name_key UNIQUE (name);


--
-- Name: awards awards_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.awards
    ADD CONSTRAINT awards_pkey PRIMARY KEY (id);


--
-- Name: banned_domains banned_domains_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.banned_domains
    ADD CONSTRAINT banned_domains_pkey PRIMARY KEY (domain);


--
-- Name: log_logins log_logins_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.log_logins
    ADD CONSTRAINT log_logins_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: news news_url_key; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.news
    ADD CONSTRAINT news_url_key UNIQUE (url);


--
-- Name: universes universes_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.universes
    ADD CONSTRAINT universes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: exile_nexus; Owner: exileng
--

ALTER TABLE ONLY exile_nexus.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: log_logins_datetime_idx; Type: INDEX; Schema: exile_nexus; Owner: exileng
--

CREATE INDEX log_logins_datetime_idx ON exile_nexus.log_logins USING btree (datetime);


--
-- Name: users_email_unique; Type: INDEX; Schema: exile_nexus; Owner: exileng
--

CREATE UNIQUE INDEX users_email_unique ON exile_nexus.users USING btree (lower((email)::text));


--
-- Name: users_username_unique; Type: INDEX; Schema: exile_nexus; Owner: exileng
--

CREATE UNIQUE INDEX users_username_unique ON exile_nexus.users USING btree (lower((username)::text));


--
-- PostgreSQL database dump complete
--
