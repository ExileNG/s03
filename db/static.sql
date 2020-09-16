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
-- Name: static; Type: SCHEMA; Schema: -; Owner: exileng
--

CREATE SCHEMA static;


ALTER SCHEMA static OWNER TO exileng;

--
-- Name: battle_result; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.battle_result AS (
	alliancetag character varying,
	owner_id integer,
	owner_name character varying,
	fleet_id integer,
	fleet_name character varying,
	shipid integer,
	shipcategory smallint,
	shiplabel character varying,
	count integer,
	lost integer,
	killed integer,
	mod_shield smallint,
	mod_handling smallint,
	mod_tracking_speed smallint,
	mod_damage smallint,
	won boolean,
	attacked boolean,
	relation1 smallint,
	relation2 smallint
);


ALTER TYPE static.battle_result OWNER TO exileng;

--
-- Name: buildings_underconstruction; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.buildings_underconstruction AS (
	planet_id integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	building_id integer,
	building_name character varying,
	remaining_time integer
);


ALTER TYPE static.buildings_underconstruction OWNER TO exileng;

--
-- Name: connectinfo; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.connectinfo AS (
	id integer,
	privilege integer,
	lastplanetid integer,
	resets integer
);


ALTER TYPE static.connectinfo OWNER TO exileng;

--
-- Name: fleet_details; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.fleet_details AS (
	id integer,
	name character varying,
	attackonsight boolean,
	engaged boolean,
	size integer,
	signature integer,
	speed integer,
	action smallint,
	idle_time integer,
	total_time integer,
	remaining_time integer,
	droppods integer,
	commanderid integer,
	commandername character varying,
	planetid integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	planet_ownerid integer,
	planet_owner_name character varying,
	planet_owner_relation smallint,
	destplanetid integer,
	destplanet_name character varying,
	destplanet_galaxy smallint,
	destplanet_sector smallint,
	destplanet_planet smallint,
	destplanet_ownerid integer,
	destplanet_owner_name character varying,
	destplanet_owner_relation smallint,
	cargo_capacity integer,
	cargo_ore integer,
	cargo_hydrocarbon integer,
	cargo_scientists integer,
	cargo_soldiers integer,
	cargo_workers integer,
	recycler_output integer,
	orbit_ore integer,
	orbit_hydrocarbon integer
);


ALTER TYPE static.fleet_details OWNER TO exileng;

--
-- Name: fleet_movement; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.fleet_movement AS (
	id integer,
	name character varying,
	attackonsight boolean,
	firepower integer,
	engaged boolean,
	size integer,
	signature integer,
	speed integer,
	remaining_time integer,
	total_time integer,
	commanderid integer,
	commandername character varying,
	ownerid integer,
	owner_name character varying,
	owner_relation smallint,
	owner_alliance_id integer,
	planetid integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	planet_ownerid integer,
	planet_owner_name character varying,
	planet_owner_relation smallint,
	destplanetid integer,
	destplanet_name character varying,
	destplanet_galaxy smallint,
	destplanet_sector smallint,
	destplanet_planet smallint,
	destplanet_ownerid integer,
	destplanet_owner_name character varying,
	destplanet_owner_relation smallint,
	from_radarstrength integer,
	to_radarstrength integer,
	cargo_capacity integer,
	cargo_free integer,
	cargo_ore integer,
	cargo_hydrocarbon integer,
	cargo_scientists integer,
	cargo_soldiers integer,
	cargo_workers integer
);


ALTER TYPE static.fleet_movement OWNER TO exileng;

--
-- Name: galaxy_info; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.galaxy_info AS (
	id integer,
	open_since timestamp without time zone,
	protected_until timestamp without time zone,
	recommended integer
);


ALTER TYPE static.galaxy_info OWNER TO exileng;

--
-- Name: invasion_result; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.invasion_result AS (
	result smallint,
	soldiers_total integer,
	soldiers_lost integer,
	def_scientists_total integer,
	def_scientists_lost integer,
	def_soldiers_total integer,
	def_soldiers_lost integer,
	def_workers_total integer,
	def_workers_lost integer
);


ALTER TYPE static.invasion_result OWNER TO exileng;

--
-- Name: item_quantity; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.item_quantity AS (
	id integer,
	quantity bigint
);


ALTER TYPE static.item_quantity OWNER TO exileng;

--
-- Name: research_status; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.research_status AS (
	userid integer,
	researchid integer,
	category smallint,
	name character varying,
	label character varying,
	description character varying,
	rank integer,
	cost_credits integer,
	levels smallint,
	level smallint,
	status integer,
	total_time integer,
	total_cost integer,
	remaining_time integer,
	expiration_time integer,
	researchable boolean,
	buildings_requirements_met boolean,
	planet_elements_requirements_met boolean
);


ALTER TYPE static.research_status OWNER TO exileng;

--
-- Name: resource_price; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.resource_price AS (
	buy_ore real,
	buy_hydrocarbon real,
	sell_ore real,
	sell_hydrocarbon real
);


ALTER TYPE static.resource_price OWNER TO exileng;

--
-- Name: ships_underconstruction; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.ships_underconstruction AS (
	planet_id integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	ship_id integer,
	ship_name character varying,
	remaining_time integer
);


ALTER TYPE static.ships_underconstruction OWNER TO exileng;

--
-- Name: training_price; Type: TYPE; Schema: static; Owner: exileng
--

CREATE TYPE static.training_price AS (
	scientist_ore smallint,
	scientist_hydrocarbon smallint,
	scientist_credits smallint,
	soldier_ore smallint,
	soldier_hydrocarbon smallint,
	soldier_credits smallint
);


ALTER TYPE static.training_price OWNER TO exileng;

--
-- Name: db_buildings_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_buildings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_buildings_id_seq OWNER TO exileng;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: db_buildings; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_buildings (
    id integer DEFAULT nextval('static.db_buildings_id_seq'::regclass) NOT NULL,
    category smallint DEFAULT 1 NOT NULL,
    name character varying(32) DEFAULT 'name'::character varying NOT NULL,
    label character varying(64) DEFAULT 'label'::character varying NOT NULL,
    description text DEFAULT 'description here'::text NOT NULL,
    cost_ore integer DEFAULT 0 NOT NULL,
    cost_hydrocarbon integer DEFAULT 0 NOT NULL,
    cost_credits integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    energy_consumption integer DEFAULT 0 NOT NULL,
    energy_production integer DEFAULT 0 NOT NULL,
    floor smallint DEFAULT 1 NOT NULL,
    space smallint DEFAULT 0 NOT NULL,
    production_ore integer DEFAULT 0 NOT NULL,
    production_hydrocarbon integer DEFAULT 0 NOT NULL,
    storage_ore integer DEFAULT 0 NOT NULL,
    storage_hydrocarbon integer DEFAULT 0 NOT NULL,
    storage_workers integer DEFAULT 0 NOT NULL,
    construction_maximum smallint DEFAULT 1 NOT NULL,
    construction_time integer DEFAULT 3600 NOT NULL,
    destroyable boolean DEFAULT true NOT NULL,
    mod_production_ore real DEFAULT 0 NOT NULL,
    mod_production_hydrocarbon real DEFAULT 0 NOT NULL,
    mod_production_energy real DEFAULT 0 NOT NULL,
    mod_production_workers real DEFAULT 0 NOT NULL,
    mod_construction_speed_buildings real DEFAULT 0 NOT NULL,
    mod_construction_speed_ships real DEFAULT 0 NOT NULL,
    storage_scientists integer DEFAULT 0 NOT NULL,
    storage_soldiers integer DEFAULT 0 NOT NULL,
    radar_strength smallint DEFAULT 0 NOT NULL,
    radar_jamming smallint DEFAULT 0 NOT NULL,
    is_planet_element boolean DEFAULT false NOT NULL,
    can_be_disabled boolean DEFAULT false NOT NULL,
    training_scientists integer DEFAULT 0 NOT NULL,
    training_soldiers integer DEFAULT 0 NOT NULL,
    maintenance_factor smallint DEFAULT 1 NOT NULL,
    security_factor smallint DEFAULT 1 NOT NULL,
    sandworm_activity smallint DEFAULT 0 NOT NULL,
    seismic_activity smallint DEFAULT 0 NOT NULL,
    production_credits integer DEFAULT 0 NOT NULL,
    production_credits_random integer DEFAULT 0 NOT NULL,
    mod_research_effectiveness real DEFAULT 0 NOT NULL,
    energy_receive_antennas smallint DEFAULT 0 NOT NULL,
    energy_send_antennas smallint DEFAULT 0 NOT NULL,
    construction_time_exp_per_building real DEFAULT 1 NOT NULL,
    storage_energy integer DEFAULT 0 NOT NULL,
    buildable boolean DEFAULT false NOT NULL,
    lifetime integer DEFAULT 0 NOT NULL,
    active_when_destroying boolean DEFAULT false NOT NULL,
    upkeep integer DEFAULT 0 NOT NULL,
    cost_energy integer DEFAULT 0 NOT NULL,
    use_planet_production_pct boolean DEFAULT true NOT NULL,
    production_exp_per_building real,
    consumption_exp_per_building real,
    vortex_strength integer DEFAULT 0 NOT NULL,
    production_prestige integer DEFAULT 0 NOT NULL,
    cost_prestige integer DEFAULT 0 NOT NULL,
    mod_planet_need_ore real DEFAULT 0 NOT NULL,
    mod_planet_need_hydrocarbon real DEFAULT 0 NOT NULL,
    bonus_planet_need_ore integer DEFAULT 0 NOT NULL,
    bonus_planet_need_hydrocarbon integer DEFAULT 0 NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    invasion_defense integer DEFAULT 0 NOT NULL,
    parked_ships_capacity integer DEFAULT 0 NOT NULL
);


ALTER TABLE static.db_buildings OWNER TO exileng;

--
-- Name: COLUMN db_buildings.is_planet_element; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.is_planet_element IS 'True if it is an element of the planet that can''t be removed like mountains, ancient artifact, ..';


--
-- Name: COLUMN db_buildings.maintenance_factor; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.maintenance_factor IS 'Factor by which to multiply the number of workers needed for the maintenance of this building';


--
-- Name: COLUMN db_buildings.production_credits; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.production_credits IS 'Some buildings may produce credits directly';


--
-- Name: COLUMN db_buildings.production_credits_random; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.production_credits_random IS 'Some building may produce a random amount of credits (from 0 to the given value) every week';


--
-- Name: COLUMN db_buildings.lifetime; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.lifetime IS 'Duration of the building once it is built or deployed';


--
-- Name: COLUMN db_buildings.active_when_destroying; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_buildings.active_when_destroying IS 'Whether the building still function while being destroyed, it can be useful for deployed buildings with a lifetime';


--
-- Name: db_ships_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_ships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_ships_id_seq OWNER TO exileng;

--
-- Name: db_ships; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_ships (
    id integer DEFAULT nextval('static.db_ships_id_seq'::regclass) NOT NULL,
    category smallint DEFAULT 1,
    name character varying(32) NOT NULL,
    label character varying(64) DEFAULT 'label'::character varying NOT NULL,
    description text DEFAULT 'description'::text NOT NULL,
    cost_ore integer DEFAULT 0 NOT NULL,
    cost_hydrocarbon integer DEFAULT 0 NOT NULL,
    cost_credits integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    crew smallint DEFAULT 10 NOT NULL,
    capacity integer DEFAULT 1 NOT NULL,
    construction_time integer DEFAULT 180 NOT NULL,
    maximum smallint DEFAULT 0 NOT NULL,
    hull integer DEFAULT 100 NOT NULL,
    shield integer DEFAULT 0 NOT NULL,
    weapon_power smallint DEFAULT 0 NOT NULL,
    weapon_ammo smallint DEFAULT 0 NOT NULL,
    weapon_tracking_speed smallint DEFAULT 0 NOT NULL,
    weapon_turrets smallint DEFAULT 0 NOT NULL,
    signature smallint DEFAULT 0 NOT NULL,
    speed integer DEFAULT 1000 NOT NULL,
    handling smallint DEFAULT 10 NOT NULL,
    buildingid integer,
    recycler_output integer DEFAULT 0 NOT NULL,
    droppods smallint DEFAULT 0 NOT NULL,
    long_distance_capacity smallint DEFAULT 0 NOT NULL,
    buildable boolean DEFAULT false NOT NULL,
    required_shipid integer,
    new_shipid integer,
    mod_speed real DEFAULT 0 NOT NULL,
    mod_shield real DEFAULT 0 NOT NULL,
    mod_handling real DEFAULT 0 NOT NULL,
    mod_tracking_speed real DEFAULT 0 NOT NULL,
    mod_damage real DEFAULT 0 NOT NULL,
    mod_signature real DEFAULT 0 NOT NULL,
    mod_recycling real DEFAULT 0 NOT NULL,
    protection integer DEFAULT 0 NOT NULL,
    upkeep integer DEFAULT 0 NOT NULL,
    cost_energy integer DEFAULT 0 NOT NULL,
    weapon_dmg_em smallint DEFAULT 0 NOT NULL,
    weapon_dmg_explosive smallint DEFAULT 0 NOT NULL,
    weapon_dmg_kinetic smallint DEFAULT 0 NOT NULL,
    weapon_dmg_thermal smallint DEFAULT 0 NOT NULL,
    resist_em smallint DEFAULT 0 NOT NULL,
    resist_explosive smallint DEFAULT 0 NOT NULL,
    resist_kinetic smallint DEFAULT 0 NOT NULL,
    resist_thermal smallint DEFAULT 0 NOT NULL,
    tech smallint DEFAULT 0 NOT NULL,
    prestige_reward integer DEFAULT 0 NOT NULL,
    credits_reward integer DEFAULT 0 NOT NULL,
    cost_prestige integer DEFAULT 0 NOT NULL,
    built_per_batch integer DEFAULT 1 NOT NULL,
    bounty integer DEFAULT 0 NOT NULL,
    required_vortex_strength integer DEFAULT 0 NOT NULL,
    leadership integer DEFAULT 0 NOT NULL,
    can_be_parked boolean DEFAULT true NOT NULL,
    required_jump_capacity integer DEFAULT 1 NOT NULL
);


ALTER TABLE static.db_ships OWNER TO exileng;

--
-- Name: COLUMN db_ships.crew; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.crew IS 'Number of workers that will be taken to serve on board the ship';


--
-- Name: COLUMN db_ships.weapon_power; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.weapon_power IS 'Damanges dealt by each hit';


--
-- Name: COLUMN db_ships.weapon_ammo; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.weapon_ammo IS 'number of times a ship fires per round';


--
-- Name: COLUMN db_ships.weapon_tracking_speed; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.weapon_tracking_speed IS 'tracking speed gives a bonus for ships with bad handling';


--
-- Name: COLUMN db_ships.weapon_turrets; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.weapon_turrets IS 'number of turrets on the ship';


--
-- Name: COLUMN db_ships.handling; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.handling IS 'A ship with a better handling is harder to hit/target';


--
-- Name: COLUMN db_ships.recycler_output; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.recycler_output IS 'Quantity of resources this ship can recycle every 10 minutes';


--
-- Name: COLUMN db_ships.required_shipid; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.required_shipid IS 'Base ship required to build this new ship (to do upgrade of ships)';


--
-- Name: COLUMN db_ships.new_shipid; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.new_shipid IS 'Final shipid built, null by default. It can be an id of an other ship in case we want to create an upgrade of a ship to another one';


--
-- Name: COLUMN db_ships.mod_signature; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_ships.mod_signature IS 'Modify the whole fleet signature';


--
-- Name: _sp_account_create(character varying, character varying, character varying, integer, inet); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_account_create(_name character varying, _password character varying, _email character varying, _lcid integer, _address inet) RETURNS integer
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

		INSERT INTO users(id, login, password, email, lcid, regaddress)

		VALUES(userid, $1, sp_account_password($2), $3, $4, $5);

		RETURN userid;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN NULL;

	END;

	-- check if the error comes from a duplicated login

	PERFORM 1 FROM users WHERE upper(login)=upper($1) LIMIT 1;

	IF FOUND THEN

		RETURN -1;

	END IF;

	-- check if the error comes from a duplicated email

	PERFORM 1 FROM users WHERE upper(email)=upper($3) LIMIT 1;

	IF FOUND THEN

		RETURN -2;

	END IF;

	-- check if the error comes from a duplicated registration address

	PERFORM 1 FROM users WHERE regaddress=$5 LIMIT 1;

	IF FOUND THEN

		RETURN -3;

	END IF;

	RETURN -4;

END;$_$;


ALTER FUNCTION static._sp_account_create(_name character varying, _password character varying, _email character varying, _lcid integer, _address inet) OWNER TO exileng;

--
-- Name: FUNCTION _sp_account_create(_name character varying, _password character varying, _email character varying, _lcid integer, _address inet); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static._sp_account_create(_name character varying, _password character varying, _email character varying, _lcid integer, _address inet) IS 'Create a new user and return the userid :

-1 - duplicated login

-2 - duplicated email

-3 - duplicated registration address

-4 - unexpected error';


--
-- Name: _sp_account_password(character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_account_password(character varying) RETURNS character varying
    LANGUAGE sql
    AS $_$SELECT MD5('seed' || MD5($1));$_$;


ALTER FUNCTION static._sp_account_password(character varying) OWNER TO exileng;

--
-- Name: FUNCTION _sp_account_password(character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static._sp_account_password(character varying) IS 'Return the password hash of given parameter';


--
-- Name: _sp_alliance_accept_nap(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_alliance_accept_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_user record;

	fromaid int4;

	offer record;

	c bigint;

BEGIN

	-- find the alliance id of the user and check if he can accept NAPs for his alliance

	SELECT INTO r_user

		alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to accept the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO fromaid id

	FROM alliances

	WHERE upper(tag) = upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- check if there is a NAP request from "fromaid" to "aid" and retrieve the guarantees

	SELECT INTO offer guarantee, guarantee_asked

	FROM alliances_naps_offers

	WHERE allianceid=fromaid AND targetallianceid=r_user.alliance_id AND NOT declined;

	IF NOT FOUND THEN

		-- no requests issued from the named alliance $2

		RETURN 3;

	END IF;

	-- check number of naps

	SELECT INTO c count(*)

	FROM alliances_naps

	WHERE allianceid1=r_user.alliance_id;

	IF c >= 10 THEN

		RETURN 4;

	END IF;

	SELECT INTO c count(*)

	FROM alliances_naps

	WHERE allianceid2=fromaid;

	IF c >= 10 THEN

		RETURN 4;

	END IF;

	INSERT INTO alliances_naps(allianceid1, allianceid2, guarantee)

	VALUES(r_user.alliance_id, fromaid, offer.guarantee_asked);

	INSERT INTO alliances_naps(allianceid1, allianceid2, guarantee)

	VALUES(fromaid, r_user.alliance_id, offer.guarantee);

	DELETE FROM alliances_naps_offers

	WHERE allianceid=fromaid AND targetallianceid=r_user.alliance_id;

	RETURN 0;

END;$_$;


ALTER FUNCTION static._sp_alliance_accept_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: _sp_alliance_break_nap(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_alliance_break_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can break NAPs for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_break_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to break the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- retrieve the credits put in guarantee for this NAP

	SELECT INTO aguarantee guarantee

	FROM alliances_naps

	WHERE allianceid1=aid AND allianceid2=targetaid LIMIT 1;

	IF NOT FOUND THEN

		-- no NAPs found

		RETURN 3;

	END IF;

	--RAISE NOTICE '%',aguarantee;

	BEGIN

		UPDATE alliances SET

			credits = credits - aguarantee

		WHERE id=aid;

		UPDATE alliances SET

			credits = credits + aguarantee

		WHERE id=targetaid;

		INSERT INTO alliances_wallet_journal(allianceid, credits, destination, type)

		VALUES(aid, -aguarantee, (SELECT name FROM alliances WHERE id=targetaid), 10);

		INSERT INTO alliances_wallet_journal(allianceid, credits, source, type)

		VALUES(targetaid, aguarantee, (SELECT name FROM alliances WHERE id=aid), 11);

	EXCEPTION

		-- check violation in case not enough credits

		WHEN CHECK_VIOLATION THEN

			RETURN 4;

	END;

	DELETE FROM alliances_naps

	WHERE (allianceid1=aid AND allianceid2=targetaid) or (allianceid1=targetaid AND allianceid2=aid);

	RETURN 0;

END;$$;


ALTER FUNCTION static._sp_alliance_break_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: _sp_alliance_invite(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_alliance_invite() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(1000);$$;


ALTER FUNCTION static._sp_alliance_invite() OWNER TO exileng;

--
-- Name: _sp_clean_fleets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_clean_fleets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_fleet record;

BEGIN

	FOR r_fleet IN

		SELECT id

		FROM fleets

		WHERE planetid is null AND dest_planetid is null AND idle_since < now() - INTERVAL '1 week' AND action = 0

		LIMIT 150

	LOOP

		DELETE FROM fleets WHERE id=r_fleet.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static._sp_clean_fleets() OWNER TO exileng;

--
-- Name: _sp_test(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static._sp_test() RETURNS integer
    LANGUAGE plpgsql
    AS $$BEGIN

	BEGIN

		UPDATE users SET credits = credits WHERE id < 10;

		RAISE EXCEPTION '__dummy_restore_state__';

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			IF SQLERRM = '__dummy_restore_state__' THEN 

				RETURN -2;

			END IF;

	END;

END;$$;


ALTER FUNCTION static._sp_test() OWNER TO exileng;

--
-- Name: admin_add_ship(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_add_ship(integer, integer, integer) RETURNS void
    LANGUAGE sql
    AS $_$update planet_ships SET quantity=quantity+$3 WHERE planetid=$1 AND shipid=$2;$_$;


ALTER FUNCTION static.admin_add_ship(integer, integer, integer) OWNER TO exileng;

--
-- Name: admin_add_vortexes(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_add_vortexes(_galaxyid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	i int4;

	vortexes int4;

	r_planet record;

BEGIN

	vortexes := 0;

	SELECT INTO r_planet id, galaxy, sector, planet

	FROM nav_planet

	WHERE galaxy=_galaxyid AND sector > 11 AND sector < 30 AND sector%10 <> 0 AND sector%10 <> 1 AND floor=0 AND spawn_ore = 0 AND spawn_hydrocarbon = 0

	ORDER BY random()

	LIMIT 1;

	INSERT INTO planet_buildings(planetid, buildingid, quantity)

	VALUES(r_planet.id, 89, 1);

	RAISE NOTICE 'vortex at: %,%,%', r_planet.galaxy, r_planet.sector, r_planet.planet;

	vortexes := 1;

	IF random() > 0.40 THEN

		SELECT INTO r_planet id, galaxy, sector, planet

		FROM nav_planet

		WHERE galaxy=_galaxyid AND sector > 31 AND sector < 50 AND sector%10 <> 0 AND sector%10 <> 1 AND floor=0 AND spawn_ore = 0 AND spawn_hydrocarbon = 0 AND NOT EXISTS(SELECT 1 FROM nav_planet n WHERE galaxy=_galaxyid AND vortex_strength > 0 AND sp_travel_distance(nav_planet.sector, nav_planet.planet, n.sector, n.planet) < 8 LIMIT 1)

		ORDER BY random()

		LIMIT 1;		

		IF FOUND THEN

			INSERT INTO planet_buildings(planetid, buildingid, quantity)

			VALUES(r_planet.id, 89, 1);

			RAISE NOTICE 'vortex at: %,%,%', r_planet.galaxy, r_planet.sector, r_planet.planet;

			vortexes := 2;

		END IF;

	END IF;

	IF random() > 0.70 THEN

		SELECT INTO r_planet id, galaxy, sector, planet

		FROM nav_planet

		WHERE galaxy=_galaxyid AND sector > 51 AND sector < 90 AND sector%10 <> 0 AND sector%10 <> 1 AND floor=0 AND spawn_ore = 0 AND spawn_hydrocarbon = 0 AND NOT EXISTS(SELECT 1 FROM nav_planet n WHERE galaxy=_galaxyid AND vortex_strength > 0 AND sp_travel_distance(nav_planet.sector, nav_planet.planet, n.sector, n.planet) < 8 LIMIT 1)

		ORDER BY random()

		LIMIT 1;		

		IF FOUND THEN

			INSERT INTO planet_buildings(planetid, buildingid, quantity)

			VALUES(r_planet.id, 89, 1);

			RAISE NOTICE 'vortex at: %,%,%', r_planet.galaxy, r_planet.sector, r_planet.planet;

			vortexes := 3;

		END IF;

	END IF;

	IF vortexes < 2 OR random() > 0.5 THEN

		SELECT INTO r_planet id, galaxy, sector, planet

		FROM nav_planet

		WHERE galaxy=_galaxyid AND sector > 71 AND sector < 90 AND sector%10 <> 0 AND sector%10 <> 1 AND floor=0 AND spawn_ore = 0 AND spawn_hydrocarbon = 0 AND NOT EXISTS(SELECT 1 FROM nav_planet n WHERE galaxy=_galaxyid AND vortex_strength > 0 AND sp_travel_distance(nav_planet.sector, nav_planet.planet, n.sector, n.planet) < 8 LIMIT 1)

		ORDER BY random()

		LIMIT 1;		

		IF FOUND THEN

			INSERT INTO planet_buildings(planetid, buildingid, quantity)

			VALUES(r_planet.id, 89, 1);

			RAISE NOTICE 'vortex at: %,%,%', r_planet.galaxy, r_planet.sector, r_planet.planet;

			vortexes := vortexes + 1;

		END IF;		

	END IF;

	RETURN vortexes;

END;$$;


ALTER FUNCTION static.admin_add_vortexes(_galaxyid integer) OWNER TO exileng;

--
-- Name: admin_check1(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_check1(integer) RETURNS void
    LANGUAGE sql
    AS $_$INSERT INTO researches(userid, researchid, level)

SELECT $1, id, defaultlevel FROM db_research WHERE defaultlevel > 0 AND NOT EXISTS(SELECT 1 FROM researches WHERE userid=$1 AND researchid=db_research.id);

SELECT sp_update_researches($1);

update users set id=id where id = -1000;$_$;


ALTER FUNCTION static.admin_check1(integer) OWNER TO exileng;

--
-- Name: admin_copy_fleet(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_copy_fleet(integer, integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Copy a fleet to somewhere else belonging to someone else

-- Param1: FleetId

-- Param2: NewOwner

-- Param3: PlanetId

DECLARE

	fleet_id int4;

BEGIN

	fleet_id := nextval('fleets_id_seq');

	INSERT INTO fleets(id, ownerid, planetid, name) SELECT fleet_id, $2, $3, name FROM fleets WHERE id=$1;

	INSERT INTO fleets_ships(fleetid, shipid, quantity) SELECT fleet_id, shipid, quantity FROM fleets_ships WHERE fleetid=$1;

	RETURN;

END;$_$;


ALTER FUNCTION static.admin_copy_fleet(integer, integer, integer) OWNER TO exileng;

--
-- Name: admin_create_big_galaxies(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_big_galaxies(_fromgalaxy integer, _togalaxy integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	g int4; 

	s int4;

	p int4;

	fl int2;

	sp int2;

	-- abundance of ore, hydrocarbon

	pore int2;

	phydrocarbon int2;

	t int2;

	planettype int2;

	i int4;

	specialplanets int2[];

	sectorvalue float;

	sectorplanets int2;

	sectorfloor int4;

	sectorspace int4;

	galaxyplanets int4;

	planet_id int4;

BEGIN

	FOR g IN _fromgalaxy.._togalaxy LOOP

		RAISE NOTICE 'Populating galaxy %', g;

		INSERT INTO nav_galaxies(id, visible) VALUES(g, false);

		galaxyplanets := 0;

		FOR s IN 0..99 LOOP

			sectorvalue := (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2)))*20;

			sectorplanets := 25;

			FOR i IN 1..10 LOOP specialplanets[i] := int2(200*random()); END LOOP;

			FOR p IN 0..99 LOOP

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						sectorplanets := sectorplanets - 1;

						EXIT;

					END IF;

				END LOOP;

			END LOOP;

			--IF s=45 OR s=46 OR s=55 OR s=56 THEN sectorplanets := sectorplanets - 1; END IF;

			--RAISE NOTICE 'Sector % : %,%', s, sectorvalue, sectorplanets;

			sectorvalue := sectorvalue*25/sectorplanets;

			FOR p IN 0..99 LOOP

				planettype := 1; -- normal planet

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						planettype := int2(100*random());

						IF planettype < 92 THEN

							planettype := 0;	-- empty space

						ELSEIF planettype <= 98 THEN

							planettype := 3;	-- asteroid with auto-spawn of ore in orbit

						ELSE

							planettype := 4;	-- star with auto-spawn of hydrocarbon in orbit

						END IF;						

						-- no spawning resources near the center of galaxies

						IF (planettype = 3 OR planettype = 4) AND (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2))) > 4.5 THEN

							planettype := 1;

						END IF;

						EXIT;

					END IF;

				END LOOP;

				-- reserve these planets to put merchants on them

				IF p = 13 AND (s=23 OR s=28 OR s=73 OR s=78) THEN

					planettype := 1;

				END IF;

				-- planet in the very center of a galaxy are always empty

				IF (s=45 AND p=25) OR (s=46 AND p=21) OR (s=55 AND p=5) OR (s=56 AND p=1) THEN planettype := 0; END IF;

				-- floor/space and random ore/hydrocarbon abundancy

				IF s <= 10 OR s >= 90 OR s % 10 = 0 OR s % 10 = 1 THEN

					IF planettype = 3 OR planettype = 4 THEN

						planettype := 0;	-- empty space

					END IF;

					fl := 80;

					sp := 10;

					pore := 60;

					phydrocarbon := 60;

				ELSE

					fl := int2((sectorvalue*2/3) + random()*sectorvalue/3);

					WHILE fl < 80 LOOP

						fl := fl + 4;

					END LOOP;

					WHILE fl > 155 LOOP

						fl := fl - 4;

					END LOOP;

					IF fl < 90 THEN

						sp := int2(20+random()*20);

					ELSEIF fl < 100 THEN

						sp := int2(15+random()*20);

					ELSE

						sp := int2(10+random()*15);

					END IF;

					t := int2(80+random()*100 + sectorvalue / 5);

					IF fl > 70 AND fl < 85 THEN

						t := (t * 1.3)::integer;

					END IF;

					pore := int2(LEAST(35+random()*(t-47), t));

					phydrocarbon := t - pore;

					IF random() > 0.6 THEN

						t := phydrocarbon;

						phydrocarbon := pore;

						pore := t;

					END IF;

				END IF;

				planet_id := g*100*100 + s*100 + p;

				IF planettype = 0 THEN	-- empty space

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES(planet_id, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0);

				ELSEIF planettype = 1 THEN	-- normal planet

					galaxyplanets := galaxyplanets + 1;

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES(planet_id, g, s, p, fl, sp, fl, sp, pore, phydrocarbon, pore, phydrocarbon);

					IF fl > 120 AND random() < 0.01 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES(planet_id, 96, 1);

					END IF;

					IF fl > 65 AND random() < 0.001 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES(planet_id, 90, 1);

					END IF;

				ELSEIF planettype = 3 THEN	-- spawn ore

					IF s = 34 OR s = 35 OR s = 36 OR s = 37 OR s = 44 OR s = 47 OR s = 54 OR s = 57 OR s = 64 OR s = 65 OR s = 66 OR s = 67 THEN

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES(planet_id, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 22000+5000*random(), 0);

					ELSE

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES(planet_id, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 13000+4000*random(), 0);

					END IF;

				ELSE	-- spawn hydrocarbon

					IF s = 34 OR s = 35 OR s = 36 OR s = 37 OR s = 44 OR s = 47 OR s = 54 OR s = 57 OR s = 64 OR s = 65 OR s = 66 OR s = 67 THEN

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES(planet_id, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22000+5000*random());

					ELSE

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES(planet_id, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13000+4000*random());

					END IF;

				END IF;

				IF s % 10 = 0 OR s % 10 = 1 OR s <= 10 OR s > 90 THEN

					UPDATE nav_planet SET

						min_security_level=1

					WHERE id=planet_id;

				ELSEIF s % 10 = 2 OR s % 10 = 9 OR s <= 20 OR s > 80 THEN

					UPDATE nav_planet SET

						min_security_level=2

					WHERE id=planet_id;

				END IF;

			END LOOP;

		END LOOP;

		RAISE NOTICE 'Galaxy %, planets: %', g, galaxyplanets;

		RAISE NOTICE 'creating merchant planets';

/*

		s := int2(1+49*random());

		PERFORM sp_admin_create_merchants(galaxy, sector, planet) FROM nav_planet WHERE galaxy=g AND sector=s;

		s := int2(51+48*random());

		PERFORM sp_admin_create_merchants(galaxy, sector, planet) FROM nav_planet WHERE galaxy=g AND sector=s;

*/

/*

		PERFORM admin_create_merchants(g, 23, 13);

		PERFORM admin_create_merchants(g, 28, 13);

		PERFORM admin_create_merchants(g, 73, 13);

		PERFORM admin_create_merchants(g, 78, 13);

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 1) FROM nav_planet WHERE galaxy=g AND planet_floor > 95 AND planet_floor <= 120 AND ownerid IS NULL;

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 2) FROM nav_planet WHERE galaxy=g AND planet_floor > 120 AND ownerid IS NULL;

		UPDATE fleets SET attackonsight=true WHERE ownerid=1 AND NOT attackonsight;

*/

		UPDATE nav_galaxies SET

			planets=(SELECT count(*) FROM nav_planet WHERE galaxy=g AND planet_floor > 0),

			protected_until = null

		WHERE id=g;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.admin_create_big_galaxies(_fromgalaxy integer, _togalaxy integer) OWNER TO exileng;

--
-- Name: FUNCTION admin_create_big_galaxies(_fromgalaxy integer, _togalaxy integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.admin_create_big_galaxies(_fromgalaxy integer, _togalaxy integer) IS 'Initialization function - create planets in given galaxies';


--
-- Name: admin_create_deploy_ship(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_deploy_ship(_shipid integer, _buildingid integer) RETURNS void
    LANGUAGE sql
    AS $_$INSERT INTO db_ships(id, category, buildingid, name, label, description, cost_ore, cost_hydrocarbon, cost_credits, crew, construction_time, signature, speed, handling, buildable, capacity)

SELECT $1, 10, id, 'd_' || name, 'D: ' || label, 'desc', 5000+cost_ore, 2600+cost_hydrocarbon, 200, 2, 9600+construction_time, (5000+cost_ore+2600+cost_hydrocarbon) * 2 / 1000, 350, 1, true, 0

FROM db_buildings

where id=$2$_$;


ALTER FUNCTION static.admin_create_deploy_ship(_shipid integer, _buildingid integer) OWNER TO exileng;

--
-- Name: admin_create_galaxies(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_galaxies(_fromgalaxy integer, _togalaxy integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	g int4; 

	s int4;

	p int4;

	fl int2;

	sp int2;

	-- abundance of ore, hydrocarbon

	pore int2;

	phydrocarbon int2;

	t int2;

	planettype int2;

	i int4;

	specialplanets int2[];

	sectorvalue float;

	sectorplanets int2;

	sectorfloor int4;

	sectorspace int4;

	galaxyplanets int4;

BEGIN

	FOR g IN _fromgalaxy.._togalaxy LOOP

		RAISE NOTICE 'Populating galaxy %', g;

		INSERT INTO nav_galaxies(id, visible) VALUES(g,true);

		galaxyplanets := 0;

		FOR s IN 1..99 LOOP

			sectorvalue := (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2)))*20;

			sectorplanets := 25;

			FOR i IN 1..10 LOOP specialplanets[i] := int2(50*random()); END LOOP;

			FOR p IN 1..25 LOOP

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						sectorplanets := sectorplanets - 1;

						EXIT;

					END IF;

				END LOOP;

			END LOOP;

			IF s=45 OR s=46 OR s=55 OR s=56 THEN sectorplanets := sectorplanets - 1; END IF;

			--RAISE NOTICE 'Sector % : %,%', s, sectorvalue, sectorplanets;

			sectorvalue := sectorvalue*25/sectorplanets;

			FOR p IN 1..25 LOOP

				planettype := 1; -- normal planet

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						planettype := int2(100*random());

						IF planettype < 92 THEN

							planettype := 0;	-- empty space

						ELSEIF planettype <= 98 THEN

							planettype := 3;	-- asteroid with auto-spawn of ore in orbit

						ELSE

							planettype := 4;	-- star with auto-spawn of hydrocarbon in orbit

						END IF;						

						-- no spawning resources near the center of galaxies

						IF (planettype = 3 OR planettype = 4) AND (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2))) > 4.5 THEN

							planettype := 1;

						END IF;

						EXIT;

					END IF;

				END LOOP;

				-- reserve these planets to put merchants on them

				IF p = 13 AND (s=23 OR s=28 OR s=73 OR s=78) THEN

					planettype := 1;

				END IF;

				-- planet in the very center of a galaxy are always empty

				IF (s=45 AND p=25) OR (s=46 AND p=21) OR (s=55 AND p=5) OR (s=56 AND p=1) THEN planettype := 0; END IF;

				-- floor/space and random ore/hydrocarbon abundancy

				IF s <= 10 OR s >= 90 OR s % 10 = 0 OR s % 10 = 1 THEN

					IF planettype = 3 OR planettype = 4 THEN

						planettype := 0;	-- empty space

					END IF;

					fl := 80;

					sp := 10;

					pore := 60;

					phydrocarbon := 60;

				ELSE

					fl := int2((sectorvalue*2/3) + random()*sectorvalue/3);

					WHILE fl < 80 LOOP

						fl := fl + 4;

					END LOOP;

					WHILE fl > 155 LOOP

						fl := fl - 4;

					END LOOP;

					IF fl < 90 THEN

						sp := int2(20+random()*20);

					ELSEIF fl < 100 THEN

						sp := int2(15+random()*20);

					ELSE

						sp := int2(10+random()*15);

					END IF;

					t := int2(80+random()*100 + sectorvalue / 5);

					IF fl > 70 AND fl < 85 THEN

						t := (t * 1.3)::integer;

					END IF;

					pore := int2(LEAST(35+random()*(t-47), t));

					phydrocarbon := t - pore;

					IF random() > 0.6 THEN

						t := phydrocarbon;

						phydrocarbon := pore;

						pore := t;

					END IF;

				END IF;

				IF planettype = 0 THEN	-- empty space

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0);

				ELSEIF planettype = 1 THEN	-- normal planet

					galaxyplanets := galaxyplanets + 1;

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, fl, sp, fl, sp, pore, phydrocarbon, pore, phydrocarbon);

					IF fl > 120 AND random() < 0.01 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 96, 1);

					END IF;

					IF fl > 65 AND random() < 0.001 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 90, 1);

					END IF;

				ELSEIF planettype = 3 THEN	-- spawn ore

					IF s = 34 OR s = 35 OR s = 36 OR s = 37 OR s = 44 OR s = 47 OR s = 54 OR s = 57 OR s = 64 OR s = 65 OR s = 66 OR s = 67 THEN

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 22000+5000*random(), 0);

					ELSE

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 13000+4000*random(), 0);

					END IF;

				ELSE	-- spawn hydrocarbon

					IF s = 34 OR s = 35 OR s = 36 OR s = 37 OR s = 44 OR s = 47 OR s = 54 OR s = 57 OR s = 64 OR s = 65 OR s = 66 OR s = 67 THEN

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22000+5000*random());

					ELSE

						INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

						VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13000+4000*random());

					END IF;

				END IF;

				IF s % 10 = 0 OR s % 10 = 1 OR s <= 10 OR s > 90 THEN

					UPDATE nav_planet SET

						min_security_level=1

					WHERE id=(g-1)*25*99 + (s-1)*25 + p;

				ELSEIF s % 10 = 2 OR s % 10 = 9 OR s <= 20 OR s > 80 THEN

					UPDATE nav_planet SET

						min_security_level=2

					WHERE id=(g-1)*25*99 + (s-1)*25 + p;

				END IF;

			END LOOP;

		END LOOP;

		RAISE NOTICE 'Galaxy %, planets: %', g, galaxyplanets;

		RAISE NOTICE 'creating merchant planets';

/*

		s := int2(1+49*random());

		PERFORM sp_admin_create_merchants(galaxy, sector, planet) FROM nav_planet WHERE galaxy=g AND sector=s;

		s := int2(51+48*random());

		PERFORM sp_admin_create_merchants(galaxy, sector, planet) FROM nav_planet WHERE galaxy=g AND sector=s;

*/

		PERFORM admin_create_merchants(g, 23, 13);

		PERFORM admin_create_merchants(g, 28, 13);

		PERFORM admin_create_merchants(g, 73, 13);

		PERFORM admin_create_merchants(g, 78, 13);

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 1) FROM nav_planet WHERE galaxy=g AND planet_floor > 95 AND planet_floor <= 120 AND ownerid IS NULL;

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 2) FROM nav_planet WHERE galaxy=g AND planet_floor > 120 AND ownerid IS NULL;

		UPDATE fleets SET attackonsight=true WHERE ownerid=1 AND NOT attackonsight;

		UPDATE nav_galaxies SET

			planets=(SELECT count(*) FROM nav_planet WHERE galaxy=g AND planet_floor > 0),

			protected_until = null

		WHERE id=g;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.admin_create_galaxies(_fromgalaxy integer, _togalaxy integer) OWNER TO exileng;

--
-- Name: FUNCTION admin_create_galaxies(_fromgalaxy integer, _togalaxy integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.admin_create_galaxies(_fromgalaxy integer, _togalaxy integer) IS 'Initialization function - create planets in given galaxies';


--
-- Name: admin_create_galaxies2(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_galaxies2(_fromgalaxy integer, _togalaxy integer) RETURNS void
    LANGUAGE plpgsql
    AS $$-- create a galaxy without market

DECLARE

	g int4; 

	s int4;

	p int4;

	fl int2;

	sp int2;

	-- abundance of ore, hydrocarbon

	pore int2;

	phydrocarbon int2;

	t int2;

	planettype int2;

	i int4;

	specialplanets int2[];

	sectorvalue float;

	sectorplanets int2;

	sectorfloor int4;

	sectorspace int4;

	galaxyplanets int4;

BEGIN

	FOR g IN _fromgalaxy.._togalaxy LOOP

		RAISE NOTICE 'Populating galaxy %', g;

		INSERT INTO nav_galaxies(id, visible, has_merchants, allow_new_players) VALUES(g, true, false, false);

		galaxyplanets := 0;

		FOR s IN 1..99 LOOP

			--sectorvalue := (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2)))*20;

			sectorvalue := 130 - 3*LEAST(sp_travel_distance(s, 13, 23, 13), sp_travel_distance(s, 13, 28, 13), sp_travel_distance(s, 13, 73, 13), sp_travel_distance(s, 13, 78, 13));

			sectorplanets := 25;

			FOR i IN 1..10 LOOP specialplanets[i] := int2(30*random()); END LOOP;

			FOR p IN 1..25 LOOP

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						sectorplanets := sectorplanets - 1;

						EXIT;

					END IF;

				END LOOP;

			END LOOP;

			IF s=45 OR s=46 OR s=55 OR s=56 THEN sectorplanets := sectorplanets - 1; END IF;

			--RAISE NOTICE 'Sector % : %,%', s, sectorvalue, sectorplanets;

			sectorvalue := sectorvalue*25/sectorplanets;

			FOR p IN 1..25 LOOP

				planettype := 1; -- normal planet

				FOR i IN 1..10 LOOP

					IF specialplanets[i] = p THEN

						planettype := int2(100*random());

						IF planettype < 98 THEN

							planettype := 0;	-- empty space

						ELSEIF random() < 0.5 THEN

							planettype := 3;	-- asteroid with auto-spawn of ore in orbit

						ELSE

							planettype := 4;	-- star with auto-spawn of hydrocarbon in orbit

						END IF;						

/*

						-- no spawning resources near the center of galaxies

						IF (planettype = 3 OR planettype = 4) AND (6-0.55*sqrt(power(5.5-(s%10), 2) + power(5.5-(s/10 + 1), 2))) > 4.5 THEN

							planettype := 1;

						END IF;*/

						EXIT;

					END IF;

				END LOOP;

				-- reserve these planets to put merchants on them

				IF p = 13 AND (s=23 OR s=28 OR s=73 OR s=78) THEN

					planettype := 1;

				END IF;

				-- planet in the very center of a galaxy are always empty

				IF (s=45 AND p=25) OR (s=46 AND p=21) OR (s=55 AND p=5) OR (s=56 AND p=1) THEN planettype := 0; END IF;

				-- floor/space and random ore/hydrocarbon abundancy

				fl := int2(1.1*((sectorvalue*2/3) + random()*sectorvalue/3));

				WHILE fl > 200 LOOP

					fl := fl - 4;

				END LOOP;

				IF fl < 90 THEN

					sp := int2(20+random()*20);

				ELSEIF fl < 100 THEN

					sp := int2(15+random()*20);

				ELSE

					sp := int2(10+random()*15);

				END IF;

				t := int2(80+random()*100 + sectorvalue / 5);

				pore := int2(LEAST(35+random()*(t-47), t));

				phydrocarbon := t - pore;

				IF random() > 0.6 THEN

					t := phydrocarbon;

					phydrocarbon := pore;

					pore := t;

				END IF;

				IF planettype = 0 THEN	-- empty space

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0);

				ELSEIF planettype = 1 THEN	-- normal planet

					galaxyplanets := galaxyplanets + 1;

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, fl, sp, fl, sp, pore, phydrocarbon, pore, phydrocarbon);

					IF fl > 170 AND random() < 0.5 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 95, 1);

					END IF;

					IF fl > 120 AND random() < 0.05 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 96, 1);

					END IF;

					IF fl > 65 AND random() < 0.02 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 94, 1);

					END IF;

					IF fl > 65 AND random() < 0.01 THEN

						INSERT INTO planet_buildings(planetid, buildingid, quantity)

						VALUES((g-1)*25*99 + (s-1)*25 + p, 90, 1);

					END IF;

				ELSEIF planettype = 3 THEN	-- spawn ore

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 42000+10000*random(), 0);

				ELSE	-- spawn hydrocarbon

					INSERT INTO nav_planet(id, galaxy, sector, planet, planet_floor, planet_space, floor, space, planet_pct_ore, planet_pct_hydrocarbon, pct_ore, pct_hydrocarbon, spawn_ore, spawn_hydrocarbon)

					VALUES((g-1)*25*99 + (s-1)*25 + p, g, s, p, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42000+10000*random());

				END IF;

			END LOOP;

		END LOOP;

		RAISE NOTICE 'creating pirates';

/*

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 6) FROM nav_planet WHERE galaxy=g AND planet_floor >= 95 AND planet_floor < 140 AND ownerid IS NULL;

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 7) FROM nav_planet WHERE galaxy=g AND planet_floor >= 140 AND planet_floor < 180 AND ownerid IS NULL;

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 8) FROM nav_planet WHERE galaxy=g AND planet_floor >= 180 AND ownerid IS NULL;

		PERFORM admin_generate_fleet(1, 'Les fossoyeurs', id, null, 5) FROM nav_planet WHERE galaxy=g AND planet_floor = 0 AND ownerid IS NULL;

		UPDATE fleets SET attackonsight=true WHERE ownerid=1 AND NOT attackonsight;

*/

		UPDATE nav_galaxies SET

			planets=(SELECT count(*) FROM nav_planet WHERE galaxy=g AND planet_floor > 0),

			protected_until = now()

		WHERE id=g;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.admin_create_galaxies2(_fromgalaxy integer, _togalaxy integer) OWNER TO exileng;

--
-- Name: admin_create_merchants(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_merchants(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

	pid int4;

BEGIN

	pid := sp_planet($1,$2,$3);

	UPDATE nav_planet SET ownerid=3 WHERE id=pid AND ownerid IS NULL;

	IF NOT FOUND THEN

		RETURN 0;

	END IF;

	INSERT INTO planet_buildings(planetid, buildingid) VALUES(pid, 1001);

	INSERT INTO planet_buildings(planetid, buildingid) VALUES(pid, 1020);

	INSERT INTO planet_buildings(planetid, buildingid) VALUES(pid, 1021);

	UPDATE nav_planet SET workers=100000, mod_production_workers=0, recruit_workers=false WHERE id=pid;

	RETURN pid;

END;$_$;


ALTER FUNCTION static.admin_create_merchants(integer, integer, integer) OWNER TO exileng;

--
-- Name: admin_create_new_galaxy(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_create_new_galaxy() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	newgalaxy int2;

BEGIN

	SELECT INTO newgalaxy

		COALESCE(MAX(id),0)+1

	FROM nav_galaxies;

	PERFORM admin_create_galaxies(newgalaxy, newgalaxy);

	RETURN;

END;$$;


ALTER FUNCTION static.admin_create_new_galaxy() OWNER TO exileng;

--
-- Name: FUNCTION admin_create_new_galaxy(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.admin_create_new_galaxy() IS 'Initialization function - create planets in a new galaxy';


--
-- Name: admin_generate_fleet(integer, character varying, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_generate_fleet(integer, character varying, integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: OwnerId

-- Param2: Fleet Name

-- Param3: PlanetId (Null if unknown)

-- Param4: DestPlanetId (Null if no movement)

-- Param5: FleetSize (0=small, 4=big with invasion fleets)

DECLARE

	fleet_id int4;

BEGIN

	IF $3 IS NULL AND $4 IS NULL THEN

		RETURN -1;

	END IF;

	IF ($5 < 0 OR $5 > 15) AND ($5 <> 99) THEN

		RETURN -1;

	END IF;

	fleet_id := nextval('fleets_id_seq');

	INSERT INTO fleets(id, ownerid, planetid, name, idle_since, speed)

	VALUES(fleet_id, $1, $3, $2, now(), 800);

	IF $5 = 0 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 20+int4(random()*20));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 10+int4(random()*10));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 10+int4(random()*10));

	END IF;

	IF $5 = 1 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 20+int4(random()*20));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 80+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 50+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 20+int4(random()*20));

	END IF;

	IF $5 = 2 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 100+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 100+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 60+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 100+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 30+int4(random()*30));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 30+int4(random()*30));

		/* UPDATE fleets SET

			cargo_workers=5000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 3 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 100+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 100+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 200+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 50+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 150+int4(random()*100));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 200+int4(random()*100));

		/* UPDATE fleets SET

			cargo_workers=20000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 4 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 200+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 200+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 404, 500+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 300+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 504, 500+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 105, 30+int4(random()*40));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 106, int4(random()*300));

		/* UPDATE fleets SET

			cargo_soldiers=50000,

			cargo_workers=50000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 5 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 200+int4(random()*2000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 200+int4(random()*2000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 200+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 200+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 200+int4(random()*600));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 200+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 200+int4(random()*800));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 404, 500+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 300+int4(random()*800));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 504, 500+int4(random()*700));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 105, 30+int4(random()*70));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 106, int4(random()*300));

		/* UPDATE fleets SET

			cargo_soldiers=50000,

			cargo_workers=50000

		WHERE id=fleet_id; */

	END IF;

	-- 200k

	IF $5 = 6 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 200+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 200+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 200+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 404, 500+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 300+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 504, 500+int4(random()*300));

		/* UPDATE fleets SET

			cargo_soldiers=50000,

			cargo_workers=50000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 7 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 1200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 1200+int4(random()*1000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 300+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 300+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 300+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 300+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 400+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 404, 700+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 500+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 504, 1000+int4(random()*300));

		/* UPDATE fleets SET

			cargo_soldiers=50000,

			cargo_workers=50000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 8 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 5200+int4(random()*2000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 5200+int4(random()*2000));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 301, 800+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 302, 800+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 304, 1200+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 401, 1000+int4(random()*300));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 402, 600+int4(random()*200));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 404, 1000+int4(random()*500));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 501, 1200+int4(random()*800));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 504, 2000+int4(random()*1000));

		/* UPDATE fleets SET

			cargo_soldiers=50000,

			cargo_workers=50000

		WHERE id=fleet_id; */

	END IF;

	-- cargo fleets

	IF $5 = 10 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 50+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 50+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 102, 10+int4(random()*10));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 103, 10+int4(random()*10));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 121, 5+int4(random()*10));

		/* UPDATE fleets SET

			cargo_ore=100000,

			cargo_hydrocarbon=100000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 11 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 80+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 80+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 102, 30+int4(random()*30));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 103, 30+int4(random()*30));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 121, 5+int4(random()*10));

		/* UPDATE fleets SET

			cargo_ore=200000,

			cargo_hydrocarbon=200000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 12 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 201, 80+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 202, 80+int4(random()*50));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 102, 60+int4(random()*40));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 103, 100+int4(random()*60));

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 121, 10+int4(random()*20));

		/* UPDATE fleets SET

			cargo_ore=300000,

			cargo_hydrocarbon=300000

		WHERE id=fleet_id; */

	END IF;

	IF $5 = 13 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 950, 5);

	END IF;

	-- fleet with a probe

	IF $5 = 15 THEN

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 100, 1);

	END IF;

	IF $4 IS NOT NULL THEN

		UPDATE fleets SET

			dest_planetid = $4,

			action_start_time = now(),

			action_end_time = now() + (64800 * 1000.0/speed) * INTERVAL '1 second',

			engaged = false,

			action = 1,

			idle_since = null

		WHERE id=fleet_id;

	END IF;

	RETURN fleet_id;

END;$_$;


ALTER FUNCTION static.admin_generate_fleet(integer, character varying, integer, integer, integer) OWNER TO exileng;

--
-- Name: admin_give_money(character varying, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_give_money(character varying, integer) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE users SET credits=credits+$2 WHERE login=$1;$_$;


ALTER FUNCTION static.admin_give_money(character varying, integer) OWNER TO exileng;

--
-- Name: admin_init(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_init() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	PERFORM setval('users_id_seq', 1000);

	PERFORM sp_admin_populate_planets(1,20);

END;$$;


ALTER FUNCTION static.admin_init() OWNER TO exileng;

--
-- Name: admin_init_starting_planets(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_init_starting_planets(_galaxy_id integer) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE nav_planet SET

	planet_floor=70,

	floor=70,

	planet_space=20,

	space=20,

	pct_ore=60,

	planet_pct_ore=60,

	pct_hydrocarbon=60,

	planet_pct_hydrocarbon=60

WHERE ownerid IS NULL AND (galaxy = $1) AND (planet % 2 = 0) AND

	(sector % 10 = 0 OR sector % 10 = 1 OR sector <= 10 OR sector > 90) AND

	planet_floor > 0 AND planet_space > 0;$_$;


ALTER FUNCTION static.admin_init_starting_planets(_galaxy_id integer) OWNER TO exileng;

--
-- Name: admin_move_fleets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_move_fleets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r record;

	p record;

BEGIN

	FOR r IN

		SELECT id, ownerid

		FROM fleets

		WHERE ownerid=1

	LOOP

		SELECT INTO p galaxy, sector, planet from nav_planet n INNER JOIN users u ON u.id=n.ownerid ORDER BY score_global DESC OFFSET int4(random()*300) LIMIT 1;

		PERFORM sp_move_fleet(r.ownerid, r.id, int4(p.galaxy), int4(p.sector), int4(p.planet));

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.admin_move_fleets() OWNER TO exileng;

--
-- Name: admin_populate_evilbunnies(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_populate_evilbunnies() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	INSERT INTO fleets(ownerid, planetid, name, uid)

	SELECT 1, id, 'Les fossoyeurs', nextval('npc_fleet_uid_seq'::text) FROM nav_planet WHERE floor > 112 AND ownerid IS NULL;

	RAISE NOTICE 'Fleets inserted';

	INSERT INTO fleets_ships(fleetid, shipid, quantity)

	SELECT id, 301, int4(random()*30) FROM fleets WHERE ownerid=1;

	RAISE NOTICE 'Corvettes inserted';

	INSERT INTO fleets_ships(fleetid, shipid, quantity)

	SELECT id, 304, int4(random()*10) FROM fleets WHERE ownerid=1;

	RAISE NOTICE 'Multigun Corvettes inserted';

	INSERT INTO fleets_ships(fleetid, shipid, quantity)

	SELECT id, 401, int4(random()*30) FROM fleets WHERE ownerid=1;

	RAISE NOTICE 'Frigates inserted';

	RETURN;

END;$$;


ALTER FUNCTION static.admin_populate_evilbunnies() OWNER TO exileng;

--
-- Name: admin_populate_users(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_populate_users() RETURNS void
    LANGUAGE sql
    AS $$INSERT INTO users(id, login, password, email, lastlogin, privilege) VALUES(1, 'Les fossoyeurs', '9sd8fDe587r53Z', 'evilbunnies@exile.fr', now()+INTERVAL '100 years', -10);

INSERT INTO users(id, login, password, email, lastlogin, privilege) VALUES(2, 'Nation oubliÃƒÂ©e', '9sd8fDe587r53Z', 'lostnation@exile.fr', now()+INTERVAL '100 years', -10);

INSERT INTO users(id, login, password, email, lastlogin, privilege) VALUES(3, 'Guilde marchande', '9sd8fDe587r53Z', 'merchants@exile.fr', now()+INTERVAL '100 years', -10);

DELETE FROM commanders WHERE ownerid <= 3;

UPDATE nav_planet SET ownerid=null WHERE ownerid <= 3;

$$;


ALTER FUNCTION static.admin_populate_users() OWNER TO exileng;

--
-- Name: FUNCTION admin_populate_users(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.admin_populate_users() IS 'Add the default users like the enemy, the lost nation and the merchants';


--
-- Name: admin_reduce_floor(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_reduce_floor(integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: PlanetId

-- Param2: Size of floor to remove

DECLARE

	owner int4;

BEGIN

	UPDATE nav_planet SET

		planet_floor = planet_floor-$2

	WHERE id=$1;

	PERFORM sp_update_planet($1);

	SELECT INTO owner ownerid FROM nav_planet WHERE id=$1;

	INSERT INTO reports(ownerid, type, subtype, planetid)

	VALUES(owner, 7, 90, $1);

END;$_$;


ALTER FUNCTION static.admin_reduce_floor(integer, integer) OWNER TO exileng;

--
-- Name: admin_reinit_planets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_reinit_planets() RETURNS void
    LANGUAGE sql
    AS $$delete from nav_galaxies;

delete from nav_planet;

select sp_admin_populate_planets(1,2);

update nav_planet set ownerid=5 where id=1;$$;


ALTER FUNCTION static.admin_reinit_planets() OWNER TO exileng;

--
-- Name: admin_reset_commanders(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_reset_commanders() RETURNS void
    LANGUAGE sql
    AS $$UPDATE commanders SET

			mod_production_ore=0,

			mod_production_hydrocarbon=0,

			mod_production_workers=0,

			mod_fleet_speed=0,

			mod_fleet_shield=0,

			mod_fleet_handling=0,

			mod_fleet_tracking_speed=0,

			mod_fleet_damage=0,

			mod_construction_speed_buildings=0,

			mod_construction_speed_ships=0,

			points=10;

SELECT sp_update_planet(id) from nav_planet where commanderid is not null;

SELECT sp_update_fleet(id) from fleets where commanderid is not null;

-- stupid update command (that does nothing) so that the function returns void

UPDATE commanders SET points=points WHERE points <> points;$$;


ALTER FUNCTION static.admin_reset_commanders() OWNER TO exileng;

--
-- Name: admin_restore_backup(timestamp without time zone); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_restore_backup(timestamp without time zone) RETURNS void
    LANGUAGE sql
    AS $_$UPDATE fleets SET

	action_start_time=action_start_time+(now()-$1),

	action_end_time=action_end_time+(now()-$1);

UPDATE nav_planet SET

	production_lastupdate=production_lastupdate+(now()-$1),

	last_catastrophe=last_catastrophe+(now()-$1);

UPDATE market_sales SET

	sale_time=sale_time+(now()-$1)$_$;


ALTER FUNCTION static.admin_restore_backup(timestamp without time zone) OWNER TO exileng;

--
-- Name: FUNCTION admin_restore_backup(timestamp without time zone); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.admin_restore_backup(timestamp without time zone) IS 'After a database restore, call this function with the timestamp of the backup';


--
-- Name: admin_resynch_ships_kills(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_resynch_ships_kills() RETURNS void
    LANGUAGE sql
    AS $$UPDATE users_ships_kills SET killed=0;

UPDATE users SET victory_marks=0;

INSERT INTO users_ships_kills(userid, shipid, killed, lost)

SELECT owner_id, destroyed_shipid, sum(count), 0

FROM battles_fleets_ships_kills

	INNER JOIN battles_fleets ON (battles_fleets.id = battles_fleets_ships_kills.fleetid)

WHERE owner_id IN (SELECT id FROM users)

GROUP BY owner_id, destroyed_shipid

ORDER by owner_id;$$;


ALTER FUNCTION static.admin_resynch_ships_kills() OWNER TO exileng;

--
-- Name: admin_switch_planets(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_switch_planets(_planet1 integer, _planet2 integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet1 record;

	r_planet2 record;

BEGIN

	PERFORM 1 FROM fleets WHERE dest_planetid=_planet1 LIMIT 1;

	IF FOUND THEN

		RETURN 'a fleet going to first planet';

	END IF;

	PERFORM 1 FROM fleets WHERE dest_planetid=_planet2 LIMIT 1;

	IF FOUND THEN

		RETURN 'a fleet going to second planet';

	END IF;

	SELECT INTO r_planet1 galaxy, sector, planet FROM nav_planet WHERE id=_planet1;

	IF NOT FOUND THEN

		RETURN 'first planet not found';

	END IF;

	SELECT INTO r_planet2 galaxy, sector, planet FROM nav_planet WHERE id=_planet2;

	IF NOT FOUND THEN

		RETURN 'second planet not found';

	END IF;

	UPDATE nav_planet SET id=0, galaxy=1, sector=0, planet=0 WHERE id=_planet2;

	UPDATE nav_planet SET id=_planet2, galaxy=r_planet2.galaxy, sector=r_planet2.sector, planet=r_planet2.planet WHERE id=_planet1;

	UPDATE nav_planet SET id=_planet1, galaxy=r_planet1.galaxy, sector=r_planet1.sector, planet=r_planet1.planet WHERE id=0;

	RETURN 'done';

END;$$;


ALTER FUNCTION static.admin_switch_planets(_planet1 integer, _planet2 integer) OWNER TO exileng;

--
-- Name: admin_test(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_test(integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_event record;

BEGIN

	FOR r_event IN

		SELECT *

		FROM events

		WHERE last_runtime+run_every < now()

	LOOP

		BEGIN

			EXECUTE 'SELECT ' || r_event.procedure;

			UPDATE events SET last_runtime = now(), last_result=null WHERE procedure = r_event.procedure;

		EXCEPTION

			WHEN OTHERS THEN

				UPDATE events SET last_result=SQLERRM WHERE procedure = r_event.procedure;

		END;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.admin_test(integer) OWNER TO exileng;

--
-- Name: admin_test_routes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.admin_test_routes() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	fleet_id int4;

	route_id int8;

BEGIN

	-- create the fleet

	fleet_id := nextval('public.fleets_id_seq');

	INSERT INTO fleets(id, uid, ownerid, name, planetid, action)

	VALUES(fleet_id, nextval('public.npc_fleet_uid_seq'), 5, 'Sonde', sp_planet(30,55,6), 0);

	--fleet_id := sp_create_fleet(5, sp_planet(30,55,11), 'sonde');

	--INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 99, 1);

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 105, 1);

	UPDATE fleets SET speed=100000,cargo_soldiers=100 WHERE id=fleet_id;

	-- create route

	route_id := sp_create_route(5, 'route_' || fleet_id);

/*

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, sp_planet(30,55,13));

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

	INSERT INTO routes_waypoints(routeid, "action", ore, hydrocarbon, soldiers)

	VALUES(route_id, 0, 1000, 1000, 10000);

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

*/

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, sp_planet(30,55,11));

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, sp_planet(30,55,12));

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, sp_planet(30,55,13));

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, sp_planet(30,55,14));

	INSERT INTO routes_waypoints(routeid, "action", waittime)

	VALUES(route_id, 4, 10);

	UPDATE fleets SET

		next_waypointid=(SELECT Min(id) FROM routes_waypoints WHERE routeid=route_id)

	WHERE id=fleet_id;

	PERFORM sp_routes_continue(5, fleet_id); 

END;$$;


ALTER FUNCTION static.admin_test_routes() OWNER TO exileng;

--
-- Name: const_alliance_max_simultaneous_leaves(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_alliance_max_simultaneous_leaves() RETURNS smallint
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int2(3);$$;


ALTER FUNCTION static.const_alliance_max_simultaneous_leaves() OWNER TO exileng;

--
-- Name: const_coef_score_to_war(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_coef_score_to_war() RETURNS double precision
    LANGUAGE sql
    AS $$SELECT 0.08::double precision;$$;


ALTER FUNCTION static.const_coef_score_to_war() OWNER TO exileng;

--
-- Name: const_cost_per_war(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_cost_per_war() RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int4(1000000);$$;


ALTER FUNCTION static.const_cost_per_war() OWNER TO exileng;

--
-- Name: const_enabled_holidays(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_enabled_holidays() RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $$SELECT true;$$;


ALTER FUNCTION static.const_enabled_holidays() OWNER TO exileng;

--
-- Name: const_enabled_retries(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_enabled_retries() RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $$SELECT true;$$;


ALTER FUNCTION static.const_enabled_retries() OWNER TO exileng;

--
-- Name: const_galaxy_days_protection(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_galaxy_days_protection() RETURNS integer
    LANGUAGE sql
    AS $$SELECT int4(60);$$;


ALTER FUNCTION static.const_galaxy_days_protection() OWNER TO exileng;

--
-- Name: const_galaxy_x(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_galaxy_x(_galaxyid integer) RETURNS smallint
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int2(10);$$;


ALTER FUNCTION static.const_galaxy_x(_galaxyid integer) OWNER TO exileng;

--
-- Name: const_galaxy_y(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_galaxy_y(_galaxyid integer) RETURNS smallint
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int2(10);$$;


ALTER FUNCTION static.const_galaxy_y(_galaxyid integer) OWNER TO exileng;

--
-- Name: const_game_speed(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_game_speed() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(1.0);$$;


ALTER FUNCTION static.const_game_speed() OWNER TO exileng;

--
-- Name: const_hours_before_bankruptcy(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_hours_before_bankruptcy() RETURNS smallint
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int2(168);$$;


ALTER FUNCTION static.const_hours_before_bankruptcy() OWNER TO exileng;

--
-- Name: const_interval_alliance_leave(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_alliance_leave() RETURNS interval
    LANGUAGE sql
    AS $$SELECT INTERVAL '24 hours';$$;


ALTER FUNCTION static.const_interval_alliance_leave() OWNER TO exileng;

--
-- Name: const_interval_before_can_fight(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_before_can_fight() RETURNS interval
    LANGUAGE sql
    AS $$SELECT INTERVAL '24 hours';$$;


ALTER FUNCTION static.const_interval_before_can_fight() OWNER TO exileng;

--
-- Name: const_interval_before_commander_promotion(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_before_commander_promotion() RETURNS interval
    LANGUAGE sql IMMUTABLE
    AS $$SELECT INTERVAL '2 weeks'$$;


ALTER FUNCTION static.const_interval_before_commander_promotion() OWNER TO exileng;

--
-- Name: const_interval_before_invasion(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_before_invasion() RETURNS interval
    LANGUAGE sql IMMUTABLE
    AS $$SELECT INTERVAL '5 minutes';$$;


ALTER FUNCTION static.const_interval_before_invasion() OWNER TO exileng;

--
-- Name: const_interval_before_join_new_alliance(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_before_join_new_alliance() RETURNS interval
    LANGUAGE sql IMMUTABLE
    AS $$SELECT INTERVAL '8 hours';$$;


ALTER FUNCTION static.const_interval_before_join_new_alliance() OWNER TO exileng;

--
-- Name: const_interval_before_plunder(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_before_plunder() RETURNS interval
    LANGUAGE sql IMMUTABLE
    AS $$SELECT INTERVAL '0 seconds'$$;


ALTER FUNCTION static.const_interval_before_plunder() OWNER TO exileng;

--
-- Name: const_interval_galaxy_protection(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_interval_galaxy_protection() RETURNS interval
    LANGUAGE sql
    AS $$SELECT INTERVAL '3 month';$$;


ALTER FUNCTION static.const_interval_galaxy_protection() OWNER TO exileng;

--
-- Name: const_planet_market_stock_max(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_planet_market_stock_max() RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int4(90000000);$$;


ALTER FUNCTION static.const_planet_market_stock_max() OWNER TO exileng;

--
-- Name: const_planet_market_stock_min(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_planet_market_stock_min() RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $$SELECT int4(-35000000);$$;


ALTER FUNCTION static.const_planet_market_stock_min() OWNER TO exileng;

--
-- Name: const_recycle_hydrocarbon(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_recycle_hydrocarbon(_userid integer) RETURNS real
    LANGUAGE plpgsql STABLE
    AS $$DECLARE

	res float4;

BEGIN

	SELECT INTO res 0.40+mod_recycling/100.0 FROM users WHERE id=_userid;

	IF res IS NULL THEN

		RETURN 0.40;

	ELSE

		RETURN res;

	END IF;

END;$$;


ALTER FUNCTION static.const_recycle_hydrocarbon(_userid integer) OWNER TO exileng;

--
-- Name: const_recycle_ore(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_recycle_ore(_userid integer) RETURNS real
    LANGUAGE plpgsql STABLE
    AS $$DECLARE

	res float4;

BEGIN

	SELECT INTO res 0.45+mod_recycling/100.0 FROM users WHERE id=_userid;

	IF res IS NULL THEN

		RETURN 0.45;

	ELSE

		RETURN res;

	END IF;

END;$$;


ALTER FUNCTION static.const_recycle_ore(_userid integer) OWNER TO exileng;

--
-- Name: const_seconds_before_invasion(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_seconds_before_invasion() RETURNS integer
    LANGUAGE sql
    AS $$SELECT int4(2*60*60);	--2 hours$$;


ALTER FUNCTION static.const_seconds_before_invasion() OWNER TO exileng;

--
-- Name: FUNCTION const_seconds_before_invasion(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.const_seconds_before_invasion() IS 'Time in seconds before being able to invade a planet';


--
-- Name: const_ship_recycling_multiplier(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_ship_recycling_multiplier() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT 0.05::real;$$;


ALTER FUNCTION static.const_ship_recycling_multiplier() OWNER TO exileng;

--
-- Name: const_upkeep_commanders(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_commanders() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(1);$$;


ALTER FUNCTION static.const_upkeep_commanders() OWNER TO exileng;

--
-- Name: const_upkeep_planets(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_planets(integer) RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT float4(860 + 40*GREATEST(0,$1) + 80*GREATEST(0,$1-5) + 120*GREATEST(0,$1-10) + 188*GREATEST(0,$1-15));$_$;


ALTER FUNCTION static.const_upkeep_planets(integer) OWNER TO exileng;

--
-- Name: const_upkeep_scientists(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_scientists() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(2);$$;


ALTER FUNCTION static.const_upkeep_scientists() OWNER TO exileng;

--
-- Name: const_upkeep_ships(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_ships() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(1);$$;


ALTER FUNCTION static.const_upkeep_ships() OWNER TO exileng;

--
-- Name: const_upkeep_ships_in_position(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_ships_in_position() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(4);$$;


ALTER FUNCTION static.const_upkeep_ships_in_position() OWNER TO exileng;

--
-- Name: const_upkeep_ships_parked(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_ships_parked() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(0.8);$$;


ALTER FUNCTION static.const_upkeep_ships_parked() OWNER TO exileng;

--
-- Name: const_upkeep_soldiers(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_upkeep_soldiers() RETURNS real
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float4(1);$$;


ALTER FUNCTION static.const_upkeep_soldiers() OWNER TO exileng;

--
-- Name: const_value_crew(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_crew() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(0.1);$$;


ALTER FUNCTION static.const_value_crew() OWNER TO exileng;

--
-- Name: const_value_hydrocarbon(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_hydrocarbon() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(1.0);$$;


ALTER FUNCTION static.const_value_hydrocarbon() OWNER TO exileng;

--
-- Name: const_value_ore(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_ore() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(1.0);$$;


ALTER FUNCTION static.const_value_ore() OWNER TO exileng;

--
-- Name: const_value_scientists(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_scientists() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(60);$$;


ALTER FUNCTION static.const_value_scientists() OWNER TO exileng;

--
-- Name: FUNCTION const_value_scientists(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.const_value_scientists() IS 'Value of a scientist';


--
-- Name: const_value_soldiers(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_soldiers() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(50);$$;


ALTER FUNCTION static.const_value_soldiers() OWNER TO exileng;

--
-- Name: const_value_workers(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.const_value_workers() RETURNS double precision
    LANGUAGE sql IMMUTABLE
    AS $$SELECT float8(0.01);$$;


ALTER FUNCTION static.const_value_workers() OWNER TO exileng;

--
-- Name: notifications_chat_messages(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.notifications_chat_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- notifications_chat_messages

BEGIN

	PERFORM sp_player_addnotification(chat_users.userid, 'chat:say', '{channelid:' || NEW.channelid || ',tag:' || sp__quote(sp_alliance_get_tag(NEW.allianceid)) || ',name:' || sp__quote(NEW.name) || ',action:' || NEW.action || ',parameter:' || sp__quote(NEW.parameter) || '}')

	FROM chat_users

		INNER JOIN sessions ON (chat_users.userid = sessions.userid)

	WHERE channelid = NEW.channelid;

	RETURN null; -- result ignored as it is an after trigger

END;$$;


ALTER FUNCTION static.notifications_chat_messages() OWNER TO exileng;

--
-- Name: notifications_chat_users(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.notifications_chat_users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- notifications_chat_users

BEGIN

	IF (TG_OP = 'DELETE') THEN

		PERFORM sp_player_addnotification(chat_users.userid, 'chat:leave', '{name:' || sp__quote(sp_player_get_name(OLD.userid)) || ',channelid:' || OLD.channelid || '}')

		FROM chat_users

			INNER JOIN sessions ON (chat_users.userid = sessions.userid)

		WHERE chat_users.channelid = OLD.channelid AND chat_users.userid <> OLD.userid;

	ELSEIF (TG_OP = 'INSERT') THEN

		PERFORM sp_player_addnotification(chat_users.userid, 'chat:join', '{tag:' || sp__quote(sp_player_get_tag(NEW.userid)) || ',name:' || sp__quote(sp_player_get_name(NEW.userid)) || ',channelid:' || NEW.channelid || ',rights:' || NEW.rights || '}')

		FROM chat_users

			INNER JOIN sessions ON (chat_users.userid = sessions.userid)

		WHERE chat_users.channelid = NEW.channelid AND chat_users.userid <> NEW.userid;

	END IF;

	RETURN null; -- result ignored as it is an after trigger

END;$$;


ALTER FUNCTION static.notifications_chat_users() OWNER TO exileng;

--
-- Name: FUNCTION notifications_chat_users(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.notifications_chat_users() IS 'Add a notification to users in the channel when a user joins/leaves';


--
-- Name: notifications_messages(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.notifications_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- sp_messages_notifications

BEGIN

	IF NEW.ownerid IS NULL THEN

		RETURN NULL;

	END IF;

	IF sp_session_isalive(NEW.ownerid) THEN

		PERFORM sp_player_addnotification(NEW.ownerid, 'mails:new', '{}');

	END IF;

	RETURN NULL; -- result ignored as it is an after trigger

END;$$;


ALTER FUNCTION static.notifications_messages() OWNER TO exileng;

--
-- Name: notifications_reports(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.notifications_reports() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- sp_reports_notifications

BEGIN

	IF NEW.ownerid IS NULL THEN

		RETURN NULL;

	END IF;

	IF sp_session_isalive(NEW.ownerid) THEN

		PERFORM sp_player_addnotification(NEW.ownerid, 'reports:new', '{category:' || NEW.type || '}');

	END IF;

	RETURN NULL; -- result ignored as it is an after trigger

END;$$;


ALTER FUNCTION static.notifications_reports() OWNER TO exileng;

--
-- Name: sp___out(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp___out(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$BEGIN

	RAISE NOTICE '%',$1;

	RETURN $1;

END;$_$;


ALTER FUNCTION static.sp___out(integer) OWNER TO exileng;

--
-- Name: sp__atoi(inet); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp__atoi(inet) RETURNS bigint
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT sp__atoi(host($1));$_$;


ALTER FUNCTION static.sp__atoi(inet) OWNER TO exileng;

--
-- Name: sp__atoi(character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp__atoi(character varying) RETURNS bigint
    LANGUAGE plpgsql IMMUTABLE
    AS $_$DECLARE

	res int8;

BEGIN

	SELECT INTO res ((int8(split_part($1,'.',1))*256+int8(split_part($1,'.',2)))*256+int8(split_part($1,'.',3)))*256+int8(split_part($1,'.',4));

	RETURN res;

EXCEPTION

	WHEN DATA_EXCEPTION THEN

		RETURN 0;

END;$_$;


ALTER FUNCTION static.sp__atoi(character varying) OWNER TO exileng;

--
-- Name: sp__itoa(bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp__itoa(bigint) RETURNS character varying
    LANGUAGE sql
    AS $_$SELECT ($1 / (256*256*256) || '.' || ($1 / (256*256)) % 256 || '.' || ($1 / (256)) % 256 || '.' || $1 % 256)::varchar;$_$;


ALTER FUNCTION static.sp__itoa(bigint) OWNER TO exileng;

--
-- Name: sp__quote(character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp__quote(_value character varying) RETURNS character varying
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT COALESCE('"' || $1 || '"', '""');$_$;


ALTER FUNCTION static.sp__quote(_value character varying) OWNER TO exileng;

--
-- Name: sp__utcdate(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp__utcdate() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT 'UTCDate(' || int8(date_part('epoch', now())*1000) || ')';$$;


ALTER FUNCTION static.sp__utcdate() OWNER TO exileng;

--
-- Name: sp_abandon_fleet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_abandon_fleet(_userid integer, _fleetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_fleet record;

	r_ships record;

	r_user record;

BEGIN

	-- retrieve info on the fleet if it is not moving and not engaged in battle

	-- get planetid, cargo_ore and cargo_hydrocarbon

	SELECT INTO r_fleet

		planetid, cargo_ore, cargo_hydrocarbon

	FROM fleets 

	WHERE id=_fleetid AND ownerid=_userid AND action=0 AND NOT engaged;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve total ore/hydrocarbon used for building the ships

	SELECT INTO r_ships

		sum(quantity*cost_ore) AS ore,

		sum(quantity*cost_hydrocarbon) AS hydrocarbon

	FROM fleets_ships

		INNER JOIN db_ships ON (id=shipid)

	WHERE fleetid=_fleetid;

	-- retrieve user recycling effectiveness

	SELECT INTO r_user

		mod_recycling

	FROM users

	WHERE id=_userid;

	IF NOT FOUND THEN

		RETURN 2;	-- user not found ?

	END IF;

	DELETE FROM fleets WHERE id=_fleetid AND ownerid=_userid;

	-- put ore/hydrocarbon into orbit

	UPDATE nav_planet SET

		orbit_ore = orbit_ore + r_ships.ore*((0.15+0.10*random()) + r_user.mod_recycling/100.0) + r_fleet.cargo_ore,

		orbit_hydrocarbon = orbit_hydrocarbon + r_ships.hydrocarbon*((0.15+0.10*random()) + r_user.mod_recycling/100.0) + r_fleet.cargo_hydrocarbon

	WHERE id=r_fleet.planetid;

	INSERT INTO users_expenses(userid, credits_delta, fleetid)

	VALUES(_userid, 999999, $2);

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_abandon_fleet(_userid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_abandon_planet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_abandon_planet(_userid integer, _planetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$BEGIN

	RETURN sp_abandon_planet(_userid, _planetid, true);

END;$$;


ALTER FUNCTION static.sp_abandon_planet(_userid integer, _planetid integer) OWNER TO exileng;

--
-- Name: sp_abandon_planet(integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_abandon_planet(_userid integer, _planetid integer, _report boolean) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: PlanetId

-- Param3: whether a report is added to player reports

DECLARE

	c int4;

	r_planet record;

	successful boolean;

BEGIN

	SELECT INTO c

		count(*)

	FROM nav_planet

	WHERE ownerid=$1;

	IF NOT FOUND OR c <= 1 THEN

		-- allow to abandon last planet if an enemy fleet is orbiting the planet

		PERFORM 1

		FROM fleets

		WHERE ((planetid=$2 AND action <> -1 AND action <> 1) OR dest_planetid=$2) AND firepower > 0 AND NOT EXISTS(SELECT 1 FROM vw_friends WHERE userid=$1 AND friend=fleets.ownerid);

		-- if no enemy fleet is found, do not allow to abandon the planet

		IF NOT FOUND THEN

			RETURN 1;

		END IF;

	END IF;

	PERFORM 1

	FROM reports

	WHERE planetid=$2 AND type=2 AND SUBTYPE=13 AND invasionid > 0 AND datetime > now()-INTERVAL '1 day';

	IF FOUND THEN

		-- if there was an invasion recently, do not reset number of workers/soldiers

		UPDATE nav_planet SET

			production_lastupdate=now(),

			ownerid=2,

			recruit_workers=true

		WHERE ownerid=$1 AND id=$2/* AND score >= 80000 AND random() > 0.6*/;

	ELSE

		UPDATE nav_planet SET

			workers=GREATEST(workers, workers_capacity / 2),

			soldiers=GREATEST(soldiers, soldiers_capacity / 5),

			production_lastupdate=now(),

			ownerid=2,

			recruit_workers=true

		WHERE ownerid=$1 AND id=$2/* AND score >= 80000 AND random() > 0.6*/;

	END IF;

	successful := FOUND;

	SELECT INTO r_planet

		id, ownerid, galaxy, sector, planet

	FROM nav_planet

	WHERE id=_planetid;

/*

	IF NOT successful THEN

		PERFORM sp_clear_planet($2);

		IF _report THEN

			INSERT INTO reports(ownerid, type, subtype, planetid, data)

			VALUES(_userid, 6, 1, _planetid, '{planet:{owner:' || sp__quote(COALESCE(sp_get_user(_userid), '')) || ',g:' || r_planet.galaxy || ',s:' || r_planet.sector  || ',p:' || r_planet.planet || '}}');

		END IF;

	ELSE*/

		IF _report THEN

			INSERT INTO reports(ownerid, type, subtype, planetid, data)

			VALUES(_userid, 6, 2, _planetid, '{planet:{owner:' || sp__quote(COALESCE(sp_get_user(_userid), '')) || ',g:' || r_planet.galaxy || ',s:' || r_planet.sector  || ',p:' || r_planet.planet || '}}');

		END IF;

	--END IF;

	UPDATE nav_planet SET

		mood=mood-20

	WHERE ownerid=_userid;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_abandon_planet(_userid integer, _planetid integer, _report boolean) OWNER TO exileng;

--
-- Name: sp_account_connect(integer, integer, inet, character varying, character varying, bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_account_connect(_userid integer, _lcid integer, _address inet, _forwarded character varying, _browser character varying, _browserid bigint) RETURNS SETOF static.connectinfo
    LANGUAGE plpgsql
    AS $_$-- connect to a user

--  param1: userid

--  param2: connection LCID

--  param3: connection address

DECLARE

	result static.connectinfo;

	r_users record;

	t timestamp;

	other_userid int4;

	connection_id int8;

BEGIN

	SELECT INTO r_users

	*

	FROM users

	WHERE id=_userid

	LIMIT 1;

	IF FOUND THEN

		r_users.password := '';

		t := now();

		UPDATE users_connections SET

			disconnected = LEAST(t, r_users.lastactivity+INTERVAL '1 minutes')

		WHERE userid=r_users.id AND disconnected IS NULL;

		-- update lastlogin column

		UPDATE users SET lastlogin=t, lastactivity=t WHERE id=r_users.id AND privilege <> -1;

		r_users.lastlogin := t;

		r_users.lastactivity := t;

	ELSE

		-- create the user

		INSERT INTO users(id, lcid, regaddress)

		VALUES(_userid, _lcid, _address);

		-- return user row

		SELECT INTO r_users

		*

		FROM users

		WHERE id=_userid

		LIMIT 1;

	END IF;

	result.id = r_users.id;

	result.privilege = r_users.privilege;

	result.lastplanetid = r_users.lastplanetid;

	result.resets = r_users.resets;

	RETURN NEXT result;

	connection_id := nextval('users_connections_id_seq');

	-- save clients address/brower info

	INSERT INTO users_connections(id, userid, address, forwarded_address, browser, browserid)

	VALUES(connection_id, r_users.id, sp__atoi(_address), substr(_forwarded, 1, 64), substr(_browser, 1, 128), _browserid);

	-- add multiaccount warnings

	IF r_users.privilege = 0 THEN

		INSERT INTO log_multi_account_warnings(id, withid)

			SELECT DISTINCT ON (userid) connection_id, id

			FROM users_connections

			WHERE datetime > now()-INTERVAL '30 minutes' AND address=sp__atoi($3) AND userid <> _userid;

	END IF;

END;$_$;


ALTER FUNCTION static.sp_account_connect(_userid integer, _lcid integer, _address inet, _forwarded character varying, _browser character varying, _browserid bigint) OWNER TO exileng;

--
-- Name: sp_add_battle_fleet(integer, integer, integer, integer, integer, integer, integer, boolean, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_add_battle_fleet(_battleid integer, _ownerid integer, _fleetid integer, _mod_shield integer, _mod_handling integer, _mod_tracking_speed integer, _mod_damage integer, _attackonsight boolean, _won boolean) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	_battle_fleet_id int8;

	r_user record;

BEGIN

	_battle_fleet_id := nextval('battles_fleets_id_seq');

	SELECT INTO r_user login, (SELECT tag FROM alliances WHERE id=users.alliance_id) AS alliancetag FROM users WHERE id=_ownerid;

	INSERT INTO battles_fleets(id, battleid, alliancetag, owner_id, owner_name, fleet_id, fleet_name, mod_shield, mod_handling, mod_tracking_speed, mod_damage, attackonsight, won)

	VALUES(_battle_fleet_id, _battleid, r_user.alliancetag, _ownerid, r_user.login, _fleetid, (SELECT name FROM fleets WHERE id=_fleetid), 

		_mod_shield, _mod_handling, _mod_tracking_speed, _mod_damage,

		_attackonsight, _won);

	RETURN _battle_fleet_id;

END;$$;


ALTER FUNCTION static.sp_add_battle_fleet(_battleid integer, _ownerid integer, _fleetid integer, _mod_shield integer, _mod_handling integer, _mod_tracking_speed integer, _mod_damage integer, _attackonsight boolean, _won boolean) OWNER TO exileng;

--
-- Name: sp_add_battle_result(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, bigint, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_add_battle_result(_battleid integer, _ownerid integer, _fleetid integer, _shipid integer, _mod_shield integer, _mod_handling integer, _mod_tracking_speed integer, _mod_damage integer, _attackonsight integer, _before integer, _after integer, _killed integer, _damages bigint, _won integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	fleetid int8;

BEGIN

END;$$;


ALTER FUNCTION static.sp_add_battle_result(_battleid integer, _ownerid integer, _fleetid integer, _shipid integer, _mod_shield integer, _mod_handling integer, _mod_tracking_speed integer, _mod_damage integer, _attackonsight integer, _before integer, _after integer, _killed integer, _damages bigint, _won integer) OWNER TO exileng;

--
-- Name: sp_advertisement_displayed(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_advertisement_displayed(_userid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET displays_ads=displays_ads+1 WHERE id=_userid;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_advertisement_displayed(_userid integer) OWNER TO exileng;

--
-- Name: sp_ai_find_nearest_planet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_find_nearest_planet(integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: PlanetId from where to search

DECLARE

	r_planet record;

	res int4;

BEGIN

	SELECT INTO r_planet galaxy, sector, planet FROM nav_planet WHERE id=$1;

	SELECT INTO res id

	FROM nav_planet

	WHERE galaxy=r_planet.galaxy AND floor > 0 AND space > 0

	ORDER BY sp_travel_distance(sector,planet,r_planet.sector,r_planet.planet) ASC

	LIMIT 1;

	IF FOUND THEN

		RETURN res;

	END IF;

	RETURN -1;

END;$_$;


ALTER FUNCTION static.sp_ai_find_nearest_planet(integer) OWNER TO exileng;

--
-- Name: sp_ai_find_nearest_planet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_find_nearest_planet(integer, integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: UserId

-- Param2: PlanetId from where to search

DECLARE

	r_planet record;

	res int4;

BEGIN

	SELECT INTO r_planet galaxy, sector, planet FROM nav_planet WHERE id=$2;

	SELECT INTO res id

	FROM nav_planet

	WHERE ownerid=$1 AND galaxy=r_planet.galaxy AND floor > 0 AND space > 0

	ORDER BY sp_travel_distance(sector,planet,r_planet.sector,r_planet.planet) ASC

	LIMIT 1;

	IF FOUND THEN

		RETURN res;

	END IF;

	-- otherwise try to return an uninhabited planet

	SELECT INTO res id

	FROM nav_planet

	WHERE ownerid IS NULL AND galaxy=r_planet.galaxy AND NOT sector IN (0, 1,2,3,4,5,6,7,8,9, 10, 11, 20, 21, 30, 31, 40, 41, 50, 51, 60, 61, 70, 71, 80, 81, 90, 91)

	ORDER BY sp_travel_distance(sector,planet,r_planet.sector,r_planet.planet) ASC

	LIMIT 1;

	IF FOUND THEN

		RETURN res;

	END IF;

	RETURN -1;

END;$_$;


ALTER FUNCTION static.sp_ai_find_nearest_planet(integer, integer) OWNER TO exileng;

--
-- Name: sp_ai_planets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_planets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	r_ship record;

	r_fleet record;

	fleetid int4;

	cr int4;

	enemysig int4;

	planetsignature int4;

BEGIN

	--RETURN; 

	FOR r_planet IN

		SELECT id, ownerid, workers, workers_capacity, soldiers, soldiers_capacity, energy_production-energy_consumption AS energy, 

			floor-floor_occupied AS floor, space-space_occupied AS space,

			ore_capacity, hydrocarbon_capacity, ore, hydrocarbon

		FROM vw_planets

			INNER JOIN ai_planets ON (planetid=id)

		WHERE nextupdate <= now() ORDER BY nextupdate LIMIT 2

	LOOP

		UPDATE users SET credits=credits+25 WHERE id=r_planet.ownerid;

		UPDATE ai_planets SET nextupdate = now()+interval '1 hour' WHERE planetid=r_planet.id;

		IF cr > 2000000 OR r_planet.soldiers < 1000 THEN

			IF r_planet.workers > r_planet.workers_capacity*0.7 THEN

				IF r_planet.soldiers < LEAST(3500, r_planet.soldiers_capacity) THEN

					PERFORM sp_start_training(r_planet.ownerid, r_planet.id, 0, LEAST(3500, r_planet.soldiers_capacity)-r_planet.soldiers);

				END IF;

			END IF;

		END IF;

/*

		PERFORM sp_start_building(r_planet.ownerid, r_planet.id, id, false)

		FROM vw_buildings

		WHERE planetid=r_planet.id AND buildings_requirements_met AND research_requirements_met AND energy_production > 0 AND quantity < construction_maximum

		ORDER BY energy_production DESC LIMIT 1

		-- enhance energy system: destroy less effective energy plant to build a bigger one

		SELECT buildingid

		FROM planet_buildings

			INNER JOIN db_buildings ON (db_buildings.id=planet_buildings.buildingid AND db_buildings.energy_production > 0 AND db_buildings.floor > 0 AND destroyable)

		WHERE planetid=r_planet.id

		ORDER BY db_buildings.energy_production / (db_buildings.floor) ASC

		PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, buildingid)

		FROM planet_buildings

		WHERE planetid= AND quantity > 2

*/

		IF r_planet.floor > 10 THEN

			-- rectenna

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=207;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 207, false);

			END IF;

			-- prebuilt plant

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=102;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 102, false);

			END IF;

			-- automates plant

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=202;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 202, false);

			END IF;

			-- spatioport

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=105;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 105, false);

			END IF;

			-- ore mine

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=115 AND quantity > 20;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 115, false);

			END IF;

			-- hydrocarbon mine

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=116 AND quantity > 20;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 116, false);

			END IF;

			-- city

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=201;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 201, false);

			END IF;

			-- workshop

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=204 AND quantity >= 10;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 204, false);

			END IF;

			-- soldiers camp

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=208 AND quantity >= 2;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 208, false);

			END IF;

		ELSEIF r_planet.floor < 5 THEN

			-- find which building is in greater quantity : ore (115) or hydrocarbon (116)

			SELECT INTO cr quantity FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=115;

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=116 AND quantity > cr;

			-- destroy either ore or hydrocarbon mine

			IF FOUND THEN

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 116);

			ELSE

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 115);

			END IF;

		END IF;

		IF r_planet.energy > 400 THEN

			-- ore_storage_2

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=220;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 220, false);

			END IF;

			-- hydrocarbon_storage_2

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=221;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 221, false);

			END IF;

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=120 AND quantity >= 2;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 120, false);

			END IF;

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=121 AND quantity >= 2;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 121, false);

			END IF;

		ELSE

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=205;

			IF NOT FOUND THEN

				IF r_planet.space > 0 THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 218, false);

				END IF;

			END IF;

		END IF;

		-- compute signature of enemy fleets orbiting the planet

		SELECT INTO enemysig int4(COALESCE(0, sum(signature))) FROM fleets WHERE ownerid > 100 AND planetid=r_planet.id;

		IF NOT FOUND THEN

			enemysig := 0;

		END IF;

		SELECT INTO planetsignature int4(COALESCE(0, sum(signature*quantity)))

		FROM planet_ships

			INNER JOIN db_ships ON (shipid = db_ships.id)

		WHERE planetid=r_planet.id;

		IF NOT FOUND THEN

			planetsignature := 0;

		END IF;

		-- create ships

		SELECT INTO cr credits FROM users WHERE id=r_planet.ownerid;

		IF cr > 1000000 AND enemysig < planetsignature + 5000 AND planetsignature < r_planet.soldiers*5 THEN

			-- build ships

			PERFORM 1 FROM planet_ships_pending WHERE planetid=r_planet.id LIMIT 1;

			IF NOT FOUND THEN

				FOR r_ship IN

					SELECT id

					FROM vw_ships

					WHERE planetid=r_planet.id

					ORDER BY int8(weapon_power)*int8(weapon_ammo) DESC

				LOOP

					EXIT WHEN sp_start_ship(r_planet.id, r_ship.id, 10) = 0;

				END LOOP;

			END IF;

		END IF;

		-- form fleets if usefull only

		IF planetsignature > enemysig THEN

			SELECT INTO fleetid id FROM fleets WHERE planetid=r_planet.id AND ownerid=r_planet.ownerid;

			IF NOT FOUND THEN

				fleetid := nextval('public.fleets_id_seq');

				INSERT INTO fleets(id, ownerid, planetid, name, uid, idle_since)

				VALUES(fleetid, r_planet.ownerid, r_planet.id, 'Liberte', nextval('public.npc_fleet_uid_seq'::text), now());

			END IF;

			PERFORM sp_transfer_ships_to_fleet(r_planet.ownerid, fleetid, shipid, quantity) FROM planet_ships WHERE planetid=r_planet.id;

			-- update fleet stance if enemy fleets are orbiting our planet, attack when there are enemy fleets and go back in defend only when there is no more threat

			UPDATE fleets SET attackonsight = enemysig > 0 WHERE ownerid=r_planet.ownerid AND planetid=r_planet.id AND attackonsight = enemysig = 0;

			DELETE FROM fleets WHERE id=fleetid AND signature = 0;

		END IF;

		UPDATE ai_planets SET enemysignature=enemysig WHERE planetid=r_planet.id;

		-- sell resources

		PERFORM sp_sell_resources(ownerid, id, ore, hydrocarbon, 120, 200) FROM nav_planet WHERE id=r_planet.id AND (ore > ore_capacity / 2 OR hydrocarbon > hydrocarbon_capacity / 2);

		-- call to arms if needed and possible: train soldiers

		SELECT INTO cr

			int4(sum(cargo_soldiers))

		FROM fleets

		WHERE (dest_planetid = r_planet.id OR planetid = r_planet.id) AND ownerid > 100;

		IF FOUND AND r_planet.soldiers < cr THEN

			PERFORM sp_start_training(r_planet.ownerid, r_planet.id, 0, LEAST(r_planet.workers-500, LEAST(r_planet.soldiers_capacity, 3500)-r_planet.soldiers));

		END IF;

	END LOOP;

/*

-- move fleets to friendly planets

SELECT (SELECT sp_move_fleet(2, fleets.id, galaxy, sector, planet) FROM nav_planet WHERE id=sp_ai_find_nearest_planet(2, fleets.planetid))

FROM fleets

WHERE fleets.ownerid=2 AND (SELECT ownerid FROM nav_planet WHERE id=fleets.planetid) <> fleets.ownerid

*/

/*

-- enemy fleets coming toward our planets

SELECT dest_planetid, min(action_end_time), sum(signature), sum(cargo_soldiers)

FROM fleets

WHERE dest_planetid IN (SELECT id FROM nav_planet WHERE ownerid=2) AND ownerid > 100

GROUP BY dest_planetid

ORDER BY min(action_end_time);

*/

/*

	-- select all the planets targeted by someone

	FOR r_fleet IN

		SELECT dest_planetid, min(action_end_time), sum(signature) AS fsignature, sum(cargo_soldiers) AS fsoldiers, p.workers, p.soldiers, p.soldiers_capacity

		FROM fleets

			INNER JOIN nav_planet AS p ON (p.id = fleets.dest_planetid)

		WHERE dest_planetid IN (SELECT planetid FROM ai_planets) AND ownerid > 100

		GROUP BY dest_planetid

		ORDER BY min(action_end_time)

	LOOP

		IF r_fleet.fsoldiers > p.soldiers, p.soldiers_capacity

	END LOOP;

*/

	RETURN;

END;$$;


ALTER FUNCTION static.sp_ai_planets() OWNER TO exileng;

--
-- Name: FUNCTION sp_ai_planets(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_ai_planets() IS 'Auto-manage planets belonging to the computer';


--
-- Name: sp_ai_raids(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_raids() RETURNS void
    LANGUAGE plpgsql
    AS $$-- Acquire a target (userid) and raid one of his planets

DECLARE

	r_target record;

BEGIN

	SELECT INTO r_target id, score_global FROM users ORDER BY score_global DESC LIMIT 1;

	IF NOT FOUND OR r_target.score_global < 100000 THEN

		RETURN;

	END IF;

END;$$;


ALTER FUNCTION static.sp_ai_raids() OWNER TO exileng;

--
-- Name: sp_ai_send_recyclers(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_send_recyclers(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- send a recycler toward planet $1

-- Param1: PlanetId

-- Param2: How much to recycle (to create a fleet with a correct size)

DECLARE

	fleet_id int4;

	route_id int8;

	recyclers int4;

	r_deposit_planet record;

BEGIN

	-- compute how much recyclers will be needed

	recyclers := int4(LEAST(100, $2 / 1000 / 36));

	-- select where the fleet will deposit his recycled resources

	SELECT INTO r_deposit_planet nav_planet.id

	FROM nav_planet

		INNER JOIN users ON (nav_planet.ownerid=users.id AND users.privilege = -50)

	WHERE galaxy=(SELECT galaxy FROM nav_planet WHERE id=$1);

	IF NOT FOUND THEN

		RETURN 0;

	END IF;

	-- create the fleet

	fleet_id := nextval('public.fleets_id_seq');

	INSERT INTO fleets(id, uid, ownerid, name, planetid, action)

	VALUES(fleet_id, nextval('public.npc_fleet_uid_seq'), 1, 'Les fossoyeurs', null, 0);

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 103, recyclers/10); -- cargo

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 121, recyclers); -- recyclers

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 954, recyclers*4); -- escorters

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES(fleet_id, 304, recyclers*3); -- multigun corvettes

	UPDATE fleets SET speed=1000 WHERE id=fleet_id;

	-- create route

	route_id := sp_create_route(null, 'rcr_' || fleet_id);

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, $1);

	INSERT INTO routes_waypoints(routeid, "action")

	VALUES(route_id, 2); -- recycle until full or nothing remain

	INSERT INTO routes_waypoints(routeid, "action", planetid)

	VALUES(route_id, 1, r_deposit_planet.id);

	INSERT INTO routes_waypoints(routeid, "action")

	VALUES(route_id, 9);

	UPDATE fleets SET

		next_waypointid=(SELECT Min(id) FROM routes_waypoints WHERE routeid=route_id)

	WHERE id=fleet_id;

	PERFORM sp_routes_continue(1, fleet_id); 

	RETURN fleet_id;

END;$_$;


ALTER FUNCTION static.sp_ai_send_recyclers(integer, integer) OWNER TO exileng;

--
-- Name: sp_ai_watched_planets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ai_watched_planets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT vw_planets.id

		FROM ai_watched_planets

			INNER JOIN vw_planets ON (vw_planets.id=ai_watched_planets.planetid)

		WHERE ownerid IS NULL OR ownerid <= 100 OR (workers > 1000 AND mood > 5)

	LOOP

		DELETE FROM ai_watched_planets WHERE planetid=r_planet.id;

	END LOOP;

	-- add all planets that have few workers on it

	INSERT INTO ai_watched_planets(planetid)

	SELECT id FROM vw_planets WHERE ownerid > 100 AND id NOT IN (SELECT planetid FROM ai_watched_planets) AND (workers <= 1000 OR mood <= 5);

END;$$;


ALTER FUNCTION static.sp_ai_watched_planets() OWNER TO exileng;

--
-- Name: FUNCTION sp_ai_watched_planets(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_ai_watched_planets() IS 'Check planets with few workers on them and track their population';


--
-- Name: sp_alliance_accept_invitation(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Alliance tag

DECLARE

	r_alliance record;

	r_user record;

	_members int4;

	_rankid int2;

BEGIN

	-- find the alliance id for the given tag

	SELECT INTO r_alliance

		id, max_members, tag, name

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 1;

	END IF;

	-- check that there is an invitation from this alliance for this player

	PERFORM allianceid

	FROM alliances_invitations

	WHERE allianceid=r_alliance.id AND userid=_userid AND NOT declined;

	IF NOT FOUND THEN

		-- no invitations issued from this alliance

		RETURN 2;

	END IF;

	-- check that max members count is not reached

	SELECT INTO _members count(1) FROM users WHERE alliance_id=r_alliance.id;

	IF _members >= r_alliance.max_members THEN

		-- max members count reached

		RETURN 4;

	END IF;

	-- check if alliance has active wars against another alliance

	PERFORM 1 FROM alliances_wars WHERE allianceid1=r_alliance.id;

	IF FOUND THEN

		-- only allow new members every 12 hours

		PERFORM 1 FROM users WHERE alliance_id=r_alliance.id AND alliance_joined > now() - INTERVAL '12 hours';

		IF FOUND THEN

			RETURN 4;

		END IF;

	END IF;

	-- only allow the player to join this alliance if he was not a part of it for the last week

	PERFORM 1

	FROM users_alliance_history

	WHERE alliance_tag=r_alliance.tag AND userid=_userid AND "left" > now() - INTERVAL '1 week';

	IF FOUND THEN

		RETURN 6;

	END IF;

	SELECT INTO _rankid rankid FROM alliances_ranks WHERE allianceid=r_alliance.id AND enabled AND is_default ORDER BY rankid DESC LIMIT 1;

	IF NOT FOUND THEN

		SELECT INTO _rankid rankid FROM alliances_ranks WHERE allianceid=r_alliance.id AND enabled ORDER BY rankid DESC LIMIT 1;

		IF NOT FOUND THEN

			RETURN 1;

		END IF;

	END IF;

	UPDATE users SET

		alliance_id = r_alliance.id,

		alliance_rank = _rankid,

		alliance_joined = now(),

		alliance_left = null

	WHERE id=_userid AND alliance_id IS NULL AND (alliance_left IS NULL OR alliance_left < now())

	RETURNING login INTO r_user;

	IF NOT FOUND THEN

		-- player is already in an alliance

		RETURN 3;

	END IF;

	-- remove invitation

	DELETE FROM alliances_invitations WHERE allianceid=r_alliance.id AND userid=_userid;

	-- add a report that the player accepted the invitation

	INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, data)

	VALUES(r_alliance.id, $1, 1, 30, '{player:' || sp__quote(r_user.login) || '}');

	-- add a report that the player joined this alliance

	INSERT INTO reports(ownerid, type, subtype, data)

	VALUES($1, 1, 40, '{alliance:{tag:' || sp__quote(r_alliance.tag) || ',name:' || sp__quote(r_alliance.name) || '}}');

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) IS 'Accept the invitation of an alliance.

Returns 0 if no error';


--
-- Name: sp_alliance_cancel_invitation(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_cancel_invitation(_userid integer, _invited_user character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: name of user invited

DECLARE

	r_user record;

	r_inviteduser record;

BEGIN

	-- check that the player $1 can cancel an invitation

	SELECT INTO r_user

		alliance_id, login

	FROM users

	WHERE id=_userid AND (SELECT can_invite_player FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the invited player

	SELECT INTO r_inviteduser

		id, login

	FROM users

	WHERE upper(login)=upper(_invited_user);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	BEGIN

		DELETE FROM alliances_invitations WHERE allianceid=r_user.alliance_id AND userid=r_inviteduser.id;

		INSERT INTO reports(ownerid, type, subtype, allianceid, userid)

		VALUES(r_inviteduser.id, 1, 21, r_user.alliance_id, _userid, '{by:' || sp__quote(r_user.login) || ',invited:' || sp__quote(r_inviteduser.login) || '}');

		RETURN 0;

	EXCEPTION

		WHEN FOREIGN_KEY_VIOLATION THEN

			RETURN 4;

		WHEN UNIQUE_VIOLATION THEN

			RETURN 5;

	END;

END;$_$;


ALTER FUNCTION static.sp_alliance_cancel_invitation(_userid integer, _invited_user character varying) OWNER TO exileng;

--
-- Name: sp_alliance_check_for_leader(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_check_for_leader(_allianceid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	SELECT INTO r_user id, alliance_rank

	FROM users

	WHERE alliance_id=_allianceid

	ORDER BY alliance_rank, alliance_joined LIMIT 1;

	IF FOUND AND r_user.alliance_rank <> 0 THEN

		-- promote this user as the new alliance leader

		UPDATE users SET

			alliance_rank = 0

		WHERE id=r_user.id AND alliance_id=_allianceid;

	ELSEIF NOT FOUND THEN

		-- if no members are part of this alliance then delete the alliance

		DELETE FROM alliances WHERE id=_allianceid;

	END IF;

END;$$;


ALTER FUNCTION static.sp_alliance_check_for_leader(_allianceid integer) OWNER TO exileng;

--
-- Name: sp_alliance_decline_invitation(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: Alliance tag

DECLARE

	r_alliance record;

	r_user record;

BEGIN

	SELECT INTO r_user

		id, login

	FROM users

	WHERE id=_userid;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO r_alliance

		id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 1;

	END IF;

	-- check that there is an invitation from this alliance for this player

	UPDATE alliances_invitations SET

		declined=true,

		replied=now()

	WHERE allianceid=r_alliance.id AND userid=_userid AND NOT declined AND replied IS NULL;

	IF NOT FOUND THEN

		-- no invitations issued from this alliance

		RETURN 2;

	END IF;

	-- add a report that the player declined the invitation

	INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, data)

	VALUES(r_alliance.id, _userid, 1, 22, '{player:' || sp__quote(r_user.login) || '}');

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) IS 'Decline the invitation of an alliance.

Returns 0 if no error';


--
-- Name: sp_alliance_decline_nap(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_decline_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	aid int4;

	fromaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can decline NAPs on behalf of his alliance

	SELECT INTO aid

		alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to accept the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO fromaid

		id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- update the NAP request from "fromaid" and "aid"

	UPDATE alliances_naps_offers SET

		declined=true,

		replied=now()

	WHERE allianceid=fromaid AND targetallianceid=aid AND NOT declined;

	IF NOT FOUND THEN

		-- no requests issued from the named alliance $2

		RETURN 3;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_decline_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_get_leave_cost(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_get_leave_cost(_userid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$BEGIN

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_get_leave_cost(_userid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_get_leave_cost(_userid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_get_leave_cost(_userid integer) IS 'Return the price of user to leave an alliance';


--
-- Name: sp_alliance_get_tag(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_get_tag(_allianceid integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$--sp_alliance_get_tag

SELECT COALESCE((SELECT alliances.tag

FROM alliances

WHERE id=$1), '');$_$;


ALTER FUNCTION static.sp_alliance_get_tag(_allianceid integer) OWNER TO exileng;

--
-- Name: sp_alliance_invite(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_invite(_userid integer, _invited_user character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: name of user invited

DECLARE

	r_user record;

	r_inviteduser record;

	has_unprotected_planets boolean;

BEGIN

	-- check that the player $1 can invite

	SELECT INTO r_user

		alliance_id, login, alliances.tag, alliances.name

	FROM users

		INNER JOIN alliances ON (alliances.id=users.alliance_id)

	WHERE users.id=_userid AND (SELECT can_invite_player FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- if alliance only has planets in protected galaxies then can't invite users in other galaxies

	PERFORM 1

	FROM users

		INNER JOIN nav_planet ON (nav_planet.ownerid = users.id)

		INNER JOIN nav_galaxies ON (nav_galaxies.id = nav_planet.galaxy)

	WHERE alliance_id = r_user.alliance_id AND protected_until < now();

	has_unprotected_planets := FOUND;

	-- retrieve id of the invited player

	SELECT INTO r_inviteduser

		id,

		login,

		(SELECT count(DISTINCT galaxy) FROM nav_planet WHERE ownerid=users.id) AS galaxies,

		(SELECT galaxy FROM nav_planet WHERE ownerid=users.id LIMIT 1) AS galaxy

	FROM users

	WHERE upper(login)=upper(_invited_user);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF NOT has_unprotected_planets THEN

		-- allow only users in the same galaxy

		PERFORM 1

		FROM users

			INNER JOIN nav_planet ON (nav_planet.ownerid = users.id)

		WHERE alliance_id = r_user.alliance_id AND nav_planet.galaxy <> r_inviteduser.galaxy;

		IF FOUND THEN

			RETURN 6;

		END IF;

	END IF;

	IF r_inviteduser.galaxies = 1 THEN

		PERFORM 1

		FROM nav_galaxies

		WHERE id=r_inviteduser.galaxy AND protected_until > now();

		IF FOUND THEN

			-- trying to invite a nation in a protected galaxy

			-- check that all planets of the alliance are in the same galaxy of the invited nation

			PERFORM 1

			FROM users

				INNER JOIN nav_planet ON (nav_planet.ownerid = users.id)

			WHERE alliance_id = r_user.alliance_id AND nav_planet.galaxy <> r_inviteduser.galaxy;

			IF FOUND THEN

				RETURN 6;

			END IF;

		END IF;

	END IF;

	-- check that the invited player is not already a member of this alliance

	PERFORM id

	FROM users

	WHERE id=r_inviteduser.id AND alliance_id = r_user.alliance_id;

	IF FOUND THEN

		RETURN 3;

	END IF;

	BEGIN

		INSERT INTO alliances_invitations(allianceid, userid, recruiterid)

		VALUES(r_user.alliance_id, r_inviteduser.id, _userid);

		INSERT INTO reports(ownerid, type, subtype, allianceid, userid, data)

		VALUES(r_inviteduser.id, 1, 0, r_user.alliance_id, _userid, '{by:' || sp__quote(r_user.login) || ',alliance:{tag:' || sp__quote(r_user.tag) || ',name:' || sp__quote(r_user.name) || '}}');

		-- add an invitation notice to user alliance

		INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, invited_username, data)

		VALUES(r_user.alliance_id, _userid, 1, 20, r_inviteduser.login, '{by:' || sp__quote(r_user.login) || ',invited:' || sp__quote(r_inviteduser.login) || '}');

		RETURN 0;

	EXCEPTION

		WHEN FOREIGN_KEY_VIOLATION THEN

			RETURN 4;

		WHEN UNIQUE_VIOLATION THEN

			RETURN 5;

	END;

END;$_$;


ALTER FUNCTION static.sp_alliance_invite(_userid integer, _invited_user character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_invite(_userid integer, _invited_user character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_invite(_userid integer, _invited_user character varying) IS 'Invite a player named $2 to join the alliance of the player $1.

Returns values

0 : successful

1 : player $1 doesn''t exist or has not the rights to invite a player

2 : there is no player named $2

3 : shouldn''t happen ..

4 : the player has already been invited';


--
-- Name: sp_alliance_is_at_war(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_is_at_war(_alliance_id integer) RETURNS boolean
    LANGUAGE sql
    AS $_$SELECT count(*) > 2

FROM alliances_wars

WHERE (allianceid1=$1) OR (allianceid2=$1);$_$;


ALTER FUNCTION static.sp_alliance_is_at_war(_alliance_id integer) OWNER TO exileng;

--
-- Name: sp_alliance_kick_member(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_kick_member(_userid integer, _kicked_user character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Name of who to kick from the alliance

DECLARE

	r_user record;	-- info on the "kicker"

	r_kicked record;	-- info on the "kicked player"

	leave_count integer;

	ttl interval;	-- time it will take the player to leave alliance

BEGIN

	-- check that the player $1 can kick

	SELECT INTO r_user

		users.id, login, alliance_id, alliance_rank, alliances.tag, alliances.name

	FROM users

		INNER JOIN alliances ON (alliances.id=alliance_id)

	WHERE users.id=_userid AND (SELECT can_kick_player FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	BEGIN

	/*

		-- check that no more than const_alliance_max_simultaneous_leaves() are already leaving the alliance

		SELECT INTO leave_count

			count(1)

		FROM users

		WHERE alliance_id=r_user.alliance_id AND leave_alliance_datetime IS NOT NULL;

		IF leave_count >= const_alliance_max_simultaneous_leaves() THEN

			RETURN 9;

		END IF;*/

		PERFORM 1 FROM alliances WHERE id=r_user.alliance_id AND last_kick > now()-INTERVAL '24 hours';

		IF FOUND THEN

			RETURN 9;

		END IF;

		-- if alliance is at war, time to leave alliance is 3 times longer

		IF sp_alliance_is_at_war(r_user.alliance_id) THEN

			ttl := 7*const_interval_alliance_leave();

		ELSE

			ttl := const_interval_alliance_leave();

		END IF;

		-- remove user from the alliance

		UPDATE users SET

			--alliance_id=null,

			leave_alliance_datetime=now() + ttl

		WHERE upper(login)=upper(_kicked_user) AND alliance_id=r_user.alliance_id AND alliance_rank > r_user.alliance_rank AND leave_alliance_datetime IS NULL

		RETURNING id, login, sp_alliance_get_leave_cost(id) as price INTO r_kicked;

		IF NOT FOUND THEN

			RETURN 2;

		END IF;

		IF r_kicked.price > 0 THEN

			UPDATE alliances SET credits=credits-r_kicked.price WHERE id=r_user.alliance_id;

		END IF;

		UPDATE alliances SET last_kick=now() WHERE id=r_user.alliance_id;

		-- add a report that the player was kicked

		INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, userid, credits, data)

		VALUES(r_user.alliance_id, r_kicked.id, 1, 32, r_user.id, r_kicked.price, '{by:' || sp__quote(r_user.login) || ',player:' || sp__quote(r_kicked.login) || '}');

		INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, source, type)

		VALUES(r_user.alliance_id, r_user.id, -r_kicked.price, '', r_kicked.login, 5);

		INSERT INTO reports(ownerid, type, subtype, data)

		VALUES(r_kicked.id, 1, 42, '{by:' || sp__quote(r_user.login) || ',alliance:{tag:' || sp__quote(r_user.tag) || ',name:' || sp__quote(r_user.name) || '}}');

		RETURN 0;

	EXCEPTION

		WHEN CHECK_VIOLATION THEN -- not enough money

			RETURN 3;

	END;

END;$_$;


ALTER FUNCTION static.sp_alliance_kick_member(_userid integer, _kicked_user character varying) OWNER TO exileng;

--
-- Name: sp_alliance_leave(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_leave(_userid integer, _cost integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: charges cost

DECLARE

	r_user record;

	leave_count integer;

	ttl interval;

BEGIN

	SELECT INTO r_user

		login, alliance_id, alliances.tag, alliances.name

	FROM users

		INNER JOIN alliances ON (alliances.id=users.alliance_id)

	WHERE users.id=_userid AND alliance_id IS NOT NULL;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

/*

	-- check that no more than const_alliance_max_simultaneous_leaves() are already leaving the alliance

	SELECT INTO leave_count

		count(1)

	FROM users

	WHERE alliance_id=r_user.alliance_id AND leave_alliance_datetime IS NOT NULL;

	IF leave_count >= const_alliance_max_simultaneous_leaves() THEN

		RETURN 9;

	END IF;

*/

	INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, source, type)

	VALUES(r_user.alliance_id, _userid, 0, '', r_user.login, 2);

	-- add a report that the player is leaving the alliance

	INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, data)

	VALUES(r_user.alliance_id, _userid, 1, 31, '{player:' || sp__quote(r_user.login) || '}');

	-- add a report to the user reports that he is leaving

	INSERT INTO reports(ownerid, type, subtype, data)

	VALUES(_userid, 1, 41, '{alliance:{tag:' || sp__quote(r_user.tag) || ',name:' || sp__quote(r_user.name) || '}}');

	IF _cost > 0 THEN

		INSERT INTO users_expenses(userid, credits_delta, leave_alliance)

		VALUES($1, -_cost, r_user.alliance_id);

	END IF;

	-- if alliance is at war, time to leave alliance is 3 times longer

	IF sp_alliance_is_at_war(r_user.alliance_id) THEN

		ttl := 7*const_interval_alliance_leave();

	ELSE

		ttl := const_interval_alliance_leave();

	END IF;

	UPDATE users SET

		--alliance_id=null,

		credits=credits-_cost,

		leave_alliance_datetime=now() + ttl

	WHERE id=_userid AND leave_alliance_datetime IS NULL;

	RETURN 0;

EXCEPTION

	WHEN CHECK_VIOLATION THEN

		RETURN 1;

END;$_$;


ALTER FUNCTION static.sp_alliance_leave(_userid integer, _cost integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_accept(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_money_accept(_userid integer, _money_requestid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: money request Id

DECLARE

	r_user record;

	r_request record;

BEGIN

	SELECT INTO r_user

		alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_accept_money_requests FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found

		RETURN 1;

	END IF;

	SELECT INTO r_request

		userid, credits, description

	FROM alliances_wallet_requests

	WHERE id=_money_requestid AND allianceid=r_user.alliance_id;

	BEGIN

		DELETE FROM alliances_wallet_requests WHERE id=_money_requestid AND allianceid=r_user.alliance_id;

		IF sp_alliance_transfer_money(r_request.userid, -r_request.credits, r_request.description, 3) <> 0 THEN

			RAISE EXCEPTION 'not enough money';

		END IF;

		RETURN 0;

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			RETURN 1;

	END;

END;$$;


ALTER FUNCTION static.sp_alliance_money_accept(_userid integer, _money_requestid integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_deny(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_money_deny(_userid integer, _money_requestid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: money request Id

DECLARE

	r_user record;

BEGIN

	SELECT INTO r_user alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_accept_money_requests FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found

		RETURN 1;

	END IF;

	UPDATE alliances_wallet_requests SET

		result=false

	WHERE id=_money_requestid AND allianceid=r_user.alliance_id;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_money_deny(_userid integer, _money_requestid integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_request(integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Money

-- Param3: Description

DECLARE

	r_user record;

	had_request bool;

BEGIN

	-- find the alliance id of the user and check if he can accept NAPs for his alliance

	SELECT INTO r_user

		login, alliance_id, alliance_rank

	FROM users

	WHERE id=_userid AND (SELECT can_ask_money FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank) AND (now()-game_started > INTERVAL '2 weeks');

	IF NOT FOUND THEN

		-- user not found

		RETURN 1;

	END IF;

	-- delete the previous request if he already had one

	DELETE FROM alliances_wallet_requests WHERE allianceid=r_user.alliance_id AND userid=$1;

	had_request := FOUND;

	IF $2 > 0 THEN

		INSERT INTO alliances_wallet_requests(allianceid, userid, credits, description)

		VALUES(r_user.alliance_id, $1, $2, $3);

		-- notify leader/treasurer : send them a report

		IF had_request THEN

			INSERT INTO reports(ownerid, "type", subtype, credits, description, userid, data)

			SELECT id, 1, 11, $2, $3, $1, '{player:' || sp__quote(r_user.login) || ',credits:' || _credits || ',reason:' || sp__quote(_reason) || '}' FROM users WHERE alliance_id=r_user.alliance_id AND alliance_rank <= 1;

		ELSE

			INSERT INTO reports(ownerid, "type", subtype, credits, description, userid, data)

			SELECT id, 1, 10, $2, $3, $1, '{player:' || sp__quote(r_user.login) || ',credits:' || _credits || ',reason:' || sp__quote(_reason) || '}' FROM users WHERE alliance_id=r_user.alliance_id AND alliance_rank <= 1;

		END IF;

	ELSE

		IF had_request THEN

			INSERT INTO reports(ownerid, "type", subtype, userid, data)

			SELECT id, 1, 12, $1, '{player:' || sp__quote(r_user.login) || '}' FROM users WHERE alliance_id=r_user.alliance_id AND alliance_rank <= 1;

		END IF;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_money_request(_userid integer, _credits integer, _reason character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) IS 'Request money from alliance, if the userid is the treasurer or the boss then they get the money immediatly';


--
-- Name: sp_alliance_nap_accept(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_accept(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_user record;

	fromaid int4;

	offer record;

	c int4;

BEGIN

	-- find the alliance id of the user and check if he can accept NAPs for his alliance

	SELECT INTO r_user

		alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to accept the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO fromaid id

	FROM alliances

	WHERE upper(tag) = upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- check if there is a NAP request from "fromaid" to "aid" and retrieve the guarantees

	SELECT INTO offer break_interval

	FROM alliances_naps_offers

	WHERE allianceid=fromaid AND targetallianceid=r_user.alliance_id AND NOT declined;

	IF NOT FOUND THEN

		-- no requests issued from the named alliance $2

		RETURN 3;

	END IF;

	-- check if there is a WAR between "fromaid" and "aid"

	PERFORM 1

	FROM alliances_wars

	WHERE (allianceid1=fromaid AND allianceid2=r_user.alliance_id) OR (allianceid2=fromaid AND allianceid1=r_user.alliance_id);

	IF FOUND THEN

		RETURN 4;

	END IF;

	-- check number of naps

	SELECT INTO c count(*)

	FROM alliances_naps

	WHERE allianceid1=r_user.alliance_id;

	IF c >= 15 THEN

		RETURN 5;

	END IF;

	SELECT INTO c count(*)

	FROM alliances_naps

	WHERE allianceid2=fromaid;

	IF c >= 15 THEN

		RETURN 5;

	END IF;

	INSERT INTO alliances_naps(allianceid1, allianceid2, break_interval)

	VALUES(r_user.alliance_id, fromaid, offer.break_interval);

	INSERT INTO alliances_naps(allianceid1, allianceid2, break_interval)

	VALUES(fromaid, r_user.alliance_id, offer.break_interval);

	DELETE FROM alliances_naps_offers

	WHERE allianceid=fromaid AND targetallianceid=r_user.alliance_id;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_accept(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_nap_break(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_break(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	r_nap record;

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can break NAPs for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_break_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to break the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- retrieve the NAP conditions

	SELECT INTO r_nap break_interval

	FROM alliances_naps

	WHERE allianceid1=aid AND allianceid2=targetaid LIMIT 1;

	IF NOT FOUND THEN

		-- no NAPs found

		RETURN 3;

	END IF;

	UPDATE alliances_naps SET

		break_on=now() + r_nap.break_interval

	WHERE break_on IS NULL AND ((allianceid1=aid AND allianceid2=targetaid) or (allianceid1=targetaid AND allianceid2=aid));

	IF FOUND THEN

		-- warn the target alliance leaders that this alliance broke the NAP

		INSERT INTO reports(ownerid, type, subtype, allianceid)

		SELECT id, 1, 71, aid

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=targetaid AND (r.leader OR r.can_create_nap);	

	END IF;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_nap_break(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_nap_cancel(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_cancel(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: tag of alliance

-- Param3: hours to break the nap

DECLARE

	r_user record;

	invitedallianceid int4;

BEGIN

	-- check that the player $1 can request a NAP

	SELECT INTO r_user id, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT leader OR can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the invited alliance

	SELECT id INTO invitedallianceid

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF r_user.alliance_id = invitedallianceid THEN

		RETURN 2;

	END IF;

	DELETE FROM alliances_naps_offers WHERE allianceid=r_user.alliance_id AND targetallianceid=invitedallianceid;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_cancel(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_nap_cancel(_userid integer, _alliance_tag character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_nap_cancel(_userid integer, _alliance_tag character varying) IS 'Cancel a NAP request with the alliance with tag $2.

Returns values

0 : successful

1 : player $1 doesn''t exist or has not the rights to request a NAP

2 : there is no alliances tagged $2

3 : there is already a NAP between the 2 alliances

4 : 

5 : shouldn''t happen

6 : the alliance has already been offered a NAP recently

5 : ';


--
-- Name: sp_alliance_nap_decline(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_decline(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	aid int4;

	fromaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can decline NAPs on behalf of his alliance

	SELECT INTO aid

		alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to accept the NAP

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO fromaid

		id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	-- update the NAP request from "fromaid" and "aid"

	UPDATE alliances_naps_offers SET

		declined=true,

		replied=now()

	WHERE allianceid=fromaid AND targetallianceid=aid AND NOT declined;

	IF NOT FOUND THEN

		-- no requests issued from the named alliance $2

		RETURN 3;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_decline(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_nap_request(integer, character varying, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_request(_userid integer, _alliance_tag character varying, _hours integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: tag of alliance

-- Param3: hours to break the nap

DECLARE

	r_user record;

	invitedallianceid int4;

BEGIN

	-- check that the player $1 can request a NAP

	SELECT INTO r_user id, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the invited alliance

	SELECT id INTO invitedallianceid

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF r_user.alliance_id = invitedallianceid THEN

		RETURN 2;

	END IF;

	-- check that there is not already a NAP between the 2 alliances

	PERFORM 1

	FROM alliances_naps

	WHERE allianceid1=invitedallianceid AND allianceid2 = r_user.alliance_id;

	IF FOUND THEN

		RETURN 3;

	END IF;

	-- check that there is not already a NAP request from the target alliance

	PERFORM 1

	FROM alliances_naps_offers

	WHERE allianceid=invitedallianceid AND targetallianceid = r_user.alliance_id AND NOT declined;

	IF FOUND THEN

		RETURN 4;

	END IF;

	BEGIN

		INSERT INTO alliances_naps_offers(allianceid, targetallianceid, recruiterid, break_interval)

		VALUES(r_user.alliance_id, invitedallianceid, r_user.id, GREATEST(0, LEAST(72, _hours))*INTERVAL '1 hour');

		RETURN 0;

	EXCEPTION

		WHEN FOREIGN_KEY_VIOLATION THEN

			RETURN 5;

		WHEN UNIQUE_VIOLATION THEN

			RETURN 6;

	END;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_request(_userid integer, _alliance_tag character varying, _hours integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_nap_request(_userid integer, _alliance_tag character varying, _hours integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_nap_request(_userid integer, _alliance_tag character varying, _hours integer) IS 'Invite an alliance with the tag $2 to create a NAP.

Returns values

0 : successful

1 : player $1 doesn''t exist or has not the rights to request a NAP

2 : there is no alliances tagged $2

3 : there is already a NAP between the 2 alliances

4 : 

5 : shouldn''t happen

6 : the alliance has already been offered a NAP recently

5 : ';


--
-- Name: sp_alliance_nap_toggle_share_locs(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_toggle_share_locs(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: tag of target alliance

DECLARE

	user record;

	targetallianceid int4;

BEGIN

	-- check that the player $1 can request a NAP

	SELECT INTO user id, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT leader OR can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the target alliance

	SELECT INTO targetallianceid

		id

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF user.alliance_id = targetallianceid THEN

		RETURN 2;

	END IF;

	UPDATE alliances_naps SET

		share_locs = NOT share_locs

	WHERE allianceid1=user.alliance_id AND allianceid2=targetallianceid;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_toggle_share_locs(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_nap_toggle_share_radars(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_nap_toggle_share_radars(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: tag of target alliance

DECLARE

	user record;

	targetallianceid int4;

BEGIN

	-- check that the player $1 can request a NAP

	SELECT INTO user id, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT leader OR can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the target alliance

	SELECT INTO targetallianceid

		id

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF user.alliance_id = targetallianceid THEN

		RETURN 2;

	END IF;

	UPDATE alliances_naps SET

		share_radars = NOT share_radars

	WHERE allianceid1=user.alliance_id AND allianceid2=targetallianceid;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_nap_toggle_share_radars(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_request_nap(integer, character varying, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: tag of alliance

-- Param3: guarantee amount given by alliance of $1

-- Param4: guarantee amount asked to alliance $2

DECLARE

	user record;

	invitedallianceid int4;

BEGIN

	-- limit the first guarantee to 100 000 000 credits

	IF ($3 > 100000000) OR ($4 > 100000000) THEN

		RETURN 7;

	END IF;

	-- check that the player $1 can request a NAP

	SELECT INTO user id, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve id of the invited alliance

	SELECT id INTO invitedallianceid

	FROM alliances

	WHERE upper(tag)=upper($2);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF user.alliance_id = invitedallianceid THEN

		RETURN 2;

	END IF;

	-- check that there is not already a NAP between the 2 alliances

	PERFORM created

	FROM alliances_naps

	WHERE allianceid1=invitedallianceid AND allianceid2 = user.alliance_id;

	IF FOUND THEN

		RETURN 3;

	END IF;

	-- check that there is not already a NAP request from the target alliance

	PERFORM created

	FROM alliances_naps_offers

	WHERE allianceid=invitedallianceid AND targetallianceid = user.alliance_id AND NOT declined;

	IF FOUND THEN

		RETURN 4;

	END IF;

	BEGIN

		INSERT INTO alliances_naps_offers(allianceid, targetallianceid, recruiterid, guarantee, guarantee_asked)

		VALUES(user.alliance_id, invitedallianceid, user.id, $3, $4);

		RETURN 0;

	EXCEPTION

		WHEN FOREIGN_KEY_VIOLATION THEN

			RETURN 5;

		WHEN UNIQUE_VIOLATION THEN

			RETURN 6;

	END;

END;$_$;


ALTER FUNCTION static.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) IS 'Invite an alliance with the tag $2 to create a NAP.

Returns values

0 : successful

1 : player $1 doesn''t exist or has not the rights to request a NAP

2 : there is no alliances tagged $2

3 : there is already a NAP between the 2 alliances

4 : 

5 : shouldn''t happen

6 : the alliance has already been offered a NAP recently

5 : ';


--
-- Name: sp_alliance_set_tax(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_set_tax(_userid integer, _new_tax integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Tax rates for 1000 credits (eg. 200 for 1000 = 2% tax rates)

DECLARE

	r_user record;

	r_alliance record;

BEGIN

	-- check tax limits

	IF ($2 < 0) OR ($2 > 100) OR ($2 % 5 <> 0) THEN

		RETURN 2;

	END IF;

	-- find the alliance id of the user and check if he can accept NAPs for his alliance

	SELECT INTO r_user

		login, alliance_id

	FROM users

	WHERE id=$1 AND (SELECT can_change_tax_rate FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to set the tax rates

		RETURN 1;

	END IF;

	SELECT INTO r_alliance

		id, tax

	FROM alliances

	WHERE id=r_user.alliance_id;

	UPDATE alliances SET

		tax=_new_tax

	WHERE id=r_user.alliance_id AND tax <> _new_tax;

	IF FOUND THEN

		INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, destination, type)

		VALUES(r_user.alliance_id, $1, 0, _new_tax, r_user.login, 4);

		INSERT INTO alliances_reports(ownerallianceid, ownerid, type, subtype, data)

		VALUES(r_user.alliance_id, _userid, 1, 33, '{from:' || r_alliance.tax/10.0 || ',to:' || _new_tax/10.0 || ',by:' || sp__quote(r_user.login) || '}');

		INSERT INTO reports(ownerid, type, subtype, data)

		SELECT id, 1, 33, '{from:' || r_alliance.tax/10.0 || ',to:' || _new_tax/10.0 || ',by:' || sp__quote(r_user.login) || '}' FROM users WHERE alliance_id=r_alliance.id;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_set_tax(_userid integer, _new_tax integer) OWNER TO exileng;

--
-- Name: sp_alliance_transfer_money(integer, integer, character varying, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_transfer_money(integer, integer, character varying, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Transfer money from player wallet to alliance wallet if credits > 0

-- Param1: UserId

-- Param2: Credits

-- Param3: Description

-- Param4: Type of transfer (0=gift, 1=tax, 2=player left alliance, 3=money request accepted)

DECLARE

	r_user record;

BEGIN

	IF $2 = 0 THEN

		RETURN 0;

	END IF;

	SELECT INTO r_user login, alliance_id FROM users WHERE id=$1;

	IF NOT FOUND OR r_user.alliance_id IS NULL  THEN

		RETURN 1;

	END IF;

	BEGIN

		IF $2 > 0 THEN

			INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, source, type)

			VALUES(r_user.alliance_id, $1, $2, $3, r_user.login, $4);

		ELSE

			INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, destination, type)

			VALUES(r_user.alliance_id, $1, $2, $3, r_user.login, $4);

		END IF;

		IF $2 > 0 THEN

			UPDATE users SET alliance_credits_given = alliance_credits_given + $2 WHERE id=$1;

		ELSE

			UPDATE users SET alliance_credits_taken = alliance_credits_taken - $2 WHERE id=$1;

		END IF;

		--PERFORM sp_log_credits($1, -$2, 'Transfer money to alliance');

		INSERT INTO users_expenses(userid, credits_delta, to_alliance)

		VALUES($1, -$2, r_user.alliance_id);

		IF $4 = 0 THEN

			-- check if has enough credits only for gifts, keep paying taxes on sales

			UPDATE users SET credits=credits-$2 WHERE id=$1 AND credits >= $2;

			IF NOT FOUND THEN

				RAISE EXCEPTION 'not enough credits';

			END IF;

		ELSE

			UPDATE users SET credits=credits-$2 WHERE id=$1;

		END IF;

		UPDATE alliances SET credits = credits + $2 WHERE id=r_user.alliance_id;

		IF NOT FOUND THEN

			RAISE EXCEPTION 'alliance not found';

		END IF;

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			RETURN 2;

	END;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_alliance_transfer_money(integer, integer, character varying, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_transfer_money(integer, integer, character varying, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_alliance_transfer_money(integer, integer, character varying, integer) IS 'Transfer money from player to the alliance.';


--
-- Name: sp_alliance_tribute_cancel(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_tribute_cancel(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can cease wars for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_break_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to cease the war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	DELETE FROM alliances_tributes

	WHERE allianceid=aid AND target_allianceid=targetaid;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_tribute_cancel(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_tribute_new(integer, character varying, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_tribute_new(_userid integer, _alliance_tag character varying, _credits integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

	IF _credits <= 0 THEN

		RETURN 1;

	END IF;

	-- find the alliance id of the user and check if he can create NAPs for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to declare war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid

		id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	PERFORM 1

	FROM users

		INNER JOIN nav_planet ON (nav_planet.ownerid = users.id)

		INNER JOIN nav_galaxies ON (nav_galaxies.id = nav_planet.galaxy)

	WHERE alliance_id = targetaid AND protected_until > now();

	IF FOUND THEN

		-- target alliance only has protected planets

		-- check that the alliance setting up the tribute is in the same galaxy

		PERFORM 1

		FROM nav_planet n1

			INNER JOIN users u1 ON (u1.id = n1.ownerid)

		WHERE u1.alliance_id=aid AND n1.galaxy IN (SELECT DISTINCT galaxy 

								FROM nav_planet

									INNER JOIN users ON (users.id=nav_planet.ownerid)

								WHERE users.alliance_id=targetaid)

		LIMIT 1;

		IF NOT FOUND THEN

			RETURN 4;

		END IF;

	END IF;

	PERFORM 1

	FROM alliances_tributes

	WHERE allianceid=aid AND target_allianceid=targetaid;

	IF FOUND THEN

		RETURN 3;

	END IF;

	INSERT INTO alliances_tributes(allianceid, target_allianceid, credits)

	VALUES(aid, targetaid, _credits);

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_tribute_new(_userid integer, _alliance_tag character varying, _credits integer) OWNER TO exileng;

--
-- Name: sp_alliance_value(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_value(_alliance_id integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	rec record;

BEGIN

	SELECT INTO rec

		sum(score) AS score, count(1) AS members

	FROM users

	WHERE alliance_id = _alliance_id AND privilege > -10;

	RETURN COALESCE((rec.score * (1 + 0.02*rec.members))::bigint, 0);

END;$$;


ALTER FUNCTION static.sp_alliance_value(_alliance_id integer) OWNER TO exileng;

--
-- Name: sp_alliance_war_cost(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_war_cost(_target_alliance_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	_value integer;

BEGIN

	SELECT INTO _value

		sum(sp_alliance_value(allianceid1))

	FROM alliances_wars

	WHERE allianceid2 = _target_alliance_id;

	RETURN GREATEST(0, _value*const_coef_score_to_war())::integer;

END;$$;


ALTER FUNCTION static.sp_alliance_war_cost(_target_alliance_id integer) OWNER TO exileng;

--
-- Name: sp_alliance_war_declare(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_war_declare(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

	r_target record;

	result int4;

BEGIN

	-- find the alliance id of the user and check if he can declare wars for his alliance

	SELECT INTO r_user

		id, privilege, alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to declare war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO r_target id, tag

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	IF r_target.id = r_user.alliance_id THEN

		RETURN 2;

	END IF;

	PERFORM 1

	FROM alliances_naps

	WHERE (allianceid1=r_user.alliance_id AND allianceid2=r_target.id) OR (allianceid1=r_target.id AND allianceid2=r_user.alliance_id);

	IF FOUND THEN

		-- there is a nap between the alliances

		RETURN 4;

	END IF;

	PERFORM 1

	FROM alliances_wars

	WHERE (allianceid1=r_user.alliance_id AND allianceid2=r_target.id) OR (allianceid2=r_user.alliance_id AND allianceid1=r_target.id);

	IF FOUND THEN

		RETURN 3;

	END IF;

	IF r_user.privilege > -100 THEN

		INSERT INTO alliances_wars(allianceid1, allianceid2, can_fight)

		VALUES(r_user.alliance_id, r_target.id, now()/* + (SELECT count(1) FROM users WHERE alliance_id=r_target.id) * INTERVAL '1 hour'*/);

		-- pay bill now

		result := sp_alliance_war_pay_bill(_userid, r_target.tag);

		IF result <> 0 THEN

			-- if bill could not be paid, remove the war

			DELETE FROM alliances_wars WHERE allianceid1=r_user.alliance_id AND allianceid2=r_target.id;

			RETURN result;

		END IF;

	ELSE

		-- declare npc war

		INSERT INTO alliances_wars(allianceid1, allianceid2, next_bill, can_fight)

		VALUES(r_user.alliance_id, r_target.id, null, now());

	END IF;

	-- warn the target alliance leaders that this alliance declared the war

	INSERT INTO reports(ownerid, type, subtype, allianceid)

	SELECT id, 1, 60, r_user.alliance_id

	FROM users

		INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

	WHERE alliance_id=r_target.id AND (r.leader OR r.can_create_nap);

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_war_declare(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_war_pay_bill(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_war_pay_bill(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	r_target record;

	aguarantee int4;

	war_cost int4;

BEGIN

	-- find the alliance id of the user and check if he can pay wars for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_create_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to pay the war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO r_target id, tag, name

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	PERFORM 1 FROM alliances_wars WHERE allianceid1=aid AND allianceid2=r_target.id AND next_bill < now() + INTERVAL '1 week';

	IF NOT FOUND THEN

		-- prevent paying more than 1 week

		RETURN 1;

	END IF;

	BEGIN

		war_cost := sp_alliance_war_cost(r_target.id);

		UPDATE alliances SET credits=credits-war_cost WHERE id=aid AND credits >= war_cost;

		IF FOUND THEN

			UPDATE alliances_wars SET next_bill=next_bill+INTERVAL '1 week' WHERE allianceid1=aid AND allianceid2=r_target.id;

			INSERT INTO alliances_wallet_journal(allianceid, userid, credits, description, source, type)

			VALUES(aid, _userid, -war_cost, '', r_target.name, 12);

		ELSE

			RETURN 9;

		END IF;

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			RETURN 1;

	END;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_war_pay_bill(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_war_stop(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_war_stop(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

	-- find the alliance id of the user and check if he can stop wars for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_break_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to stop the war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	DELETE FROM alliances_wars WHERE allianceid1=aid AND allianceid2=targetaid;

	IF FOUND THEN

		-- warn the user alliance leaders that he stopped the war

		INSERT INTO reports(ownerid, type, subtype, allianceid, userid)

		SELECT id, 1, 63, targetaid, _userid

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=aid AND (r.leader OR r.can_create_nap);	

		-- warn the target alliance leaders that this alliance stopped the war

		INSERT INTO reports(ownerid, type, subtype, allianceid)

		SELECT id, 1, 62, aid

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=targetaid AND (r.leader OR r.can_create_nap);	

	END IF;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_war_stop(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_war_surrender(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliance_war_surrender(_userid integer, _alliance_tag character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	aid int4;

	targetaid int4;

	aguarantee int4;

BEGIN

RETURN 0;

	-- find the alliance id of the user and check if he can cease wars for his alliance

	SELECT INTO aid alliance_id

	FROM users

	WHERE id=_userid AND (SELECT can_break_nap FROM alliances_ranks WHERE allianceid=alliance_id AND rankid=alliance_rank);

	IF NOT FOUND THEN

		-- user not found or doesn't have the rights to cease the war

		RETURN 1;

	END IF;

	-- find the alliance id for the given tag

	SELECT INTO targetaid id

	FROM alliances

	WHERE upper(tag)=upper(_alliance_tag);

	IF NOT FOUND THEN

		-- alliance tag not found

		RETURN 2;

	END IF;

	UPDATE alliances_wars SET

		cease_fire_requested=aid,

		cease_fire_expire=now() + INTERVAL '1 week'

	WHERE cease_fire_requested IS NULL AND ((allianceid1=aid AND allianceid2=targetaid) OR (allianceid2=aid AND allianceid1=targetaid));

	IF FOUND THEN

		-- warn the target alliance leaders that this alliance asked to stop the war

		INSERT INTO reports(ownerid, type, subtype, allianceid)

		SELECT id, 1, 61, aid

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=targetaid AND (r.leader OR r.can_create_nap);

	END IF;

	DELETE FROM alliances_wars

	WHERE cease_fire_requested IS NOT NULL AND cease_fire_requested <> aid AND ((allianceid1=aid AND allianceid2=targetaid) OR (allianceid2=aid AND allianceid1=targetaid));

	IF FOUND THEN

		-- warn the target alliance leaders that this alliance accepted to stop the war

		INSERT INTO reports(ownerid, type, subtype, allianceid)

		SELECT id, 1, 62, aid

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=targetaid AND (r.leader OR r.can_create_nap);	

	END IF;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_alliance_war_surrender(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliances_wallet_journal_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_alliances_wallet_journal_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r record;

	id int4;

BEGIN

	--LOCK alliances_wallet_journal IN ACCESS EXCLUSIVE MODE;

	SELECT INTO r

		type, userid, description, destination, groupid

	FROM alliances_wallet_journal

	WHERE allianceid=NEW.allianceid

	ORDER BY datetime DESC

	LIMIT 1;

	IF FOUND THEN

		IF r.type IS DISTINCT FROM NEW.type OR

		   r.userid IS DISTINCT FROM NEW.userid OR

		   r.description IS DISTINCT FROM NEW.description OR

		   r.destination IS DISTINCT FROM NEW.destination THEN

			id := r.groupid+1;

		ELSE

			id := r.groupid;

		END IF;

	ELSE

		id := 0;

	END IF;

	NEW.groupid := id;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_alliances_wallet_journal_before_insert() OWNER TO exileng;

--
-- Name: sp_apply_tax(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_apply_tax(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Apply the taxes on the given credits, return the credits - the taxes if any

-- Do not use the returned value directly, store it in a var before using it in a query

-- Param1: UserId

-- Param2: Credits

DECLARE

	r_user record;

	taxes int4;

	remaining_credits int4;

BEGIN

	SELECT INTO r_user login, alliance_id, tax

	FROM users

		INNER JOIN alliances ON (alliances.id=users.alliance_id)

	WHERE users.id=$1 AND users.planets > 1 FOR UPDATE;

	IF FOUND THEN

		taxes := int4($2*(r_user.tax / 1000.0));

		remaining_credits := $2 - taxes;

		IF taxes > 0 THEN

			UPDATE alliances SET credits=credits+taxes WHERE id=r_user.alliance_id;

			UPDATE users SET alliance_taxes_paid=alliance_taxes_paid + taxes WHERE id=$1;

			INSERT INTO alliances_wallet_journal(allianceid, userid, credits, source, type)

			VALUES(r_user.alliance_id, $1, taxes, r_user.login, 1);

			RETURN remaining_credits;

		END IF;

	END IF;

	RETURN $2;

END;$_$;


ALTER FUNCTION static.sp_apply_tax(integer, integer) OWNER TO exileng;

--
-- Name: sp_buy_resources(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_buy_resources(integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Buy resources

-- Param1: User ID

-- Param2: Planet ID

-- Param3: ore

-- Param4: hydrocarbon

DECLARE

	time int4;

	cr numeric;

	fleet_id int8;

	total int4;

	r_planet record;

	prices resource_price;

BEGIN

	IF ($3 < 0) OR ($4 < 0) THEN

		RETURN 1;

	END IF;

	-- check that the planet exists and is owned by the given user

	SELECT INTO r_planet

		galaxy, space, sp_get_planet_blocus_strength($2) >= space AS blocked

	FROM vw_planets

	WHERE ownerid=$1 AND id=$2 AND workers >= workers_for_maintenance / 2 AND (SELECT has_merchants FROM nav_galaxies WHERE id=galaxy);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- check if enough enemy fleets are orbiting the planet to block the planet

	IF r_planet.blocked THEN

		RETURN 4;

	END IF;

	prices := sp_get_resource_price($1, r_planet.galaxy);

	-- compute how long it will take (from merchants to player planets)

	time := int4((2 - ($3+$4) / 100000.0)*3600);

	IF time < 3600 THEN

		time := 3600;

	END IF;

	time := int4(time + random()*1800);

	total := $3 + $4;

	cr := $3/1000 * prices.buy_ore + $4/1000 * prices.buy_hydrocarbon;

	INSERT INTO users_expenses(userid, credits_delta, planetid, ore, hydrocarbon)

	VALUES($1, -cr, $2, $3, $4);

	-- pay immediately

	UPDATE users SET credits = credits - cr WHERE id = $1 AND credits > cr;

	IF NOT FOUND THEN

		RAISE EXCEPTION 'not enough credits';

	END IF;

	-- insert the purchase to market_purchases table, raise an exception if there's already a sale for the same planet

	INSERT INTO market_purchases(planetid, ore, hydrocarbon, ore_price, hydrocarbon_price, credits, delivery_time)

	VALUES($2, $3, $4, prices.buy_ore, prices.buy_hydrocarbon, cr, now() + time/2.0 * interval '1 second');

	-- insert the sale to the market history

	INSERT INTO market_history(ore_sold, hydrocarbon_sold, credits, username)

	SELECT -$3, -$4, cr, login FROM users WHERE id=$1;

	-- order a merchant fleet to go deposit resources to the planet

	SELECT INTO fleet_id id FROM fleets WHERE ownerid=3 AND action=0 AND cargo_capacity >= total AND cargo_capacity < total+100000 ORDER BY cargo_capacity LIMIT 1 FOR UPDATE;

	-- if no fleets could be sent, create a new one

	IF NOT FOUND THEN

		fleet_id := nextval('fleets_id_seq');

		INSERT INTO fleets(id, uid, ownerid, name, planetid, dest_planetid, action_start_time, action_end_time, action)

		VALUES(fleet_id, nextval('npc_fleet_uid_seq'), 3, 'Flotte marchande', NULL, $2, now(), now()+time/2.0 * interval '1 second', 1);

		-- add merchant ships to the fleet

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 910, 1+total / (SELECT capacity FROM db_ships WHERE id=910));

	ELSE

		-- send the merchant fleet

		UPDATE fleets SET

			planetid=NULL,

			dest_planetid=$2,

			action_start_time=now(),

			action_end_time=now()+time/2.0 * interval '1 second',

			action=1

		WHERE id=fleet_id;

	END IF;

	-- update galaxy traded wares quantity

	UPDATE nav_galaxies SET

		traded_ore = traded_ore - $3,

		traded_hydrocarbon = traded_hydrocarbon - $4

	WHERE id=r_planet.galaxy;

	RETURN 0;

EXCEPTION

	WHEN RAISE_EXCEPTION THEN

		RETURN 3;

	WHEN UNIQUE_VIOLATION THEN

		RETURN 4;

END;$_$;


ALTER FUNCTION static.sp_buy_resources(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_can_build_on(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_can_build_on(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: PlanetId

-- Param2: BuildingId

-- Param3: OwnerId

BEGIN

/*

	PERFORM 1

	FROM planet_buildings

	WHERE planetid=$1 AND buildingid=$2

	AND quantity + (SELECT int4(COALESCE(sum(*), 0)) FROM planet_buildings_pending WHERE planetid=$1 AND buildingid=$2) >= (SELECT construction_maximum FROM db_buildings WHERE id=$2);

*/

	PERFORM 1

	WHERE COALESCE((SELECT quantity FROM planet_buildings WHERE planetid=$1 AND buildingid=$2), 0) +

		COALESCE((SELECT count(id) FROM planet_buildings_pending WHERE planetid=$1 AND buildingid=$2), 0) >= (SELECT construction_maximum FROM db_buildings WHERE id=$2);

	IF FOUND THEN

		-- maximum buildings of this type reached

		RETURN 1;

	END IF;

	PERFORM 1

	FROM db_buildings_req_building 

	WHERE buildingid = $2 AND (required_buildingid NOT IN (SELECT buildingid FROM planet_buildings WHERE planetid=$1 AND (quantity > 1 OR (quantity >= 1 AND destroy_datetime IS NULL))));

	IF FOUND THEN

		-- buildings requirements not met

		RETURN 2;

	END IF;

	PERFORM 1

	FROM db_buildings_req_research

	WHERE buildingid = $2 AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=$3 AND level >= required_researchlevel));

	IF FOUND THEN

		-- research requirements not met

		RETURN 3;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_can_build_on(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_can_build_on(integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_can_build_on(integer, integer, integer) IS 'Return 0 if can build buildingid on planet id

Return 1 if max buildings of this type is reached

Return 2 if buildings requirements are not met

Return 3 if research requirements are not met';


--
-- Name: sp_cancel_building(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_building(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- cancel the construction of a building on a planet

-- param1: user id

-- param2: planet id

-- param3: building id

DECLARE

	r_building db_buildings;

	percent float4;

BEGIN

	-- check that the planet belongs to the user

	PERFORM id

	FROM nav_planet

	WHERE ownerid=$1 AND id=$2;

	IF NOT FOUND THEN

		RETURN 5;

	END IF;

	-- retrieve construction percentage of the building

	SELECT INTO percent COALESCE( 1.0 - date_part('epoch', now() - start_time) / date_part('epoch', end_time - start_time) / 2.0, 0)

	FROM planet_buildings_pending

	WHERE planetid=$2 AND buildingid=$3 FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	IF percent > 1.0 THEN

		percent := 1.0;

	ELSEIF percent < 0.5 THEN

		percent := 0.5;

	END IF;

	-- retrieve building info

	SELECT INTO r_building * FROM db_buildings WHERE id=$3 LIMIT 1;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- delete pending building from list

	DELETE FROM planet_buildings_pending

	WHERE planetid=$2 AND buildingid=$3;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	PERFORM sp_update_planet($2);

	-- give resources back

	UPDATE nav_planet SET

		ore = ore + percent * r_building.cost_ore,

		hydrocarbon = hydrocarbon + percent * r_building.cost_hydrocarbon,

		energy = energy + percent * r_building.cost_energy

	WHERE id=$2;

	UPDATE users SET

		credits = credits + percent * r_building.cost_credits,

		prestige_points_refund = prestige_points_refund + (0.95 * percent * r_building.cost_prestige)::integer

	WHERE id=$1;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_cancel_building(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_move(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_move(integer, integer) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: UserId

-- Param2: FleetId

UPDATE fleets SET

	planetid=dest_planetid,

	dest_planetid=planetid,

	action_start_time = now()-(action_end_time-now()),

	action_end_time = now()+(now()-action_start_time),

	action = -1,

	next_waypointid = null

WHERE ownerid=$1 AND id=$2 AND action=1 AND not engaged AND planetid IS NOT NULL AND int4(date_part('epoch', now()-action_start_time)) < GREATEST(100/(speed*mod_speed/100.0)*3600, 120);$_$;


ALTER FUNCTION static.sp_cancel_move(integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_move(integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_move(integer, integer, boolean) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: UserId

-- Param2: FleetId

-- Param3: Force the fleet to come back even if can't be called back normally

UPDATE fleets SET

	planetid=dest_planetid,

	dest_planetid=planetid,

	action_start_time = now()-(action_end_time-now()),

	action_end_time = now()+(now()-action_start_time),

	action = -1,

	next_waypointid = null

WHERE ownerid=$1 AND id=$2 AND action=1 AND not engaged AND planetid IS NOT NULL AND ($3 OR int4(date_part('epoch', now()-action_start_time)) < GREATEST(100/(speed*mod_speed/100.0)*3600, 120));$_$;


ALTER FUNCTION static.sp_cancel_move(integer, integer, boolean) OWNER TO exileng;

--
-- Name: sp_cancel_recycling(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_recycling(integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: FleetId

BEGIN

	UPDATE fleets SET

		action_start_time = NULL,

		action_end_time = NULL,

		action = 0,

		next_waypointid = NULL

	WHERE ownerid=$1 AND id=$2 AND action=2;

	-- update recycler percent of all remaining fleets recycling

	IF FOUND THEN

		PERFORM sp_update_fleets_recycler_percent((SELECT planetid FROM fleets WHERE ownerid=$1 AND id=$2));

	END IF;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_cancel_recycling(integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_research(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_research(integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- cancel the construction of a building on a planet

-- param1: user id

-- param2: research id

DECLARE

	rec research_status;

	percent float4;

BEGIN

	-- first, retrieve research percentage

	SELECT COALESCE( 1.0 - date_part('epoch', now() - start_time) / date_part('epoch', end_time - start_time) / 2.0, 0) INTO percent

	FROM researches_pending

	WHERE userid=$1 AND researchid=$2;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	IF percent > 1.0 THEN

		percent := 1.0;

	ELSEIF percent < 0.5 THEN

		percent := 0.5;

	END IF;

	-- retrieve research info

	SELECT INTO rec * FROM sp_list_researches($1) WHERE researchid=$2 LIMIT 1;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- delete pending building from list

	DELETE FROM researches_pending

	WHERE userid=$1 AND researchid=$2;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- give money back

	UPDATE users SET

		credits = credits + percent * rec.total_cost

	WHERE id=$1;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_cancel_research(integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_ship(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_ship(_planetid integer, _pending_id integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- cancel construction 

-- Param1: Planet id

-- Param2: Id of planet_ships_pending

DECLARE

	r_pending record;

	r_pending2 record;

	r_ship record;

	percent float4;

BEGIN

	-- retrieve shipid, quantity, percent built if under construction

	SELECT INTO r_pending

		shipid,

		quantity,

		start_time,

		end_time,

		recycle,

		COALESCE( 1.0 - date_part('epoch', now() - start_time) / date_part('epoch', end_time - start_time) / 2.0, 0.98) AS percentage,

		take_resources

	FROM planet_ships_pending

	WHERE id=$2 AND planetid=$1 AND (NOT recycle OR end_time IS NULL) FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- give back ships that were to be recycled

	IF r_pending.recycle THEN

		DELETE FROM planet_ships_pending WHERE id=$2 AND planetid=$1;

		IF r_pending.end_time is not null THEN

			INSERT INTO planet_ships(planetid, shipid, quantity)

			VALUES($1, r_pending.shipid, r_pending.quantity);

		END IF;

		RETURN 0;

	END IF;

	IF (NOT r_pending.take_resources) OR (r_pending.end_time IS NOT NULL) THEN

		SELECT INTO r_ship

			cost_ore, cost_hydrocarbon, cost_energy, 0 AS cost_credits, crew, required_shipid, cost_prestige

		FROM db_ships

		WHERE id=r_pending.shipid;

		IF NOT FOUND THEN

			RETURN 1;

		END IF;

		IF r_pending.end_time IS NOT NULL THEN

			percent := r_pending.percentage;

			IF percent > 1.0 THEN

				percent := 1.0;

			ELSEIF percent < 0.5 THEN

				percent := 0.5;

			END IF;

		ELSE

			percent := 1.0;

		END IF;

		PERFORM sp_update_planet($1);

		-- give resources back

		UPDATE nav_planet SET

			ore = ore + LEAST(ore_capacity-ore, int4(percent * r_ship.cost_ore * r_pending.quantity)),

			hydrocarbon = hydrocarbon + LEAST(hydrocarbon_capacity-hydrocarbon, int4(percent * r_ship.cost_hydrocarbon * r_pending.quantity)),

			workers = workers + LEAST(workers_capacity-workers, int4(r_ship.crew) * r_pending.quantity),

			energy = energy + LEAST(energy_capacity-energy, int4(percent * r_ship.cost_energy * r_pending.quantity))

		WHERE id=$1;

		if r_ship.required_shipid IS NOT NULL THEN

			INSERT INTO planet_ships(planetid, shipid, quantity)

			VALUES($1, r_ship.required_shipid, r_pending.quantity);

		END IF;

		IF r_ship.cost_credits > 0 OR r_ship.cost_prestige > 0 THEN

			UPDATE users SET

				credits = credits + int4(percent * r_ship.cost_credits * r_pending.quantity),

				prestige_points_refund = prestige_points_refund + int4(r_ship.cost_prestige * percent * 0.95)

			WHERE id=(SELECT ownerid FROM nav_planet WHERE id=$1 LIMIT 1);

		END IF;

	END IF;

	DELETE FROM planet_ships_pending WHERE id=$2 AND planetid=$1;

	PERFORM sp_continue_ships_construction($1);

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_cancel_ship(_planetid integer, _pending_id integer) OWNER TO exileng;

--
-- Name: sp_cancel_training(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_training(_planetid integer, _trainingid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- cancel construction 

-- Param1: Planet id

-- Param2: Id of planet_training_pending

DECLARE

	r_pending record;

	prices training_price;

	percent float4;

BEGIN

	-- retrieve shipid, quantity, percent built if under construction

	SELECT INTO r_pending

		GREATEST(0, scientists) AS scientists,

		GREATEST(0, soldiers) AS soldiers,

		start_time,

		end_time--,

		--COALESCE( 1.0 - date_part('epoch', now() - start_time) / date_part('epoch', end_time - start_time) / 2.0, 0.98) AS percentage

	FROM planet_training_pending

	WHERE id=_trainingid AND planetid=_planetid FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	prices := sp_get_training_price(0);

	DELETE FROM planet_training_pending WHERE id=_trainingid AND planetid=_planetid;

/*

	percent := r_pending.percentage;

	IF percent > 1.0 THEN

		percent := 1.0;

	ELSEIF percent < 0.5 THEN

		percent := 0.5;

	END IF;

*/

	percent := 1.0;

	PERFORM sp_update_planet(_planetid);

--	RAISE NOTICE '%', int4( (/*prices.scientist_ore * r_pending.scientists*/ + /*prices.soldier_ore */ r_pending.soldiers));

	-- give resources back

	UPDATE nav_planet SET

		ore = LEAST(ore_capacity, ore + int4(percent * (prices.scientist_ore * r_pending.scientists + prices.soldier_ore * r_pending.soldiers) )),

		hydrocarbon = LEAST(hydrocarbon_capacity, hydrocarbon + int4(percent * (prices.scientist_hydrocarbon * r_pending.scientists + prices.soldier_hydrocarbon * r_pending.soldiers) )),

		workers = LEAST(workers_capacity, workers + int4(r_pending.scientists + r_pending.soldiers))

	WHERE id=$1;

	UPDATE users SET credits = credits + int4(percent * (prices.scientist_credits * r_pending.scientists + prices.soldier_credits * r_pending.soldiers) )

	WHERE id=(SELECT ownerid FROM nav_planet WHERE id=_planetid LIMIT 1);

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_cancel_training(_planetid integer, _trainingid integer) OWNER TO exileng;

--
-- Name: sp_cancel_waiting(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_cancel_waiting(_ownerid integer, _fleetid integer) RETURNS void
    LANGUAGE sql
    AS $_$-- sp_cancel_waiting

UPDATE fleets SET

	action_start_time = NULL,

	action_end_time = NULL,

	action = 0,

	next_waypointid = NULL

WHERE ownerid=$1 AND id=$2 AND action=4;$_$;


ALTER FUNCTION static.sp_cancel_waiting(_ownerid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_catastrophe_electromagnetic_storm(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_catastrophe_electromagnetic_storm(integer, integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Add an electromagnetic storm to the planet

-- Param1: UserId (if null, planet owner is taken)

-- Param2: PlanetId

-- Param3: Duration in hours (if null, random duration is computed)

DECLARE

	duration int4;

	planet_ownerid int4;

BEGIN

	IF $3 IS NULL THEN

		duration := int4((8 + random()*3.5)*3600);

	ELSE

		duration := $3*3600;

	END IF;

	-- insert the special building

	INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

	VALUES($2, 91, 1, now()+duration*INTERVAL '1 second');

	IF $1 IS NULL THEN

		SELECT INTO planet_ownerid ownerid FROM nav_planet WHERE id=$2;

	ELSE

		planet_ownerid := $1;

	END IF;

	-- UPDATE planet last_catastrophe

	UPDATE nav_planet SET last_catastrophe = now() WHERE id = $2;

	-- UPDATE user last_catastrophe

	IF planet_ownerid IS NOT NULL THEN

		UPDATE users SET last_catastrophe = now() WHERE id = planet_ownerid;

	END IF;

	-- create the begin and end reports

	IF planet_ownerid IS NOT NULL THEN

		INSERT INTO reports(datetime, ownerid, type, subtype, planetid) VALUES(now(), planet_ownerid, 7, 10, $2);

		INSERT INTO reports(datetime, ownerid, type, subtype, planetid) VALUES(now()+duration*INTERVAL '1 second', planet_ownerid, 7, 11, $2);

	END IF;

END;$_$;


ALTER FUNCTION static.sp_catastrophe_electromagnetic_storm(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_chat_channels_leave(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_channels_leave(_userid integer, _channelid integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- sp_chat_channels_leave

BEGIN

	DELETE FROM chat_users WHERE userid=$1 AND channelid=$2;

	-- delete channel if it isn't in the channel list of any user

	DELETE FROM chat_channels WHERE id > 0 AND NOT public AND name IS NOT NULL AND id=$2 AND (SELECT count(1) FROM users_channels WHERE channelid=chat_channels.id AND password=chat_channels.password) = 0;

END;$_$;


ALTER FUNCTION static.sp_chat_channels_leave(_userid integer, _channelid integer) OWNER TO exileng;

--
-- Name: sp_chat_channels_write(integer, integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_channels_write(_userid integer, _channelid integer, _action integer, _parameter character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$-- sp_chat_channels_write

-- action: 0=say, 

DECLARE

	r_user record;

	r_channel record;

	message_id bigint;

BEGIN

	-- check channel exists

	UPDATE chat_users SET

		lastactivity=now()

	WHERE channelid=_channelid AND userid=_userid;

	IF NOT FOUND THEN

		-- not in channel, exit

		RETURN -1;

	END IF;

	SELECT INTO r_user

		login, alliance_id, COALESCE(alliances.tag, '') AS tag

	FROM users

		LEFT JOIN alliances ON (alliances.id = users.alliance_id)

	WHERE users.id=_userid;

	INSERT INTO chat_messages(channelid, allianceid, name, action, parameter)

	VALUES(_channelid, r_user.alliance_id, r_user.login, _action, _parameter)

	RETURNING id INTO message_id;

	RETURN message_id;

END;$$;


ALTER FUNCTION static.sp_chat_channels_write(_userid integer, _channelid integer, _action integer, _parameter character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_chat_channels_write(_userid integer, _channelid integer, _action integer, _parameter character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_chat_channels_write(_userid integer, _channelid integer, _action integer, _parameter character varying) IS 'Write to the channel';


--
-- Name: sp_chat_join(character varying, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_join(_name character varying, _password character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	r_chat record;

	chatid int4;

BEGIN

	SELECT INTO r_chat id, name, password

	FROM chat

	WHERE upper(name)=upper(_name);

	IF NOT FOUND THEN

		chatid := nextval('chat_id_seq');

		INSERT INTO chat(id, name, password) VALUES(chatid, _name, _password);

		RETURN chatid;

	ELSE

		IF r_chat.id < 0 THEN

			RETURN -1;

		END IF;

		IF r_chat.password <> '' AND r_chat.password <> _password THEN

			RETURN -2;

		END IF;

	END IF;

	RETURN r_chat.id;

END;$$;


ALTER FUNCTION static.sp_chat_join(_name character varying, _password character varying) OWNER TO exileng;

--
-- Name: sp_chat_lines_after_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_lines_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

/*

	-- keep only xx lines of chat

	DELETE FROM chat_lines

	WHERE chatid=NEW.chatid AND id < (SELECT min(id) FROM (SELECT id FROM chat_lines WHERE chatid=NEW.chatid ORDER BY datetime DESC LIMIT 100) as t);

*/

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_chat_lines_after_insert() OWNER TO exileng;

--
-- Name: sp_chat_lines_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_lines_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	_chatid int4;

BEGIN

	-- if chatid = 0 then post to the alliance chat

	IF NEW.chatid = 0 THEN

		SELECT INTO _chatid chatid

		FROM alliances 

		WHERE id = NEW.allianceid;

		IF FOUND THEN

			NEW.chatid := _chatid;

			UPDATE chat_onlineusers SET

				lastactivity = now()

			WHERE chatid=NEW.chatid AND userid=NEW.userid;

			IF NOT FOUND THEN

				INSERT INTO chat_onlineusers(chatid, userid) VALUES(NEW.chatid, NEW.userid);

			END IF;

			NEW.message := sp_chat_replace_banned_words(NEW.message);

			RETURN NEW;

		ELSE

			RETURN NULL;

		END IF;

	END IF;

	PERFORM 1

	FROM users_chats

		INNER JOIN chat ON (chat.id=users_chats.chatid AND (chat.password='' OR chat.password = users_chats.password))

	WHERE userid = NEW.userid AND chatid = NEW.chatid;

	IF FOUND THEN

		UPDATE chat_onlineusers SET

			lastactivity = now()

		WHERE chatid=NEW.chatid AND userid=NEW.userid;

		IF NOT FOUND THEN

			INSERT INTO chat_onlineusers(chatid, userid) VALUES(NEW.chatid, NEW.userid);

		END IF;

		NEW.message := sp_chat_replace_banned_words(NEW.message);

		RETURN NEW;

	ELSE

		RETURN NULL;	-- user cant write to this chat

	END IF;

END;$$;


ALTER FUNCTION static.sp_chat_lines_before_insert() OWNER TO exileng;

--
-- Name: sp_chat_onlineusers_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_onlineusers_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	_chatid int4;

BEGIN

/*

	-- if chatid = 0 then post to the alliance chat

	IF NEW.chatid = 0 THEN

		SELECT INTO _chatid chatid

		FROM users

			INNER JOIN alliances ON (alliances.id = users.alliance_id)

		WHERE users.id=NEW.userid;

		IF FOUND THEN

			NEW.chatid := _chatid;

		ELSE

			RETURN NULL;

		END IF;

	END IF;

*/

	UPDATE chat_onlineusers SET

		lastactivity = now()

	WHERE chatid=NEW.chatid AND userid=NEW.userid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_chat_onlineusers_before_insert() OWNER TO exileng;

--
-- Name: sp_chat_replace_banned_words(character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_chat_replace_banned_words(_line character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE

	res varchar;

	r_bans record;

BEGIN

	res := _line;

	FOR r_bans IN

		SELECT regexp, replace_by

		FROM chat_banned_words

	LOOP

		res := regexp_replace(res, r_bans.regexp, r_bans.replace_by, 'ig');

	END LOOP;

	RETURN res;

END;$$;


ALTER FUNCTION static.sp_chat_replace_banned_words(_line character varying) OWNER TO exileng;

--
-- Name: sp_check_battle(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_check_battle(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- Param1: PlanetId

BEGIN

	--RETURN FALSE;

	/*

	PERFORM 1

	FROM fleets f

		INNER JOIN fleets f2 ON (f.ownerid <> f2.ownerid AND (f.action <> -1 AND f.action <> 1 OR f.engaged) AND (f2.action <> -1 AND f2.action <> 1 OR f2.engaged))

	WHERE f.planetid = $1 AND f2.planetid=$1 AND ((sp_relation(f.ownerid, f2.ownerid) = -2 AND (f.military_signature > 0 OR f2.military_signature > 0)) OR (sp_relation(f.ownerid, f2.ownerid) IN (-2,-1) AND (f.attackonsight OR f2.attackonsight)))

	LIMIT 1

	FOR UPDATE;*/

	PERFORM 1

	FROM (SELECT DISTINCT ON (ownerid, action, military_signature > 0, engaged, attackonsight) * FROM fleets WHERE planetid = $1) AS f

		INNER JOIN (SELECT DISTINCT ON (ownerid, action, military_signature > 0, engaged, attackonsight) * FROM fleets WHERE planetid = $1) AS f2 ON (f.ownerid <> f2.ownerid AND (f.action <> -1 AND f.action <> 1 OR f.engaged) AND (f2.action <> -1 AND f2.action <> 1 OR f2.engaged))

	--WHERE ((f.military_signature > 0 OR f2.military_signature > 0) AND sp_relation(f.ownerid, f2.ownerid) = -2) OR ((f.attackonsight OR f2.attackonsight) AND sp_relation(f.ownerid, f2.ownerid) IN (-2,-1))

	WHERE (f.military_signature > 0 OR f2.military_signature > 0) AND (sp_relation(f.ownerid, f2.ownerid) = -2 OR ((f.attackonsight OR f2.attackonsight) AND sp_relation(f.ownerid, f2.ownerid) = -1))

	LIMIT 1;

	IF FOUND THEN

		--UPDATE fleets SET engaged = false WHERE planetid=$1;

		UPDATE fleets SET engaged = true/*, action=0*/ WHERE planetid=$1 AND action <> -1 AND action <> 1;

		UPDATE nav_planet SET next_battle = now() + '5 minutes' WHERE id=$1 AND next_battle IS NULL;

		RETURN TRUE;

	ELSE

		UPDATE fleets SET engaged = false, action=4, action_end_time=now() WHERE engaged AND action=0 AND planetid=$1;

		UPDATE fleets SET engaged = false WHERE engaged AND planetid=$1;

		UPDATE nav_planet SET next_battle = null WHERE id=$1 AND next_battle IS NOT NULL;

		RETURN FALSE;

	END IF;

END;$_$;


ALTER FUNCTION static.sp_check_battle(integer) OWNER TO exileng;

--
-- Name: sp_clear_planet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_clear_planet(integer) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: PlanetId

DELETE FROM planet_buildings_pending WHERE planetid=$1;

DELETE FROM planet_ships_pending WHERE planetid=$1;

DELETE FROM planet_energy_transfer WHERE planetid=$1 OR target_planetid=$1;

UPDATE nav_planet SET

	name = '',

	ore = 0,

	hydrocarbon = 0,

	workers = 0,

	workers_busy = 0,

	scientists = 0,

	soldiers = 0,

	ore_production = 0,

	hydrocarbon_production = 0,

	production_lastupdate = now(),

	colonization_datetime = NULL,

	buy_ore=0,

	buy_hydrocarbon=0

WHERE id = $1;

DELETE FROM planet_buildings USING db_buildings

WHERE (planetid = $1) AND buildingid = db_buildings.id AND NOT db_buildings.is_planet_element;

DELETE FROM planet_ships WHERE planetid=$1;

UPDATE nav_planet SET

	ownerid = null,

	commanderid = null

WHERE id = $1;$_$;


ALTER FUNCTION static.sp_clear_planet(integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_clear_planet(integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_clear_planet(integer) IS 'Delete all buildings on a given planet';


--
-- Name: sp_commander_fleet_bonus_efficiency(bigint, real); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commander_fleet_bonus_efficiency(_ships bigint, _bonus real) RETURNS real
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE

	_eff real;

BEGIN

	IF _ships < 20000 THEN

		RETURN _bonus;

	END IF;

	IF _bonus < 1.0 THEN

		RETURN _bonus;

	END IF;

	_eff := GREATEST(0.0, 1.0 - (_ships - 20000.0) / 180000.0);

	RETURN 1.0 + (_bonus - 1.0) * _eff;

END;$$;


ALTER FUNCTION static.sp_commander_fleet_bonus_efficiency(_ships bigint, _bonus real) OWNER TO exileng;

--
-- Name: sp_commanders_assign(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_assign(integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- param1: UserId

-- param2: CommanderId

-- param3: planetid

-- param4: fleetid

BEGIN

	-- check that the commander belongs to the player

	PERFORM id FROM commanders WHERE ownerid=$1 AND id=$2 AND recruited <= now();

	IF NOT FOUND THEN

		RETURN 1;	-- commander not found

	END IF;

	IF $3 IS NOT NULL AND $4 IS NOT NULL THEN

		RETURN 2;

	END IF;

	-- remove the commander from any planets

	UPDATE nav_planet SET

		commanderid=null

	WHERE commanderid=$2;

	-- remove the commander from any fleets

	UPDATE fleets SET

		commanderid=null

	WHERE commanderid=$2 AND action=0 AND NOT engaged;

	PERFORM id FROM fleets WHERE commanderid=$2;

	IF FOUND THEN

		RAISE EXCEPTION 'comander busy in a fleet';

	END IF;

	-- assign new planet

	IF $3 IS NOT NULL THEN

		UPDATE nav_planet SET

			commanderid=$2

		WHERE ownerid=$1 AND id=$3;

	END IF;

	-- assign new fleet

	IF $4 IS NOT NULL THEN

		UPDATE fleets SET

			commanderid=$2

		WHERE ownerid=$1 AND id=$4;

	END IF;

	-- update the fleets of the player

	PERFORM sp_update_fleet_bonus(id)

	FROM fleets

	WHERE ownerid=$1;

	RETURN 0;

EXCEPTION

	WHEN CHECK_VIOLATION THEN

		RETURN 3;

	WHEN RAISE_EXCEPTION THEN

		-- a commander is currently busy and can't be changed

		RETURN 4;

END;$_$;


ALTER FUNCTION static.sp_commanders_assign(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_commanders_assign(integer, integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_commanders_assign(integer, integer, integer, integer) IS 'Assign the commander to a planet, a fleet or nothing';


--
-- Name: sp_commanders_check_new_commanders(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_check_new_commanders(_userid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	r_commanders record;

	max_commanders int2;

	x int2;

	_commanders_loyalty int2;

	extra_points int2;

	cost int2;

BEGIN

	-- retrieve the commanders loyalty

	SELECT INTO _commanders_loyalty commanders_loyalty FROM users WHERE id=_userid;

	IF _commanders_loyalty <= 90 THEN

		RETURN 0;

	END IF;

	-- delete old commanders to be able to propose new commanders

	DELETE FROM commanders WHERE ownerid=_userid AND recruited IS NULL AND added < NOW()-INTERVAL '3 days';

	-- retrieve how many commanders the player has and how many should be proposed to player

	SELECT INTO r_commanders

		int4(COALESCE(count(recruited), 0)) AS commanders_recruited,

		int4(COALESCE(count(*)-count(recruited), 0)) AS commanders_proposed

	FROM commanders

	WHERE ownerid=_userid;

	-- retrieve max commanders the player can manage

	SELECT INTO max_commanders mod_commanders FROM users WHERE id=_userid;

	-- compute how many commanders we have to propose to the player

	max_commanders := 1 + max_commanders - r_commanders.commanders_recruited - r_commanders.commanders_proposed;

	WHILE max_commanders > 0 AND _commanders_loyalty > 90 LOOP

		PERFORM 1 FROM commanders WHERE ownerid=_userid AND salary=0;

		IF NOT FOUND THEN

			INSERT INTO commanders(ownerid, points, salary)

			VALUES(_userid, 14, 0);

		ELSE

			x := int2(random()*100);

			extra_points := int2(x / 33);

			cost := 5000 + extra_points*(600+extra_points*50);

			x := int2(random()*100);

			IF x < 75 THEN

				INSERT INTO commanders(ownerid, points, salary)

				VALUES(_userid, 10+extra_points, cost);

			ELSEIF x < 80 THEN

				INSERT INTO commanders(ownerid, points, salary, mod_production_ore)

				VALUES(_userid, 10+extra_points, cost, 1.0 + 0.01*int2(random()*2));

			ELSEIF x < 85 THEN

				INSERT INTO commanders(ownerid, points, salary, mod_production_hydrocarbon)

				VALUES(_userid, 10+extra_points, cost, 1.0 + 0.01*int2(random()*2));

			ELSEIF x < 90 THEN

				INSERT INTO commanders(ownerid, points, salary, mod_construction_speed_buildings)

				VALUES(_userid, 10+extra_points, cost, 1.0 + 0.05*int2(random()*2));

			ELSEIF x < 95 THEN

				INSERT INTO commanders(ownerid, points, salary, mod_construction_speed_ships)

				VALUES(_userid, 10+extra_points, cost, 1.0 + 0.05*int2(random()*2));

			ELSE

				INSERT INTO commanders(ownerid, points, salary, mod_fleet_shield, mod_fleet_handling, mod_fleet_tracking_speed)

				VALUES(_userid, 10+extra_points, cost, 1.0 + 0.02*int2(random()*2), 1.0 + 0.05*int2(random()*2), 1.0 + 0.05*int2(random()*2));

			END IF;

		END IF;

		_commanders_loyalty := _commanders_loyalty - 15;

		max_commanders := max_commanders - 1;

	END LOOP;

	PERFORM sp_commanders_update_salary(_userid, id) FROM commanders WHERE ownerid=_userid;

	-- store the new value of commanders_loyalty

	UPDATE users SET commanders_loyalty = _commanders_loyalty WHERE id=_userid;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_commanders_check_new_commanders(_userid integer) OWNER TO exileng;

--
-- Name: sp_commanders_engage(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_engage(_userid integer, _commanderid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	commanders_max int2;

	commanders_engaged int2;

BEGIN

	-- retrieve max commanders

	SELECT INTO commanders_max

		mod_commanders

	FROM users

	WHERE id=_userid;

	IF NOT FOUND THEN

		RETURN 2;	-- player doesn't exist ?

	END IF;

	-- retrieve number of commanders working for the player

	SELECT INTO commanders_engaged

		int2(count(*))

	FROM commanders

	WHERE ownerid=_userid AND recruited <= now();

	IF commanders_engaged >= commanders_max THEN

		RETURN 3;	-- max commanders reached

	END IF;

	UPDATE commanders SET recruited=now() WHERE ownerid=_userid AND id=_commanderid AND recruited IS NULL;

	IF FOUND THEN

		-- pay the commander

		UPDATE users SET credits=credits-(SELECT salary FROM commanders WHERE ownerid=_userid AND id=_commanderid) WHERE id=_userid;

		RETURN 0;	-- ok

	ELSE

		RETURN 1;	-- commander not found

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_engage(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_commanders_fire(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_fire(_userid integer, _commanderid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$BEGIN

	DELETE FROM commanders WHERE can_be_fired AND ownerid=_userid AND id=_commanderid AND recruited <= now();

	UPDATE users SET commanders_loyalty = commanders_loyalty - 30 WHERE id=_userid;

	IF FOUND THEN

		RETURN 0;

	ELSE

		RETURN 1;

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_fire(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_commanders_prestige_to_train(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_prestige_to_train(_userid integer, _commanderid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	r_commander record;

BEGIN

	SELECT INTO r_commander 

		(1+salary_increases) * 2000 * GREATEST(0.1, date_part('epoch', salary_last_increase + const_interval_before_commander_promotion() - now()) / date_part('epoch', const_interval_before_commander_promotion()))  AS prestige

	FROM commanders

	WHERE ownerid=_userid AND id=_commanderid;

	RETURN r_commander.prestige::integer;

END;$$;


ALTER FUNCTION static.sp_commanders_prestige_to_train(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_commanders_promote(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_promote(_userid integer, _commanderid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$DECLARE

	r_commander record;

BEGIN

	UPDATE commanders SET

		salary_increases = salary_increases + 1,

		salary_last_increase = now(),

		points = points + 1

	WHERE id = _commanderid AND ownerid=_userid

	RETURNING INTO r_commander id, ownerid, name;

	IF FOUND THEN

		INSERT INTO reports(ownerid, type, subtype, commanderid, data)

		VALUES(r_commander.ownerid, 3, 20, r_commander.id, '{commander:' || sp__quote(r_commander.name) || '}');

		RETURN true;

	ELSE

		RETURN false;

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_promote(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_commanders_rename(integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_rename(_userid integer, _commanderid integer, _name character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$BEGIN

	IF char_length(_name) < 4 THEN

		RETURN 1;

	END IF;

	UPDATE commanders SET name=_name WHERE ownerid=_userid AND id=_commanderid AND recruited <= now();

	IF FOUND THEN

		RETURN 0;

	ELSE

		RETURN 1;

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_rename(_userid integer, _commanderid integer, _name character varying) OWNER TO exileng;

--
-- Name: sp_commanders_train(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_train(_userid integer, _commanderid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$DECLARE

	prestige int;

BEGIN

	-- check commander can be trained

	PERFORM 1 FROM commanders WHERE ownerid=_userid AND id=_commanderid AND last_training <= now()-interval '1 day';

	IF NOT FOUND THEN

		RETURN false;

	END IF;

	-- retrieve training cost

	prestige := sp_commanders_prestige_to_train(_userid, _commanderid);

	-- remove prestige points

	UPDATE users SET prestige_points = prestige_points - prestige WHERE id=_userid AND prestige_points >= prestige;

	IF NOT FOUND THEN

		RETURN false;

	END IF;

	-- promote

	UPDATE commanders SET last_training=now() WHERE ownerid=_userid AND id=_commanderid AND last_training <= now()-interval '1 day' AND salary_increases < 20;

	IF FOUND THEN

		RETURN sp_commanders_promote(_userid, _commanderid);

	ELSE

		RETURN false;

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_train(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_commanders_update_salary(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_commanders_update_salary(_userid integer, _commanderid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	r_commanders record;

BEGIN

	UPDATE commanders SET

		salary = 5000 + 

			(mod_production_ore-1.0)*10000 +

			(mod_production_hydrocarbon-1.0)*10000 +

			(mod_production_energy-1.0)*10000 +

			(mod_production_workers-1.0)*10000 +

			(mod_fleet_speed-1.0)*50000 +

			(mod_fleet_shield-1.0)*50000 +

			(mod_fleet_handling-1.0)*20000 +

			(mod_fleet_tracking_speed-1.0)*20000 +

			(mod_fleet_damage-1.0)*50000 +

			(mod_fleet_signature-1.0)*20000 +

			(mod_construction_speed_buildings-1.0)*20000 +

			(mod_construction_speed_ships-1.0)*50000

	WHERE ownerid=_userid AND id=_commanderid AND salary > 0

	RETURNING INTO r_commanders salary;

	IF FOUND THEN

		RETURN r_commanders.salary;

	ELSE

		RETURN 0;

	END IF;

END;$$;


ALTER FUNCTION static.sp_commanders_update_salary(_userid integer, _commanderid integer) OWNER TO exileng;

--
-- Name: sp_compute_military_points(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_compute_military_points(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$-- param1: BattleId

-- param2: UserId

DECLARE

	c int4;

BEGIN

	SELECT INTO c 

		sum(signature*(before-after))

	FROM battles_ships

		INNER JOIN db_ships ON db_ships.id = battles_ships.shipid

	WHERE battles_ships.battleid=1642 AND owner_id <> 15855 AND

		NOT EXISTS(SELECT battleid FROM battles_relations WHERE battleid=battles_ships.battleid AND ((user1=15855 AND user2=owner_id) OR (user1=owner_id AND user2=15855)));

	RETURN c;

END;$$;


ALTER FUNCTION static.sp_compute_military_points(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_compute_military_points(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_compute_military_points(integer, integer) IS 'Compute how many points a player $2 won from the battle $1';


--
-- Name: sp_continue_ships_construction(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_continue_ships_construction(_planetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: planet id

DECLARE

	r_planet record;

	r_pending record;

	r_ship record;

	to_wait interval;

	p_id int4;

BEGIN

	LOOP

	BEGIN

		-- check if any ship is being built/recycled

		PERFORM 1

		FROM planet_ships_pending

		WHERE planetid=_planetid AND end_time IS NOT NULL;

		IF FOUND THEN

			RETURN 0;

		END IF;

		-- remove shipyard_next_continue timestamp

		UPDATE nav_planet SET

			shipyard_next_continue = NULL

		WHERE id=_planetid AND NOT shipyard_suspended;

		IF NOT FOUND THEN

			RETURN 0;

		END IF;

		-- select next ship to build/recycle from pending list

		SELECT INTO r_pending

			id, shipid, quantity, recycle, take_resources

		FROM planet_ships_pending

		WHERE planetid=_planetid AND end_time IS NULL

		ORDER BY start_time, id LIMIT 1 FOR UPDATE;

		IF FOUND THEN

			SELECT INTO r_ship

				construction_time, cost_ore, cost_hydrocarbon, cost_energy, 0 AS cost_credits, crew, required_shipid, cost_prestige

			FROM vw_ships

			WHERE planetid=_planetid AND id=r_pending.shipid;

			IF r_pending.recycle THEN

				r_ship.construction_time := int4(const_ship_recycling_multiplier() * r_ship.construction_time);

				UPDATE planet_ships SET

					quantity = quantity - 1

				WHERE planetid=_planetid AND shipid=r_pending.shipid AND quantity >= 1;

				IF NOT FOUND THEN

					RAISE EXCEPTION 'no ship to recycle';

				END IF;

			ELSEIF r_pending.take_resources THEN

				PERFORM sp_update_planet_production(_planetid);

				SELECT INTO r_planet ownerid,

					ore, ore_production, ore_capacity,

					hydrocarbon, hydrocarbon_production, hydrocarbon_capacity,

					energy, energy_production - energy_consumption AS energy_production, energy_capacity,

					workers, workers_busy, workers_capacity, mod_production_workers

				FROM nav_planet

				WHERE id=_planetid;

				IF r_planet.ore >= r_ship.cost_ore AND r_planet.hydrocarbon >= r_ship.cost_hydrocarbon AND r_planet.energy >= r_ship.cost_energy AND (r_planet.workers-r_planet.workers_busy) >= r_ship.crew THEN

					UPDATE nav_planet SET

						ore=ore - r_ship.cost_ore,

						hydrocarbon=hydrocarbon - r_ship.cost_hydrocarbon,

						energy=energy - r_ship.cost_energy,

						workers=workers - r_ship.crew

					WHERE id=_planetid;

					IF r_ship.cost_credits > 0 OR r_ship.cost_prestige > 0 THEN

						UPDATE users SET

							credits=credits-r_ship.cost_credits,

							prestige_points=prestige_points-r_ship.cost_prestige

						WHERE id=r_planet.ownerid AND prestige_points >= r_ship.cost_prestige;

						IF NOT FOUND THEN

							RAISE EXCEPTION 'Not enough prestige';

						END IF;

					END IF;

				ELSE

					to_wait := INTERVAL '-1 hour';

					IF (r_planet.ore < r_ship.cost_ore AND r_planet.ore_production > 0) THEN

						to_wait := GREATEST(to_wait, (float8(r_ship.cost_ore) - r_planet.ore) / r_planet.ore_production * INTERVAL '1 hour');

					END IF;

					IF (r_planet.hydrocarbon < r_ship.cost_hydrocarbon AND r_planet.hydrocarbon_production > 0) THEN

						to_wait := GREATEST(to_wait, (float8(r_ship.cost_hydrocarbon) - r_planet.hydrocarbon) / r_planet.hydrocarbon_production * INTERVAL '1 hour');

					END IF;

					IF (r_planet.energy < r_ship.cost_energy AND r_planet.energy_production > 0) THEN

						to_wait := GREATEST(to_wait, (float8(r_ship.cost_energy) - r_planet.energy) / r_planet.energy_production * INTERVAL '1 hour');

					END IF;

					IF r_planet.workers < r_ship.crew AND r_planet.workers*r_planet.mod_production_workers/100 > 0 THEN

						to_wait := GREATEST(to_wait, (float8(r_ship.crew) - r_planet.workers) / (r_planet.workers*r_planet.mod_production_workers/100) * INTERVAL '1 hour');

					END IF;

					IF to_wait = INTERVAL '-1 hour' THEN

						to_wait := INTERVAL '24 hours';

					END IF;

					UPDATE nav_planet SET shipyard_next_continue = now() + to_wait WHERE id=_planetid;

					RETURN 0;

				END IF;

				IF r_ship.required_shipid IS NOT NULL THEN

					UPDATE planet_ships SET

						quantity = quantity - 1

					WHERE planetid=_planetid AND shipid=r_ship.required_shipid AND quantity >= 1;

					IF NOT FOUND THEN

						RAISE EXCEPTION 'not enough required ship';

					END IF;

				END IF;

			END IF;

			-- extract one ship from the pending ship list

			IF r_pending.quantity > 1 THEN

				UPDATE planet_ships_pending SET quantity = quantity - 1 WHERE id=r_pending.id;

			ELSE

				DELETE FROM planet_ships_pending WHERE id=r_pending.id;

			END IF;

			-- insert the ship to be built/recycled into the pending list

			SELECT INTO p_id COALESCE(min(id)-1, 1) FROM planet_ships_pending;

			IF FOUND AND p_id > 0 THEN

				BEGIN

					INSERT INTO planet_ships_pending(id, planetid, shipid, start_time, end_time, recycle)

					VALUES(p_id, _planetid, r_pending.shipid, now(), now() + r_ship.construction_time * INTERVAL '1 second', r_pending.recycle);

				EXCEPTION

					WHEN OTHERS THEN

						p_id := 0;

				END;

			END IF;

			IF p_id <= 0 THEN

				INSERT INTO planet_ships_pending(planetid, shipid, start_time, end_time, recycle)

				VALUES(_planetid, r_pending.shipid, now(), now() + r_ship.construction_time * INTERVAL '1 second', r_pending.recycle);

			END IF;

		END IF;

		RETURN 0;

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			PERFORM sp_cancel_ship(_planetid, r_pending.id);

		WHEN CHECK_VIOLATION THEN

			--UPDATE nav_planet SET shipyard_next_continue=

			RETURN 0;

	END;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_continue_ships_construction(_planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_continue_ships_construction(_planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_continue_ships_construction(_planetid integer) IS 'Continue production of ships on planet id $1';


--
-- Name: sp_continue_training(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_continue_training(_planetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: planet id

DECLARE

	r_pending record;

	r_training record;

	r_planet record;

BEGIN

	LOOP

	BEGIN

		-- check if any training is being done

		SELECT INTO r_training

			COALESCE(sum(scientists), 0) AS scientists,

			COALESCE(sum(soldiers), 0) AS soldiers

		FROM planet_training_pending

		WHERE planetid=_planetid AND end_time IS NOT NULL;

		IF FOUND AND r_training.scientists > 0 AND r_training.soldiers > 0 THEN

			RETURN 0;

		END IF;

		-- retrieve how much we can train every "batch"

		SELECT INTO r_planet

			GREATEST(0, LEAST(scientists_capacity-scientists, training_scientists)) AS training_scientists,

			GREATEST(0, LEAST(soldiers_capacity-soldiers, training_soldiers)) AS training_soldiers

		FROM nav_planet

		WHERE id=_planetid;

		IF r_training.scientists = 0 THEN

			-- delete any scientists we have to train in queue if we can't train them

			IF r_planet.training_scientists = 0 THEN

				PERFORM sp_cancel_training(_planetid, id)

				FROM planet_training_pending

				WHERE planetid=_planetid AND scientists > 0;

			ELSE

				-- see how many scientists there are to train

				SELECT INTO r_pending

					id, scientists

				FROM planet_training_pending

				WHERE planetid=_planetid AND end_time IS NULL AND scientists > 0

				ORDER BY start_time LIMIT 1 FOR UPDATE;

				IF FOUND THEN

					IF r_pending.scientists > r_planet.training_scientists THEN

						UPDATE planet_training_pending SET

							scientists = GREATEST(0, scientists - r_planet.training_scientists)

						WHERE id=r_pending.id;

						r_pending.scientists := r_planet.training_scientists;

					ELSE

						DELETE FROM planet_training_pending WHERE id=r_pending.id;

					END IF;

					-- insert the training to be done into the pending list

					INSERT INTO planet_training_pending(planetid, scientists, start_time, end_time)

					VALUES(_planetid, r_pending.scientists, now(), now() + INTERVAL '1 hour');

				END IF;

			END IF;

		END IF;

		IF r_training.soldiers = 0 THEN

			-- delete any soldiers we have to train in queue if we can't train them

			IF r_planet.training_soldiers = 0 THEN

				PERFORM sp_cancel_training(_planetid, id)

				FROM planet_training_pending

				WHERE planetid=_planetid AND soldiers > 0;

			ELSE

				-- see how many soldiers there are to train

				SELECT INTO r_pending

					id, soldiers

				FROM planet_training_pending

				WHERE planetid=_planetid AND end_time IS NULL AND soldiers > 0

				ORDER BY start_time LIMIT 1 FOR UPDATE;

				IF FOUND THEN

					IF r_pending.soldiers > r_planet.training_soldiers THEN

						UPDATE planet_training_pending SET

							soldiers = GREATEST(0, soldiers - r_planet.training_soldiers)

						WHERE id=r_pending.id;

						r_pending.soldiers := r_planet.training_soldiers;

					ELSE

						DELETE FROM planet_training_pending WHERE id=r_pending.id;

					END IF;

					-- insert the training to be done into the pending list

					INSERT INTO planet_training_pending(planetid, soldiers, start_time, end_time)

					VALUES(_planetid, r_pending.soldiers, now(), now() + INTERVAL '1 hour');

				END IF;

			END IF;

		END IF;

		RETURN 0;

	EXCEPTION

		WHEN RAISE_EXCEPTION THEN

			PERFORM sp_cancel_training(_planetid, r_pending.id);

	END;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_continue_training(_planetid integer) OWNER TO exileng;

--
-- Name: sp_create_alliance(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_alliance("UserId" integer, "AllianceName" character varying, "AllianceTag" character varying, "AllianceDescription" character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	_allianceid int4;

	_chatid int8;

BEGIN

	-- check that user is not in an alliance and that he can create an alliance

	PERFORM id FROM users WHERE id=$1 AND alliance_id IS NULL AND (alliance_left IS NULL OR alliance_left < now());

	IF NOT FOUND THEN

		-- The user either doesn't exist, is already in an alliance or can't create an alliance for now

		RETURN -1;

	END IF;

	-- create the alliance

	BEGIN

		-- try to get the money first to prevent any further queries in case the user doesn't have enough money

		-- raise a check_violation if the player have not enough money

		UPDATE users SET credits=credits-10000 WHERE id=$1 AND credits >= 10000;

		IF NOT FOUND THEN

			RETURN -4; -- not enough money

		END IF;

		-- delete alliances with no members that conflict with the chosen names/tags

		DELETE FROM alliances 

		WHERE (upper(name) = upper($2) OR upper(tag) = upper($3)) AND (SELECT count(*) FROM users WHERE alliance_id=alliances.id) = 0;

		-- retrieve an alliance id

		_allianceid := nextval('alliances_id_seq');

		-- create chat cannal for the alliance

		_chatid := nextval('chat_id_seq');

		INSERT INTO chat(id) VALUES(_chatid);

		INSERT INTO alliances(id, name, tag, description, chatid)

		VALUES(_allianceid, $2, upper($3), $4, _chatid);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, members_displayed, can_manage_description, can_manage_announce, can_see_members_info, can_order_other_fleets, can_use_alliance_radars)

		VALUES(_allianceid, 0, 'Responsable', true, true, true, true, true, true, true, true, true, true, false, true, true, true, true, true, true);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, can_see_members_info)

		VALUES(_allianceid, 10, 'Trésorier', false, true, true, true, true, true, true, true, true, true, false, true);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, can_see_members_info)

		VALUES(_allianceid, 20, 'Ambassadeur', false, true, true, true, true, true, true, false, false, true, false, true);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, can_see_members_info)

		VALUES(_allianceid, 30, 'Officier recruteur', false, true, true, false, false, true, true, false, false, false, false, true);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, can_see_members_info)

		VALUES(_allianceid, 40, 'Officier', false, false, false, false, false, true, true, false, false, false, false, true);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default)

		VALUES(_allianceid, 50, 'Membre', false, false, false, false, false, true, false, false, false, false, false);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, enabled)

		VALUES(_allianceid, 60, 'Grade #7', false, false, false, false, false, false, false, false, false, false, false, false);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, enabled)

		VALUES(_allianceid, 70, 'Grade #8', false, false, false, false, false, false, false, false, false, false, false, false);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default, enabled)

		VALUES(_allianceid, 80, 'Grade #9', false, false, false, false, false, false, false, false, false, false, false, false);

		INSERT INTO alliances_ranks(allianceid, rankid, label, leader, can_invite_player, can_kick_player, can_create_nap, can_break_nap, can_ask_money, can_see_reports, can_accept_money_requests, can_change_tax_rate, can_mail_alliance, is_default)

		VALUES(_allianceid, 100, 'Novice', false, false, false, false, false, false, false, false, false, false, true);

		UPDATE users SET

			alliance_id=_allianceid,

			alliance_rank=0,

			alliance_joined=now(),

			alliance_left=null

		WHERE id=$1;

		-- declare war

		PERFORM sp_alliance_war_declare(1, upper($3));

		PERFORM sp_alliance_war_declare(2, upper($3));

		RETURN _allianceid;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN

			PERFORM id FROM alliances WHERE upper(name)=upper($2);

			-- it is either a duplicate name or tag

			IF FOUND THEN

				-- duplicate name

				RETURN -2;

			ELSE

				-- duplicate tag

				RETURN -3;

			END IF;

	END;

END;$_$;


ALTER FUNCTION static.sp_create_alliance("UserId" integer, "AllianceName" character varying, "AllianceTag" character varying, "AllianceDescription" character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_create_alliance("UserId" integer, "AllianceName" character varying, "AllianceTag" character varying, "AllianceDescription" character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_create_alliance("UserId" integer, "AllianceName" character varying, "AllianceTag" character varying, "AllianceDescription" character varying) IS 'Create an alliance and return the alliance id. In case of error, a negative number is returned :

-1 : User doesn''t exist or is already in an alliance

-2 : Alliance name already exists

-3 : Alliance tag already exists

-4 : Player has not the required credits';


--
-- Name: sp_create_battle(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_battle(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: planetid where battle happened

DECLARE

	battleid int4;

BEGIN

	battleid := nextval('battles_id_seq');

	INSERT INTO battles(id, planetid, rounds, key) VALUES(battleid, $1, $2, sp_create_key());

	RETURN battleid;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN sp_create_battle($1, $2);

END;$_$;


ALTER FUNCTION static.sp_create_battle(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_create_battle(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_create_battle(integer, integer) IS 'Create a new battle entry and return the ID of this battle';


--
-- Name: sp_create_commander(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_commander(integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

DECLARE

	commanderid int4;

BEGIN

	commanderid := nextval('commanders_id_seq');

	INSERT INTO commanders(id, ownerid, name) VALUES(commanderid, $1, sp_create_commander_name());

	RETURN commanderid;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN sp_create_commander($1);

END;$_$;


ALTER FUNCTION static.sp_create_commander(integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_create_commander(integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_create_commander(integer) IS 'Create a new commander and return the ID of this commander';


--
-- Name: sp_create_commander_name(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_commander_name() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT (SELECT name FROM db_firstnames ORDER BY random() LIMIT 1) || ' ' || (SELECT name FROM db_names ORDER BY random() LIMIT 1);$$;


ALTER FUNCTION static.sp_create_commander_name() OWNER TO exileng;

--
-- Name: sp_create_fleet(integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_fleet(integer, integer, character varying) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$-- Create a new fleet, it is possible to create a fleet anywhere

-- Param1: owner id

-- Param2: planet id

-- Param3: fleet name

DECLARE

	fleet_id int4;

BEGIN

	fleet_id := nextval('fleets_id_seq');

	PERFORM 1

	FROM fleets

	WHERE ownerid=$1

	HAVING count(*) > (SELECT mod_fleets FROM users WHERE id=$1);

	IF FOUND THEN

		RETURN -3;

	END IF;

	INSERT INTO fleets(id, ownerid, planetid, name, idle_since)

	VALUES(fleet_id, $1, $2, $3, now());

	PERFORM sp_update_fleet_bonus(fleet_id);

	RETURN fleet_id;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN -2;

END;$_$;


ALTER FUNCTION static.sp_create_fleet(integer, integer, character varying) OWNER TO exileng;

--
-- Name: sp_create_fleet(integer, integer, character varying, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_fleet(integer, integer, character varying, boolean) RETURNS integer
    LANGUAGE plpgsql STRICT
    AS $_$-- Create a new fleet, it is possible to create a fleet anywhere

-- Param1: owner id

-- Param2: planet id

-- Param3: fleet name

-- Param4: bypass fleet count limitation

DECLARE

	fleet_id int4;

BEGIN

	fleet_id := nextval('fleets_id_seq');

	IF NOT $4 THEN

		PERFORM 1

		FROM fleets

		WHERE ownerid=$1

		HAVING count(*) > (SELECT mod_fleets FROM users WHERE id=$1);

		IF FOUND THEN

			RETURN -3;

		END IF;

	END IF;

	INSERT INTO fleets(id, ownerid, planetid, name, idle_since)

	VALUES(fleet_id, $1, $2, $3, now());

	PERFORM sp_update_fleet_bonus(fleet_id);

	RETURN fleet_id;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN -2;

END;$_$;


ALTER FUNCTION static.sp_create_fleet(integer, integer, character varying, boolean) OWNER TO exileng;

--
-- Name: sp_create_key(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_key() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT substring(md5(int2(random()*1000) || chr(int2(65+random()*25)) || chr(int2(65+random()*25)) || date_part('epoch', now()) || chr(int2(65+random()*25)) || chr(int2(65+random()*25))) from 4 for 8);$$;


ALTER FUNCTION static.sp_create_key() OWNER TO exileng;

--
-- Name: sp_create_route(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_route(integer, character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Route name

DECLARE

	routeid int4;

BEGIN

	routeid := nextval('public.routes_id_seq');

	IF $2 IS NULL THEN

		INSERT INTO routes(id, ownerid, name) VALUES(routeid, $1, 'r_' || routeid);

	ELSE

		INSERT INTO routes(id, ownerid, name) VALUES(routeid, $1, $2);

	END IF;

	RETURN routeid;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN sp_create_route($1, $2);

END;$_$;


ALTER FUNCTION static.sp_create_route(integer, character varying) OWNER TO exileng;

--
-- Name: sp_create_route_recycle_move(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_route_recycle_move(integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$-- Create a route to recycle resources then move to a planet

-- Param1: PlanetId

DECLARE

	route_id int8;

	waypoint_id int8;

BEGIN

	-- create route

	route_id := sp_create_route(null, null);

	waypoint_id := sp_wp_append_recycle(route_id);

	PERFORM sp_wp_append_move(route_id, $1);

	RETURN waypoint_id;

END;$_$;


ALTER FUNCTION static.sp_create_route_recycle_move(integer) OWNER TO exileng;

--
-- Name: sp_create_route_unload_move(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_route_unload_move(integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$-- Create a route to unload resources then move to a planet

-- Param1: PlanetId

DECLARE

	route_id int8;

	waypoint_id int8;

BEGIN

	-- create route

	route_id := sp_create_route(null, null);

	waypoint_id := sp_wp_append_unloadall(route_id);

	PERFORM sp_wp_append_move(route_id, $1);

	RETURN waypoint_id;

END;$_$;


ALTER FUNCTION static.sp_create_route_unload_move(integer) OWNER TO exileng;

--
-- Name: sp_create_spy(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_create_spy(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Create a new intelligence report

-- Param1: owner id

-- Param2: report type

-- - 1 nation infos

-- - 2 fleets infos

-- - 3 planet infos

-- Param3: spy level

-- - 0 cheap

-- - 1 normal

-- - 2 best

-- - 3 ultra

DECLARE

	spy_id integer;

BEGIN

	spy_id := nextval('spy_id_seq');

	INSERT INTO spy(id, userid, date, "type", level, key)

	VALUES(spy_id, $1, now()+interval '1 hour', $2, $3, sp_create_key() );

	RETURN spy_id;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN -1;

	WHEN UNIQUE_VIOLATION THEN

		RETURN sp_create_spy($1, $2, $3);

END;$_$;


ALTER FUNCTION static.sp_create_spy(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_daily_cleaning(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_daily_cleaning() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET credits=1000000 WHERE id <= 5;

	DELETE FROM alliances_reports WHERE datetime < now() - INTERVAL '2 weeks';

	-- remove alliance wallet journal entries older than a month

	DELETE FROM alliances_wallet_journal WHERE datetime < now() - INTERVAL '2 weeks';

	DELETE FROM reports WHERE datetime < now() - INTERVAL '2 weeks';

	DELETE FROM messages WHERE datetime < now() - INTERVAL '2 month';

	-- remove IP addresses older than 3 months

	DELETE FROM users_connections WHERE datetime < now() - INTERVAL '3 months';

	-- remove users expenses older than 2 weeks

	DELETE FROM users_expenses WHERE datetime < now() - INTERVAL '2 week';

	DELETE FROM log_failed_logins WHERE datetime < now()-INTERVAL '2 week';

	DELETE FROM log_http_errors WHERE datetime < now()-INTERVAL '1 week';

	DELETE FROM log_notices WHERE datetime < now()-INTERVAL '1 week';

	DELETE FROM market_history WHERE datetime < now()-INTERVAL '2 months';

	DELETE FROM users_newemails WHERE expiration < now();

	-- clean chats

	DELETE FROM chat_lines WHERE datetime < now()-INTERVAL '2 weeks';

	DELETE FROM chat WHERE id > 0 AND NOT public AND name IS NOT NULL AND (SELECT count(1) FROM users_chats WHERE chatid=chat.id) = 0;

	DELETE FROM chat_onlineusers WHERE lastactivity < now() - INTERVAL '15 minutes';

	-- destroy lost fleets

	PERFORM sp_abandon_fleet(2, id) FROM fleets WHERE ownerid=2 AND idle_since < now() - INTERVAL '1 day';

	DELETE FROM fleets WHERE planetid is null AND dest_planetid is null AND idle_since < now() - INTERVAL '1 week' AND action = 0;

	UPDATE fleets SET action=4 WHERE action = 2 and recycler_output = 0;

	UPDATE users SET

		planets = 0

	WHERE planets > 0 AND NOT EXISTS(SELECT 1 FROM nav_planet WHERE ownerid=users.id LIMIT 1);

	RETURN;

END;$$;


ALTER FUNCTION static.sp_daily_cleaning() OWNER TO exileng;

--
-- Name: sp_daily_credits_production(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_daily_credits_production() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT id, ownerid, int4(credits_production + credits_random_production * random()) AS credits

		FROM nav_planet

		WHERE ownerid IS NOT NULL AND (credits_production > 0 OR credits_random_production > 0) AND not production_frozen

	LOOP

		UPDATE users SET

			credits = credits + r_planet.credits

		WHERE id=r_planet.ownerid;

		INSERT INTO reports(ownerid, type, subtype, credits, planetid)

		VALUES(r_planet.ownerid, 5, 10, r_planet.credits, r_planet.id);

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_daily_credits_production() OWNER TO exileng;

--
-- Name: sp_daily_update_scores(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_daily_update_scores() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_player record;

	i int4;

BEGIN

	-- update players scores

	FOR r_player IN

		SELECT id FROM vw_players

	LOOP

		i := 0;

		<<retries>>

		WHILE i < 5 LOOP

			i := i + 1;

			BEGIN

				RAISE NOTICE 'updating %', r_player.id;

				PERFORM sp_update_player_score(r_player.id);

				EXIT retries;

			EXCEPTION

				WHEN OTHERS THEN

					RAISE NOTICE '%', SQLERRM;

			END;

		END LOOP retries;

	END LOOP;

	-- update alliances scores

	UPDATE alliances SET

		previous_score=score,

		score=COALESCE((SELECT sum(score_global) FROM users WHERE privilege=0 AND alliance_id=alliances.id),0)/1000;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_daily_update_scores() OWNER TO exileng;

--
-- Name: sp_delete_account(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_delete_account(integer) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: Userid

-- remove the player from his alliance to assign a new leader or delete the alliance

UPDATE users SET alliance_id=null WHERE id=$1;

-- delete player commanders, researches_pending

DELETE FROM commanders WHERE ownerid=$1;

DELETE FROM researches_pending WHERE userid=$1;

-- give player planets to the lost worlds

UPDATE nav_planet SET commanderid=null, ownerid=2 WHERE ownerid=$1;

-- delete player account

DELETE FROM users WHERE id=$1;$_$;


ALTER FUNCTION static.sp_delete_account(integer) OWNER TO exileng;

--
-- Name: sp_destroy_building(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_destroy_building(_userid integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Destroying a build is immediate but it requires that we are not already building another building

-- We also need to check that we do not try to destroy a building that other buildings depend on

-- Param1: user id

-- Param2: planet id

-- Param3: building id

DECLARE

	r_building record;

	r_planet record;

	r_user record;

	demolition_time int4;

	c int4;

BEGIN

	-- check the planet ownership and the next_building_destruction

	SELECT INTO r_planet id, workers-workers_busy AS workers, mod_construction_speed_buildings, 

		energy_receive_antennas, energy_receive_links, energy_send_antennas, energy_send_links

	FROM vw_planets

	WHERE ownerid=_userid AND id=$2;-- AND next_building_destruction <= now();

	IF NOT FOUND THEN

		RETURN 5;

	END IF;

	-- check that the building can be destroyed and retrieve how much ore, hydrocarbon it costs

	SELECT INTO r_building

		cost_ore, cost_hydrocarbon, workers, construction_time, construction_time_exp_per_building,

		energy_receive_antennas, energy_send_antennas

	FROM db_buildings

	WHERE id=$3 AND destroyable AND NOT is_planet_element

	LIMIT 1;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	IF r_building.workers / 2 > r_planet.workers THEN

		RETURN 6;

	END IF;

	-- check receive/send energy links

	IF r_planet.energy_receive_antennas - r_building.energy_receive_antennas < r_planet.energy_receive_links THEN

		RETURN 3;

	END IF;

	IF r_planet.energy_send_antennas - r_building.energy_send_antennas < r_planet.energy_send_links THEN

		RETURN 3;

	END IF;

	-- check that there are no buildings that depends on the building $3 that is going to be destroyed

	PERFORM db_buildings_req_building.buildingid

	FROM db_buildings_req_building 

		INNER JOIN planet_buildings ON (planet_buildings.planetid=$2 AND planet_buildings.buildingid = db_buildings_req_building.buildingid)

		INNER JOIN db_buildings ON (db_buildings.id=db_buildings_req_building.buildingid)

	WHERE required_buildingid = $3 AND quantity > 0 AND db_buildings.destroyable

	LIMIT 1;

	IF FOUND THEN

		RETURN 3;

	END IF;

	-- check that there are no buildings being built that requires the building we're going to destroy

	PERFORM db_buildings_req_building.buildingid

	FROM db_buildings_req_building 

		INNER JOIN planet_buildings_pending ON (planet_buildings_pending.planetid=$2 AND planet_buildings_pending.buildingid = db_buildings_req_building.buildingid)

		INNER JOIN db_buildings ON (db_buildings.id=db_buildings_req_building.buildingid)

	WHERE required_buildingid = $3 AND db_buildings.destroyable

	LIMIT 1;

	IF FOUND THEN

		RETURN 3;

	END IF;

	SELECT INTO r_user mod_recycling FROM users WHERE id=_userid;

	IF NOT FOUND THEN

		RETURN 5;

	END IF;

	SELECT INTO c quantity-1 FROM planet_buildings WHERE planetid=$2 AND buildingid=$3;

	demolition_time := int4(0.05*sp_get_construction_time(r_building.construction_time, r_building.construction_time_exp_per_building, c, r_planet.mod_construction_speed_buildings));

	BEGIN

		INSERT INTO users_expenses(userid, credits_delta, planetid, buildingid)

		VALUES($1, 1, $2, $3);

		-- set building demolition datetime

		UPDATE planet_buildings SET

			destroy_datetime = now()+demolition_time*INTERVAL '1 second'

		WHERE planetid=$2 AND buildingid=$3 AND destroy_datetime IS NULL;

/*

		IF FOUND THEN

			UPDATE nav_planet SET

				ore = LEAST(ore_capacity, ore + r_building.cost_ore*(0.3 + r_user.mod_recycling/100.0)),

				hydrocarbon = LEAST(hydrocarbon_capacity, hydrocarbon + r_building.cost_hydrocarbon*(0.3 + r_user.mod_recycling/100.0))

			WHERE id=$2;

		END IF;

*/

		RETURN 0;

	EXCEPTION

		WHEN CHECK_VIOLATION THEN

			RETURN 4;

	END;

END;$_$;


ALTER FUNCTION static.sp_destroy_building(_userid integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_destroy_building(_userid integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_destroy_building(_userid integer, integer, integer) IS 'Destroy a building on a planet only if not building on this planet and no other buildings depend on the building';


--
-- Name: sp_destroy_planet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_destroy_planet(_planetid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	PERFORM sp_clear_planet(_planetid);

	UPDATE nav_planet SET

		floor = 0,

		planet_floor = 0,

		space = 0,

		planet_space = 0,

		spawn_ore = (40000 * (1.0 + random()))::integer,

		spawn_hydrocarbon = (40000 * (1.0 + random()))::integer

	WHERE id=_planetid;

END;$$;


ALTER FUNCTION static.sp_destroy_planet(_planetid integer) OWNER TO exileng;

--
-- Name: sp_destroy_planet_ship(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_destroy_planet_ship(_planet_id integer, _ship_id integer, _quantity integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	total int8;

	q int4;

BEGIN

	IF _ship_id = 999 THEN

		RETURN;

	END IF;

	q := LEAST(int4(1 + (0.75+0.20*random())*_quantity), _quantity);

	UPDATE planet_ships SET

		quantity = quantity - q

	WHERE planetid = _planet_id AND shipid = _ship_id AND quantity >= q;

	IF NOT FOUND THEN

		RETURN;

	END IF;

	SELECT INTO total (int8(q) * int8(db_ships.cost_ore)) / 1000

	FROM db_ships

	WHERE id=_ship_id;

	IF FOUND THEN

		INSERT INTO planet_ships(planetid, shipid, quantity)

		VALUES(_planet_id, 999, total);

	END IF;

END;$$;


ALTER FUNCTION static.sp_destroy_planet_ship(_planet_id integer, _ship_id integer, _quantity integer) OWNER TO exileng;

--
-- Name: sp_destroy_ships(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_destroy_ships(integer, integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: FleetId

-- Param2: ShipId

-- Param3: Quantity

DECLARE

	fleet record;

	ship record;

	cargo_lost int4;

	cargo_unused int4;

	new_cargo_capacity int4;

	p float;

	lost_ore int4;

	lost_hydrocarbon int4; 

	lost_scientists int4;

	lost_soldiers int4;

	lost_workers int4;

	tmp int4;

BEGIN

	-- retrieve fleet cargo info

	SELECT INTO fleet

		planetid,

		cargo_capacity, 

		cargo_ore+cargo_hydrocarbon+cargo_scientists+cargo_soldiers+cargo_workers AS cargo_used,

		cargo_ore, cargo_hydrocarbon, cargo_scientists, cargo_soldiers, cargo_workers

	FROM fleets

	WHERE id=$1 FOR UPDATE;

	cargo_unused := fleet.cargo_capacity - fleet.cargo_used;

	lost_ore := 0;

	lost_hydrocarbon := 0;

	lost_scientists := 0;

	lost_soldiers := 0;

	lost_workers := 0;

	-- there is something, we will have to compute how much is lost when we remove the ships

	SELECT INTO ship

		cost_ore, cost_hydrocarbon, capacity

	FROM db_ships

	WHERE id=$2;

	-- check if there is something in the fleet cargo

	IF fleet.cargo_used > 0 THEN

		cargo_lost := ship.capacity*$3;

		cargo_lost := cargo_lost - cargo_unused;

		--RAISE NOTICE 'cargo lost: %', cargo_lost;

		IF cargo_lost > 0 THEN

			new_cargo_capacity := fleet.cargo_used - cargo_lost;

			--RAISE NOTICE 'new cargo: %', new_cargo_capacity;

			IF new_cargo_capacity = 0 THEN

				lost_ore := fleet.cargo_ore;

				lost_hydrocarbon := fleet.cargo_hydrocarbon;

				lost_scientists := fleet.cargo_scientists;

				lost_soldiers := fleet.cargo_soldiers;

				lost_workers := fleet.cargo_workers;

			ELSE

				-- compute percent of cargo lost

				p := 1.0 - (new_cargo_capacity / fleet.cargo_used);

				WHILE cargo_lost > 0 LOOP

					-- lost ore

					tmp := int4((random()*p)*(fleet.cargo_ore-lost_ore));

					tmp := LEAST(tmp, cargo_lost);

					lost_ore := lost_ore + tmp;

					cargo_lost := cargo_lost - tmp;

					--RAISE NOTICE 'ore %', lost_ore;

					-- lost hydrocarbon

					tmp := int4((random()*p)*(fleet.cargo_hydrocarbon-lost_hydrocarbon));

					tmp := LEAST(tmp, cargo_lost);

					lost_hydrocarbon := lost_hydrocarbon + tmp;

					cargo_lost := cargo_lost - tmp;

					--RAISE NOTICE 'hydro %', lost_hydrocarbon;

					-- lost scientists

					tmp := int4((random()*p)*(fleet.cargo_scientists-lost_scientists));

					tmp := LEAST(tmp, cargo_lost);

					lost_scientists := lost_scientists + tmp;

					cargo_lost := cargo_lost - tmp;

					-- lost soldiers

					tmp := int4((random()*p)*(fleet.cargo_soldiers-lost_soldiers));

					tmp := LEAST(tmp, cargo_lost);

					lost_soldiers := lost_soldiers + tmp;

					cargo_lost := cargo_lost - tmp;

					-- lost workers

					tmp := int4((random()*p)*(fleet.cargo_workers-lost_workers));

					tmp := LEAST(tmp, cargo_lost);

					lost_workers := lost_workers + tmp;

					cargo_lost := cargo_lost - tmp;

					--EXIT;

				END LOOP;

			END IF;

			--RAISE NOTICE 'cargo: % - lost: %', fleet.cargo_ore, lost_ore;

			UPDATE fleets SET

				cargo_ore = cargo_ore - lost_ore,

				cargo_hydrocarbon = cargo_hydrocarbon - lost_hydrocarbon,

				cargo_scientists = cargo_scientists - lost_scientists,

				cargo_soldiers = cargo_soldiers - lost_soldiers,

				cargo_workers = cargo_workers - lost_workers

			WHERE id=$1;

		END IF;

	END IF;

	UPDATE fleets_ships SET 

		quantity = GREATEST(0, quantity - $3)

	WHERE fleetid=$1 AND shipid=$2;

	UPDATE nav_planet SET

		orbit_ore = LEAST(2147483647, int8(orbit_ore) + int8(lost_ore) + int8(ship.cost_ore)*$3*(0.15+0.10*random())),

		orbit_hydrocarbon = LEAST(2147483647, int8(orbit_hydrocarbon) + int8(lost_hydrocarbon) + int8(ship.cost_hydrocarbon)*$3*(0.15+0.10*random()))

	WHERE id=fleet.planetid;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_destroy_ships(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_destroy_ships(integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_destroy_ships(integer, integer, integer) IS 'Destroy ships of a fleet and remove the necessary cargo';


--
-- Name: sp_dismiss_staff(integer, integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_dismiss_staff(integer, integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: PlanetId

-- Param3: scientists to dismiss

-- Param4: soldiers to dismiss

-- Param5: workers to dismiss

BEGIN

	IF $3 < 0 OR $4 < 0 OR $5 < 0 THEN

		RETURN 1;

	END IF;

	PERFORM 1 FROM nav_planet WHERE ownerid=$1 AND id=$2;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	IF $5 > 0 THEN

		PERFORM sp_update_planet_production($2);

	END IF;

	UPDATE nav_planet SET

		scientists=GREATEST(0, scientists-$3),

		soldiers=GREATEST(0, soldiers-$4),

		workers=LEAST(workers_capacity, GREATEST(workers_busy, workers - LEAST( GREATEST(0, workers-GREATEST(500, workers_for_maintenance/2)), $5 - LEAST(scientists, $3) - LEAST(soldiers, $4) ) ) )

	WHERE id=$2;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_dismiss_staff(integer, integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_dismiss_staff(integer, integer, integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_dismiss_staff(integer, integer, integer, integer, integer) IS 'Dismiss scientists, soldiers or workers from planet';


--
-- Name: sp_event_annihilation_fleets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_annihilation_fleets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_gal record;

	r_planet record;

	r_fleet record;

	c int8;

	fleet_id int4;

	fleet_route int8;

	fleet_wp int8;

	military_sig int8;

	i int4;

	destination int4;

BEGIN

	UPDATE fleets SET

		action = 4, 

		action_end_time = now() 

	WHERE ownerid=1 AND signature <= 1 AND action=0 AND next_waypointid IS NOT NULL;

	FOR r_fleet IN

		SELECT id, planetid, (SELECT galaxy FROM nav_planet WHERE nav_planet.id = fleets.planetid) as galaxy

		FROM fleets

		WHERE ownerid=1 AND signature <= 1 AND planetid IS NOT NULL AND (action_end_time IS NULL OR action_end_time < now()) AND action = 0

	LOOP

		destination := sp_ai_find_nearest_planet(r_fleet.planetid);

		RAISE NOTICE '% : %', r_fleet.id, destination;

		PERFORM 1 FROM fleets WHERE ownerid=1 AND signature <= 1 AND dest_planetid = destination;

		IF FOUND THEN

			SELECT INTO destination

				id

			FROM nav_planet

			WHERE galaxy = r_fleet.galaxy AND floor > 0

			ORDER BY random()

			LIMIT 1;

		END IF;

		fleet_route := sp_create_route(null, null);

		fleet_wp := sp_wp_append_destruction(fleet_route);

		PERFORM sp_wp_append_move(fleet_route, destination);

		PERFORM sp_wp_append_wait(fleet_route, 10);

		UPDATE fleets SET attackonsight = true, next_waypointid=fleet_wp WHERE id=r_fleet.id;

		PERFORM sp_routes_continue(1, r_fleet.id);

	END LOOP;

	FOR r_gal IN

		SELECT id, sp_first_planet(id, 1) AS first, sp_last_planet(id, 99) AS last

		FROM nav_galaxies

	LOOP

		-- check there are enough annihilation fleets in the galaxy

		SELECT INTO c count(*)

		FROM fleets

		WHERE ownerid=1 AND signature <= 1 AND ((planetid >= r_gal.first AND planetid <= r_gal.last) OR (dest_planetid >= r_gal.first AND dest_planetid <= r_gal.last));

		IF c >= 15 THEN

			CONTINUE;

		END IF;

		FOR r_planet IN

			SELECT id

			FROM nav_planet

			WHERE floor > 0 AND galaxy = r_gal.id

			ORDER BY floor

			LIMIT 15 - c

		LOOP

			fleet_id := nextval('fleets_id_seq');

			INSERT INTO fleets(id, ownerid, planetid, name, idle_since, speed)

			VALUES(fleet_id, 1, r_planet.id, 'Les fossoyeurs', now(), 800);

			-- annihilator

			INSERT INTO fleets_ships(fleetid, shipid, quantity)

			VALUES(fleet_id, 959, 1);

			fleet_route := sp_create_route(null, null);

			--fleet_wp := sp_wp_append_move(fleet_route, r_planet.id);

			fleet_wp := sp_wp_append_wait(fleet_route, 10);

			PERFORM sp_wp_append_destruction(fleet_route);

			UPDATE fleets SET attackonsight = true, next_waypointid=fleet_wp WHERE id=fleet_id;

			PERFORM sp_routes_continue(1, fleet_id);

			--RAISE NOTICE 'create fleet % toward %',fleet_id, r_planet.id;

		END LOOP;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_event_annihilation_fleets() OWNER TO exileng;

--
-- Name: sp_event_can_happen(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_can_happen(integer, integer) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: UserId

-- Param2: PlanetId

DECLARE

	res bool;

BEGIN

	SELECT INTO res now()-last_catastrophe > INTERVAL '1 hour' AND (planets > 3) FROM users WHERE id=$1;

	IF FOUND AND NOT res THEN

		RETURN res;

	END IF;

	IF $2 IS NOT NULL THEN

		SELECT INTO res now()-last_catastrophe > INTERVAL '1 hour' FROM nav_planet WHERE id=$2 AND ownerid=$1;

	END IF;

	IF NOT FOUND THEN

		RETURN true;

	ELSE

		RETURN res;

	END IF;

END;$_$;


ALTER FUNCTION static.sp_event_can_happen(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_event_can_happen(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_event_can_happen(integer, integer) IS 'Return whether an event (mostly  catastrophes) can happen for a user or on a planet';


--
-- Name: sp_event_commanders_promotions(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_commanders_promotions() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_commander record;

BEGIN

	FOR r_commander IN

		SELECT id, ownerid, name

		FROM commanders

		WHERE salary_last_increase < now()-INTERVAL '2 week' AND random() < 0.1

	LOOP

		PERFORM sp_commanders_promote(r_commander.ownerid, r_commander.id);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_commanders_promotions() OWNER TO exileng;

--
-- Name: sp_event_decay(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_decay() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT id, ownerid, random() AS x

		FROM nav_planet

		WHERE ownerid > 100 AND buildings_dilapidation > 1000

		ORDER BY random() LIMIT 20

	LOOP

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_decay() OWNER TO exileng;

--
-- Name: sp_event_fleet_delayed(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_fleet_delayed() RETURNS void
    LANGUAGE plpgsql
    AS $$-- fleets moving have a probability to have an engine problem and see their travel time increased a little

DECLARE

	r_fleet record;

BEGIN

	FOR r_fleet IN

		SELECT id, ownerid, name

		FROM fleets

		WHERE dest_planetid IS NOT NULL AND NOT engaged AND action_end_time > now()+INTERVAL '2 hour' AND random() < log(GREATEST(1, signature-military_signature))/50000 FOR UPDATE

	LOOP

		UPDATE fleets SET

			action_start_time = action_start_time - INTERVAL '1 hour',

			action_end_time = action_end_time + INTERVAL '1 hour'

		WHERE id=r_fleet.id;

		-- create a report

		INSERT INTO reports(ownerid, type, subtype, fleetid, fleet_name)

		VALUES(r_fleet.ownerid, 7, 24, r_fleet.id, r_fleet.name);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_fleet_delayed() OWNER TO exileng;

--
-- Name: sp_event_laboratory_accident(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_laboratory_accident() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	p float;

BEGIN

	-- make laboratory explosions more likely to happen between 22:00 and 8:00

	p := Extract(hour from now());

	IF p >= 22 OR p <= 8 THEN

		p := 0.03;

	ELSE

		p := 0.015;

	END IF;

	FOR r_planet IN

		SELECT id, ownerid, 1.0*scientists*LEAST(0.5, 1.0*(workers_for_maintenance-workers)/(1.0+workers_for_maintenance)) AS scientists

		FROM vw_planets

		WHERE ownerid > 100 AND not production_frozen AND scientists > 20 AND random() < 1.0*(1.0+workers_for_maintenance-workers)/(1.0+workers_for_maintenance)*p+0.00001 AND last_catastrophe < now()-INTERVAL '6 hours' FOR UPDATE

	LOOP

		CONTINUE WHEN r_planet.scientists < 1;

		-- kill some scientists

		UPDATE nav_planet SET

			scientists = scientists - r_planet.scientists,

			last_catastrophe = now()

		WHERE id=r_planet.id;

		-- create a report

		INSERT INTO reports(ownerid, type, subtype, planetid, scientists)

		VALUES(r_planet.ownerid, 7, 23, r_planet.id, r_planet.scientists);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_laboratory_accident() OWNER TO exileng;

--
-- Name: sp_event_long(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_long() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	q int4;

	maxstorms float;

BEGIN

	FOR r_planet IN

		SELECT p.id, p.ownerid, planets

		FROM nav_planet AS p

			INNER JOIN users AS u ON (u.id = p.ownerid AND p.ownerid > 100)

		WHERE planet_floor > 0 AND (random() < 0.00005) AND NOT production_frozen AND (u.privilege=0) AND (u.planets > 5) AND (p.last_catastrophe < now()-INTERVAL '48 hours') FOR UPDATE

	LOOP

		-- check that we did not put an electromagnetic storm for this user less than 6 hours ago

		--PERFORM 1 FROM users WHERE id=r_planet.ownerid AND last_catastrophe < now()-INTERVAL '6 hours';

		SELECT INTO q COALESCE(sum(quantity), 0)

		FROM planet_buildings

			INNER JOIN nav_planet ON nav_planet.id=planet_buildings.planetid

		WHERE nav_planet.ownerid=r_planet.ownerid AND buildingid=91;

		-- limit to max 10% of player planets

		maxstorms := r_planet.planets / 10.0;

		IF r_planet.planets > 50 THEN

			-- add 1 more planet every 10 owned planets

			maxstorms := maxstorms + int4((r_planet.planets-50)/10);

		END IF;

		IF q < maxstorms THEN

			PERFORM sp_catastrophe_electromagnetic_storm(r_planet.ownerid, r_planet.id, null);

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_long() OWNER TO exileng;

--
-- Name: sp_event_lost_nations_abandon(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_lost_nations_abandon() RETURNS void
    LANGUAGE plpgsql
    AS $$-- make some planets owned by lost nations join players empires

DECLARE

	r_planet record;

	r_user record;

BEGIN

	-- select a planet to abandon

	SELECT INTO r_planet id, galaxy, sector, planet

	FROM nav_planet

	WHERE ownerid=2 AND production_lastupdate < now()-INTERVAL '1 week' AND random() < 0.1

	ORDER BY random()

	LIMIT 1;

	IF NOT FOUND THEN

		RETURN;

	END IF;

	PERFORM sp_clear_planet(r_planet.id);

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_lost_nations_abandon() OWNER TO exileng;

--
-- Name: FUNCTION sp_event_lost_nations_abandon(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_event_lost_nations_abandon() IS 'Abandon 1 planet of the lost nations';


--
-- Name: sp_event_lottery(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_lottery() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_contestant record;

	_total bigint;

	_winner bigint;

	_fleet_id integer;

BEGIN

	BEGIN

		LOCK TABLE users, messages;

		SELECT INTO _total sum(credits)

		FROM messages

		WHERE ownerid=3 AND read_date IS NULL AND messages.credits > 0;

		_winner := (random() * _total)::bigint;

		FOR r_contestant IN

			SELECT senderid, lcid, login, sum(messages.credits) AS credits

			FROM messages

				INNER JOIN users ON (users.id = messages.senderid)

			WHERE ownerid=3 AND read_date IS NULL AND messages.credits > 0 AND planets > 0

			GROUP BY senderid, lcid, login

			ORDER BY random()

		LOOP

			IF _winner >= 0 AND _winner < r_contestant.credits THEN

				PERFORM sp_send_sys_message(r_contestant.senderid, 11, r_contestant.lcid, r_contestant.credits::character varying, '');

				_fleet_id := nextval('fleets_id_seq');

				INSERT INTO fleets(id, ownerid, planetid, name, idle_since, speed)

				VALUES(_fleet_id, r_contestant.senderid, null, 'Gros lot', now(), 800);

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(_fleet_id, 605, 1);

				UPDATE fleets SET

					dest_planetid = (SELECT id FROM nav_planet WHERE ownerid=r_contestant.senderid ORDER BY blocus_strength ASC, score DESC LIMIT 1),

					action_start_time = now(),

					action_end_time = now() + INTERVAL '8 hours',

					engaged = false,

					action = 1,

					idle_since = null

				WHERE id=_fleet_id;

				INSERT INTO exile_nexus.users_successes(user_id, success_id, universe_id)

				VALUES(r_contestant.senderid, 4, const_universe_id());

			ELSE

				PERFORM sp_send_sys_message(r_contestant.senderid, 10, r_contestant.lcid, r_contestant.credits::character varying, '');

			END IF;

			_winner := _winner - r_contestant.credits;

		END LOOP;

		UPDATE messages SET

			read_date = now()

		WHERE ownerid=3;

		PERFORM sp_send_sys_message(id, 12, lcid)

		FROM users

		WHERE privilege = 0 AND login is not null;

	EXCEPTION

		WHEN NO_DATA_FOUND THEN

			-- nothing, just need to have a when clause

	END;

END;$$;


ALTER FUNCTION static.sp_event_lottery() OWNER TO exileng;

--
-- Name: sp_event_merchants_contract(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_merchants_contract() RETURNS void
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

DECLARE

	r_player record;

	r_user record;

	r_research record;

BEGIN

	FOR r_player IN

		SELECT username, sum(ore_sold) + sum(hydrocarbon_sold) as total_sold

		FROM market_history

		WHERE datetime > now()-interval '1 week'-- AND ore_sold > 0 and hydrocarbon_sold > 0

		GROUP BY username

		ORDER BY total_sold DESC

		LIMIT 20

	LOOP

		SELECT INTO r_user id, lcid

		FROM users

		WHERE login=r_player.username;

		IF FOUND THEN

			SELECT INTO r_research expires < now() as expired FROM researches WHERE userid=r_user.id AND researchid=5;

			IF FOUND THEN

				IF r_research.expired THEN

					PERFORM sp_send_sys_message(r_user.id, 3, r_user.lcid);

					UPDATE researches SET

						expires=now()+INTERVAL '7 days'

					WHERE userid=r_user.id AND researchid=5;

				END IF;

			ELSE

				PERFORM sp_send_sys_message(r_user.id, 2, r_user.lcid);

				INSERT INTO researches(userid, researchid, expires)

				VALUES(r_user.id, 5, now()+INTERVAL '7 days');

				PERFORM sp_update_researches(r_user.id);

			END IF;

		END IF;

	END LOOP;

	FOR r_player IN

		SELECT userid

		FROM researches

		WHERE researchid=5 AND expires IS NOT NULL AND expires < now()

	LOOP

		DELETE FROM researches WHERE userid=r_player.userid AND researchid=5;

		PERFORM sp_send_sys_message(r_player.userid, 4, (SELECT lcid FROM users WHERE id=r_player.userid));

		PERFORM sp_update_researches(r_player.userid);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_merchants_contract() OWNER TO exileng;

--
-- Name: FUNCTION sp_event_merchants_contract(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_event_merchants_contract() IS 'Give a sell bonus to the 20 players that sell the most ressources';


--
-- Name: sp_event_planet_bonus(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_planet_bonus() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	i int2;

	time int4;

BEGIN

	-- BAD ISSUE with random() makes it returns always the same random() value for each joined row

	FOR r_planet IN

		SELECT * FROM

		(SELECT p.id, p.ownerid, random() * users.planets * 2 as rand, ore_production, hydrocarbon_production, workers, workers_capacity

		FROM vw_planets p

			JOIN users ON (users.id = p.ownerid AND users.privilege=0)

		WHERE p.ownerid > 100 AND planets <= 20 AND not production_frozen

		OFFSET 0) as t

		where t.rand < 0.05

	LOOP

		i := int2(random()*2);

		-- baby boom : 50

		-- ore bonus : 51

		-- hydrocarbon bonus : 52

		IF i = 0 AND false THEN

			-- only allow baby boom for planets with workers space and with at least 1000 workers

			IF (r_planet.workers_capacity - r_planet.workers < r_planet.workers_capacity / 3) OR (r_planet.workers < 1000) THEN

				RETURN;

			END IF;

			PERFORM 1 FROM planet_buildings WHERE planetid = r_planet.id AND buildingid = 50;

			IF FOUND THEN

				RETURN;

			END IF;

			-- insert the baby boom building

			INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

			VALUES(r_planet.id, 50, 1);

		ELSEIF i = 1 AND r_planet.ore_production > 0 THEN

			-- check that there is not already a ore bonus building

			PERFORM 1 FROM planet_buildings WHERE planetid = r_planet.id AND buildingid = 51;

			IF FOUND THEN

				RETURN;

			END IF;

			-- compute how long the bonus will remain in minutes

			time := int4(60 * 100000.0 / (r_planet.ore_production+1));

			IF time > 48*60 THEN

				time := int4(48*60 + random()*6*60);

			END IF;

			-- insert the bonus building

			INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

			VALUES(r_planet.id, 51, 1, now()+time*INTERVAL '1 minute');

			-- insert the reports

			INSERT INTO reports(ownerid, planetid, type, subtype)

			VALUES(r_planet.ownerid, r_planet.id, 7, 52);

			INSERT INTO reports(ownerid, planetid, type, subtype, datetime)

			VALUES(r_planet.ownerid, r_planet.id, 7, 53, now()+time*INTERVAL '1 minute');

		ELSEIF i = 2 AND r_planet.hydrocarbon_production > 0 THEN

			-- check that there is not already a hydrocarbon bonus building

			PERFORM 1 FROM planet_buildings WHERE planetid = r_planet.id AND buildingid = 52;

			IF FOUND THEN

				RETURN;

			END IF;

			-- compute how long the bonus will remain in minutes

			time := int4(60 * 100000.0 / r_planet.hydrocarbon_production+1);

			IF time > 48*60 THEN

				time := int4(48*60 + random()*6*60);

			END IF;

			-- insert the bonus building

			INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

			VALUES(r_planet.id, 52, 1, now()+time*INTERVAL '1 minute');

			-- insert the reports

			INSERT INTO reports(ownerid, planetid, type, subtype)

			VALUES(r_planet.ownerid, r_planet.id, 7, 54);

			INSERT INTO reports(ownerid, planetid, type, subtype, datetime)

			VALUES(r_planet.ownerid, r_planet.id, 7, 55, now()+time*INTERVAL '1 minute');

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_planet_bonus() OWNER TO exileng;

--
-- Name: sp_event_riots(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_riots() RETURNS void
    LANGUAGE plpgsql
    AS $$-- Riots happen if workers+scientists < soldiers*100 with a small probability

DECLARE

	r_planet record;

	p float;

	pop float;

BEGIN

	--RETURN;

	-- make riots more likely to happen between 18:00 and 22:00

	p := Extract(hour from now());

	IF p >= 18 AND p <= 24 THEN

		p := 0.005;

	ELSE

		p := 0.0025;

	END IF;

	-- theft is workers+scientists / 1000 percent

	FOR r_planet IN

		SELECT id, ownerid, scientists, soldiers, workers, ore, hydrocarbon, mood

		FROM vw_planets

		WHERE planet_floor > 0 AND ownerid > 100 AND not production_frozen AND last_catastrophe < now()-INTERVAL '4 hours' AND mood < 60 AND random() < (1.0 + workers + scientists + (60-mood)*500 - soldiers*250)/(1.0+workers + scientists)*p

	LOOP

		PERFORM sp_stop_all_buildings(r_planet.ownerid, r_planet.id);

		PERFORM sp_update_planet(r_planet.id);

		pop := (r_planet.workers + r_planet.scientists - r_planet.soldiers*100)/1000.0;

		r_planet.scientists := LEAST(r_planet.scientists, int4(r_planet.scientists * pop/100.0/6.0));

		r_planet.soldiers := LEAST(r_planet.soldiers, int4(r_planet.soldiers * pop/100.0/8.0));

		r_planet.workers := LEAST(r_planet.workers, int4(r_planet.workers * (pop/100.0/5.0)));

		r_planet.ore := LEAST(r_planet.ore, int4(r_planet.ore * (0.2 + (pop+100-r_planet.mood)/100.0)));

		r_planet.hydrocarbon := LEAST(r_planet.hydrocarbon, int4(r_planet.hydrocarbon * (0.2+(pop+100-r_planet.mood)/100.0)));

		-- kill people & steal resources from planet 

		UPDATE nav_planet SET

			scientists = GREATEST(0, scientists - r_planet.scientists),

			soldiers = GREATEST(0, soldiers - r_planet.soldiers),

			workers = workers - r_planet.workers,

			ore = GREATEST(0, ore - r_planet.ore),

			hydrocarbon = GREATEST(0, hydrocarbon - r_planet.hydrocarbon),

			last_catastrophe = now(),

			mood = GREATEST(0, mood - 15)

		WHERE id=r_planet.id;

		UPDATE nav_planet SET

			mood = GREATEST(0, mood - 2)

		WHERE ownerid=r_planet.ownerid AND mood > 80;

		-- create reports

		INSERT INTO reports(ownerid, type, subtype, planetid, ore, hydrocarbon)

		VALUES(r_planet.ownerid, 7, 20, r_planet.id, r_planet.ore, r_planet.hydrocarbon);

		INSERT INTO reports(ownerid, type, subtype, planetid, scientists, soldiers, workers)

		VALUES(r_planet.ownerid, 7, 21, r_planet.id, r_planet.scientists, r_planet.soldiers, r_planet.workers);

	END LOOP;

	-- make planets with low mood/workers declare their independance

	FOR r_planet IN

		SELECT ai_watched_planets.planetid AS id, nav_planet.ownerid

		FROM ai_watched_planets

			INNER JOIN nav_planet ON (nav_planet.id=ai_watched_planets.planetid)

		WHERE watched_since < now() - INTERVAL '6 days' AND random() < 0.005

	LOOP

		PERFORM sp_stop_all_buildings(r_planet.ownerid, r_planet.id);

		PERFORM sp_update_planet(r_planet.id);

		-- give planet to independent nations

		PERFORM sp_abandon_planet(r_planet.ownerid, r_planet.id);

		-- create reports

		INSERT INTO reports(ownerid, type, subtype, planetid)

		VALUES(r_planet.ownerid, 7, 25, r_planet.id);

		DELETE FROM ai_watched_planets WHERE planetid=r_planet.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_riots() OWNER TO exileng;

--
-- Name: sp_event_robberies(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_robberies() RETURNS void
    LANGUAGE plpgsql
    AS $$-- Steal resources from planets that have less than (workers+scientists)/100 soldiers

DECLARE

	r_planet record;

	p float;

	pop float;

	moodloss int4;

BEGIN

	--RETURN;

	-- make thefts more likely to happen between 0:00 and 6:00

	p := Extract(hour from now());

	IF p >= 0 AND p <= 6 THEN

		p := 0.05;

	ELSE

		p := 0.02;

	END IF;

	-- theft probability is workers+scientists / 1000 percent

	FOR r_planet IN

		SELECT v.id, v.ownerid, v.workers, v.scientists, v.soldiers, v.ore, v.hydrocarbon, v.mood

		FROM vw_planets AS v

			INNER JOIN users ON (users.id=v.ownerid AND users.privilege=0)

		WHERE planet_floor > 0 AND v.ownerid > 100 AND planets > 2 AND random() < planets/100.0 AND not production_frozen AND v.last_catastrophe < now()-INTERVAL '5 hours' AND v.mood < 90 AND random() < (1.0+v.workers + v.scientists + (90-v.mood)*100.0 - v.soldiers*250)/(1.0+v.workers + v.scientists)*p

		ORDER BY Random()

		LIMIT 40

	LOOP

		pop := GREATEST(0, (r_planet.workers + r_planet.scientists - r_planet.soldiers*100)/1000.0);

		--RAISE NOTICE '%',r_planet.id;

		CONTINUE WHEN r_planet.workers + r_planet.scientists < 2000 OR r_planet.workers + r_planet.scientists < r_planet.soldiers*100;

		--RAISE NOTICE 'robberies on %',r_planet.id;

		PERFORM sp_update_planet_production(r_planet.id);

		r_planet.ore := LEAST(r_planet.ore, int4(r_planet.ore * (0.2 + (pop+100-r_planet.mood)/300.0)));

		r_planet.hydrocarbon := LEAST(r_planet.hydrocarbon, int4(r_planet.hydrocarbon * (0.2+(pop+100-r_planet.mood)/300.0)));

		IF r_planet.soldiers*100 >= r_planet.workers + r_planet.scientists THEN

			moodloss := 3; -- only lose 3 points of mood if we had enough soldiers

		ELSE

			moodloss := 12;

		END IF;

		-- steal resources from planet

		UPDATE nav_planet SET

			ore = GREATEST(0, ore - r_planet.ore),

			hydrocarbon = GREATEST(0, hydrocarbon - r_planet.hydrocarbon),

			last_catastrophe = now(),

			mood = GREATEST(0, mood - moodloss)

		WHERE id=r_planet.id;

		-- create a report

		INSERT INTO reports(ownerid, type, subtype, planetid, ore, hydrocarbon)

		VALUES(r_planet.ownerid, 7, 20, r_planet.id, r_planet.ore, r_planet.hydrocarbon);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_robberies() OWNER TO exileng;

--
-- Name: sp_event_rogue_fleets_patrol(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_rogue_fleets_patrol() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	fleet_id int4;

	fleet_route int8;

	fleet_wp int8;

	r_planet record;

	military_sig int8;

	sectorvalue float8;

	r_fleet record;

	galaxy_count integer;

BEGIN

	FOR r_planet IN

		SELECT nav_planet.id, nav_planet.sector

		FROM nav_planet

			INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

		WHERE (spawn_ore = 0 AND spawn_hydrocarbon = 0) AND (planet_floor = 0 AND planet_space = 0) AND nav_galaxies.protected_until < now() AND random() < 0.0001

		--WHERE nav_planet.id=sp_planet(25,45,25)

	LOOP

		sectorvalue := (sqrt(const_galaxy_x(1)+const_galaxy_y(1)) - 0.8 * sqrt(power(const_galaxy_x(1)/2.0 - (r_planet.sector % const_galaxy_y(1)), 2) + power(const_galaxy_y(1)/2.0 - (r_planet.sector/const_galaxy_x(1) + 1), 2))) * 20;

		--CONTINUE WHEN sectorvalue <= 10;

		PERFORM 1 FROM fleets WHERE ownerid=1 AND (planetid=r_planet.id OR dest_planetid=r_planet.id);

		IF NOT FOUND THEN

			SELECT INTO military_sig sum(military_signature) FROM fleets WHERE planetid=r_planet.id AND ownerid > 100;

			CONTINUE WHEN random() > sectorvalue*1000 / (military_sig+1);

			fleet_id := nextval('fleets_id_seq');

			--RAISE NOTICE 'create fleet %', fleet_id;

			INSERT INTO fleets(id, ownerid, planetid, name, idle_since, speed)

			VALUES(fleet_id, 1, null, 'Les fossoyeurs', now(), 800);

			IF sectorvalue < 60 THEN

				IF random() < 0.15 THEN

					-- obliterator

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 951, sectorvalue+int4(random()*10));

				ELSE

					sectorvalue := sectorvalue*2.0;

				END IF;

				IF random() < 0.75 THEN

					-- mower

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 952, sectorvalue*20+int4(random()*100));

				ELSE

					sectorvalue := sectorvalue*2.0;

				END IF;

				IF random() < 0.75 THEN

					-- escorter

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 954, sectorvalue*15+int4(random()*75));

				ELSE

					sectorvalue := sectorvalue*2.0;

				END IF;

				-- multigun corvette

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 955, sectorvalue*20+int4(random()*100));

				-- rogue recycler

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 960, 9+int4(random()*4));

			ELSE

				IF military_sig > 100000 THEN

					sectorvalue := sectorvalue * 1.5;

				END IF;

				IF random() < 0.35 THEN

					-- obliterator

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 951, int4(sectorvalue*2.5+int4(random()*10)));

				ELSE

					sectorvalue := sectorvalue*3.0;

				END IF;

				IF random() < 0.75 THEN

					-- mower

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 952, sectorvalue*20+int4(random()*100));

				ELSE

					sectorvalue := sectorvalue*2.0;

				END IF;

				IF random() < 0.75 THEN

					-- escorter

					INSERT INTO fleets_ships(fleetid, shipid, quantity)

					VALUES(fleet_id, 954, sectorvalue*15+int4(random()*75));

				ELSE

					sectorvalue := sectorvalue*2.0;

				END IF;

				-- multigun corvette

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 955, sectorvalue*20+int4(random()*100));

				-- rogue recycler

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 960, 15+int4(random()*5));

			END IF;

			fleet_route := sp_create_route(null, null);

			fleet_wp := sp_wp_append_move(fleet_route, r_planet.id);

			PERFORM sp_wp_append_wait(fleet_route, int4(9*60*60));

			PERFORM sp_wp_append_wait(fleet_route, int4((6*random())*60*60));

			PERFORM sp_wp_append_recycle(fleet_route);

			IF random() > 0.5 THEN

				PERFORM sp_wp_append_wait(fleet_route, int4((6+2*random())*60*60));

			END IF;

			PERFORM sp_wp_append_disappear(fleet_route, 8*60*60);

			UPDATE fleets SET attackonsight = true, next_waypointid=fleet_wp WHERE id=fleet_id;

			PERFORM sp_routes_continue(1, fleet_id);

			RAISE NOTICE 'fleet created % toward %', fleet_id, r_planet.id;

		END IF;

	END LOOP;

	SELECT INTO galaxy_count (count(1)/10)::integer FROM nav_galaxies;

	-- check all idle fleets

	FOR r_fleet IN

		SELECT planetid, galaxy, sector

		FROM fleets

			INNER JOIN nav_planet ON nav_planet.id=fleets.planetid

		WHERE fleets.ownerid > 100 AND military_signature < 2000 AND idle_since < now()-interval '2 weeks' AND NOT planetid IN (34,35,36,37,44,45,46,47,54,55,56,57,64,65,66,67) AND NOT production_frozen

		ORDER BY random()

		LIMIT galaxy_count

	LOOP

		fleet_id := admin_generate_fleet(1, 'Les fossoyeurs', null, r_fleet.planetid, 0);

		fleet_route := sp_create_route(null, null);

		fleet_wp := sp_wp_append_wait(fleet_route, 0);

		RAISE NOTICE 'patrol fleet created % toward %', fleet_id, r_fleet.planetid;

		FOR r_planet IN

			SELECT nav_planet.id

			FROM nav_planet

			WHERE id <> r_fleet.planetid AND (ownerid IS NULL OR planet_floor=0) AND galaxy = r_fleet.galaxy AND sector IN (r_fleet.sector, r_fleet.sector+10, r_fleet.sector-10) AND EXISTS(SELECT 1 FROM fleets WHERE ownerid > 100 AND planetid=nav_planet.id AND military_signature < 2000 AND idle_since <= now()-interval '2 weeks') AND NOT production_frozen

			ORDER BY random()

			LIMIT 20

		LOOP

			PERFORM sp_wp_append_move(fleet_route, r_planet.id);

		END LOOP;

		PERFORM sp_wp_append_disappear(fleet_route, 8*60*60);

		UPDATE fleets SET attackonsight = true, next_waypointid=fleet_wp WHERE id=fleet_id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_rogue_fleets_patrol() OWNER TO exileng;

--
-- Name: sp_event_rogue_fleets_rush_resources(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_rogue_fleets_rush_resources() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	fleet_id int4;

	fleet_route int8;

	fleet_wp int8;

	r_planet record;

	military_sig int8;

BEGIN

	FOR r_planet IN

		SELECT nav_planet.id

		FROM nav_planet

			INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

		WHERE (spawn_ore > 0 OR spawn_hydrocarbon > 0) AND nav_galaxies.protected_until < now() AND random() < 0.01

	LOOP

		PERFORM 1 FROM fleets WHERE ownerid=1 AND planetid=r_planet.id OR dest_planetid=r_planet.id;

		IF NOT FOUND THEN

			SELECT INTO military_sig sum(military_signature) FROM fleets WHERE planetid=r_planet.id;

			CONTINUE WHEN military_sig > 10000;

			fleet_id := nextval('fleets_id_seq');

			INSERT INTO fleets(id, ownerid, planetid, name, idle_since, speed)

			VALUES(fleet_id, 1, null, 'Les fossoyeurs', now(), 800);

			IF military_sig < 2000 THEN

				-- escorter

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 954, 80+int4(random()*50));

				-- rogue recycler

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 960, 5+int4(random()*3));

			ELSEIF military_sig < 5000 THEN

				-- mower

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 952, 200+int4(random()*100));

				-- escorter

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 954, 100+int4(random()*75));

				-- rogue recycler

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 960, 9+int4(random()*4));

			ELSE

				-- mower

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 952, 50+int4(random()*50));

				-- escorter

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 954, 250+int4(random()*100));

				-- rogue recycler

				INSERT INTO fleets_ships(fleetid, shipid, quantity)

				VALUES(fleet_id, 960, 15+int4(random()*5));

			END IF;

			fleet_route := sp_create_route(null, null);

			fleet_wp := sp_wp_append_move(fleet_route, r_planet.id);

			PERFORM sp_wp_append_recycle(fleet_route);

			IF random() > 0.5 THEN

				PERFORM sp_wp_append_wait(fleet_route, int4((2*random())*60*60));

			END IF;

			PERFORM sp_wp_append_disappear(fleet_route, 8*60*60);

			UPDATE fleets SET attackonsight = true, next_waypointid=fleet_wp WHERE id=fleet_id;

			PERFORM sp_routes_continue(1, fleet_id);

			--RAISE NOTICE 'create fleet % toward %',fleet_id,r_planet.id;

		END IF;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_event_rogue_fleets_rush_resources() OWNER TO exileng;

--
-- Name: sp_event_sandworm(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_sandworm() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	r_building record;

BEGIN

	-- sandworm

	FOR r_planet IN

		SELECT v.id, v.ownerid

		FROM nav_planet AS v

			INNER JOIN users ON (users.id=v.ownerid AND users.privilege=0)

		WHERE v.ownerid > 100 AND sandworm_activity > 0 AND random() < 0.5*sandworm_activity/10000.0 AND not production_frozen

		ORDER BY random()

		LIMIT 40

	LOOP

		FOR r_building IN

			SELECT buildingid

			FROM planet_buildings

				INNER JOIN db_buildings ON (db_buildings.id = planet_buildings.buildingid)

			WHERE planetid=r_planet.id AND random() > 0.75 AND buildingid >= 100 AND db_buildings.floor > 0

			ORDER BY random()

		LOOP

			IF sp_destroy_building(r_planet.ownerid, r_planet.id, r_building.buildingid) = 0 THEN

				-- mood loss of 20 points

				UPDATE nav_planet SET

					mood=GREATEST(0, mood-20),

					buildings_dilapidation=LEAST(10000, buildings_dilapidation+1000)

				WHERE id=r_planet.id;

				-- create a report

				INSERT INTO reports(ownerid, type, subtype, planetid, buildingid)

				VALUES(r_planet.ownerid, 7, 91, r_planet.id, r_building.buildingid);

				EXIT;

			END IF;

		END LOOP;

	END LOOP;

	-- seism

	FOR r_planet IN

		SELECT v.id, v.ownerid, v.workers

		FROM nav_planet AS v

			INNER JOIN users ON (users.id=v.ownerid AND users.privilege=0)

		WHERE v.ownerid > 100 AND seismic_activity > 0 AND random() < 0.5*seismic_activity/10000.0 AND not production_frozen

		ORDER BY random()

		LIMIT 40

	LOOP

		FOR r_building IN

			SELECT buildingid

			FROM planet_buildings

				INNER JOIN db_buildings ON (db_buildings.id = planet_buildings.buildingid)

			WHERE planetid=r_planet.id AND random() > 0.75 AND buildingid >= 100 AND db_buildings.floor > 0

			ORDER BY random()

		LOOP

			IF sp_destroy_building(r_planet.ownerid, r_planet.id, r_building.buildingid) = 0 THEN

				-- mood loss of 100 points

				UPDATE nav_planet SET

					mood=GREATEST(0, mood-100),

					buildings_dilapidation=LEAST(10000, buildings_dilapidation+6000),

					planet_stock_ore=const_planet_market_stock_min(),

					planet_stock_hydrocarbon=const_planet_market_stock_min()

				WHERE id=r_planet.id;

				r_planet.workers := LEAST(r_planet.workers, int4(LEAST(0.5, random()) * r_planet.workers));

				UPDATE nav_planet SET

					workers = workers - r_planet.workers

				WHERE id=r_planet.id;

				-- create a report

				INSERT INTO reports(ownerid, type, subtype, planetid, buildingid, workers)

				VALUES(r_planet.ownerid, 7, 90, r_planet.id, r_building.buildingid, r_planet.workers);

				EXIT;

			END IF;

		END LOOP;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_sandworm() OWNER TO exileng;

--
-- Name: sp_event_spawn_new_resource_points(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_spawn_new_resource_points() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

/*

	-- create new resource spawning points

	FOR r_planet IN

		SELECT nav_planet.id

		FROM nav_planet

			JOIN nav_galaxies ON (nav_planet.galaxy=nav_galaxies.id)

		WHERE colonies > 400 AND ownerid IS NULL AND planet_floor=0 AND planet_space=0 AND warp_to IS NULL AND spawn_ore=0 AND spawn_hydrocarbon=0 AND random() < 0.00005

	LOOP

		IF random() < 0.5 THEN

			UPDATE nav_planet SET

				spawn_ore=int4(10000+random()*3000)

			WHERE id=r_planet.id;

		ELSE

			UPDATE nav_planet SET

				spawn_hydrocarbon=int4(9000+random()*2000)

			WHERE id=r_planet.id;

		END IF;

		INSERT INTO events_spawned_resources(planetid, end_time)

		VALUES(r_planet.id, now()+'1 day');

	END LOOP;

*/

	-- check which resource spawning points have to be stopped

	FOR r_planet IN

		SELECT planetid

		FROM events_spawned_resources

		WHERE end_time <= now()

	LOOP

		UPDATE nav_planet SET

			spawn_ore=1

		WHERE id=r_planet.planetid AND spawn_ore > 0;

		UPDATE nav_planet SET

			spawn_hydrocarbon=1

		WHERE id=r_planet.planetid AND spawn_hydrocarbon > 0;

		DELETE FROM events_spawned_resources WHERE planetid=r_planet.planetid;

	END LOOP;

	-- destroy resource spawning points

	UPDATE nav_planet SET

		spawn_ore = 0,

		spawn_hydrocarbon = 0

	WHERE (spawn_ore = 1 and orbit_ore < 1000) or (spawn_hydrocarbon = 1 and orbit_hydrocarbon < 1000);

END;$$;


ALTER FUNCTION static.sp_event_spawn_new_resource_points() OWNER TO exileng;

--
-- Name: sp_event_spawn_orbit_resources(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_event_spawn_orbit_resources() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	-- spawn resources to resource spawning points

	UPDATE nav_planet SET

		orbit_ore = orbit_ore + (0.01+0.02*random()) * spawn_ore,

		orbit_hydrocarbon = orbit_hydrocarbon + (0.01+0.02*random()) * spawn_hydrocarbon

	WHERE (spawn_ore > 0 AND orbit_ore < 20*spawn_ore) OR (spawn_hydrocarbon > 0 AND orbit_hydrocarbon < 20*spawn_hydrocarbon);

	RETURN;

END;$$;


ALTER FUNCTION static.sp_event_spawn_orbit_resources() OWNER TO exileng;

--
-- Name: FUNCTION sp_event_spawn_orbit_resources(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_event_spawn_orbit_resources() IS 'Some space planets produce resources (ore or hydrocarbon) that are automatically put into orbit';


--
-- Name: sp_execute_daily_updates(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_execute_daily_updates() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_item record;

	start timestamp;

BEGIN

	FOR r_item IN

		SELECT *

		FROM sys_daily_updates

		WHERE last_runtime+run_every < now() AND enabled

	LOOP

		start := to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY');

		BEGIN

			EXECUTE 'SELECT ' || r_item.procedure;

			UPDATE sys_daily_updates SET

				last_runtime = now(),

				last_result = null,

				last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

			WHERE procedure = r_item.procedure;

		EXCEPTION

			WHEN OTHERS THEN

				UPDATE sys_daily_updates SET

					last_result = SQLERRM,

					last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

				WHERE procedure = r_item.procedure;

				INSERT INTO log_sys_errors(procedure, error) VALUES(r_item.procedure, SQLERRM);

		END;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_execute_daily_updates() OWNER TO exileng;

--
-- Name: sp_execute_events(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_execute_events() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_item record;

	start timestamp;

BEGIN

	FOR r_item IN

		SELECT *

		FROM sys_events

		WHERE last_runtime+run_every < now() AND enabled

	LOOP

		start := to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY');

		BEGIN

			EXECUTE 'SELECT ' || r_item.procedure;

			UPDATE sys_events SET

				last_runtime = now(),

				last_result = null,

				last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

			WHERE procedure = r_item.procedure;

		EXCEPTION

			WHEN OTHERS THEN

				UPDATE sys_events SET

					last_result = SQLERRM,

					last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

				WHERE procedure = r_item.procedure;

				INSERT INTO log_sys_errors(procedure, error) VALUES(r_item.procedure, SQLERRM);

		END;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_execute_events() OWNER TO exileng;

--
-- Name: sp_execute_processes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_execute_processes() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_item record;

	start timestamp;

BEGIN

	FOR r_item IN

		SELECT *

		FROM sys_processes

		WHERE last_runtime+run_every < now() AND enabled

	LOOP

		start := to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY');

		BEGIN

			EXECUTE 'SELECT ' || r_item.procedure;

			UPDATE sys_processes SET

				last_runtime = now(),

				last_result = null,

				last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

			WHERE procedure = r_item.procedure;

		EXCEPTION

			WHEN OTHERS THEN

				UPDATE sys_processes SET

					last_result = SQLERRM,

					last_executiontimes = (to_timestamp(timeofday(), 'Dy Mon DD HH24:MI:SS.US YYYY')-start) || last_executiontimes[0:9]

				WHERE procedure = r_item.procedure;

				INSERT INTO log_sys_errors(procedure, error) VALUES(r_item.procedure, SQLERRM);

		END;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_execute_processes() OWNER TO exileng;

--
-- Name: sp_factor(real, real); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_factor(_exp real, _quantity real) RETURNS real
    LANGUAGE plpgsql IMMUTABLE
    AS $$BEGIN

	IF _exp IS NULL THEN

		RETURN _quantity;

	ELSEIF _quantity <= 0 THEN

		RETURN 0;

	ELSE

		RETURN power(_exp, _quantity-1);

	END IF;

END;$$;


ALTER FUNCTION static.sp_factor(_exp real, _quantity real) OWNER TO exileng;

--
-- Name: sp_fire_commander(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fire_commander(integer, integer) RETURNS smallint
    LANGUAGE sql
    AS $_$-- fire/delete a commander

DELETE FROM commanders WHERE ownerid=$1 AND id=$2;

SELECT int2(0);$_$;


ALTER FUNCTION static.sp_fire_commander(integer, integer) OWNER TO exileng;

--
-- Name: sp_first_planet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_first_planet(integer, integer) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ($1-1)*25*99 + ($2-1)*25 + 1;$_$;


ALTER FUNCTION static.sp_first_planet(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_first_planet(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_first_planet(integer, integer) IS 'Return the first planet in a given galaxy:sector';


--
-- Name: sp_fleets_categories_add(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_categories_add(_userid integer, _label character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	cat smallint;

BEGIN

	-- retrieve the new category id

	SELECT INTO cat COALESCE(max(category)+1, 1) FROM users_fleets_categories WHERE userid=$1;

	INSERT INTO users_fleets_categories(userid, category, label)

	VALUES($1, cat, $2);

	RETURN cat;

END;$_$;


ALTER FUNCTION static.sp_fleets_categories_add(_userid integer, _label character varying) OWNER TO exileng;

--
-- Name: sp_fleets_categories_delete(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_categories_delete(_userid integer, _categoryid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	DELETE FROM users_fleets_categories WHERE userid=$1 AND category=$2;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_fleets_categories_delete(_userid integer, _categoryid integer) OWNER TO exileng;

--
-- Name: sp_fleets_categories_rename(integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_categories_rename(_userid integer, _categoryid integer, _label character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	UPDATE users_fleets_categories SET label=$3 WHERE userid=$1 AND category=$2;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_fleets_categories_rename(_userid integer, _categoryid integer, _label character varying) OWNER TO exileng;

--
-- Name: sp_fleets_check_battle(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_check_battle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	CheckBattle bool;

	ContinueRoute bool;

	r_from record;

	r_to record;

	travel_distance float;

	pct float8;

BEGIN

	CheckBattle := true;

	ContinueRoute := false;

	IF (TG_OP = 'DELETE') THEN

		UPDATE nav_planet SET

			blocus_strength=NULL

		WHERE id=OLD.planetid AND blocus_strength IS NOT NULL;

		RETURN OLD;

	END IF;

	IF (NEW.size = 0) /*OR (NEW.planetid IS NULL AND NEW.dest_planetid IS NULL)*/ THEN

		-- if fleet is being created/modified, planetid & dest_planetid are null

		RETURN NULL;

	END IF;

	-- only check for battles if fleets (behavior or planetid) change or if it is an insert

	IF (TG_OP = 'UPDATE') THEN

		IF OLD.action <> 0 AND NEW.action = 0 AND NEW.military_signature > 0 THEN

			UPDATE nav_planet SET

				blocus_strength=NULL

			WHERE id=NEW.planetid AND blocus_strength IS NOT NULL;

		END IF;

		-- when speed decreases, compute new fleet action_end_time

		IF (OLD.action = NEW.action) AND (NEW.action = 1 OR NEW.action = -1) THEN

			IF NEW.mod_speed < OLD.mod_speed THEN

				SELECT INTO r_from galaxy, sector, planet FROM nav_planet WHERE id=NEW.planetid;

				IF FOUND THEN

					SELECT INTO r_to galaxy, sector, planet FROM nav_planet WHERE id=NEW.dest_planetid;

					IF FOUND THEN

						IF r_from.galaxy = r_to.galaxy THEN

							travel_distance := sp_travel_distance(r_from.sector, r_from.planet, r_to.sector, r_to.planet);

							IF NEW.action_end_time > NEW.action_start_time THEN

								pct := date_part('epoch', now() - NEW.action_start_time) / date_part('epoch', NEW.action_end_time - NEW.action_start_time);

							ELSE

								pct := 1;

							END IF;

							UPDATE fleets SET

								action_end_time = GREATEST(action_end_time, action_start_time + pct * travel_distance * 3600 * 1000.0/(NEW.speed*OLD.mod_speed/100.0) * INTERVAL '1 second' + (1-pct)*travel_distance * 3600 * 1000.0/(NEW.speed*NEW.mod_speed/100.0) * INTERVAL '1 second')

							WHERE id=NEW.id;

						END IF;

					END IF;

				END IF;

			END IF;

		END IF;

		IF (OLD.action <> 0 OR OLD.engaged) AND NOT NEW.engaged AND NEW.action=0 AND NEW.next_waypointid IS NOT NULL THEN

			ContinueRoute := true;

		END IF;

		IF OLD.planetid = NEW.planetid AND OLD.attackonsight = NEW.attackonsight AND OLD.size = NEW.size THEN

			CheckBattle := false;

		END IF;

		-- don't check anything for fleets that cancels their travel

		IF NOT OLD.engaged AND (NEW.action=-1 OR NEW.action=1) THEN

			CheckBattle := false;

		END IF;

	END IF;

	IF CheckBattle THEN

		PERFORM sp_check_battle(NEW.planetid);

	END IF;

	IF ContinueRoute THEN

		PERFORM sp_routes_continue(NEW.ownerid, NEW.id);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_fleets_check_battle() OWNER TO exileng;

--
-- Name: sp_fleets_set_category(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_set_category(_userid integer, _fleetid integer, _oldcategoryid integer, _newcategoryid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	UPDATE fleets SET categoryid=$4 WHERE ownerid=$1 AND id=$2 AND categoryid=$3;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_fleets_set_category(_userid integer, _fleetid integer, _oldcategoryid integer, _newcategoryid integer) OWNER TO exileng;

--
-- Name: sp_fleets_ships_afterchanges(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_ships_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF (TG_OP = 'DELETE') THEN

		PERFORM sp_update_fleet(OLD.fleetid);

	ELSEIF (TG_OP = 'INSERT') THEN

		PERFORM sp_update_fleet(NEW.fleetid);

	ELSEIF (TG_OP = 'UPDATE') AND ( OLD.quantity != NEW.quantity ) THEN

		IF NEW.quantity < 0 THEN

			RAISE EXCEPTION 'Quantity is negative';

		ELSEIF NEW.quantity = 0 THEN

			DELETE FROM fleets_ships WHERE fleetid=NEW.fleetid AND shipid=NEW.shipid AND quantity=0;

			RETURN NULL; -- trigger will be called again for DELETE

		END IF;

		PERFORM sp_update_fleet(OLD.fleetid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_fleets_ships_afterchanges() OWNER TO exileng;

--
-- Name: sp_fleets_ships_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_fleets_ships_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE fleets_ships SET quantity = quantity + NEW.quantity WHERE fleetid=NEW.fleetid AND shipid=NEW.shipid;

	IF FOUND OR NEW.quantity = 0 THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_fleets_ships_beforeinsert() OWNER TO exileng;

--
-- Name: sp_flush_unused_accounts(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_flush_unused_accounts() RETURNS void
    LANGUAGE sql
    AS $$DELETE FROM users WHERE privilege > -50 AND privilege < 100 AND orientation=0 AND (now() - regdate > INTERVAL '7 days');

DELETE FROM users WHERE privilege > -50 AND privilege < 100 AND (now() - regdate > INTERVAL '2 months');$$;


ALTER FUNCTION static.sp_flush_unused_accounts() OWNER TO exileng;

--
-- Name: sp_get_addressee_list(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_addressee_list(integer) RETURNS SETOF character varying
    LANGUAGE sql
    AS $_$-- return the list of addressee names

-- param1: id

SELECT login

FROM messages_addressee_history INNER JOIN users ON messages_addressee_history.addresseeid = users.id

WHERE ownerid=$1

ORDER BY upper(login);$_$;


ALTER FUNCTION static.sp_get_addressee_list(integer) OWNER TO exileng;

--
-- Name: sp_get_available_alliance_radars(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_available_alliance_radars(_userid integer) RETURNS SETOF integer
    LANGUAGE plpgsql STABLE
    AS $$-- return a list of alliance ids the user can use radars

DECLARE

	r_user record;

BEGIN

	-- retrieve player alliance info and rights

	SELECT INTO r_user

		users.alliance_id, users.security_level, alliances_ranks.leader OR alliances_ranks.can_use_alliance_radars AS see_alliance

	FROM users

		INNER JOIN alliances_ranks ON (alliances_ranks.rankid = users.alliance_rank AND alliances_ranks.allianceid = users.alliance_id)

	WHERE id=_userid;

/*

SELECT friends.userid, friends.friend

   FROM ( SELECT u1.id AS userid, u2.id AS friend

           FROM exile_s01.users u1

      JOIN exile_s01.alliances_naps naps ON u1.alliance_id = naps.allianceid2 AND naps.share_radars

   JOIN exile_s01.users u2 ON u2.alliance_id = naps.allianceid1

UNION 

         SELECT u1.id AS userid, u2.id AS friend

           FROM exile_s01.users u1

      JOIN exile_s01.users u2 ON u1.alliance_id = u2.alliance_id OR u2.alliance_id IS NULL AND u1.id = u2.id) friends;

*/

END;$$;


ALTER FUNCTION static.sp_get_available_alliance_radars(_userid integer) OWNER TO exileng;

--
-- Name: sp_get_battle_result(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_battle_result(integer, integer, integer) RETURNS SETOF static.battle_result
    LANGUAGE sql
    AS $_$-- Param1: BattleId

-- Param2: UserId

-- Param3: UserId

SELECT *

FROM (SELECT alliancetag, owner_id, owner_name, fleet_id, fleet_name, shipid, db_ships.category AS shipcategory, db_ships.label AS shiplabel, before, before-after AS lost, killed, 

	battles_fleets.mod_shield, battles_fleets.mod_handling, battles_fleets.mod_tracking_speed, battles_fleets.mod_damage, won, attackonsight,

	CASE

		WHEN owner_id=$2 THEN int2(2) 

		ELSE COALESCE((SELECT relation FROM battles_relations WHERE battleid=$1 AND ((user1=$2 AND user2=owner_id) OR (user1=owner_id AND user2=$2))), int2(-1))

	END,

	CASE

		WHEN owner_id=$3 THEN int2(2) 

		ELSE COALESCE((SELECT relation FROM battles_relations WHERE battleid=$1 AND ((user1=$3 AND user2=owner_id) OR (user1=owner_id AND user2=$3))), int2(-1))

	END AS friend

	FROM battles_fleets

		INNER JOIN battles_fleets_ships ON (battles_fleets.id = battles_fleets_ships.fleetid)

		INNER JOIN db_ships ON (db_ships.id=battles_fleets_ships.shipid)

	WHERE battleid=$1) AS t

ORDER BY -friend, upper(owner_name), upper(fleet_name), fleet_id, shipcategory, shipid;$_$;


ALTER FUNCTION static.sp_get_battle_result(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_get_construction_time(integer, real, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_construction_time(_time integer, _exp real, _buildings_built integer, _mod_speed integer) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$DECLARE

	t int4;

	mod float4;

BEGIN

	t := int4(_time * power(_exp, COALESCE(_buildings_built, 0)));

	IF _mod_speed > 100 AND t > 172800 THEN -- 172800 = 2 days

		mod := 100.0 + (_mod_speed-100.0) * 172800.0/t;

	ELSE

		mod := _mod_speed;

	END IF;

	RETURN int4(LEAST(10*t, t * 100.0/mod));

END;$$;


ALTER FUNCTION static.sp_get_construction_time(_time integer, _exp real, _buildings_built integer, _mod_speed integer) OWNER TO exileng;

--
-- Name: sp_get_galaxy_info(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_galaxy_info(_user_id integer) RETURNS SETOF static.galaxy_info
    LANGUAGE plpgsql
    AS $$DECLARE

	r_info galaxy_info;

	r_galaxy record;

	r_user record;

BEGIN

	SELECT INTO r_user *

	FROM users

	WHERE id=_user_id;

	IF NOT FOUND THEN

		r_user.regdate = now();

	END IF;

	FOR r_galaxy IN

		SELECT id, 

			(protected_until - const_interval_galaxy_protection()) AS open_since,

			protected_until,

			( SELECT count(DISTINCT nav_planet.ownerid) FROM nav_planet WHERE nav_planet.galaxy = nav_galaxies.id) AS players,

			colonies, planets

		FROM nav_galaxies

		WHERE allow_new_players --AND protected_until IS NOT NULL

		ORDER BY id

	LOOP

		r_info.id = r_galaxy.id;

		r_info.open_since = r_galaxy.open_since;

		r_info.protected_until = r_galaxy.protected_until;

		r_info.recommended := -1;	-- -1: cant be chosen

		PERFORM 1

		FROM nav_planet

			INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

		WHERE ownerid IS NULL AND (nav_galaxies.id = r_galaxy.id) AND (planet % 2 = 0) AND

			(sector % 10 = 0 OR sector % 10 = 1 OR sector <= 10 OR sector > 90) AND

			planet_floor > 0 AND planet_space > 0 AND allow_new_players

		LIMIT 1;

		IF FOUND THEN

			IF (r_galaxy.protected_until IS NULL AND r_user.regdate > now() - INTERVAL '2 weeks') OR (now() > r_galaxy.protected_until) OR (now() > r_galaxy.open_since + (r_galaxy.open_since - r_user.regdate) ) THEN

				IF r_galaxy.players > 400 OR r_galaxy.colonies > 0.66*r_galaxy.planets THEN

					r_info.recommended := 0;

				ELSEIF r_galaxy.players < 50 OR r_galaxy.protected_until IS NULL OR r_galaxy.protected_until > now() THEN

					r_info.recommended := 2;

				ELSE

					r_info.recommended := 1;

				END IF;

				RETURN NEXT r_info;

			END IF;

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_get_galaxy_info(_user_id integer) OWNER TO exileng;

--
-- Name: sp_get_galaxy_planets(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_galaxy_planets(_galaxyid integer, _userid integer) RETURNS text
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planets record;

	r_user record;

	result varchar;

BEGIN

	result := '';

	-- retrieve player alliance info and rights

	SELECT INTO r_user

		users.alliance_id, users.security_level, alliances_ranks.leader OR alliances_ranks.can_use_alliance_radars AS see_alliance

	FROM users

		LEFT JOIN alliances_ranks ON (alliances_ranks.rankid = users.alliance_rank AND alliances_ranks.allianceid = users.alliance_id)

	WHERE id=_userid;

	FOR r_planets IN

		SELECT CASE

			WHEN warp_to IS NOT NULL OR vortex_strength > 0 THEN 7	-- vortex

			WHEN ownerid=_userid THEN 4				-- player planet

			WHEN users.alliance_id=r_user.alliance_id AND r_user.see_alliance THEN 3	-- ally planet

			WHEN privilege=-50 OR (allianceid1 IS NOT NULL AND alliances_naps.share_locs AND r_user.see_alliance) OR (ownerid IS NOT NULL AND users.security_level <> r_user.security_level) THEN 2	-- friend/NAP planet

			WHEN spawn_ore > 0 THEN 5				-- resource ore

			WHEN spawn_hydrocarbon > 0 THEN 6			-- resource hydrocarbon

			WHEN planet_floor > 0 AND ownerid IS NULL THEN 1	-- uninhabited planet

			WHEN planet_floor = 0 THEN 8	-- empty/nothing

			ELSE 0 END AS t						-- enemy planet

		FROM nav_planet

			LEFT JOIN users ON ownerid = users.id

			LEFT JOIN alliances_naps ON (allianceid1 = users.alliance_id AND allianceid2 = r_user.alliance_id)

		WHERE galaxy=_galaxyid

		ORDER BY nav_planet.id

	LOOP

		result := result || r_planets.t;

	END LOOP;

	RETURN result;

END;$$;


ALTER FUNCTION static.sp_get_galaxy_planets(_galaxyid integer, _userid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_get_galaxy_planets(_galaxyid integer, _userid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_get_galaxy_planets(_galaxyid integer, _userid integer) IS 'Returns the list of planets from the first to the last one in the given galaxy as a string (first char is the first planet, last char the last planet). Each char gives the status of the planet : owned by the user, empty/nothing, ally planet, etc ..';


--
-- Name: sp_get_nav_galaxycount(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_nav_galaxycount() RETURNS smallint
    LANGUAGE sql STABLE
    AS $$SELECT int2(25)$$;


ALTER FUNCTION static.sp_get_nav_galaxycount() OWNER TO exileng;

--
-- Name: FUNCTION sp_get_nav_galaxycount(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_get_nav_galaxycount() IS 'Return number of galaxies in the universe';


--
-- Name: sp_get_nav_sectorcount(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_nav_sectorcount(integer) RETURNS smallint
    LANGUAGE sql STABLE
    AS $$SELECT int2(99);$$;


ALTER FUNCTION static.sp_get_nav_sectorcount(integer) OWNER TO exileng;

--
-- Name: sp_get_planet_blocus_strength(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_planet_blocus_strength(_planetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_planet record;

BEGIN

	-- check if it hasn't been computed already

	SELECT INTO r_planet ownerid, blocus_strength FROM nav_planet WHERE id=$1;

	IF FOUND AND r_planet.blocus_strength IS NOT NULL THEN

		RETURN r_planet.blocus_strength;

	END IF;

	IF NOT FOUND THEN

		RETURN 0;

	END IF;

	-- compute how many enemy military fleets there are near this planet

	SELECT INTO r_planet

		int4(sum(military_signature) / 100) AS blocus_strength

	FROM fleets

	WHERE planetid=$1 AND attackonsight AND action <> -1 AND action <> 1 AND firepower > 0 AND NOT EXISTS(SELECT 1 FROM vw_friends WHERE userid=r_planet.ownerid AND friend=fleets.ownerid);

	IF r_planet.blocus_strength IS NULL THEN

		r_planet.blocus_strength := 0;

	END IF;

	-- update planet blocus strength

	UPDATE nav_planet SET

		blocus_strength = r_planet.blocus_strength

	WHERE id=$1;

	RETURN r_planet.blocus_strength;

END;$_$;


ALTER FUNCTION static.sp_get_planet_blocus_strength(_planetid integer) OWNER TO exileng;

--
-- Name: sp_get_planet_name(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_planet_name(_userid integer, _planetid integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	SELECT INTO r_planet ownerid, name, galaxy, sector FROM nav_planet WHERE id=_planetid;

	IF r_planet.ownerid = _userid THEN

		RETURN r_planet.name;

	END IF;

	IF sp_relation(r_planet.ownerid, _userid) >= 0 THEN

		RETURN sp_get_user(r_planet.ownerid);

	END IF;

	IF sp_get_user_rs(_userid, r_planet.galaxy, r_planet.sector) > 0 THEN

		RETURN sp_get_user(r_planet.ownerid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_get_planet_name(_userid integer, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_get_planet_name(_userid integer, _planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_get_planet_name(_userid integer, _planetid integer) IS 'Return the planet name if it belongs to the player or the player name if a radar or a fleet is in orbit otherwise it returns nothing';


--
-- Name: sp_get_planet_owner(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_planet_owner(integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $_$-- return the ownerid of given planet id

-- Param1: planet id

SELECT ownerid FROM nav_planet WHERE id=$1 LIMIT 1;$_$;


ALTER FUNCTION static.sp_get_planet_owner(integer) OWNER TO exileng;

--
-- Name: sp_get_prestige_cost_for_new_planet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_prestige_cost_for_new_planet(_planets integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$BEGIN

	RETURN 0;

/*	IF _planets < 5 THEN

		RETURN 0;

	END IF;

*/

END;$$;


ALTER FUNCTION static.sp_get_prestige_cost_for_new_planet(_planets integer) OWNER TO exileng;

--
-- Name: sp_get_research_cost(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_research_cost(integer, integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $_$-- Param1: UserId

-- Param2: ResearchId

SELECT int4((SELECT mod_research_cost FROM users WHERE id=$1) * cost_credits * power(2.35, 5-levels + COALESCE((SELECT level FROM researches WHERE researchid = db_research.id AND userid=$1), 0)))

FROM db_research

WHERE id=$2;$_$;


ALTER FUNCTION static.sp_get_research_cost(integer, integer) OWNER TO exileng;

--
-- Name: sp_get_research_time(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_research_time(_userid integer, _rank integer, _levels integer, _level integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$-- Param1: UserId

-- Param2: ResearchRank

-- Param3: ResearchLevels

-- Param4: ResearchLevel

DECLARE

	result int4;

	scientist_planets int4;

	scientist_total numeric;

	research_rank int4;

BEGIN

	SELECT INTO scientist_planets int4(count(*)-1) FROM nav_planet WHERE ownerid=_userid AND scientists > 0;

	SELECT INTO scientist_total 100 + COALESCE(sum(GREATEST(scientists-scientist_planets*5, scientists*5/100.0)*mod_research_effectiveness/1000.0), 0) FROM nav_planet WHERE ownerid=_userid AND scientists > 0;

	research_rank := _rank;

	IF research_rank > 0 THEN

/*

		SELECT INTO result

			int4((SELECT (100+mod_research_time)/100.0 FROM users WHERE id=_userid)*(3600 + 3.6/log(6,

			int4( 

				100 + sum( GREATEST( 0, scientists - (SELECT 5*(count(*)-1) FROM nav_planet WHERE ownerid=_userid and scientists > 0) ) ) )

			) * 800 * _rank * power(3.4+ GREATEST(-0.05, _rank-sum(scientists)/1500.0)/10.0, 5-_levels+COALESCE(_level, 0))))

		FROM nav_planet WHERE ownerid=_userid;

*/

		result := int4((3600 + 

			3.6/log(4+research_rank, scientist_total) * 800 * research_rank * power(3.4+ GREATEST(-0.05, research_rank-scientist_total/(research_rank*500.0))/10.0, 5-_levels+_level)));

	ELSE

		research_rank := -_rank;

		IF _level >= 16 THEN

			research_rank := research_rank + 5;

		ELSEIF _level >= 13 THEN

			research_rank := research_rank + 4;

		ELSEIF _level >= 10 THEN

			research_rank := research_rank + 3;

		ELSEIF _level >= 7 THEN

			research_rank := research_rank + 2;

		END IF;

/*

		SELECT INTO result

			int4((SELECT (100+mod_research_time)/100.0 FROM users WHERE id=_userid)*(3600 + 3.6/log(6,

			int4( 

				100 + sum( GREATEST( 0, scientists - (SELECT 5*(count(*)-1) FROM nav_planet WHERE ownerid=_userid and scientists > 0) ) ) )

			) * 800 * (-research_rank) * power(3.4+ GREATEST(-0.05, (-research_rank)-sum(scientists)/1500.0)/10.0, 4)))

		FROM nav_planet WHERE ownerid=_userid;

*/

		result := int4((3600 + 

			3.6/log(6, scientist_total) * 800 * research_rank * power(3.4+ GREATEST(-0.05, research_rank-scientist_total/1500.0)/10.0, 4)));

	END IF;

	RETURN int4((SELECT mod_research_time FROM users WHERE id=_userid) * result * const_game_speed());

END;$$;


ALTER FUNCTION static.sp_get_research_time(_userid integer, _rank integer, _levels integer, _level integer) OWNER TO exileng;

--
-- Name: sp_get_resource_price(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_resource_price(_userid integer, _galaxyid integer) RETURNS static.resource_price
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: userid

-- Param2: galaxy id

DECLARE

	p resource_price;

BEGIN

	p := sp_get_resource_price($1, $2, false);

	RETURN p;

END;$_$;


ALTER FUNCTION static.sp_get_resource_price(_userid integer, _galaxyid integer) OWNER TO exileng;

--
-- Name: sp_get_resource_price(integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_resource_price(_userid integer, _galaxyid integer, _stableprices boolean) RETURNS static.resource_price
    LANGUAGE plpgsql STABLE
    AS $_$-- Param1: userid

-- Param2: galaxy id

DECLARE

	p resource_price;

	r_user record;

	r_gal record;

	perc_ore real;

	perc_hydrocarbon real;

BEGIN

	p.sell_ore := 120.0;

	p.sell_hydrocarbon := 160.0;

	IF NOT _stableprices THEN

		SELECT INTO r_gal

			traded_ore,

			traded_hydrocarbon

		FROM nav_galaxies

		WHERE id=$2;

		IF FOUND THEN

			p.sell_ore := LEAST(200, GREATEST(80, 200.0 - power(GREATEST(r_gal.traded_ore, 1), 0.95) / 10000000.0));

			p.sell_hydrocarbon := LEAST(200, GREATEST(80, 200.0 - power(GREATEST(r_gal.traded_hydrocarbon, 1), 0.95) / 10000000.0));

		END IF;

	END IF;

	p.buy_ore := (p.sell_ore+5) * 1.2;

	p.buy_hydrocarbon := (p.sell_hydrocarbon+5) * 1.2;

	SELECT INTO r_user

		mod_merchant_buy_price, mod_merchant_sell_price

	FROM users

	WHERE id=$1;

	IF FOUND THEN

		p.buy_ore := p.buy_ore * r_user.mod_merchant_buy_price;

		p.buy_hydrocarbon := p.buy_hydrocarbon * r_user.mod_merchant_buy_price;

		p.sell_ore := p.sell_ore * r_user.mod_merchant_sell_price;

		p.sell_hydrocarbon := p.sell_hydrocarbon * r_user.mod_merchant_sell_price;

	END IF;

	p.buy_ore := round(p.buy_ore::numeric, 2);

	p.buy_hydrocarbon := round(p.buy_hydrocarbon::numeric, 2);

	p.sell_ore := round(p.sell_ore::numeric, 2);

	p.sell_hydrocarbon := round(p.sell_hydrocarbon::numeric, 2);

	RETURN p;

END;$_$;


ALTER FUNCTION static.sp_get_resource_price(_userid integer, _galaxyid integer, _stableprices boolean) OWNER TO exileng;

--
-- Name: sp_get_training_price(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_training_price(integer) RETURNS static.training_price
    LANGUAGE plpgsql IMMUTABLE
    AS $$-- Param1: UserID

DECLARE

	price training_price;

BEGIN

	price.scientist_ore := 10;

	price.scientist_hydrocarbon := 20;

	price.scientist_credits := 20;

	price.soldier_ore := 5;

	price.soldier_hydrocarbon := 15;

	price.soldier_credits := 10;

	RETURN price;

END;$$;


ALTER FUNCTION static.sp_get_training_price(integer) OWNER TO exileng;

--
-- Name: sp_get_user(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_user(integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$SELECT login FROM users WHERE id=$1;$_$;


ALTER FUNCTION static.sp_get_user(integer) OWNER TO exileng;

--
-- Name: sp_get_user_rs(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_get_user_rs(_userid integer, _galaxy integer, _sector integer) RETURNS smallint
    LANGUAGE plpgsql STABLE
    AS $$-- Param1: UserID

-- Param2: Galaxy

-- Param3: Sector

DECLARE

	str smallint;

	r_user record;

BEGIN

	-- retrieve player alliance info and rights

	SELECT INTO r_user

		users.alliance_id, users.security_level, alliances_ranks.leader OR alliances_ranks.can_use_alliance_radars AS see_alliance

	FROM users

		INNER JOIN alliances_ranks ON (alliances_ranks.rankid = users.alliance_rank AND alliances_ranks.allianceid = users.alliance_id)

	WHERE id=_userid;

	IF r_user.see_alliance THEN

		SELECT INTO str

			COALESCE(max(radar_strength), int2(0))

		FROM nav_planet

		WHERE galaxy=_galaxy AND sector=_sector AND ownerid IS NOT NULL AND EXISTS(SELECT 1 FROM vw_friends_radars WHERE friend=ownerid AND userid=_userid);

	ELSE

		SELECT INTO str

			COALESCE(max(radar_strength), int2(0))

		FROM nav_planet

		WHERE galaxy=_galaxy AND sector=_sector AND ownerid = _userid;

	END IF;

	RETURN str;

END;$$;


ALTER FUNCTION static.sp_get_user_rs(_userid integer, _galaxy integer, _sector integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_get_user_rs(_userid integer, _galaxy integer, _sector integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_get_user_rs(_userid integer, _galaxy integer, _sector integer) IS 'Return the player Radar Strength in a given galaxy:sector';


--
-- Name: sp_ignore_sender(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_ignore_sender(_userid integer, _ignored_user character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $$DECLARE

	ignored_id int4;

BEGIN

	SELECT INTO ignored_id id FROM users WHERE upper(login)=upper(_ignored_user) AND privilege < 500;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	INSERT INTO messages_ignore_list(userid, ignored_userid)

	VALUES(_userid, ignored_id);

	RETURN 0;

EXCEPTION

	WHEN UNIQUE_VIOLATION THEN

		RETURN 2;

END;$$;


ALTER FUNCTION static.sp_ignore_sender(_userid integer, _ignored_user character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_ignore_sender(_userid integer, _ignored_user character varying); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_ignore_sender(_userid integer, _ignored_user character varying) IS 'Add a name to a user ignore list so they can''t send him any message';


--
-- Name: sp_invade_planet(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_invade_planet(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: FleetId

-- Param3: Number of drop pods

DECLARE

	r_fleet record;

	r_planet record;

	can_take_planet bool;

	lost int4;

	def_lost int4;

	r_lost_ship record;

	lost_droppods int4;

	result invasion_result;

	invasion_id int4;

	_data character varying;

BEGIN

	lost_droppods := 0;

	result.result := 0;

	result.soldiers_total := 0;

	result.soldiers_lost := 0;

	result.def_soldiers_total := -1;

	result.def_soldiers_lost := 0;

	result.def_scientists_total := -1;

	result.def_scientists_lost := 0;

	result.def_workers_total := -1;

	result.def_workers_lost := 0;

	IF $3 <= 0 THEN

		result.result := -1;

		RETURN -1;

	END IF;

	-- retrieve fleet info and the fleet cargo

	SELECT INTO r_fleet

		id, name,

		planetid,

		LEAST(LEAST(cargo_soldiers, $3), droppods) AS soldiers

	FROM fleets

	WHERE ownerid=$1 AND id=$2 AND dest_planetid IS NULL AND not engaged AND now()-idle_since > const_interval_before_invasion() FOR UPDATE;

	IF NOT FOUND THEN

		-- can't invade : fleet either moving or fleet not found

		result.result := -2;

		RETURN -2;

	END IF;

	-- check if there are enemy fleets nearby

	PERFORM 1 FROM fleets WHERE planetid=r_fleet.planetid AND firepower > 0 AND sp_relation(ownerid, $1) < 0 AND action <> -1 AND action <> 1;

	IF FOUND THEN

		RETURN -5;

	END IF;

	IF r_fleet.soldiers <= 0 THEN

		result.result := -1;

		RETURN -1;

	END IF;

	PERFORM sp_update_planet(r_fleet.planetid);

	-- check the planet relation with the owner of the fleet

	SELECT INTO r_planet

		nav_planet.ownerid, nav_planet.name,

		nav_planet.scientists, nav_planet.soldiers, nav_planet.workers, nav_planet.workers_busy,

		sp_relation($1, nav_planet.ownerid) AS relation,

		protection_enabled OR now() < protection_datetime AS is_protected,

		production_frozen,

		alliance_id

	FROM nav_planet

		INNER JOIN users ON (users.id = nav_planet.ownerid)

	WHERE nav_planet.id=r_fleet.planetid AND planet_floor > 0 AND planet_space > 0;

	IF NOT FOUND OR r_planet.relation = -3 OR r_planet.relation > 0 THEN

		-- can't invade : planet not found or planet is friend or neutral (uninhabited)

		result.result := -3;

		RETURN -3;

	END IF;

	IF r_planet.is_protected OR r_planet.production_frozen THEN

		-- can't invade : the player is protected for 2 weeks or the planet is frozen (holidays)

		result.result := -4;

		RETURN -4;

	END IF;

	IF r_planet.relation <> -2 AND r_planet.alliance_id IS NOT NULL THEN

		result.result := -3;

		RETURN -3;

	END IF;

	result.soldiers_total := r_fleet.soldiers;

	result.def_soldiers_total := r_planet.soldiers;

	result.def_workers_total := r_planet.workers;

	result.def_scientists_total := r_planet.scientists;

	-- start invasion

	-- remove used soldiers

	UPDATE fleets SET

		cargo_soldiers = cargo_soldiers - result.soldiers_total

	WHERE ownerid=$1 AND id=$2;

	-- compute how many soldiers were shot down

	--lost_droppods

	result.soldiers_lost := lost_droppods;

	WHILE lost_droppods > 0

	LOOP

		SELECT INTO r_lost_ship

			fleetid, shipid, quantity, capacity, droppods

		FROM fleets_ships

			INNER JOIN db_ships ON (db_ships.id = fleets_ships.shipid)

		WHERE fleetid = r_fleet.id AND droppods > 0

		ORDER BY droppods;

		IF FOUND THEN

			r_lost_ship.quantity := LEAST(r_lost_ship.quantity, ceil(lost_droppods / r_lost_ship.droppods)::integer);

			PERFORM sp_destroy_ships(r_fleet.id, r_lost_ship.shipid, r_lost_ship.quantity);

		END IF;

		lost_droppods := lost_droppods - r_lost_ship.quantity * r_lost_ship.droppods;

	END LOOP;

	IF result.soldiers_lost < result.soldiers_total THEN

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_soldiers_total*8 / 4, result.soldiers_total);

		-- compute how many soldiers defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 8, result.def_soldiers_total);

		result.soldiers_lost := lost;

		result.def_soldiers_lost := def_lost;

	END IF;

	--RAISE NOTICE '% %', def_lost, lost;

	IF result.soldiers_lost < result.soldiers_total THEN

		PERFORM sp_stop_all_ships(r_planet.ownerid, r_fleet.planetid);

		-- retrieve updated number of workers

		SELECT INTO r_planet

			ownerid, name,

			scientists, LEAST(workers, workers_capacity) AS workers, workers_busy

		FROM nav_planet

		WHERE id=r_fleet.planetid;

		--RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

		result.def_workers_total := r_planet.workers;

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_workers_total*2 / 4, result.soldiers_total-result.soldiers_lost);

		-- compute how many workers defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 2, result.def_workers_total);

		IF def_lost >= r_planet.workers-r_planet.workers_busy THEN

			PERFORM sp_stop_all_buildings(r_planet.ownerid, r_fleet.planetid);

		END IF;

		-- retrieve updated number of workers

		SELECT INTO r_planet

			ownerid, name,

			scientists, workers, workers_busy

		FROM nav_planet

		WHERE id=r_fleet.planetid;

		--RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

		result.soldiers_lost := result.soldiers_lost + lost;

		result.def_workers_lost := def_lost;

	END IF;

	IF result.soldiers_lost < result.soldiers_total THEN

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_scientists_total*1 / 4, result.soldiers_total-result.soldiers_lost);

		-- compute how many scientists defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 1, result.def_scientists_total);

		result.soldiers_lost := result.soldiers_lost + lost;

		result.def_scientists_lost := def_lost;

	END IF;

	invasion_id := nextval('invasions_id_seq');

	INSERT INTO invasions(id, planet_id, planet_name, attacker_name, defender_name, attacker_succeeded, soldiers_total, soldiers_lost, def_scientists_total,

				def_scientists_lost, def_soldiers_total, def_soldiers_lost, def_workers_total, def_workers_lost)

	VALUES(invasion_id, r_fleet.planetid, r_planet.name, sp_get_user($1), sp_get_user(r_planet.ownerid), (result.soldiers_lost < result.soldiers_total), 

		result.soldiers_total, result.soldiers_lost, result.def_scientists_total, result.def_scientists_lost, result.def_soldiers_total, result.def_soldiers_lost, result.def_workers_total, result.def_workers_lost

		);

	--RAISE NOTICE '% % %', result.def_soldiers_lost, result.def_scientists_lost, result.def_workers_lost;

	-- update planet soldiers, scientists and workers

	UPDATE nav_planet SET

		soldiers = soldiers - result.def_soldiers_lost,

		scientists = scientists - result.def_scientists_lost,

		workers = workers - result.def_workers_lost,

		next_training_datetime = now()+INTERVAL '30 minutes'

	WHERE id=r_fleet.planetid;

	SELECT INTO can_take_planet

		planets < mod_planets

	FROM users

	WHERE id=$1;

	SELECT INTO r_planet

		id, ownerid, galaxy, sector, planet

	FROM nav_planet

	WHERE id=r_fleet.planetid;

	_data := '{invasionid:' || invasion_id || ', planet:{id:' || r_planet.id || ',g:' || r_planet.galaxy || ',s:' || r_planet.sector || ',p:' || r_planet.planet || ',owner:' || COALESCE(sp__quote(sp_get_user(r_planet.ownerid)), 'null') || '}}';

	-- planet captured only if at least 1 soldier remain

	IF result.soldiers_lost < result.soldiers_total THEN

		-- planet captured

		-- send a "planet lost" report to the defender

		INSERT INTO reports(ownerid, type, subtype, userid, planetid, invasionid, data)

		VALUES(r_planet.ownerid, 2, 10, $1, r_fleet.planetid, invasion_id, _data);

		IF r_planet.ownerid > 100 THEN

			UPDATE nav_galaxies SET

				traded_ore = traded_ore + 100000,

				traded_hydrocarbon = traded_hydrocarbon + 100000

			WHERE id=r_planet.galaxy;

		END IF;

		IF NOT can_take_planet THEN

			-- give planet to lost nations directly

			UPDATE nav_planet SET

				ownerid = 2,

				recruit_workers=true

			WHERE id=r_fleet.planetid;

			-- send a "planet enemies killed" report to the attacker

			INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

			VALUES($1, 2, 13, r_fleet.planetid, invasion_id, _data);

		ELSE

			UPDATE nav_planet SET

				ownerid = $1,

				recruit_workers=true,

				name=sp_get_user($1)

			WHERE id=r_fleet.planetid;

			-- send a "planet taken" report to the attacker

			INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

			VALUES($1, 2, 14, r_fleet.planetid, invasion_id, _data);

		END IF;

	ELSE

		-- send a "planet defended" report to the defender

		INSERT INTO reports(ownerid, type, subtype, userid, planetid, invasionid, data)

		VALUES(r_planet.ownerid, 2, 11, $1, r_fleet.planetid, invasion_id, _data);

		-- send a "planet invasion failed" report to the attacker

		INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

		VALUES($1, 2, 12, r_fleet.planetid, invasion_id, _data);

	END IF;

	UPDATE fleets SET

		cargo_soldiers = cargo_soldiers + result.soldiers_total - result.soldiers_lost

	WHERE ownerid=$1 AND id=$2;

	-- reset idle_since of all fleets orbiting the planet

	UPDATE fleets SET

		idle_since = now()

	WHERE planetid=r_fleet.planetid AND action <> -1 AND action <> 1;

	RETURN invasion_id;

END;$_$;


ALTER FUNCTION static.sp_invade_planet(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_invade_planet(integer, integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_invade_planet(integer, integer, integer, boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: FleetId

-- Param3: Number of drop pods

-- Param4: Take planet possession

DECLARE

	r_fleet record;

	r_planet record;

	can_take_planet bool;

	lost int4;

	def_lost int4;

	r_lost_ship record;

	lost_droppods int4;

	result invasion_result;

	invasion_id int4;

	_data character varying;

BEGIN

	lost_droppods := 0;

	result.result := 0;

	result.soldiers_total := 0;

	result.soldiers_lost := 0;

	result.def_soldiers_total := -1;

	result.def_soldiers_lost := 0;

	result.def_scientists_total := -1;

	result.def_scientists_lost := 0;

	result.def_workers_total := -1;

	result.def_workers_lost := 0;

	IF $3 <= 0 THEN

		result.result := -1;

		RETURN -1;

	END IF;

	-- retrieve fleet info and the fleet cargo

	SELECT INTO r_fleet

		id, name,

		planetid,

		LEAST(LEAST(cargo_soldiers, $3), droppods) AS soldiers

	FROM fleets

	WHERE ownerid=$1 AND id=$2 AND dest_planetid IS NULL AND not engaged AND now()-idle_since > const_interval_before_invasion() FOR UPDATE;

	IF NOT FOUND THEN

		-- can't invade : fleet either moving or fleet not found

		result.result := -2;

		RETURN -2;

	END IF;

	-- check if there are enemy fleets nearby

	PERFORM 1 FROM fleets WHERE planetid=r_fleet.planetid AND firepower > 0 AND sp_relation(ownerid, $1) < 0 AND action <> -1 AND action <> 1;

	IF FOUND THEN

		RETURN -5;

	END IF;

	IF r_fleet.soldiers <= 0 THEN

		result.result := -1;

		RETURN -1;

	END IF;

	PERFORM sp_update_planet(r_fleet.planetid);

	-- check the planet relation with the owner of the fleet

	SELECT INTO r_planet

		nav_planet.ownerid, nav_planet.name,

		nav_planet.scientists, nav_planet.soldiers, nav_planet.workers, nav_planet.workers_busy,

		sp_relation($1, nav_planet.ownerid) AS relation,

		protection_enabled OR now() < protection_datetime AS is_protected,

		production_frozen,

		alliance_id

	FROM nav_planet

		INNER JOIN users ON (users.id = nav_planet.ownerid)

	WHERE nav_planet.id=r_fleet.planetid AND planet_floor > 0 AND planet_space > 0;

	IF NOT FOUND OR r_planet.relation = -3 OR r_planet.relation > 0 THEN

		-- can't invade : planet not found or planet is friend or neutral (uninhabited)

		result.result := -3;

		RETURN -3;

	END IF;

	IF r_planet.is_protected OR r_planet.production_frozen THEN

		-- can't invade : the player is protected for 2 weeks or the planet is frozen (holidays)

		result.result := -4;

		RETURN -4;

	END IF;

	IF r_planet.relation <> -2 AND r_planet.alliance_id IS NOT NULL THEN

		result.result := -3;

		RETURN -3;

	END IF;

	result.soldiers_total := r_fleet.soldiers;

	result.def_soldiers_total := r_planet.soldiers;

	result.def_workers_total := r_planet.workers;

	result.def_scientists_total := r_planet.scientists;

	-- start invasion

	-- remove used soldiers

	UPDATE fleets SET

		cargo_soldiers = cargo_soldiers - result.soldiers_total

	WHERE ownerid=$1 AND id=$2;

	-- compute how many soldiers were shot down

	--lost_droppods

	result.soldiers_lost := lost_droppods;

	WHILE lost_droppods > 0

	LOOP

		SELECT INTO r_lost_ship

			fleetid, shipid, quantity, capacity, droppods

		FROM fleets_ships

			INNER JOIN db_ships ON (db_ships.id = fleets_ships.shipid)

		WHERE fleetid = r_fleet.id AND droppods > 0

		ORDER BY droppods;

		IF FOUND THEN

			r_lost_ship.quantity := LEAST(r_lost_ship.quantity, ceil(lost_droppods / r_lost_ship.droppods)::integer);

			PERFORM sp_destroy_ships(r_fleet.id, r_lost_ship.shipid, r_lost_ship.quantity);

		END IF;

		lost_droppods := lost_droppods - r_lost_ship.quantity * r_lost_ship.droppods;

	END LOOP;

	IF result.soldiers_lost < result.soldiers_total THEN

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_soldiers_total*8 / 4, result.soldiers_total);

		-- compute how many soldiers defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 8, result.def_soldiers_total);

		result.soldiers_lost := lost;

		result.def_soldiers_lost := def_lost;

	END IF;

	--RAISE NOTICE '% %', def_lost, lost;

	IF result.soldiers_lost < result.soldiers_total THEN

		PERFORM sp_stop_all_ships(r_planet.ownerid, r_fleet.planetid);

		-- retrieve updated number of workers

		SELECT INTO r_planet

			ownerid, name,

			scientists, LEAST(workers, workers_capacity) AS workers, workers_busy

		FROM nav_planet

		WHERE id=r_fleet.planetid;

		--RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

		result.def_workers_total := r_planet.workers;

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_workers_total*2 / 4, result.soldiers_total-result.soldiers_lost);

		-- compute how many workers defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 2, result.def_workers_total);

		IF def_lost >= r_planet.workers-r_planet.workers_busy THEN

			PERFORM sp_stop_all_buildings(r_planet.ownerid, r_fleet.planetid);

		END IF;

		-- retrieve updated number of workers

		SELECT INTO r_planet

			ownerid, name,

			scientists, workers, workers_busy

		FROM nav_planet

		WHERE id=r_fleet.planetid;

		--RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

		result.soldiers_lost := result.soldiers_lost + lost;

		result.def_workers_lost := def_lost;

	END IF;

	IF result.soldiers_lost < result.soldiers_total THEN

		-- compute how many soldiers attacker lost

		lost := LEAST(result.def_scientists_total*1 / 4, result.soldiers_total-result.soldiers_lost);

		-- compute how many scientists defender lost

		def_lost := LEAST((result.soldiers_total-result.soldiers_lost)*4 / 1, result.def_scientists_total);

		result.soldiers_lost := result.soldiers_lost + lost;

		result.def_scientists_lost := def_lost;

	END IF;

	invasion_id := nextval('invasions_id_seq');

	INSERT INTO invasions(id, planet_id, planet_name, attacker_name, defender_name, attacker_succeeded, soldiers_total, soldiers_lost, def_scientists_total,

				def_scientists_lost, def_soldiers_total, def_soldiers_lost, def_workers_total, def_workers_lost)

	VALUES(invasion_id, r_fleet.planetid, r_planet.name, sp_get_user($1), sp_get_user(r_planet.ownerid), (result.soldiers_lost < result.soldiers_total), 

		result.soldiers_total, result.soldiers_lost, result.def_scientists_total, result.def_scientists_lost, result.def_soldiers_total, result.def_soldiers_lost, result.def_workers_total, result.def_workers_lost

		);

	--RAISE NOTICE '% % %', result.def_soldiers_lost, result.def_scientists_lost, result.def_workers_lost;

	-- update planet soldiers, scientists and workers

	UPDATE nav_planet SET

		soldiers = soldiers - result.def_soldiers_lost,

		scientists = scientists - result.def_scientists_lost,

		workers = workers - result.def_workers_lost,

		next_training_datetime = now()+INTERVAL '30 minutes'

	WHERE id=r_fleet.planetid;

	SELECT INTO can_take_planet

		planets < mod_planets

	FROM users

	WHERE id=$1;

	SELECT INTO r_planet

		id, ownerid, galaxy, sector, planet

	FROM nav_planet

	WHERE id=r_fleet.planetid;

	_data := '{invasionid:' || invasion_id || ', planet:{id:' || r_planet.id || ',g:' || r_planet.galaxy || ',s:' || r_planet.sector || ',p:' || r_planet.planet || ',owner:' || COALESCE(sp__quote(sp_get_user(r_planet.ownerid)), 'null') || '}}';

	-- planet captured only if at least 1 soldier remain

	IF result.soldiers_lost < result.soldiers_total THEN

		-- planet captured

		-- send a "planet lost" report to the defender

		INSERT INTO reports(ownerid, type, subtype, userid, planetid, invasionid, data)

		VALUES(r_planet.ownerid, 2, 10, $1, r_fleet.planetid, invasion_id, _data);

		IF r_planet.ownerid > 100 THEN

			UPDATE nav_galaxies SET

				traded_ore = traded_ore + 100000,

				traded_hydrocarbon = traded_hydrocarbon + 100000

			WHERE id=r_planet.galaxy;

		END IF;

		IF $4 THEN

			PERFORM 1 FROM users WHERE prestige_points >= sp_get_prestige_cost_for_new_planet(planets) AND id=$1;

			IF NOT FOUND THEN

				can_take_planet := false;

			END IF;

		END IF;

		IF NOT can_take_planet OR NOT $4 THEN

			-- give planet to lost nations directly

			UPDATE nav_planet SET

				ownerid = 2,

				recruit_workers=true

			WHERE id=r_fleet.planetid;

			-- send a "planet enemies killed" report to the attacker

			INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

			VALUES($1, 2, 13, r_fleet.planetid, invasion_id, _data);

		ELSE

			UPDATE users SET

				prestige_points = prestige_points - sp_get_prestige_cost_for_new_planet(planets)

			WHERE id = $1;

			UPDATE nav_planet SET

				ownerid = $1,

				recruit_workers=true,

				name=sp_get_user($1)

			WHERE id=r_fleet.planetid;

			-- send a "planet taken" report to the attacker

			INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

			VALUES($1, 2, 14, r_fleet.planetid, invasion_id, _data);

		END IF;

	ELSE

		-- send a "planet defended" report to the defender

		INSERT INTO reports(ownerid, type, subtype, userid, planetid, invasionid, data)

		VALUES(r_planet.ownerid, 2, 11, $1, r_fleet.planetid, invasion_id, _data);

		-- send a "planet invasion failed" report to the attacker

		INSERT INTO reports(ownerid, type, subtype, planetid, invasionid, data)

		VALUES($1, 2, 12, r_fleet.planetid, invasion_id, _data);

	END IF;

	UPDATE fleets SET

		cargo_soldiers = cargo_soldiers + result.soldiers_total - result.soldiers_lost

	WHERE ownerid=$1 AND id=$2;

	-- reset idle_since of all fleets orbiting the planet

	UPDATE fleets SET

		idle_since = now()

	WHERE planetid=r_fleet.planetid AND action <> -1 AND action <> 1;

	RETURN invasion_id;

END;$_$;


ALTER FUNCTION static.sp_invade_planet(integer, integer, integer, boolean) OWNER TO exileng;

--
-- Name: sp_is_ally(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_is_ally(integer, integer) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $_$-- param1: User1

-- param2: User2

DECLARE

	alliance1 int4;

	alliance2 int4;

BEGIN

	-- if one player is null then return -3

	IF ($1 IS NULL) OR ($2 IS NULL) THEN

		RETURN false;

	END IF;

	-- return true for same player

	IF $1 = $2 THEN

		RETURN true;

	END IF;

	-- retrieve alliances of the 2 players

	SELECT INTO alliance1 alliance_id FROM users WHERE id=$1;

	SELECT INTO alliance2 alliance_id FROM users WHERE id=$2;

	-- return 1 for same alliance, 0 for NAPs

	RETURN alliance1 = alliance2;

END;$_$;


ALTER FUNCTION static.sp_is_ally(integer, integer) OWNER TO exileng;

--
-- Name: sp_job_update(character varying, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE log_jobs SET state=taskstate,"processid"=taskpid, lastupdate=now() WHERE lower(task)=lower(taskname);

	IF NOT FOUND THEN

		INSERT INTO log_jobs(task,state,"processid") VALUES(taskname,taskstate,taskpid);

	END IF;

END;$$;


ALTER FUNCTION static.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) OWNER TO exileng;

--
-- Name: sp_last_planet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_last_planet(integer, integer) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ($1-1)*25*99 + ($2-1)*25 + 25;$_$;


ALTER FUNCTION static.sp_last_planet(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_last_planet(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_last_planet(integer, integer) IS 'Return the last planet in a region.sector';


--
-- Name: sp_list_available_buildings(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_available_buildings(integer) RETURNS SETOF static.db_buildings
    LANGUAGE sql STABLE
    AS $_$-- param1: user id

	-- list all buildings that can be built

	-- a building can be built if it meet the requirement :

	-- if it depends on other buildings, these buildings must be built on the planet

	-- if it depends on researches, these researches must be done

	SELECT DISTINCT *

	FROM db_buildings

	WHERE buildable AND

	(

	NOT EXISTS

		(SELECT required_buildingid

		FROM db_buildings_req_building 

		WHERE (buildingid = db_buildings.id) AND (required_buildingid NOT IN (SELECT buildingid FROM nav_planet, planet_buildings WHERE nav_planet.id = planet_buildings.planetid AND nav_planet.ownerid = $1)))

	AND

	NOT EXISTS

		(SELECT required_researchid, required_researchlevel

		FROM db_buildings_req_research 

		WHERE (buildingid = db_buildings.id) AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=$1 AND level >= required_researchlevel)))

	)

	OR (SELECT count(*) FROM planet_buildings INNER JOIN nav_planet ON (nav_planet.id=planet_buildings.planetid) WHERE ownerid=$1 AND planet_buildings.buildingid=db_buildings.id LIMIT 1) > 0

	ORDER BY category, id;$_$;


ALTER FUNCTION static.sp_list_available_buildings(integer) OWNER TO exileng;

--
-- Name: sp_list_available_ships(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_available_ships(integer) RETURNS SETOF static.db_ships
    LANGUAGE sql STABLE
    AS $_$-- param1: user id

	-- list all ships that can be built

	-- a ship can be built if it meet the requirement :

	-- if it depends on researches, these researches must be done

	SELECT DISTINCT *

	FROM db_ships

	WHERE

	buildable and NOT EXISTS

		(SELECT required_researchid, required_researchlevel

		FROM db_ships_req_research 

		WHERE (shipid = db_ships.id) AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=$1 AND level >= required_researchlevel)))

	ORDER BY category, id;$_$;


ALTER FUNCTION static.sp_list_available_ships(integer) OWNER TO exileng;

--
-- Name: sp_list_available_ships2(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_available_ships2(integer) RETURNS SETOF static.db_ships
    LANGUAGE sql STABLE
    AS $_$-- param1: user id

	-- list all ships that can be built

	-- a ship can be built if it meet the requirement :

	-- if it depends on researches, these researches must be done

	SELECT

  db_ships.id,

  db_ships.category,

  db_ships.name,

  COALESCE(s2.label, db_ships.label),

  COALESCE(s2.description, db_ships.description),

  db_ships.cost_ore,

  db_ships.cost_hydrocarbon,

  db_ships.cost_credits,

  db_ships.workers,

  db_ships.crew,

  COALESCE(s2.capacity,db_ships.capacity),

  db_ships.construction_time,

  COALESCE(s2.maximum,db_ships.maximum),

  COALESCE(s2.hull,db_ships.hull),

  COALESCE(s2.shield,db_ships.shield),

  COALESCE(s2.weapon_power,db_ships.weapon_power),

  COALESCE(s2.weapon_ammo,db_ships.weapon_ammo),

  COALESCE(s2.weapon_tracking_speed,db_ships.weapon_tracking_speed),

  COALESCE(s2.weapon_turrets,db_ships.weapon_turrets),

  COALESCE(s2.signature,db_ships.signature),

  COALESCE(s2.speed,db_ships.speed),

  COALESCE(s2.handling,db_ships.handling),

  COALESCE(s2.buildingid,db_ships.buildingid),

  COALESCE(s2.recycler_output,db_ships.recycler_output),

  COALESCE(s2.droppods,db_ships.droppods),

  COALESCE(s2.long_distance_capacity,db_ships.long_distance_capacity),

  COALESCE(s2.buildable,db_ships.buildable),

  COALESCE(s2.mod_speed,db_ships.mod_speed),

  COALESCE(s2.mod_shield,db_ships.mod_shield),

  COALESCE(s2.mod_handling,db_ships.mod_handling),

  COALESCE(s2.mod_tracking_speed,db_ships.mod_tracking_speed),

  COALESCE(s2.mod_damage,db_ships.mod_damage),

  COALESCE(s2.mod_signature,db_ships.mod_signature),

  COALESCE(s2.mod_recycling,db_ships.mod_recycling),

  db_ships.required_shipid,

  db_ships.new_shipid

	FROM db_ships

		LEFT JOIN db_ships s2 ON (s2.id=db_ships.new_shipid)

	WHERE

	COALESCE(s2.buildable,db_ships.buildable) and NOT EXISTS

		(SELECT required_researchid, required_researchlevel

		FROM db_ships_req_research 

		WHERE (shipid = db_ships.id) AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=$1 AND level >= required_researchlevel)))

	ORDER BY category, id;$_$;


ALTER FUNCTION static.sp_list_available_ships2(integer) OWNER TO exileng;

--
-- Name: sp_list_fleets(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_fleets(integer, integer, integer) RETURNS SETOF static.fleet_details
    LANGUAGE sql STABLE
    AS $_$-- Param1: UserID

-- Param2: FleetID

-- Param3: PlanetID

SELECT fleets.id, 

	fleets.name, 

	fleets.attackonsight,

	fleets.engaged,

	fleets.size,

	fleets.signature,

	int4(fleets.speed*(100+fleets.mod_speed)/100.0),

	fleets.action,

	int4(date_part('epoch', now()-idle_since)),

	int4(date_part('epoch', action_end_time-action_start_time)),

	int4(date_part('epoch', action_end_time-now())),

	fleets.droppods,

	fleets.commanderid, (SELECT name FROM commanders WHERE id=fleets.commanderid),

	fleets.planetid, n1.name, n1.galaxy, n1.sector, n1.planet, n1.ownerid, sp_get_user(n1.ownerid), sp_relation(fleets.ownerid, n1.ownerid),

	fleets.dest_planetid, n2.name, n2.galaxy, n2.sector, n2.planet, n2.ownerid, sp_get_user(n2.ownerid), sp_relation(fleets.ownerid, n2.ownerid), 

	fleets.cargo_capacity, fleets.cargo_ore, fleets.cargo_hydrocarbon, fleets.cargo_scientists, fleets.cargo_soldiers, fleets.cargo_workers,

	fleets.recycler_output, n1.orbit_ore, n1.orbit_hydrocarbon

FROM fleets 

	LEFT JOIN nav_planet AS n1 ON (fleets.planetid = n1.id) 

	LEFT JOIN nav_planet AS n2 ON (fleets.dest_planetid = n2.id)

WHERE ($1 IS NULL OR fleets.ownerid = $1) AND ($2 IS NULL OR fleets.id = $2) AND ($3 IS NULL OR fleets.planetid = $3);$_$;


ALTER FUNCTION static.sp_list_fleets(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_list_fleets_moving(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_fleets_moving(integer) RETURNS SETOF static.fleet_movement
    LANGUAGE sql
    AS $_$SELECT fleets.id, fleets.name, fleets.attackonsight, fleets.firepower, fleets.engaged, fleets.size, fleets.signature, fleets.speed, 

COALESCE(fleets.remaining_time, 0) AS remaining_time, 

COALESCE(fleets.total_time, 0) AS total_time, commanderid, commandername, 

fleets.ownerid, fleets.owner_name, int2(COALESCE(( SELECT vw_relations.relation FROM vw_relations WHERE vw_relations.user1 = users.id AND vw_relations.user2 = fleets.ownerid), -3)) AS owner_relation, fleets.owner_alliance_id, 

fleets.planetid, fleets.planet_name, fleets.planet_galaxy, fleets.planet_sector, fleets.planet_planet, fleets.planet_ownerid, fleets.planet_owner_name, int2(COALESCE(( SELECT vw_relations.relation FROM vw_relations WHERE vw_relations.user1 = users.id AND vw_relations.user2 = fleets.planet_ownerid), -3)) AS planet_owner_relation, 

fleets.destplanetid, fleets.destplanet_name, fleets.destplanet_galaxy, fleets.destplanet_sector, fleets.destplanet_planet, fleets.destplanet_ownerid, fleets.destplanet_owner_name, int2(COALESCE(( SELECT vw_relations.relation FROM vw_relations WHERE vw_relations.user1 = users.id AND vw_relations.user2 = fleets.destplanet_ownerid), -3)) AS destplanet_owner_relation,

( SELECT int4(COALESCE(max(nav_planet.radar_strength), 0)) FROM nav_planet WHERE nav_planet.galaxy = fleets.planet_galaxy AND nav_planet.sector = fleets.planet_sector::integer AND nav_planet.ownerid IS NOT NULL AND EXISTS ( SELECT 1 FROM vw_allies WHERE nav_planet.ownerid = vw_allies.ally AND vw_allies.userid = users.id)) AS from_radarstrength, 

( SELECT int4(COALESCE(max(nav_planet.radar_strength), 0)) FROM nav_planet WHERE nav_planet.galaxy = fleets.destplanet_galaxy AND nav_planet.sector = fleets.destplanet_sector::integer AND nav_planet.ownerid IS NOT NULL AND EXISTS ( SELECT 1 FROM vw_allies WHERE nav_planet.ownerid = vw_allies.ally AND vw_allies.userid = users.id)) AS to_radarstrength,

fleets.cargo_capacity, fleets.cargo_free, fleets.cargo_ore, fleets.cargo_hydrocarbon, fleets.cargo_scientists, fleets.cargo_soldiers, fleets.cargo_workers

FROM users, vw_fleets fleets

WHERE users.id=$1 AND ("action" = 1 OR "action" = -1) AND (ownerid=$1 OR (destplanetid IS NOT NULL AND destplanetid IN (SELECT id FROM nav_planet WHERE ownerid=$1)))$_$;


ALTER FUNCTION static.sp_list_fleets_moving(integer) OWNER TO exileng;

--
-- Name: sp_list_researches(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_list_researches(integer) RETURNS SETOF static.research_status
    LANGUAGE sql STABLE
    AS $_$-- list researches and their status for userid $1

-- Param1: user id

SELECT $1, db_research.id, db_research.category, db_research.name, db_research.label, db_research.description, db_research.rank, db_research.cost_credits, db_research.levels,

	COALESCE((SELECT level FROM researches WHERE researchid = db_research.id AND userid=users.id), int2(0)) AS level,

	(SELECT int4(date_part('epoch', end_time-now())) FROM researches_pending WHERE researchid = db_research.id AND userid=users.id) AS status,

	sp_get_research_time(users.id, rank, levels, CASE WHEN expiration IS NULL THEN COALESCE((SELECT level FROM researches WHERE researchid = db_research.id AND userid=users.id), 0) ELSE 0 END) AS total_time,

	sp_get_research_cost(users.id, db_research.id) AS total_cost,

	(SELECT int4(date_part('epoch', expires-now())) FROM researches WHERE researchid = db_research.id AND userid = users.id) AS remaining_time,

	int4(date_part('epoch', expiration)) AS expiration_time,

	NOT EXISTS

	(SELECT 1

	FROM db_research_req_research

	WHERE (researchid = db_research.id) AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=users.id AND level >= required_researchlevel))),

	NOT EXISTS

	(SELECT 1

	FROM db_research_req_building

	WHERE (researchid = db_research.id) AND (required_buildingid NOT IN 

		(SELECT planet_buildings.buildingid

		FROM nav_planet

			LEFT JOIN planet_buildings ON (nav_planet.id = planet_buildings.planetid)

		WHERE nav_planet.ownerid=users.id

		GROUP BY planet_buildings.buildingid

		HAVING sum(planet_buildings.quantity) >= required_buildingcount))),

	NOT EXISTS

	(SELECT 1

	FROM db_research_req_building

	WHERE (researchid = db_research.id) AND (SELECT is_planet_element FROM db_buildings WHERE id=db_research_req_building.required_buildingid) = true AND (required_buildingid NOT IN 

		(SELECT planet_buildings.buildingid

		FROM nav_planet

			LEFT JOIN planet_buildings ON (nav_planet.id = planet_buildings.planetid)

		WHERE nav_planet.ownerid=users.id

		GROUP BY planet_buildings.buildingid

		HAVING sum(planet_buildings.quantity) >= required_buildingcount)))

FROM users, db_research

WHERE rank <> 0 and users.id=$1

ORDER BY category, db_research.id;$_$;


ALTER FUNCTION static.sp_list_researches(integer) OWNER TO exileng;

--
-- Name: sp_locs_shared(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_locs_shared(integer, integer) RETURNS boolean
    LANGUAGE sql STABLE
    AS $_$SELECT share_locs FROM alliances_naps WHERE allianceid1=$2 AND allianceid2=$1;$_$;


ALTER FUNCTION static.sp_locs_shared(integer, integer) OWNER TO exileng;

--
-- Name: sp_log_activity(integer, character varying, bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_activity(integer, character varying, bigint) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: Userid

-- Param2: IP address

-- Param3: browserid

DECLARE

	addr int8;

	loggedsince timestamp;

BEGIN

	UPDATE users SET

		lastactivity=now()/*,

		requests=requests+1*/

	WHERE id=$1 AND (lastactivity IS NULL OR lastactivity < now()-INTERVAL '5 minutes');-- OR lastaddress <> addr OR lastbrowserid <> $3);

/*

	SELECT INTO loggedsince lastlogin FROM users WHERE id=$1;

	IF $1 < 100 THEN

		RETURN;

	END IF;

	BEGIN

		INSERT INTO log_multi_simultaneous_warnings(datetime, userid1, userid2)

			SELECT date_trunc('hour', now()), $1, id

			FROM users

			WHERE id >= 100 AND id <> $1 AND now() > lastactivity AND lastactivity > loggedsince AND lastaddress=addr AND lastbrowserid = $3;

	EXCEPTION

		WHEN UNIQUE_VIOLATION THEN

	END;

*/

END;$_$;


ALTER FUNCTION static.sp_log_activity(integer, character varying, bigint) OWNER TO exileng;

--
-- Name: sp_log_credits(integer, integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_credits(integer, integer, character varying) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: Userid

-- Param2: Credits delta

-- Param3: Description

INSERT INTO users_expenses(userid, credits, credits_delta, description)

VALUES($1, (SELECT credits FROM users WHERE id=$1), $2, $3);$_$;


ALTER FUNCTION static.sp_log_credits(integer, integer, character varying) OWNER TO exileng;

--
-- Name: sp_log_multi_simultaneous_warnings_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_multi_simultaneous_warnings_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	PERFORM 1 FROM log_multi_simultaneous_warnings WHERE datetime=NEW.datetime AND userid1=NEW.userid1 AND userid2=NEW.userid2;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_log_multi_simultaneous_warnings_before_insert() OWNER TO exileng;

--
-- Name: sp_log_notice_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_notice_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE log_notices SET

		datetime=now(),

		repeats=repeats+1

	WHERE username=NEW.username AND title = NEW.title AND details=NEW.details AND url=NEW.url AND datetime > now()-interval '30 seconds';

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_log_notice_before_insert() OWNER TO exileng;

--
-- Name: sp_log_referer(integer, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_referer(integer, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- param1: Userid

-- param2: Referer

DECLARE

	refid int4;

BEGIN

	SELECT INTO refid id FROM log_referers WHERE referer = $2;

	IF NOT FOUND THEN

		refid := nextval('log_referers_id_seq');

		INSERT INTO log_referers(id, referer) VALUES(refid, $2);

	END IF;

	INSERT INTO log_referers_users(refererid, userid) VALUES(refid, $1);

END;$_$;


ALTER FUNCTION static.sp_log_referer(integer, character varying) OWNER TO exileng;

--
-- Name: sp_log_referer(integer, character varying, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_log_referer(integer, character varying, character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- param1: Userid

-- param2: Referer

DECLARE

	refid int4;

BEGIN

	SELECT INTO refid id FROM log_referers WHERE referer = $2;

	IF NOT FOUND THEN

		refid := nextval('log_referers_id_seq');

		INSERT INTO log_referers(id, referer, page) VALUES(refid, $2, $3);

	ELSE

		UPDATE log_referers SET page=$3 WHERE id=refid;

		UPDATE log_referers SET pages=$3::text || pages WHERE id=refid AND NOT $3 = ANY (pages);

	END IF;

	INSERT INTO log_referers_users(refererid, userid, page) VALUES(refid, $1, $3);

END;$_$;


ALTER FUNCTION static.sp_log_referer(integer, character varying, character varying) OWNER TO exileng;

--
-- Name: sp_market_price(real, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_market_price(_base_price real, _planet_stock integer) RETURNS real
    LANGUAGE plpgsql STABLE
    AS $$BEGIN

	IF _planet_stock > 0 THEN

		RETURN _base_price * 0.95 * (1.0 - 0.40 *_planet_stock / const_planet_market_stock_max());

	ELSE

		RETURN _base_price * 0.95 * (1.0 + 0.35 *_planet_stock / const_planet_market_stock_min());

	END IF;

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_market_price(_base_price real, _planet_stock integer) OWNER TO exileng;

--
-- Name: sp_market_sell(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_market_sell(_user_id integer, _planet_id integer, _ore integer, _hydro integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Put resources for sale

-- Param1: User ID

-- Param2: Planet ID

-- Param3: ore

-- Param4: hydrocarbon

-- Param5: ore price

-- Param6: hydrocarbon price

DECLARE

	r_user record;

	r_planet record;

	total int4;

	market_prices resource_price;

	ore_quantity integer;

	hydrocarbon_quantity integer;

	ore_price real;

	hydrocarbon_price real;

BEGIN

	IF ($3 < 0) OR ($4 < 0) THEN

		RETURN 1;

	END IF;

	-- check that the planet exists and is owned by the given user

	SELECT INTO r_planet

		id, name, ownerid, galaxy,

		planet_stock_ore, planet_stock_hydrocarbon

	FROM vw_planets

	WHERE ownerid=_user_id AND id=_planet_id;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	PERFORM sp_update_planet_production(_planet_id);

	-- retrieve galaxy price for everyone (don't take user price bonus into account)

	market_prices := sp_get_resource_price(0, r_planet.galaxy);

	ore_price := sp_market_price(market_prices.sell_ore, r_planet.planet_stock_ore);

	hydrocarbon_price := sp_market_price(market_prices.sell_hydrocarbon, r_planet.planet_stock_hydrocarbon);

	ore_quantity := LEAST(_ore, 10000000);

	hydrocarbon_quantity := LEAST(_hydro, 10000000);

	-- update resources, raise an exception if not enough resources

	UPDATE nav_planet SET

		ore = ore - ore_quantity,

		hydrocarbon = hydrocarbon - hydrocarbon_quantity,

		planet_stock_ore = planet_stock_ore + ore_quantity,

		planet_stock_hydrocarbon = planet_stock_hydrocarbon + hydrocarbon_quantity

	WHERE id=_planet_id AND ownerid=_user_id;

	-- insert the sale to the market history

	--INSERT INTO market_history(ore_sold, hydrocarbon_sold, credits, username)

	--SELECT ore_quantity, hydrocarbon_quantity, 0, login FROM users WHERE id=_user_id;

	-- update galaxy traded wares quantity

	UPDATE nav_galaxies SET

		traded_ore = (traded_ore + ore_quantity / GREATEST(1.0, LEAST(5.0, 1.0 * market_prices.sell_ore / ore_price)))::bigint,

		traded_hydrocarbon = (traded_hydrocarbon + hydrocarbon_quantity / GREATEST(1.0, LEAST(5.0, 1.0 * market_prices.sell_hydrocarbon / hydrocarbon_price)))::bigint

	WHERE id=r_planet.galaxy;

	-- compute total credits from the sale

	total := (ore_price * ore_quantity/1000 + hydrocarbon_price * hydrocarbon_quantity/1000)::int4;

	total := sp_apply_tax(_user_id, total);

	UPDATE users SET

		credits = credits + total

	WHERE id = _user_id;

	RETURN 0;

EXCEPTION

	WHEN CHECK_VIOLATION THEN

		RETURN 3;

	WHEN UNIQUE_VIOLATION THEN

		RETURN 4;

END;$_$;


ALTER FUNCTION static.sp_market_sell(_user_id integer, _planet_id integer, _ore integer, _hydro integer) OWNER TO exileng;

--
-- Name: sp_merge_fleets(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_merge_fleets(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Merge the second fleet ($3) to the first one ($2)

--Param1: UserId

--Param2: FleetId 1

--Param3: FleetId 2

DECLARE

	c int4;

	r_fleet record;

BEGIN

	-- check that the 2 fleets are near the same planet

	SELECT INTO r_fleet planetid FROM fleets WHERE id=$2;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	PERFORM 1 FROM fleets WHERE id=$3 AND planetid=r_fleet.planetid;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- check that the 2 fleets belong to the same player, are not engaged and idle (action=0)

	SELECT INTO c count(*) FROM fleets WHERE (id=$2 OR id=$3) AND ownerid=$1 AND action=0 AND NOT engaged;

	IF C <> 2 THEN

		RETURN 1;

	END IF;

	-- set the fleet action to 10 so no updates happen during ships transfer

	UPDATE fleets SET action=10 WHERE ownerid=$1 AND (id=$2 OR id=$3);

	-- add the ships of fleet $3 to fleet $2

	INSERT INTO fleets_ships(fleetid, shipid, quantity)

		SELECT $2, shipid, quantity FROM fleets_ships WHERE fleetid=$3;

	-- retrieve fleet $3 cargo

	SELECT INTO r_fleet

		cargo_ore, cargo_hydrocarbon, cargo_scientists, cargo_soldiers, cargo_workers, idle_since

	FROM fleets

	WHERE id=$3;

	-- set the action back to 0 for the first fleet ($2)

	UPDATE fleets SET action=0 WHERE ownerid=$1 AND id=$2;

	PERFORM sp_update_fleet($2);

	-- add the cargo of fleet $3 to fleet $2

	UPDATE fleets SET

		cargo_ore = cargo_ore + r_fleet.cargo_ore,

		cargo_hydrocarbon = cargo_hydrocarbon + r_fleet.cargo_hydrocarbon,

		cargo_scientists = cargo_scientists + r_fleet.cargo_scientists,

		cargo_soldiers = cargo_soldiers + r_fleet.cargo_soldiers,

		cargo_workers = cargo_workers + r_fleet.cargo_workers,

		idle_since = GREATEST(now(), r_fleet.idle_since)

	WHERE id=$2;

	-- delete the second fleet

	DELETE FROM fleets WHERE id=$3;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_merge_fleets(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_merge_fleets(integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_merge_fleets(integer, integer, integer) IS 'Merge the second fleet into the first fleet';


--
-- Name: sp_messages_addressee_history_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_messages_addressee_history_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	c int4;

BEGIN

	-- check if this entry isn't duplicate but do not raise an exception

	SELECT count(*) INTO c FROM messages_addressee_history WHERE ownerid=NEW.ownerid AND addresseeid=NEW.addresseeid LIMIT 1;

	IF FOUND AND c > 0 THEN

		-- do not add the entry

		UPDATE messages_addressee_history SET created=now() WHERE ownerid=NEW.ownerid AND addresseeid=NEW.addresseeid;

		RETURN NULL;

	END IF;

	-- limit to 10 entries per user

	SELECT count(*) INTO c FROM messages_addressee_history WHERE ownerid=NEW.ownerid;

	if FOUND AND c >= 10 THEN

		DELETE FROM messages_addressee_history

		WHERE ownerid=NEW.ownerid AND 

			id IN

			(SELECT id

			FROM messages_addressee_history 

			WHERE ownerid=NEW.ownerid

			ORDER BY created ASC

			LIMIT 1);

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_messages_addressee_history_beforeinsert() OWNER TO exileng;

--
-- Name: sp_messages_afterchanges(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_messages_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF NEW.ownerid IS NULL AND NEW.senderid IS NULL THEN

		DELETE FROM messages WHERE id= NEW.id;

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_messages_afterchanges() OWNER TO exileng;

--
-- Name: sp_move_fleet(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_move_fleet(_user_id integer, _fleet_id integer, _planet_id integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: user id

-- Param2: fleet id

-- Param3: planet id

DECLARE

	fleet record;

	dest_planet record;

	travel_distance float;

	travel_cost int4;

	travel_time interval;

	vortex_travel_time interval;

	create_residual_vortex integer;

	jumping_sig bigint;

BEGIN

	create_residual_vortex := 0;

	IF _planet_id <= 0 THEN

		-- check planet is valid

		RETURN -1;

	END IF;

	-- get current fleet location, time of next battle and check if the fleet is ready for order

	SELECT INTO fleet

		planetid, p.galaxy, p.sector, p.planet, (p.next_battle-now()) AS nextbattle,

		f.real_signature <= f.long_distance_capacity AS long_distance_travels_ok,

		int4(f.speed*f.mod_speed/100.0) AS speed, f.real_signature, f.firepower, f.military_signature,

		p.vortex_strength, required_vortex_strength, security_level, p.floor = 0 and p.space = 0 AS is_empty

	FROM fleets f

		LEFT JOIN nav_planet p ON (f.planetid = p.id)

		INNER JOIN users ON (users.id=f.ownerid)

	WHERE f.id=_fleet_id AND f.ownerid=$1 AND f.action=0

	FOR UPDATE OF f, users;

	IF NOT FOUND THEN

		RETURN -1;

	END IF;

	IF fleet.speed <= 0 THEN

		RETURN -10;

	END IF;

	-- check if destination = origin planet

	IF _planet_id = fleet.planetid THEN

		RETURN -2;

	END IF;

	-- get destination planet info

	SELECT INTO dest_planet

		nav_planet.id, ownerid, galaxy, sector, planet,

		(SELECT protection_enabled OR now() < protection_datetime FROM users WHERE id=nav_planet.ownerid) AS is_protected,

		production_frozen, nav_galaxies.visible, COALESCE(nav_galaxies.protected_until < now(), false) AS can_jump_to,

		vortex_strength, min_security_level, floor = 0 and space = 0 AS is_empty

	FROM nav_planet

		INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

	WHERE nav_planet.id = _planet_id;

	IF NOT FOUND OR (_user_id > 100 AND NOT dest_planet.visible AND dest_planet.ownerid <> _user_id) OR fleet.security_level < dest_planet.min_security_level THEN

		RETURN -3;

	END IF;

	-- In case of galaxy change, check if can jump

	-- Jump is ok if fleet is not around a planet

	IF fleet.planetid IS NOT NULL AND dest_planet.galaxy <> fleet.galaxy THEN

		-- check long distance travel is possible

		IF NOT fleet.long_distance_travels_ok THEN

			RETURN -5;

		END IF;

		-- can only jump to galaxies older than 2 months

		IF NOT dest_planet.can_jump_to THEN

			RETURN -8;

		END IF;

		IF NOT dest_planet.visible THEN

			RETURN -3;

		END IF;

		-- check the fleet jumps from an empty location or from a strong enough vortex

		/*IF NOT fleet.is_empty THEN

			RETURN -7;

		END IF;

		-- check the fleet jumps to a vortex with enough strength

		IF NOT fleet.is_empty THEN

			RETURN -9;

		END IF;*/

	END IF;

	-- can't move to a frozen planet

	IF dest_planet.production_frozen THEN

		RETURN 4;

	END IF;

	-- if player is protected, only allow player's own fleets or unarmed fleets of (alliance and NAP)

	IF dest_planet.is_protected AND sp_relation(dest_planet.ownerid, _user_id) < 0 AND fleet.firepower <> 0 THEN

		RETURN -4;

	END IF;

	vortex_travel_time := GREATEST(1, fleet.required_vortex_strength) * INTERVAL '12 hours';

	IF (dest_planet.galaxy <> fleet.galaxy) THEN

		--RAISE NOTICE '1';

		-- normal inter-galaxy jump

		travel_distance := 200.0;

		travel_time := 2*vortex_travel_time;

		IF (fleet.required_vortex_strength <= 1 OR fleet.required_vortex_strength <= fleet.vortex_strength) AND fleet.required_vortex_strength <= dest_planet.vortex_strength THEN

			create_residual_vortex := fleet.planetid;

			fleet.planetid = null;

		ELSE

			-- check if fleet could jump without vortex

			SELECT INTO jumping_sig COALESCE(sum(real_signature), 0)

			FROM fleets

			WHERE dest_planetid = dest_planet.id AND (SELECT galaxy FROM nav_planet WHERE nav_planet.id = fleets.planetid) <> dest_planet.galaxy;

			IF NOT FOUND THEN

				jumping_sig := 0;

			END IF;

			IF fleet.real_signature > 5000 - jumping_sig THEN

				-- too many fleets jumping toward the same point

				RETURN -10;

			END IF;

		END IF;

	ELSE

		--RAISE NOTICE '2';

		-- if fleet is not near a planet, set a fixed travel distance of 12 units

		IF fleet.planetid IS NULL THEN

			travel_distance := 12;

		ELSE

			travel_distance := sp_travel_distance(dest_planet.sector, dest_planet.planet, fleet.sector, fleet.planet);

		END IF;

		travel_time := travel_distance * 3600 * 1000.0/fleet.speed * INTERVAL '1 second'; -- compute travel time

	END IF;

	travel_cost := int4(floor(travel_distance/200.0*fleet.real_signature));

	-- allow to jump if has jumpers, required_vortex_strength <= 1 and out vortex is strong enough

	IF dest_planet.galaxy = fleet.galaxy AND fleet.planetid IS NOT NULL AND fleet.long_distance_travels_ok AND travel_time > vortex_travel_time AND fleet.vortex_strength >= 0 THEN

		-- jumpers capacity ok and jump shorter than default travel time

		IF fleet.required_vortex_strength <= 1 AND fleet.required_vortex_strength <= dest_planet.vortex_strength THEN

			--RAISE NOTICE '3';

			-- fleet can jump from anywhere to a vortex but create a residual vortex

			travel_cost := int4(2*fleet.real_signature);

			travel_time := vortex_travel_time;

			create_residual_vortex := fleet.planetid;

			fleet.planetid = null;

		ELSEIF fleet.required_vortex_strength <= fleet.vortex_strength AND fleet.required_vortex_strength <= dest_planet.vortex_strength THEN

			--RAISE NOTICE '4';

			travel_cost := int4(2*fleet.real_signature);

			travel_time := vortex_travel_time;		

		END IF;

		--RAISE NOTICE '5';

	END IF;

	-- create a residual vortex

	IF fleet.vortex_strength = 0 AND create_residual_vortex <> 0 THEN

		INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

		VALUES(create_residual_vortex, 603, 1, now() + INTERVAL '45 minutes');

	END IF;

	-- Pay travel

	-- free for the 100 special first players (npc)

	IF $1 > 100 THEN

		travel_cost := GREATEST(1, travel_cost);

		INSERT INTO users_expenses(userid, credits_delta, planetid, fleetid)

		VALUES($1, -travel_cost, dest_planet.id, $2);

		UPDATE users SET credits=credits-travel_cost WHERE id=$1;

	END IF;

	-- move fleet

	UPDATE fleets SET

		dest_planetid = dest_planet.id,

		action_start_time = now(),

		action_end_time = now() + travel_time * const_game_speed() + COALESCE(CASE WHEN engaged AND fleet.nextbattle IS NOT NULL THEN fleet.nextbattle END, INTERVAL '0 second'),

		engaged = engaged AND fleet.nextbattle IS NOT NULL,

		action = 1,

		idle_since = null,

		next_waypointid = null

	WHERE id = $2 AND ownerid=$1;

	IF NOT FOUND THEN

		RETURN -3;

	END IF;

	IF fleet.military_signature > 0 THEN

		UPDATE nav_planet SET blocus_strength = NULL WHERE id=fleet.planetid;

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_move_fleet(_user_id integer, _fleet_id integer, _planet_id integer) OWNER TO exileng;

--
-- Name: sp_move_fleet(integer, integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_move_fleet(integer, integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: user id

-- Param2: fleet id

-- Param3: galaxy

-- Param4: sector

-- Param5: planet

BEGIN

	RETURN sp_move_fleet($1, $2, sp_planet($3, $4, $5));

END;$_$;


ALTER FUNCTION static.sp_move_fleet(integer, integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_nav_planet_afterupdate(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_nav_planet_afterupdate() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	c int4;

BEGIN

	IF NEW.ownerid IS NOT NULL THEN

		IF OLD.mod_construction_speed_buildings <> NEW.mod_construction_speed_buildings THEN

			PERFORM static.sp_update_planet_buildings_construction(NEW.id);

		END IF;

		IF OLD.mod_construction_speed_ships <> NEW.mod_construction_speed_ships THEN

			PERFORM static.sp_update_planet_ships_construction(NEW.id);

		END IF;

	END IF;

	IF OLD.ownerid IS DISTINCT FROM NEW.ownerid THEN

		-- add or remove the planet from ai_planets table if the new owner is a player or a computer

		PERFORM 1 FROM users WHERE id=NEW.ownerid AND privilege <= -100;

		IF FOUND THEN

			PERFORM 1 FROM ai_planets WHERE planetid=NEW.id;

			IF NOT FOUND THEN

				INSERT INTO ai_planets(planetid) VALUES(NEW.id);

			END IF;

		ELSE

			DELETE FROM ai_planets WHERE planetid=NEW.id;

			-- destroy ships if planet lost from another real player

			IF OLD.ownerid IS NOT NULL THEN

				PERFORM sp_destroy_planet_ship(planetid, shipid, quantity) FROM planet_ships WHERE planetid = NEW.id;

			END IF;

		END IF;

		DELETE FROM ai_watched_planets WHERE planetid=NEW.id;

		-- delete all the energy transfers from this planet

		DELETE FROM planet_energy_transfer WHERE planetid = NEW.id;

		-- reset the planet buy orders

		UPDATE nav_planet SET buy_ore=0, buy_hydrocarbon=0 WHERE id=OLD.id;

		-- update production of prestige for the old ownerid

		IF OLD.ownerid IS NOT NULL THEN

			UPDATE users SET production_prestige = COALESCE((SELECT sum(production_prestige) FROM nav_planet WHERE ownerid=users.id), 0) WHERE id=OLD.ownerid;

		END IF;

	END IF;

	IF OLD.production_prestige <> NEW.production_prestige THEN

		-- update production of prestige for the new ownerid

		UPDATE users SET production_prestige = COALESCE((SELECT sum(production_prestige) FROM nav_planet WHERE ownerid=users.id), 0) WHERE id=NEW.ownerid;

	END IF;

	IF (NEW.ownerid IS NOT NULL) AND (OLD.commanderid IS DISTINCT FROM NEW.commanderid) THEN

		PERFORM static.sp_update_planet(NEW.id);

	ELSEIF (OLD.scientists <> NEW.scientists) OR (OLD.ownerid IS DISTINCT FROM NEW.ownerid) THEN

		IF NEW.planet_floor > 0 AND NEW.planet_space > 0 THEN

			IF OLD.ownerid IS NOT NULL THEN

				PERFORM static.sp_update_research(OLD.ownerid);

				IF NEW.ownerid IS DISTINCT FROM OLD.ownerid THEN

					-- update old owner planet count

					UPDATE users SET planets=planets-1 WHERE id=OLD.ownerid;

					UPDATE users SET noplanets_since=now() WHERE id=OLD.ownerid AND planets=0;

					UPDATE nav_galaxies SET colonies=colonies-1 WHERE id=OLD.galaxy;

				END IF;

			END IF;

			IF NEW.ownerid IS DISTINCT FROM OLD.ownerid THEN

				IF NEW.ownerid IS NULL THEN

					PERFORM sp_clear_planet(NEW.id);

				ELSE

					INSERT INTO reports(ownerid, type, planetid, data)

					VALUES(NEW.ownerid, 6, NEW.id, '{planet:{id:' || NEW.id || ',owner:' || sp__quote(sp_get_user(NEW.ownerid)) || ',g:' || NEW.galaxy || ',s:' || NEW.sector || ',p:' || NEW.planet || '}}');

					PERFORM sp_update_research(NEW.ownerid);

					-- update new owner planet count

					UPDATE users SET planets=planets+1, noplanets_since=null WHERE id=NEW.ownerid;

					UPDATE nav_galaxies SET colonies=colonies+1 WHERE id=NEW.galaxy;

					UPDATE nav_galaxies SET protected_until=now()+const_interval_galaxy_protection() WHERE id=NEW.galaxy AND protected_until IS NULL;

					-- 

					UPDATE nav_planet SET

						last_catastrophe = now()+INTERVAl '48 hours',

						commanderid = NULL,

						mood = 0,

						production_frozen=false

					WHERE id=NEW.id;

				END IF;

				-- add an entry in the planet_owners journal

				BEGIN

					INSERT INTO planet_owners(planetid, ownerid, newownerid) VALUES(NEW.id, OLD.ownerid, NEW.ownerid);

				EXCEPTION

					WHEN FOREIGN_KEY_VIOLATION THEN

						RETURN NEW;

				END;

			END IF;

		END IF;

	END IF;

/*

	IF NEW.shipyard_next_continue IS NOT NULL AND NOT NEW.shipyard_suspended AND 

		(OLD.ore < NEW.ore OR OLD.hydrocarbon < NEW.hydrocarbon OR OLD.energy < NEW.energy OR OLD.workers < NEW.workers OR OLD.ore_production <> NEW.ore_production OR OLD.hydrocarbon_production <> NEW.hydrocarbon_production OR OLD.energy_production <> NEW.energy_production OR OLD.energy_consumption <> NEW.energy_consumption OR OLD.mod_production_workers <> NEW.mod_production_workers OR OLD.workers_busy <> NEW.workers_busy) THEN

		UPDATE nav_planet SET shipyard_next_continue = now()+INTERVAL '2 seconds' WHERE id=NEW.id;

	--	NEW.shipyard_next_continue := now()+INTERVAL '5 seconds';

	--	RAISE NOTICE 'shipyard: %', NEW.id;

	END IF;

*/

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_nav_planet_afterupdate() OWNER TO exileng;

--
-- Name: FUNCTION sp_nav_planet_afterupdate(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_nav_planet_afterupdate() IS 'Update planet if commanderid changes and update research speed  if the number of scientists changes.';


--
-- Name: sp_nav_planet_beforechanges(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_nav_planet_beforechanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	NEW.ore := LEAST(NEW.ore, NEW.ore_capacity);

	NEW.hydrocarbon := LEAST(NEW.hydrocarbon, NEW.hydrocarbon_capacity);

	NEW.workers := LEAST(NEW.workers, NEW.workers_capacity);

	NEW.energy := GREATEST(0, LEAST(NEW.energy, NEW.energy_capacity));

	NEW.mood = GREATEST(0, NEW.mood);

	NEW.orbit_ore := LEAST(2000000000, NEW.orbit_ore);

	NEW.orbit_hydrocarbon := LEAST(2000000000, NEW.orbit_hydrocarbon);

	IF OLD.ownerid IS DISTINCT FROM NEW.ownerid THEN

		NEW.production_frozen := false;

		NEW.blocus_strength := NULL;

	END IF;

	IF OLD.ownerid IS NULL AND NEW.ownerid IS NOT NULL THEN

		NEW.colonization_datetime := now();

	END IF;

	IF NEW.shipyard_next_continue IS NOT NULL AND NOT NEW.shipyard_suspended AND 

		(OLD.ore < NEW.ore OR OLD.hydrocarbon < NEW.hydrocarbon OR OLD.energy < NEW.energy OR OLD.workers < NEW.workers OR OLD.ore_production <> NEW.ore_production OR OLD.hydrocarbon_production <> NEW.hydrocarbon_production OR OLD.energy_production <> NEW.energy_production OR OLD.energy_consumption <> NEW.energy_consumption OR OLD.mod_production_workers <> NEW.mod_production_workers OR OLD.workers_busy <> NEW.workers_busy) THEN

		NEW.shipyard_next_continue := now()+INTERVAL '5 seconds';

	END IF;

	IF (OLD.credits_production <= 0 AND OLD.credits_random_production <=0) AND (NEW.credits_production > 0 OR NEW.credits_random_production > 0) THEN

		NEW.credits_next_update := NOW();

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_nav_planet_beforechanges() OWNER TO exileng;

--
-- Name: sp_planet(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet(integer, integer, integer) RETURNS integer
    LANGUAGE sql
    AS $_$-- Param1: galaxy

-- Param2: sector

-- Param3: planet

SELECT ($1-1)*25*99 + ($2-1)*25 + $3;$_$;


ALTER FUNCTION static.sp_planet(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_planet(integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_planet(integer, integer, integer) IS 'Returns the planetid of planet at position galaxy:sector:planet';


--
-- Name: sp_planet_buildings_afterchanges(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_buildings_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF (TG_OP = 'DELETE') THEN

		PERFORM sp_update_planet(OLD.planetid);

		PERFORM 1 FROM planet_buildings WHERE planetid=OLD.planetid LIMIT 1;

		IF NOT FOUND THEN

			UPDATE nav_planet SET ownerid=null WHERE id=OLD.planetid;

		END IF;

	ELSEIF (TG_OP = 'INSERT') THEN

		PERFORM sp_update_planet(NEW.planetid);

	ELSEIF (TG_OP = 'UPDATE') THEN

		IF (OLD.quantity <> NEW.quantity) OR ( OLD.destroy_datetime IS DISTINCT FROM NEW.destroy_datetime) OR (OLD.disabled <> NEW.disabled) THEN

			IF NEW.quantity = 0 THEN

				-- it will call this trigger again for our DELETE so there's no need to update the planet ourself

				DELETE FROM planet_buildings WHERE planetid=NEW.planetid AND buildingid=NEW.buildingid AND quantity=0;

			ELSE

				PERFORM sp_update_planet(OLD.planetid);

			END IF;

		END IF;

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_planet_buildings_afterchanges() OWNER TO exileng;

--
-- Name: sp_planet_buildings_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_buildings_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE planet_buildings SET quantity = quantity + NEW.quantity WHERE planetid=NEW.planetid AND buildingid=NEW.buildingid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_planet_buildings_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_buildings_pending_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_buildings_pending_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$BEGIN

	IF sp_can_build_on(NEW.planetid, NEW.buildingid, (SELECT ownerid FROM nav_planet WHERE id=NEW.planetid)) <> 0 THEN

		RAISE EXCEPTION 'max buildings reached or requirements not met';

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_planet_buildings_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_energy_transfer_after_changes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_energy_transfer_after_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF (TG_OP = 'DELETE') THEN

		PERFORM sp_update_planet(OLD.planetid);

		PERFORM sp_update_planet(OLD.target_planetid);

	ELSE

		--PERFORM sp_update_planet(NEW.planetid);

		PERFORM sp_update_planet(NEW.target_planetid);

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_planet_energy_transfer_after_changes() OWNER TO exileng;

--
-- Name: sp_planet_energy_transfer_before_changes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_energy_transfer_before_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet1 record;

	r_planet2 record;

	effectiveness float8;

	distance float8;

BEGIN

	-- compute effective energy transferred according to planet distance and planet owner transfer energy effectiveness

	IF (TG_OP <> 'DELETE') THEN

		SELECT INTO r_planet1 galaxy, sector, planet, ownerid FROM nav_planet WHERE id=NEW.planetid;

		IF NOT FOUND THEN

			NEW.effective_energy := 0;

			RETURN NEW;

		END IF;

		SELECT INTO r_planet2 galaxy, sector, planet FROM nav_planet WHERE id=NEW.target_planetid;

		IF NOT FOUND THEN

			NEW.effective_energy := 0;

			RETURN NEW;

		END IF;

		SELECT INTO effectiveness mod_energy_transfer_effectiveness FROM users WHERE id=r_planet1.ownerid;

		IF NOT FOUND THEN

			effectiveness := 0.0;

		END IF;

		IF r_planet1.galaxy <> r_planet2.galaxy THEN

			distance := 200;

		ELSE

			distance := sp_travel_distance(r_planet1.sector, r_planet1.planet, r_planet2.sector, r_planet2.sector);

		END IF;

		effectiveness := LEAST(1.0, GREATEST(0.0, effectiveness/2.0 * 100.0 / GREATEST(1, distance)));

		NEW.energy := LEAST(NEW.energy, 250000);

		NEW.effective_energy := int4(NEW.energy * effectiveness);

	END IF;

	IF (TG_OP = 'INSERT') THEN

		UPDATE nav_planet SET energy_receive_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND target_planetid=NEW.target_planetid)+1 WHERE id=NEW.target_planetid;

		UPDATE nav_planet SET energy_send_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND planetid=NEW.planetid)+1 WHERE id=NEW.planetid;

		NEW.activation_datetime := NOW();

	ELSEIF (TG_OP = 'UPDATE') THEN

		IF OLD.planetid <> NEW.planetid OR OLD.target_planetid <> NEW.target_planetid THEN

			RETURN OLD;

		END IF;

		IF NOT OLD.enabled AND NEW.enabled THEN

			--UPDATE nav_planet SET energy_receive_links=energy_receive_links+1 WHERE id=NEW.target_planetid;

			--UPDATE nav_planet SET energy_send_links=energy_send_links+1 WHERE id=NEW.planetid;

			UPDATE nav_planet SET energy_receive_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND target_planetid=NEW.target_planetid)+1 WHERE id=NEW.target_planetid;

			UPDATE nav_planet SET energy_send_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND planetid=NEW.planetid)+1 WHERE id=NEW.planetid;

			NEW.activation_datetime := NOW();

		END IF;

		IF OLD.enabled AND NOT NEW.enabled THEN

			--UPDATE nav_planet SET energy_receive_links=energy_receive_links-1 WHERE id=NEW.target_planetid;

			--UPDATE nav_planet SET energy_send_links=energy_send_links-1 WHERE id=NEW.planetid;

			UPDATE nav_planet SET energy_receive_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND target_planetid=NEW.target_planetid)-1 WHERE id=NEW.target_planetid;

			UPDATE nav_planet SET energy_send_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND planetid=NEW.planetid)-1 WHERE id=NEW.planetid;

		END IF;

	ELSEIF (TG_OP = 'DELETE') THEN

		IF OLD.enabled THEN

			--UPDATE nav_planet SET energy_receive_links=energy_receive_links-1 WHERE id=OLD.target_planetid;

			--UPDATE nav_planet SET energy_send_links=energy_send_links-1 WHERE id=OLD.planetid;

			UPDATE nav_planet SET energy_receive_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND target_planetid=OLD.target_planetid)-1 WHERE id=OLD.target_planetid;

			UPDATE nav_planet SET energy_send_links=(SELECT count(1) FROM planet_energy_transfer WHERE enabled AND planetid=OLD.planetid)-1 WHERE id=OLD.planetid;

		END IF;

		RETURN OLD;

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_planet_energy_transfer_before_changes() OWNER TO exileng;

--
-- Name: sp_planet_ships_afterchanges(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_ships_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF NEW.quantity <= 0 THEN

		DELETE FROM planet_ships WHERE planetid = OLD.planetid AND shipid = OLD.shipid;

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_planet_ships_afterchanges() OWNER TO exileng;

--
-- Name: sp_planet_ships_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_ships_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE planet_ships SET quantity = quantity + NEW.quantity WHERE planetid=NEW.planetid AND shipid=NEW.shipid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_planet_ships_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_ships_pending_afterdelete(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_ships_pending_afterdelete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- if a ship that was being built is removed then 

	-- continue building another ship from the pending list

	IF OLD.end_time IS NOT NULL THEN

		PERFORM sp_continue_ships_construction(OLD.planetid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_planet_ships_pending_afterdelete() OWNER TO exileng;

--
-- Name: FUNCTION sp_planet_ships_pending_afterdelete(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_planet_ships_pending_afterdelete() IS 'Check if the deleted ship was a ship under construction, in this case, put the next ship order into construction if any';


--
-- Name: sp_planet_ships_pending_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_ships_pending_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	c int4;

	r_ship record;

BEGIN

	IF NEW.recycle THEN

		RETURN NEW;

	END IF;

	-- prevent inserting a ship if the player doesn't have the requirements

	-- raise an exception in this case

	SELECT INTO r_ship

		new_shipid

	FROM db_ships

	WHERE id = NEW.shipid AND buildable;

	IF NOT FOUND THEN

		RAISE EXCEPTION 'this ship doestn''t exist or can''t be built';

	END IF;

	PERFORM 1

	FROM db_ships_req_building 

	WHERE shipid = COALESCE(r_ship.new_shipid, NEW.shipid) AND required_buildingid NOT IN (SELECT buildingid FROM planet_buildings WHERE planetid=NEW.planetid);

	IF FOUND THEN

		RAISE EXCEPTION 'buildings requirements not met';

	END IF;

	PERFORM 1

	FROM db_ships_req_research

	WHERE shipid = COALESCE(r_ship.new_shipid, NEW.shipid) AND required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=(SELECT ownerid FROM nav_planet WHERE id=NEW.planetid LIMIT 1) AND level >= required_researchlevel);

	IF FOUND THEN

		RAISE EXCEPTION 'research requirements not met';

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_planet_ships_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_training_pending_afterdelete(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planet_training_pending_afterdelete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- if a training that was being done is removed then 

	-- continue another training from the pending list

	IF OLD.end_time IS NOT NULL THEN

		PERFORM sp_continue_training(OLD.planetid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION static.sp_planet_training_pending_afterdelete() OWNER TO exileng;

--
-- Name: FUNCTION sp_planet_training_pending_afterdelete(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_planet_training_pending_afterdelete() IS 'Check if the deleted training was under way, in this case, do the next training if any';


--
-- Name: sp_planets(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_planets(integer, integer) RETURNS SETOF integer
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT id FROM nav_planet WHERE galaxy=$1 AND sector=$2;$_$;


ALTER FUNCTION static.sp_planets(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_planets(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_planets(integer, integer) IS 'Return the planetid in a galaxy/sector';


--
-- Name: sp_player_addnotification(integer, character varying, text); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_player_addnotification(_playerid integer, _type character varying, _data text) RETURNS void
    LANGUAGE sql
    AS $_$-- sp_player_addnotification

INSERT INTO sessions_notifications(userid, type, data)

VALUES($1, $2, $3);$_$;


ALTER FUNCTION static.sp_player_addnotification(_playerid integer, _type character varying, _data text) OWNER TO exileng;

--
-- Name: FUNCTION sp_player_addnotification(_playerid integer, _type character varying, _data text); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_player_addnotification(_playerid integer, _type character varying, _data text) IS 'Add a notification to a player session';


--
-- Name: sp_player_get_name(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_player_get_name(_playerid integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$SELECT login

FROM users

WHERE users.id=$1;$_$;


ALTER FUNCTION static.sp_player_get_name(_playerid integer) OWNER TO exileng;

--
-- Name: sp_player_get_tag(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_player_get_tag(_playerid integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$SELECT COALESCE(alliances.tag, '')

FROM users

LEFT JOIN alliances ON (alliances.id=users.alliance_id)

WHERE users.id=$1;$_$;


ALTER FUNCTION static.sp_player_get_tag(_playerid integer) OWNER TO exileng;

--
-- Name: sp_player_isconnected(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_player_isconnected(_playerid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- return whether a player is connected

BEGIN

	PERFORM 1 FROM sessions WHERE userid=$1 AND lastactivity > now() - INTERVAL '10 minutes';

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_player_isconnected(_playerid integer) OWNER TO exileng;

--
-- Name: sp_plunder_planet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_plunder_planet(_userid integer, _fleetid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_fleet record;

BEGIN

	-- retrieve fleet info and the planet

	SELECT INTO r_fleet

		id, planetid

	FROM fleets

	WHERE ownerid=$1 AND id=$2 AND dest_planetid IS NULL AND not engaged AND now()-idle_since > const_interval_before_plunder() FOR UPDATE;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_plunder_planet(_userid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_process_accounts_deletion(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_accounts_deletion() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_users record;

BEGIN

	-- delete accounts that are marked for deletion or the user didn't log in after 72 hours of registration

	FOR r_users IN 

		SELECT id

		FROM users

		WHERE (privilege > -50 AND privilege < 100 AND ((deletion_date <= now()) OR (orientation = 0 and regdate <= now()-INTERVAL '72 hours')) ) OR

			(privilege = -1 AND lastlogin <= now() - INTERVAL '1 month') OR

			(privilege = 0 AND lastlogin <= now() - INTERVAL '1 month')

		LIMIT 20

		FOR UPDATE

	LOOP

		PERFORM sp_delete_account(r_users.id);

	END LOOP;

	-- abandon planets of players that do not play anymore after 3 weeks

	-- and new players after 2 days of inactivity

	FOR r_users IN 

		SELECT id

		FROM users

		WHERE privilege=0 AND orientation <> 0 AND planets > 0 AND (

			lastlogin <= now()-INTERVAL '3 weeks' /*OR

			(lastlogin - regdate < interval '2 days' AND lastlogin < now() - interval '2 days')*/

			)

		LIMIT 20

		FOR UPDATE

	LOOP

		PERFORM sp_clear_planet(id)

		FROM nav_planet

		WHERE ownerid=r_users.id;

	END LOOP;

	-- abandon planets of banned players after 2 weeks

	FOR r_users IN

		SELECT id

		FROM users

		WHERE privilege = -1 AND lastlogin <= now()-INTERVAL '2 weeks' AND planets > 0

		LIMIT 10

		FOR UPDATE

	LOOP

		PERFORM sp_clear_planet(id)

		FROM nav_planet

		WHERE ownerid=r_users.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_accounts_deletion() OWNER TO exileng;

--
-- Name: sp_process_ai(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_ai(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$BEGIN

	IF $1 % 5 = 0 THEN

		PERFORM sp_ai_planets();

	END IF;

	IF $1 = 1 THEN

		PERFORM sp_ai_watched_planets();

	END IF;

END;$_$;


ALTER FUNCTION static.sp_process_ai(integer) OWNER TO exileng;

--
-- Name: sp_process_alliances(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_alliances() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_alliance record;

	r_user record;

	_score bigint;

	_credits integer;

BEGIN

	FOR r_alliance IN 

		SELECT id

		FROM alliances

		WHERE last_dividends < now() - INTERVAL '24 hours'

		LIMIT 1

		FOR UPDATE

	LOOP

		FOR r_user IN 

			SELECT id

			FROM users

			WHERE alliance_id=r_alliance.id

		LOOP

			-- compute alliance score

			SELECT INTO _score COALESCE(GREATEST(1, sum(score)), 1)

			FROM users

			WHERE alliance_id=r_alliance.id AND id <> r_user.id;

			-- compute credits earned by player

			SELECT INTO _credits (power(_score, 0.65) * LEAST(20, planets) / 20.0)::int

			FROM users

			WHERE id = r_user.id;

			IF _credits > 10 THEN

				-- give the credits

				UPDATE users SET

					credits = credits + _credits

				WHERE id=r_user.id;

				-- insert the report

				INSERT INTO reports(ownerid, type, subtype, credits, data)

				VALUES(r_user.id, 3, 11, _credits, '{credits:' || _credits || '}');

			END IF;

		END LOOP;

		UPDATE alliances SET last_dividends = now() WHERE id=r_alliance.id;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_process_alliances() OWNER TO exileng;

--
-- Name: sp_process_bounties(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_bounties(_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_bounty record;

BEGIN

	FOR r_bounty IN

		SELECT userid, bounty

		FROM users_bounty

		WHERE reward_time <= now()

		LIMIT _count

	LOOP

		IF r_bounty.bounty > 0 THEN

			UPDATE users SET

				credits=credits+r_bounty.bounty

			WHERE id=r_bounty.userid;

			INSERT INTO reports(ownerid, type, subtype, credits)

			VALUES(r_bounty.userid, 2, 20, r_bounty.bounty);

		END IF;

		DELETE FROM users_bounty

		WHERE userid=r_bounty.userid;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_bounties(_count integer) OWNER TO exileng;

--
-- Name: sp_process_buildings(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_buildings() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_pending record;

	r_building record;

BEGIN

	FOR r_pending IN

		SELECT p.id, p.planetid, p.buildingid, p."loop", nav_planet.ownerid

		FROM planet_buildings_pending p

			INNER JOIN nav_planet ON (nav_planet.id=p.planetid)

		WHERE p.end_time <= now()+INTERVAL '3 seconds'

		ORDER BY p.end_time LIMIT 25 FOR UPDATE

	LOOP

		SELECT INTO r_building cost_ore, cost_hydrocarbon, lifetime

		FROM db_buildings

		WHERE id=r_pending.buildingid;

		UPDATE users SET

			score_buildings=score_buildings + r_building.cost_ore + r_building.cost_hydrocarbon

		WHERE id=r_pending.ownerid;

		-- delete building from pending list

		DELETE FROM planet_buildings_pending WHERE id=r_pending.id;

		-- insert the building to the planet buildings

		INSERT INTO planet_buildings(planetid, buildingid) VALUES(r_pending.planetid, r_pending.buildingid);

		IF r_building.lifetime > 0 THEN

			UPDATE planet_buildings SET

				destroy_datetime = now() + r_building.lifetime*INTERVAL '1 second'

			WHERE planetid=r_pending.planetid AND buildingid=r_pending.buildingid;

		END IF;

		IF r_pending.ownerid IS NOT NULL THEN

			-- add a report 301 but with a datetime that is 7 days old to prevent it from appearing to the player

			INSERT INTO reports(datetime, read_date, ownerid, type, subtype, planetid, buildingid)

			VALUES(now(), now()-INTERVAL '1 month', r_pending.ownerid, 3, 1, r_pending.planetid, r_pending.buildingid);

		END IF;

		IF r_pending."loop" THEN

			PERFORM sp_start_building(r_pending.planetid, r_pending.buildingid, r_pending."loop");

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_buildings() OWNER TO exileng;

--
-- Name: sp_process_clean_alliances(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_clean_alliances() RETURNS void
    LANGUAGE sql
    AS $$DELETE FROM alliances_invitations WHERE (declined AND replied < now()-INTERVAL '1 days') OR (created < now()-INTERVAL '7 days');

DELETE FROM alliances_naps_offers WHERE (declined AND replied < now()-INTERVAL '1 days') OR (created < now()-INTERVAL '7 days');

-- delete alliances that have no more members

DELETE FROM alliances WHERE NOT EXISTS(SELECT 1 FROM users WHERE alliance_id=alliances.id LIMIT 1);$$;


ALTER FUNCTION static.sp_process_clean_alliances() OWNER TO exileng;

--
-- Name: sp_process_clean_routes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_clean_routes() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_route record;

BEGIN

	FOR r_route IN 

		SELECT id

		FROM routes

		WHERE ownerid is null AND last_used < now()-INTERVAL '1 day' AND NOT EXISTS( SELECT 1 FROM fleets INNER JOIN routes_waypoints ON (routes_waypoints.id=fleets.next_waypointid) WHERE routes_waypoints.routeid=routes.id )

		LIMIT 50

	LOOP

		DELETE FROM routes WHERE id=r_route.id;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_process_clean_routes() OWNER TO exileng;

--
-- Name: sp_process_clean_waiting_fleets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_clean_waiting_fleets() RETURNS void
    LANGUAGE sql
    AS $$UPDATE fleets SET

	action=1, 

	action_end_time = now() + '3 hours',

	dest_planetid = null,

	engaged=false

WHERE ownerid=3 AND ((action=0 AND planetid IS NOT NULL AND next_waypointid IS NULL) OR (action <> 0 AND engaged AND action_end_time < now()));$$;


ALTER FUNCTION static.sp_process_clean_waiting_fleets() OWNER TO exileng;

--
-- Name: sp_process_continue_shipyard(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_continue_shipyard(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT id

		FROM nav_planet

		WHERE shipyard_next_continue < now()+_precision AND NOT production_frozen

		ORDER BY shipyard_next_continue

		LIMIT _count

	LOOP

		PERFORM sp_continue_ships_construction(r_planet.id);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_continue_shipyard(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_credits_production(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_credits_production(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT id, ownerid, credits_updates, credits_total, int4(credits_production + credits_random_production * random()) AS credits

		FROM nav_planet

		WHERE ownerid IS NOT NULL AND credits_next_update < now()-_precision AND (credits_production > 0 OR credits_random_production > 0) AND not production_frozen

		ORDER BY credits_next_update

		LIMIT _count

	LOOP

		UPDATE users SET

			credits_produced = credits_produced + r_planet.credits_total + r_planet.credits

		WHERE id=r_planet.ownerid;

		UPDATE nav_planet SET

			credits_total=0,

			credits_updates=0,

			credits_next_update=credits_next_update+INTERVAL '1 hour'

		WHERE id=r_planet.id;

/*		IF r_planet.credits_updates >= 23 THEN

			UPDATE users SET

				credits = credits + r_planet.credits_total + r_planet.credits

			WHERE id=r_planet.ownerid;

			INSERT INTO reports(ownerid, type, subtype, credits, planetid)

			VALUES(r_planet.ownerid, 5, 10, r_planet.credits_total + r_planet.credits, r_planet.id);

			UPDATE nav_planet SET

				credits_total=0,

				credits_updates=0,

				credits_next_update=credits_next_update+INTERVAL '1 hour'

			WHERE id=r_planet.id;

		ELSE

			UPDATE nav_planet SET

				credits_total=credits_total+r_planet.credits, 

				credits_updates=credits_updates+1,

				credits_next_update=credits_next_update+INTERVAL '1 hour'

			WHERE id=r_planet.id;

		END IF;*/

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_process_credits_production(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_destroy_buildings(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_destroy_buildings(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_building record;

BEGIN

	FOR r_building IN

		SELECT planetid, buildingid, cost_ore, cost_hydrocarbon

		FROM planet_buildings

			INNER JOIN db_buildings ON (db_buildings.id = planet_buildings.buildingid)

		WHERE destroy_datetime IS NOT NULL AND destroy_datetime < now()+_precision

		ORDER BY destroy_datetime

		LIMIT _count

	LOOP

		UPDATE planet_buildings SET

			quantity=quantity-1, destroy_datetime=NULL

		WHERE planetid=r_building.planetid AND buildingid=r_building.buildingid AND destroy_datetime IS NOT NULL AND destroy_datetime <= now()+_precision;

		IF FOUND THEN

			-- abandon planets that have no buildings owned by a player (not is_planet_element or building is being destroyed=deployed radar for instance)

			PERFORM 1

			FROM planet_buildings

				INNER JOIN db_buildings ON (planet_buildings.buildingid=db_buildings.id)

			WHERE planetid=r_building.planetid AND (NOT is_planet_element OR destroy_datetime IS NOT NULL);

			IF NOT FOUND THEN

				UPDATE nav_planet SET

					ownerid=null,

					name=''

				WHERE id=r_building.planetid;

			ELSE

				UPDATE nav_planet SET

					ore = ore + r_building.cost_ore*0.3,

					hydrocarbon = hydrocarbon + r_building.cost_hydrocarbon*0.3

				WHERE id=r_building.planetid;

			END IF;

		END IF;

	END LOOP;

END;$$;


ALTER FUNCTION static.sp_process_destroy_buildings(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_fleets_movements(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_fleets_movements(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_fleet record;

BEGIN

	-- fleets movements

	FOR r_fleet IN 

		SELECT fleets.ownerid, fleets.id, fleets.name, fleets.dest_planetid, fleets.action, nav_planet.ownerid AS dest_planet_ownerid, nav_planet.production_frozen,

			nav_planet.galaxy, nav_planet.sector, nav_planet.planet, military_signature

		FROM fleets

			LEFT JOIN nav_planet ON nav_planet.id=fleets.dest_planetid

		WHERE (action=1 OR action=-1) AND NOT fleets.engaged AND fleets.action_end_time <= now() + _precision

		ORDER BY fleets.action_end_time LIMIT _count

	LOOP

		-- reports

		IF r_fleet.action <> -1 AND r_fleet.ownerid <> 3 AND r_fleet.dest_planetid IS NOT NULL THEN

			-- send a report to owner to notify that his fleets arrived at destination

			INSERT INTO reports(ownerid, type, fleetid, fleet_name, planetid, data) 

			VALUES(r_fleet.ownerid, 4, r_fleet.id, r_fleet.name, r_fleet.dest_planetid, '{fleet:{id:' || r_fleet.id || ',name:' || sp__quote(r_fleet.name) || '},planet:{id:' || r_fleet.dest_planetid || ',g:' || r_fleet.galaxy || ',s:' || r_fleet.sector || ',p:' || r_fleet.planet || ',owner:' || COALESCE(sp__quote(sp_get_user(r_fleet.dest_planet_ownerid)), 'null') || '}}');

			IF r_fleet.dest_planet_ownerid <> r_fleet.ownerid THEN

				-- send a report to planet owner to notify that a fleet arrived near his planet

				INSERT INTO reports(ownerid, type, subtype, userid, fleet_name, planetid, data)

				VALUES(r_fleet.dest_planet_ownerid, 4, 3, r_fleet.ownerid, r_fleet.name, r_fleet.dest_planetid, '{fleet:{owner:"' || sp_get_user(r_fleet.ownerid) || '"},planet:{id:' || r_fleet.dest_planetid || ',g:' || r_fleet.galaxy || ',s:' || r_fleet.sector || ',p:' || r_fleet.planet || ',owner:' || COALESCE(sp__quote(sp_get_user(r_fleet.dest_planet_ownerid)), 'null') || '}}');

			END IF;

		END IF;

		-- update fleet

		UPDATE fleets SET

			planetid = dest_planetid,

			dest_planetid = NULL,

			action_start_time = NULL,

			action_end_time = NULL,

			action = 0,

			idle_since=now()

		WHERE id=r_fleet.id;

/*

		IF r_fleet.ownerid <> r_fleet.dest_planet_ownerid AND r_fleet.production_frozen THEN

			-- make enemy/ally/friend fleets to go elsewhere if the planet is frozen/in holidays

			PERFORM sp_move_fleet(r_fleet.ownerid, r_fleet.id, sp_ai_find_nearest_planet(r_fleet.ownerid, r_fleet.dest_planetid));

			--INSERT INTO log_http_errors(details) VALUES('sp_move_fleet(' || r_fleet.ownerid || ', ' || r_fleet.id || ', ' || 'sp_ai_find_nearest_planet(' || r_fleet.ownerid || ', ' || r_fleet.dest_planet_ownerid || ')');

		END IF;

*/

		-- make battle starts 1 minute later if a military fleet of 10k arrives

		IF r_fleet.action = 1 AND r_fleet.military_signature > 5000 THEN

			UPDATE nav_planet SET

				next_battle=now() + LEAST(r_fleet.military_signature/10000.0, 5) * INTERVAL '1 minute'

			WHERE id=r_fleet.dest_planetid AND next_battle IS NOT NULL AND next_battle < now() + LEAST(r_fleet.military_signature/10000.0, 5) * INTERVAL '1 minute';

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_fleets_movements(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_process_fleets_movements(_precision interval, _count integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_process_fleets_movements(_precision interval, _count integer) IS 'Update fleets position when they are arrived';


--
-- Name: sp_process_fleets_recycling(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_fleets_recycling(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$/*

DECLARE

	r_fleet record;

	remaining_space int4;

	max_recycled int4;

	rec_ore int4;

	rec_hydrocarbon int4;

	rec_subtype int2;	-- subtype for report (1=recycling stopped because cargo is full, 2=because there's nothing anymore)

BEGIN

	FOR r_fleet IN 

		SELECT fleets.ownerid, fleets.id, fleets.name, fleets.planetid, fleets.recycler_output / 6 AS recycler_output, 

			cargo_capacity-cargo_ore-cargo_hydrocarbon-cargo_workers-cargo_scientists-cargo_soldiers AS cargo_free,

			orbit_ore, orbit_hydrocarbon, mod_recycling AS mod_recycling,

			spawn_ore, spawn_hydrocarbon

		FROM fleets

			INNER JOIN nav_planet ON (fleets.planetid = nav_planet.id)

		WHERE action=2 AND action_end_time <= now() + _precision

		ORDER BY action_end_time LIMIT _count

	LOOP

		max_recycled := LEAST(r_fleet.cargo_free, int4(r_fleet.recycler_output * r_fleet.mod_recycling));

		-- recyclers always recycle half ore half hydrocarbon

		rec_ore := LEAST(max_recycled / 2, r_fleet.orbit_ore);

		rec_hydrocarbon = LEAST(max_recycled / 2, r_fleet.orbit_hydrocarbon);

		-- if there's a lack of a resource then get more of the other resource

		remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

		IF remaining_space > 0 THEN

			IF r_fleet.orbit_ore > rec_ore THEN

				rec_ore := LEAST(rec_ore + remaining_space, r_fleet.orbit_ore);

				remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			END IF;

			IF r_fleet.orbit_hydrocarbon > rec_hydrocarbon THEN

				rec_hydrocarbon := LEAST(rec_hydrocarbon + remaining_space, r_fleet.orbit_hydrocarbon);

				remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			END IF;

			-- remaining_space contains the capacity of the recyclers that have found nothing to recycle

			-- so if it is > 0 then it means we have nothing to recycle anymore or the cargo is full

		END IF;

		IF (remaining_space > 0 AND r_fleet.spawn_ore = 0 AND r_fleet.spawn_hydrocarbon = 0) OR (r_fleet.cargo_free <= rec_ore + rec_hydrocarbon) THEN

			-- there's nothing to recycle anymore or cargo is full

			UPDATE fleets SET

				action_start_time = NULL,

				action_end_time = NULL,

				action=0,

				cargo_ore = cargo_ore + rec_ore,

				cargo_hydrocarbon = cargo_hydrocarbon + rec_hydrocarbon

			WHERE id=r_fleet.id;

			IF remaining_space = 0 THEN

				rec_subtype := 1;

			ELSE

				rec_subtype := 2;

			END IF;

			INSERT INTO reports(ownerid, type, subtype, fleetid, fleet_name, planetid, data)

			VALUES(r_fleet.ownerid, 4, rec_subtype, r_fleet.id, r_fleet.name, r_fleet.planetid, '{fleet:{id:' || r_fleet.id || '}}');

		ELSE

			-- continue recycling

			UPDATE fleets SET

				action_start_time = now(),

				action_end_time = now()+INTERVAL '10 minutes',

				cargo_ore = cargo_ore + rec_ore,

				cargo_hydrocarbon = cargo_hydrocarbon + rec_hydrocarbon

			WHERE id=r_fleet.id;

		END IF;

		-- remove resources from planet orbit

		UPDATE nav_planet SET

			orbit_ore = GREATEST(0, orbit_ore - rec_ore),

			orbit_hydrocarbon = GREATEST(0, orbit_hydrocarbon - rec_hydrocarbon)

		WHERE id=r_fleet.planetid;

	END LOOP;

	RETURN;

END;

*/

DECLARE

	r_fleet record;

	remaining_space int4;

	max_recycled int4;

	produced int4;

	rec_ore int4;

	rec_hydrocarbon int4;

	rec_subtype int2;	-- subtype for report (1=recycling stopped because cargo is full, 2=because there's nothing anymore)

BEGIN

	FOR r_fleet IN 

		SELECT fleets.ownerid, fleets.id, fleets.name, fleets.planetid, fleets.recycler_output / 6 AS recycler_output, 

			cargo_capacity-cargo_ore-cargo_hydrocarbon-cargo_workers-cargo_scientists-cargo_soldiers AS cargo_free,

			orbit_ore, orbit_hydrocarbon, mod_recycling,

			spawn_ore, spawn_hydrocarbon, recycler_percent

		FROM fleets

			INNER JOIN nav_planet ON (fleets.planetid = nav_planet.id)

		WHERE action=2 AND action_end_time <= now() + _precision

		ORDER BY action_end_time LIMIT _count

	LOOP

		max_recycled := LEAST(r_fleet.cargo_free, int4(r_fleet.recycler_output /* * r_fleet.mod_recycling*/));

		--------------------------------

		-- RECYCLE resources in orbit --

		--------------------------------

		-- recyclers always recycle half ore half hydrocarbon

		rec_ore := LEAST(max_recycled / 2, r_fleet.orbit_ore);

		rec_hydrocarbon = LEAST(max_recycled / 2, r_fleet.orbit_hydrocarbon);

		-- if there's a lack of a resource then get more of the other resource

		remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

		IF remaining_space > 0 THEN

			IF r_fleet.orbit_ore > rec_ore THEN

				rec_ore := LEAST(rec_ore + remaining_space, r_fleet.orbit_ore);

				remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			END IF;

			IF r_fleet.orbit_hydrocarbon > rec_hydrocarbon THEN

				rec_hydrocarbon := LEAST(rec_hydrocarbon + remaining_space, r_fleet.orbit_hydrocarbon);

				remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			END IF;

			-- remaining_space is the capacity of the recyclers that have not found anything to recycle

			-- so if it is > 0 then it means we have nothing to recycle anymore from this location

		END IF;

		-- remove resources from planet orbit

		IF rec_ore > 0 OR rec_hydrocarbon > 0 THEN

			UPDATE nav_planet SET

				orbit_ore = GREATEST(0, orbit_ore - int4(rec_ore /* r_fleet.mod_recycling*/)),

				orbit_hydrocarbon = GREATEST(0, orbit_hydrocarbon - int4(rec_hydrocarbon /* r_fleet.mod_recycling*/))

			WHERE id=r_fleet.planetid;

		END IF;

		-------------------------------------------

		-- RECYCLE resources from resource field --

		-------------------------------------------

		IF remaining_space > 0 AND (r_fleet.spawn_ore > 0 OR r_fleet.spawn_hydrocarbon > 0) THEN

			--RAISE NOTICE '%', remaining_space;

			produced := int4(r_fleet.spawn_ore * r_fleet.recycler_percent * 0.2);

			rec_ore := rec_ore + LEAST(remaining_space, produced);

			remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			--RAISE NOTICE '%', remaining_space;

			produced := int4(r_fleet.spawn_hydrocarbon * r_fleet.recycler_percent * 0.2);

			rec_hydrocarbon := rec_hydrocarbon + LEAST(remaining_space, produced);

			remaining_space := max_recycled - rec_ore - rec_hydrocarbon;

			--RAISE NOTICE '%', remaining_space;

		END IF;

		IF (remaining_space > 0 AND r_fleet.spawn_ore = 0 AND r_fleet.spawn_hydrocarbon = 0) OR (r_fleet.cargo_free <= rec_ore + rec_hydrocarbon) THEN

			-- there's nothing to recycle anymore or cargo is full

			UPDATE fleets SET

				action_start_time = NULL,

				action_end_time = NULL,

				idle_since = now(),

				action = 0,

				cargo_ore = cargo_ore + rec_ore,

				cargo_hydrocarbon = cargo_hydrocarbon + rec_hydrocarbon

			WHERE id=r_fleet.id;

			PERFORM sp_update_fleets_recycler_percent(r_fleet.planetid);

			IF remaining_space = 0 THEN

				rec_subtype := 1;

			ELSE

				rec_subtype := 2;

			END IF;

			INSERT INTO reports(ownerid, type, subtype, fleetid, fleet_name, planetid)

			VALUES(r_fleet.ownerid, 4, rec_subtype, r_fleet.id, r_fleet.name, r_fleet.planetid);

		ELSE

			-- continue recycling

			UPDATE fleets SET

				action_start_time = now(),

				action_end_time = now() + INTERVAL '10 minutes' / mod_recycling,

				cargo_ore = cargo_ore + rec_ore,

				cargo_hydrocarbon = cargo_hydrocarbon + rec_hydrocarbon

			WHERE id=r_fleet.id;

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_fleets_recycling(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_fleets_waiting(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_fleets_waiting() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_fleet record;

BEGIN

	-- fleets waiting

	FOR r_fleet IN 

		SELECT fleets.id

		FROM fleets

		WHERE action=4 AND fleets.action_end_time <= now()+INTERVAL '3 seconds'

		ORDER BY fleets.action_end_time LIMIT 10

	LOOP

		-- update fleet

		UPDATE fleets SET

			action_start_time = NULL,

			action_end_time = NULL,

			action = 0

		WHERE id=r_fleet.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_fleets_waiting() OWNER TO exileng;

--
-- Name: sp_process_holidays(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_holidays() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	--return;

	FOR r_user IN 

		SELECT userid, end_time-now() AS duration

		FROM users_holidays

		WHERE NOT activated AND start_time <= now() FOR UPDATE

	LOOP

		UPDATE users_holidays SET activated=true WHERE userid=r_user.userid;

		-- set user in holidays

		UPDATE users SET privilege=-2 WHERE id=r_user.userid AND privilege=0;

		IF FOUND THEN

			-- add 14 days to buildings

			UPDATE planet_buildings_pending SET end_time=end_time + r_user.duration WHERE end_time IS NOT NULL AND planetid IN (SELECT id FROM nav_planet WHERE ownerid=r_user.userid);

			-- add 14 days to ships

			UPDATE planet_ships_pending SET end_time=end_time + r_user.duration WHERE end_time IS NOT NULL AND planetid IN (SELECT id FROM nav_planet WHERE ownerid=r_user.userid);

			-- add 14 days to research

			UPDATE researches_pending SET end_time=end_time + r_user.duration WHERE userid=r_user.userid;

			-- update all ressources before freezing the production

			PERFORM sp_update_planet_production(id) FROM nav_planet WHERE ownerid=r_user.userid;

			-- suspend all planets productions

			UPDATE nav_planet SET

				ore_production=0, 

				hydrocarbon_production=0,

				credits_production=0,

				credits_random_production=0,

				production_prestige=0,

				mod_production_workers=0,

				radar_strength=0,

				radar_jamming=0,

				production_frozen=true

			WHERE planet_floor > 0 AND planet_space > 0 AND ownerid=r_user.userid AND NOT EXISTS(SELECT 1 FROM fleets WHERE (firepower > 0) AND sp_relation(ownerid, nav_planet.ownerid) < 0 AND ((planetid=nav_planet.id AND action <> -1 AND action <> 1) OR (dest_planetid=nav_planet.id AND action = 1 AND action_end_time < now()+INTERVAL '1 day')) );

			UPDATE planet_energy_transfer SET

				enabled = false

			WHERE planetid IN (SELECT id FROM nav_planet WHERE ownerid=r_user.userid);

			-- make enemy/ally/friend fleets to go elsewhere

			PERFORM nav_planet.id, sp_move_fleet(fleets.ownerid, fleets.id, sp_ai_find_nearest_planet(fleets.ownerid, nav_planet.id))

			FROM nav_planet

				INNER JOIN fleets ON (fleets.action <> -1 AND fleets.action <> 1 AND fleets.planetid=nav_planet.id AND fleets.ownerid <> nav_planet.ownerid)

			WHERE production_frozen AND nav_planet.ownerid=r_user.userid;

		END IF;

		-- cancel movements of all player fleets

		--PERFORM sp_cancel_move(ownerid, id, true) FROM fleets WHERE ownerid=r_user.userid;

	END LOOP;

	FOR r_user IN 

		SELECT userid

		FROM users_holidays

		WHERE activated AND end_time <= now() FOR UPDATE

	LOOP

		-- resume all planets productions

		UPDATE nav_planet SET production_lastupdate=now(), production_frozen=false WHERE ownerid=r_user.userid AND production_frozen;

		PERFORM sp_update_planet(id) FROM nav_planet WHERE ownerid=r_user.userid;

		-- remove user from holidays mode

		UPDATE users SET privilege=0, last_holidays = now(), lastlogin=now(), lastactivity=now() WHERE id=r_user.userid AND privilege=-2;

		DELETE FROM users_holidays WHERE userid=r_user.userid;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_holidays() OWNER TO exileng;

--
-- Name: sp_process_leave_alliance(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_leave_alliance(_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	FOR r_user IN

		SELECT id

		FROM users

		WHERE leave_alliance_datetime IS NOT NULL AND leave_alliance_datetime <= now()

		ORDER BY leave_alliance_datetime

		LIMIT _count

	LOOP

		UPDATE users SET

			alliance_id = NULL,

			leave_alliance_datetime = NULL

		WHERE id=r_user.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_leave_alliance(_count integer) OWNER TO exileng;

--
-- Name: sp_process_market(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_market(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_market record;

	r_prices resource_price;

	r_planet record;

	x float;

	b bool;

	forgot_ore int4;

	forgot_hydro int4;

	cr int4;

	price int4;

BEGIN

	FOR r_market IN

		SELECT m.planetid, m.ore, m.hydrocarbon, m.credits, ownerid, users.planets

		FROM market_sales AS m

			INNER JOIN nav_planet ON (m.planetid=nav_planet.id)

			LEFT JOIN users ON (nav_planet.ownerid=users.id)

		WHERE sale_time <= now() + _precision

		LIMIT _count

		FOR UPDATE OF m,nav_planet

	LOOP

		DELETE FROM market_sales WHERE planetid=r_market.planetid;

		CONTINUE WHEN r_market.ownerid IS NULL;

		b := r_market.planets > 3;

		x := random();

		IF b AND (x < 0.002) THEN

			-- catastrophie : merchants ships were destroyed caused by an engine malfunction

			INSERT INTO reports(ownerid, type, subtype, planetid, ore, hydrocarbon, credits)

			VALUES(r_market.ownerid, 7, 0, r_market.planetid, r_market.ore, r_market.hydrocarbon, r_market.credits);

		ELSEIF b AND (x < 0.004) THEN

			-- catastrophie : merchants ships were destroyed by pirates

			INSERT INTO reports(ownerid, type, subtype, planetid, ore, hydrocarbon, credits)

			VALUES(r_market.ownerid, 7, 1, r_market.planetid, r_market.ore, r_market.hydrocarbon, r_market.credits);

		ELSE

			cr := sp_apply_tax(r_market.ownerid, r_market.credits - (r_market.credits / 2));

			UPDATE users SET credits = credits + cr WHERE id=r_market.ownerid;

			IF x < 0.016 AND (r_market.ore + r_market.hydrocarbon > 10000) THEN

				-- catastrophie (for the merchant) : merchants ships forgot some resources

				forgot_ore := int4(r_market.ore * random()/10.0);

				forgot_hydro := int4(r_market.hydrocarbon * random()/10.0);

				IF forgot_ore < 500 THEN

					forgot_ore := 0;

				END IF;

				IF forgot_hydro < 500 THEN

					forgot_hydro := 0;

				END IF;

				IF forgot_ore > 0 AND forgot_hydro > 0 THEN

					INSERT INTO reports(ownerid, type, subtype, planetid, ore, hydrocarbon)

					VALUES(r_market.ownerid, 7, 2, r_market.planetid, forgot_ore, forgot_hydro);

					UPDATE nav_planet SET ore=ore+forgot_ore, hydrocarbon=hydrocarbon+forgot_hydro WHERE id=r_market.planetid AND ownerid=r_market.ownerid;

				END IF;

			END IF;

			INSERT INTO reports(ownerid, type, planetid, ore, hydrocarbon, credits)

			VALUES(r_market.ownerid, 5, r_market.planetid, r_market.ore, r_market.hydrocarbon, r_market.credits);

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_market(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_market_price(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_market_price() RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE nav_galaxies SET

		price_ore = LEAST(200, GREATEST(50, 200 - power(GREATEST(1, traded_ore), 0.95) / 10000000.0)),

		price_hydrocarbon = LEAST(200, GREATEST(50, 200 - power(GREATEST(1, traded_hydrocarbon), 0.95) / 10000000.0)),

		traded_ore = COALESCE(traded_ore - 200.0 * power(200.0 / LEAST(200, GREATEST(50, 200.0 - power(GREATEST(1, traded_ore), 0.95) / 10000000.0)), 2) * 

						(SELECT GREATEST(0.5, (count(*) / 1200.0)) * sum(200.0 / nav_planet.floor)

						FROM nav_planet

							INNER JOIN users ON (nav_planet.ownerid=users.id)

						WHERE nav_planet.galaxy=nav_galaxies.id AND nav_planet.ownerid > 100 AND nav_planet.score > 0 AND floor > 0 AND users.lastlogin - users.regdate > INTERVAL '2 days' AND users.lastlogin > now() - INTERVAL '2 weeks'), 0),

		traded_hydrocarbon = COALESCE(traded_hydrocarbon - 200.0 * power(200.0 / LEAST(200, GREATEST(50, 200.0 - power(GREATEST(1, traded_hydrocarbon), 0.95) / 10000000.0)), 2) * 

						(SELECT GREATEST(0.5, (count(*) / 1200.0)) * sum(200.0 / nav_planet.floor)

						FROM nav_planet

							INNER JOIN users ON (nav_planet.ownerid=users.id)

						WHERE nav_planet.galaxy=nav_galaxies.id AND nav_planet.ownerid > 100 AND nav_planet.score > 0 AND floor > 0 AND users.lastlogin - users.regdate > INTERVAL '2 days' AND users.lastlogin > now() - INTERVAL '2 weeks'), 0);

END;$$;


ALTER FUNCTION static.sp_process_market_price() OWNER TO exileng;

--
-- Name: sp_process_market_purchases(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_market_purchases() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_market record;

	r_prices resource_price;

	r_planet record;

	x float;

	b bool;

	forgot_ore int4;

	forgot_hydro int4;

	cr int4;

	price int4;

BEGIN

	FOR r_market IN

		SELECT m.planetid, m.ore, m.hydrocarbon, m.credits, ownerid, users.planets

		FROM market_purchases AS m

			INNER JOIN nav_planet ON (m.planetid=nav_planet.id)

			LEFT JOIN users ON (nav_planet.ownerid=users.id)

		WHERE delivery_time <= now() LIMIT 50 FOR UPDATE OF m,nav_planet

	LOOP

		DELETE FROM market_purchases WHERE planetid=r_market.planetid;

		CONTINUE WHEN r_market.ownerid IS NULL;

		UPDATE nav_planet SET

			ore=LEAST(ore_capacity, ore+r_market.ore),

			hydrocarbon=LEAST(hydrocarbon_capacity, hydrocarbon+r_market.hydrocarbon)

		WHERE id=r_market.planetid;

		INSERT INTO reports(ownerid, type, subtype, userid, planetid, ore, hydrocarbon, credits)

		VALUES(r_market.ownerid, 5, 1, 3, r_market.planetid, r_market.ore, r_market.hydrocarbon, r_market.credits);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_market_purchases() OWNER TO exileng;

--
-- Name: FUNCTION sp_process_market_purchases(); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_process_market_purchases() IS 'Process market purchases';


--
-- Name: sp_process_merchant_planets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_merchant_planets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_market record;

	r_prices resource_price;

	total_ore int4;

	total_hydrocarbon int4;

	cr int4;

	price int4;

	_ore int4;

	_hydro int4;

BEGIN

	-- process when a player unload resources directly on a merchant planet

	FOR r_market IN 

		SELECT r.id, r.planetid, r.userid, r.ore, r.hydrocarbon, r.scientists, r.soldiers, r.workers, nav_planet.galaxy, nav_planet.sector, users.login

		FROM reports r

			INNER JOIN nav_planet ON (nav_planet.id=r.planetid)

			INNER JOIN users ON (users.id=r.userid)

		WHERE r.ownerid=3 AND r.type=5 AND r.subtype=1 AND r.read_date IS NULL

		LIMIT 5 FOR UPDATE

	LOOP

		r_prices := sp_get_resource_price(r_market.userid, r_market.galaxy);

/*

		_ore := r_market.ore;

		_hydro := r_market.hydrocarbon;

		WHILE ore > 0 OR hydro > 0 LOOP

			ore := GREATEST(0, ore - 10000000);

			hydro := GREATEST(0, hydro - 10000000);

		END LOOP;*/

		-- compute sale price

		total_ore := int4(r_market.ore/1000.0 * r_prices.sell_ore);

		total_hydrocarbon := int4(r_market.hydrocarbon/1000.0 * r_prices.sell_hydrocarbon);

		price := GREATEST(0, int4(total_ore + total_hydrocarbon + r_market.scientists * 25 + r_market.soldiers * 14 + r_market.workers * 0.01) - 20);

		cr := sp_apply_tax(r_market.userid, price);

		UPDATE users SET credits=credits+cr WHERE id=r_market.userid;

		INSERT INTO reports(ownerid, type, subtype, credits, ore, hydrocarbon, scientists, soldiers, workers)

		VALUES(r_market.userid, 5, 3, price, r_market.ore, r_market.hydrocarbon, r_market.scientists, r_market.soldiers, r_market.workers);

		INSERT INTO market_history(ore_sold,hydrocarbon_sold,scientists_sold,soldiers_sold,workers_sold,credits,username)

		VALUES(r_market.ore, r_market.hydrocarbon, r_market.scientists, r_market.soldiers, r_market.workers, price, r_market.login);

		-- update galaxy traded wares quantity

		UPDATE nav_galaxies SET

			traded_ore = traded_ore + r_market.ore,

			traded_hydrocarbon = traded_hydrocarbon + r_market.hydrocarbon

		WHERE id=r_market.galaxy;

		-- reset planet resources to default values

		UPDATE nav_planet SET ore=0, hydrocarbon=0, scientists=0, soldiers=0, workers=100000 WHERE id=r_market.planetid;

		-- set the reports as read

		UPDATE reports SET read_date=now() WHERE id=r_market.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_merchant_planets() OWNER TO exileng;

--
-- Name: sp_process_naps(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_naps(_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_nap record;

BEGIN

	FOR r_nap IN 

		SELECT allianceid1, allianceid2

		FROM alliances_naps

		WHERE break_on IS NOT NULL AND break_on <= now()

		ORDER BY break_on

		LIMIT _count

	LOOP

		DELETE FROM alliances_naps

		WHERE allianceid1 = r_nap.allianceid1 AND allianceid2=r_nap.allianceid2;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_naps(_count integer) OWNER TO exileng;

--
-- Name: sp_process_researches(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_researches() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_pending record;

	r_planet nav_planet;

	research_value int8;

BEGIN

	FOR r_pending IN

		SELECT userid, researchid, expires

		FROM researches

		WHERE expires IS NOT NULL AND expires <= now()+INTERVAL '3 seconds'

		ORDER BY expires

		LIMIT 5 FOR UPDATE

	LOOP

		DELETE FROM researches WHERE userid=r_pending.userid AND researchid=r_pending.researchid;

		PERFORM sp_update_researches(r_pending.userid);

		-- update all energy transfers from the player's planets

		UPDATE planet_energy_transfer SET

			energy = energy

		WHERE planetid IN (SELECT id FROM nav_planet WHERE ownerid=r_pending.userid);

		-- update all planets

		PERFORM sp_update_planet(id)

		FROM nav_planet

		WHERE ownerid=r_pending.userid;

		-- update all fleets

		PERFORM sp_update_fleet_bonus(id)

		FROM fleets

		WHERE ownerid=r_pending.userid;

	END LOOP;

	FOR r_pending IN

		SELECT researches_pending.id, userid, researchid, looping, expiration

		FROM researches_pending

			INNER JOIN db_research ON (db_research.id=researches_pending.researchid)

		WHERE end_time <= now()+INTERVAL '3 seconds'

		ORDER BY end_time LIMIT 10 FOR UPDATE

	LOOP

		-- delete pending research

		DELETE FROM researches_pending WHERE id=r_pending.id;

		-- add the terminated research

		INSERT INTO researches(userid, researchid, level) VALUES(r_pending.userid, r_pending.researchid, 1);

		IF r_pending.expiration IS NOT NULL THEN

			UPDATE researches SET

				level = 1,

				expires = now() + r_pending.expiration

			WHERE userid=r_pending.userid AND researchid=r_pending.researchid;

		END IF;

		-- retrieve the score of the terminated research

		SELECT INTO research_value

			int8(COALESCE(

				sum( cost_credits * rank * power(2.35, 5-levels + level) )

			, 0)) AS score

		FROM researches

			INNER JOIN db_research ON (researches.researchid = db_research.id)

		WHERE userid = r_pending.userid;

		-- update score

		UPDATE users SET

			score_research=research_value

		WHERE id=r_pending.userid;

		INSERT INTO reports(ownerid, type, researchid, data)

		VALUES(r_pending.userid, 3, r_pending.researchid, '{researchid:' || r_pending.researchid || '}');

		PERFORM sp_update_researches(r_pending.userid);

		-- update all energy transfers from the player's planets

		UPDATE planet_energy_transfer SET

			energy = energy

		WHERE planetid IN (SELECT id FROM nav_planet WHERE ownerid=r_pending.userid);

		-- update all planets

		PERFORM sp_update_planet(id)

		FROM nav_planet

		WHERE ownerid=r_pending.userid;

		-- update all fleets

		PERFORM sp_update_fleet_bonus(id)

		FROM fleets

		WHERE ownerid=r_pending.userid;

		IF r_pending.looping THEN

			PERFORM sp_start_research(r_pending.userid, r_pending.researchid, r_pending.looping);

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_researches() OWNER TO exileng;

--
-- Name: sp_process_rogue_planets(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_rogue_planets() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

	r_ship record;

	r_fleet record;

	fleetid int4;

	cr int4;

	soldiers int4;

	enemysig int4;

	planetsignature int4;

BEGIN

	FOR r_planet IN

		SELECT id, ownerid, workers, workers_capacity, soldiers, soldiers_capacity, energy_production-energy_consumption AS energy, 

			floor-floor_occupied AS floor, space-space_occupied AS space,

			ore_capacity, hydrocarbon_capacity, ore, hydrocarbon,

			workers_for_maintenance, is_production, pct_ore, pct_hydrocarbon

		FROM ai_rogue_planets

			INNER JOIN vw_planets ON (planetid=id)

		WHERE nextupdate <= now() ORDER BY nextupdate LIMIT 2

	LOOP

		UPDATE ai_planets SET nextupdate = now()+interval '1 hour' WHERE planetid=r_planet.id;

		IF r_planet.workers > 1000 AND r_planet.workers > r_planet.workers_for_maintenance THEN

			IF r_planet.is_production THEN

				soldiers := 3000;

			ELSE

				soldiers := 10000;

			END IF;

			IF r_planet.soldiers < LEAST(soldiers, r_planet.soldiers_capacity) THEN

				PERFORM sp_start_training(r_planet.ownerid, r_planet.id, 0, LEAST(soldiers, r_planet.soldiers_capacity)-r_planet.soldiers);

			END IF;

		END IF;

		IF r_planet.floor > 10 THEN

			-- rectenna

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=207;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 207, false);

			END IF;

			-- prebuilt plant

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=102;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 102, false);

			END IF;

			-- automates plant

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=202;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 202, false);

			END IF;

			IF pct_ore > pct_hydrocarbon THEN

				-- ore mine

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=115 AND quantity > 20;

				IF NOT FOUND THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 115, false);

				END IF;

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 116);

			ELSE

				-- hydrocarbon mine

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=116 AND quantity > 20;

				IF NOT FOUND THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 116, false);

				END IF;

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 115);

			END IF;

			-- city

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=201;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 201, false);

			END IF;

			-- workshop

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=204 AND quantity >= 10;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 204, false);

			END IF;

			-- soldiers camp

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=208 AND quantity >= 2;

			IF NOT FOUND THEN

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 208, false);

			END IF;

			IF NOT r_planet.is_production THEN

				-- spatioport

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=105;

				IF NOT FOUND THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 105, false);

				END IF;

			END IF;

		ELSEIF r_planet.floor < 5 THEN

			-- find which building is in greater quantity : ore (115) or hydrocarbon (116)

			SELECT INTO cr quantity FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=115;

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=116 AND quantity > cr;

			-- destroy either ore or hydrocarbon mine

			IF FOUND THEN

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 116);

			ELSE

				PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 115);

			END IF;

		END IF;

		IF r_planet.energy > 400 THEN

			-- ore_storage_2

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=220 AND quantity >= 1;

			IF NOT FOUND THEN

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=120 AND quantity >= 1;

				IF NOT FOUND THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 120, false);

				END IF;

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 220, false);

			ELSE

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=120;

				IF FOUND THEN

					PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 120);

				END IF;

			END IF;

			-- hydrocarbon_storage_2

			PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=221 AND quantity >= 1;

			IF NOT FOUND THEN

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=121 AND quantity >= 1;

				IF NOT FOUND THEN

					PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 121, false);

				END IF;

				PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 221, false);

			ELSE

				PERFORM 1 FROM planet_buildings WHERE planetid=r_planet.id AND buildingid=121;

				IF FOUND THEN

					PERFORM sp_destroy_building(r_planet.ownerid, r_planet.id, 121);

				END IF;

			END IF;

		ELSE

			PERFORM sp_start_building(r_planet.ownerid, r_planet.id, 218, false);

		END IF;

		-- create ships

		IF NOT r_planet.is_production THEN

			-- build ships

			PERFORM 1 FROM planet_ships_pending WHERE planetid=r_planet.id LIMIT 1;

			IF NOT FOUND THEN

				FOR r_ship IN

					SELECT id

					FROM vw_ships

					WHERE planetid=r_planet.id

					ORDER BY (weapon_dmg_em+weapon_dmg_explosive+weapon_dmg_kinetic+weapon_dmg_thermal)*weapon_turrets DESC

				LOOP

					EXIT WHEN sp_start_ship(r_planet.id, r_ship.id, 10) = 0;

				END LOOP;

			END IF;

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_rogue_planets() OWNER TO exileng;

--
-- Name: sp_process_score(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_score(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

DECLARE

	r_player record;

	r_unusedships record;

	r_fleets record;

	r_planets record;

BEGIN

	FOR r_player IN

		SELECT id

		FROM users

		WHERE (privilege=-2 OR privilege>=0) AND score_next_update < now()+_precision

		LIMIT _count

		FOR UPDATE

	LOOP

		-- compute score of unused ships

		SELECT INTO r_unusedships

			int8(COALESCE(

				sum(int8(quantity)*cost_ore)*const_value_ore() + sum(int8(quantity)*cost_hydrocarbon)*const_value_hydrocarbon() + sum(int8(quantity)*cost_credits) + sum(crew*quantity)*const_value_crew()

			, 0)) AS score

		FROM planet_ships

			INNER JOIN nav_planet ON nav_planet.id = planet_ships.planetid

			INNER JOIN db_ships ON db_ships.id = planet_ships.shipid

		WHERE ownerid=r_player.id AND db_ships.upkeep > 0;

		-- compute score of ships in fleets

		SELECT INTO r_fleets

			int8(COALESCE(sum(score) + sum(cargo_scientists)*const_value_scientists() + sum(cargo_soldiers)*const_value_soldiers(), 0)) AS score

		FROM fleets

		WHERE ownerid=r_player.id;

		-- compute score of planets resources

		-- each planet is worth 1000 points

		SELECT INTO r_planets

			int8(COALESCE(

				sum(score) + count(1)*1000 + sum(ore_production)*10*const_value_ore() + sum(hydrocarbon_production)*10*const_value_hydrocarbon() + sum(scientists)*const_value_scientists() + sum(soldiers)*const_value_soldiers() + sum(credits_production)*10 + sum(credits_random_production)/2.0*10

			, 0)) AS score

		FROM nav_planet

		WHERE ownerid=r_player.id;

		-- save score

		UPDATE users SET

			previous_score = score,

			score = int4((r_unusedships.score + r_fleets.score + r_planets.score + score_research)/1000 + log(1.05, GREATEST(1, credits))),

			score_next_update = DEFAULT

		WHERE id=r_player.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_score(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_sessions_timeout(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_sessions_timeout() RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_session record;

BEGIN

	FOR r_session IN

		SELECT userid

		FROM sessions

		WHERE lastactivity < now() - INTERVAL '10 minutes'

		FOR UPDATE

	LOOP

		PERFORM sp_session_stop(r_session.userid);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_sessions_timeout() OWNER TO exileng;

--
-- Name: sp_process_ships(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_ships(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_pending record;

	r_user record;

BEGIN

	FOR r_pending IN

		SELECT planet_ships_pending.id, planetid, shipid, ownerid, 

			COALESCE(db_ships.new_shipid, shipid) as newshipid, 

			(db_ships.cost_ore + db_ships.cost_hydrocarbon) AS ship_value,

			recycle,

			db_ships.cost_ore,

			db_ships.cost_hydrocarbon

		FROM planet_ships_pending

			INNER JOIN nav_planet ON (nav_planet.id=planet_ships_pending.planetid)

			INNER JOIN db_ships ON (db_ships.id=planet_ships_pending.shipid)

		WHERE end_time <= now() + _precision

		ORDER BY end_time

		LIMIT _count

		FOR UPDATE OF planet_ships_pending

	LOOP

		IF r_pending.recycle THEN

			UPDATE nav_planet SET

				ore = ore + r_pending.cost_ore * const_recycle_ore(nav_planet.ownerid),

				hydrocarbon = hydrocarbon + r_pending.cost_hydrocarbon * const_recycle_hydrocarbon(nav_planet.ownerid)

			WHERE id=r_pending.planetid;

			DELETE FROM planet_ships_pending WHERE id=r_pending.id;

		ELSE

			UPDATE users SET

				score_ships=score_ships + r_pending.ship_value

			WHERE id=r_pending.ownerid

			RETURNING INTO r_user id, lcid, tutorial_first_ship_built, tutorial_first_colonisation_ship_built;

			-- add built ship to planet ships list

			INSERT INTO planet_ships(planetid, shipid) VALUES(r_pending.planetid, r_pending.newshipid);

			DELETE FROM planet_ships_pending WHERE id=r_pending.id;

			-- tutorial first ship

			IF NOT r_user.tutorial_first_ship_built THEN

				PERFORM sp_send_sys_message(r_user.id, 6, r_user.lcid);

				UPDATE users SET tutorial_first_ship_built=true WHERE id=r_user.id;

			END IF;

			-- tutorial first colonisation ship

			IF NOT r_user.tutorial_first_colonisation_ship_built AND r_pending.newshipid = 150 THEN

				PERFORM sp_send_sys_message(r_user.id, 7, r_user.lcid);

				UPDATE users SET tutorial_first_colonisation_ship_built=true WHERE id=r_user.id;

			END IF;

		END IF;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_ships(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_training(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_training(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_pending record;

BEGIN

	FOR r_pending IN

		SELECT t.id, t.planetid, t.scientists, t.soldiers, ownerid

		FROM planet_training_pending t

			INNER JOIN nav_planet ON (nav_planet.id=t.planetid)

		WHERE end_time <= now()+_precision

		ORDER BY end_time LIMIT _count FOR UPDATE

	LOOP

		BEGIN

			UPDATE nav_planet SET

				scientists = scientists + r_pending.scientists,

				soldiers = soldiers + r_pending.soldiers

			WHERE id=r_pending.planetid;

		EXCEPTION

			WHEN CHECK_VIOLATION THEN

				IF r_pending.scientists > 0 THEN

					PERFORM sp_cancel_training(planetid,id) FROM planet_training_pending WHERE planetid=r_pending.planetid AND scientists > 0 AND end_time IS NULL;

				ELSE

					PERFORM sp_cancel_training(planetid,id) FROM planet_training_pending WHERE planetid=r_pending.planetid AND soldiers > 0 AND end_time IS NULL;

				END IF;

				PERFORM sp_cancel_training(r_pending.planetid,r_pending.id);

		END;

		DELETE FROM planet_training_pending WHERE id=r_pending.id;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_training(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_tributes(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_tributes(_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_tribute record;

BEGIN

	FOR r_tribute IN 

		SELECT t.allianceid, t.target_allianceid, t.credits, 

			'[' || alliances.tag || '] ' || alliances.name AS a_name,

			'[' || target.tag || '] ' || target.name AS target_name

		FROM alliances_tributes t

			INNER JOIN alliances ON (alliances.id=t.allianceid)

			INNER JOIN alliances AS target ON (target.id=t.target_allianceid)

		WHERE next_transfer <= now()

		ORDER BY next_transfer

		LIMIT _count

	LOOP

		UPDATE alliances SET

			credits = credits - r_tribute.credits

		WHERE id=r_tribute.allianceid AND credits >= r_tribute.credits;

		IF FOUND THEN

			INSERT INTO alliances_wallet_journal(allianceid, credits, destination, type)

			VALUES(r_tribute.allianceid, -r_tribute.credits, r_tribute.target_name, 20);

			UPDATE alliances SET

				credits = credits + r_tribute.credits

			WHERE id=r_tribute.target_allianceid;

			INSERT INTO alliances_wallet_journal(allianceid, credits, source, type)

			VALUES(r_tribute.target_allianceid, r_tribute.credits, r_tribute.a_name, 20);

		ELSE

			UPDATE alliances_tributes SET

				next_transfer = date_trunc('day'::text, now()) + '1 day'::interval

			WHERE allianceid=r_tribute.allianceid AND target_allianceid=r_tribute.target_allianceid;			

			-- warn the alliance leader that the tribute could not be paid

			INSERT INTO reports(ownerid, type, subtype, allianceid, credits) 

			SELECT id, 1, 50, r_tribute.target_allianceid, r_tribute.credits

			FROM users

				INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

			WHERE alliance_id=r_tribute.allianceid AND (r.leader OR r.can_create_nap);

			-- warn the target alliance leaders that the tribute was not paid

			INSERT INTO reports(ownerid, type, subtype, allianceid, credits)

			SELECT id, 1, 51, r_tribute.allianceid, r_tribute.credits

			FROM users

				INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

			WHERE alliance_id=r_tribute.target_allianceid AND (r.leader OR r.can_create_nap);

		END IF;

		UPDATE alliances_tributes SET

			next_transfer = date_trunc('day'::text, now()) + '1 day'::interval

		WHERE allianceid=r_tribute.allianceid AND target_allianceid=r_tribute.target_allianceid;

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_tributes(_count integer) OWNER TO exileng;

--
-- Name: sp_process_update_planets(interval, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_update_planets(_precision interval, _count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	FOR r_planet IN

		SELECT id, ownerid

		FROM nav_planet

		WHERE next_planet_update <= now() + _precision AND NOT production_frozen

		ORDER BY next_planet_update

		LIMIT _count

	LOOP

		--PERFORM sp_update_planet_production(r_planet.id);

		PERFORM sp_update_planet(r_planet.id);

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_update_planets(_precision interval, _count integer) OWNER TO exileng;

--
-- Name: sp_process_wars(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_process_wars(_count integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_war record;

BEGIN

	FOR r_war IN 

		SELECT allianceid1, allianceid2

		FROM alliances_wars

		WHERE cease_fire_requested IS NOT NULL AND cease_fire_expire <= now()

		ORDER BY cease_fire_expire

		LIMIT _count

	LOOP

		UPDATE alliances_wars SET

			cease_fire_requested = NULL,

			cease_fire_expire = NULL

		WHERE allianceid1 = r_war.allianceid1 AND allianceid2=r_war.allianceid2;

	END LOOP;

	FOR r_war IN 

		SELECT allianceid1, allianceid2

		FROM alliances_wars

		WHERE next_bill IS NOT NULL AND next_bill < now()

		ORDER BY next_bill

		LIMIT _count

	LOOP

		DELETE FROM alliances_wars WHERE allianceid1=r_war.allianceid1 AND allianceid2=r_war.allianceid2;

		INSERT INTO reports(ownerid, type, subtype, allianceid)

		SELECT id, 1, 62, r_war.allianceid1

		FROM users

			INNER JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

		WHERE alliance_id=r_war.allianceid2 AND (r.leader OR r.can_create_nap);	

	END LOOP;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_process_wars(_count integer) OWNER TO exileng;

--
-- Name: sp_relation(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_relation(integer, integer) RETURNS smallint
    LANGUAGE plpgsql STABLE
    AS $_$-- 2 = player

-- 1 = ally

-- 0 = nap

-- -1 = undefined

-- -2 = war

DECLARE

	r_user1 record;

	r_user2 record;

BEGIN

	-- if one player is null then return -3 : neutral

	IF ($1 IS NULL) OR ($2 IS NULL) THEN

		RETURN -3;

	END IF;

	-- return 2 for same player

	IF $1 = $2 THEN

		RETURN 2;

	END IF;

	-- Make merchants napped with everybody, their ID is 3

	IF $1 = 3 OR $2 = 3 THEN

		RETURN 0;

	END IF;

	-- retrieve alliances of the 2 players

	SELECT INTO r_user1 alliance_id, security_level FROM users WHERE id=$1;

	SELECT INTO r_user2 alliance_id, security_level FROM users WHERE id=$2;

	IF r_user1.security_level <> r_user2.security_level THEN

		RETURN 0;

	END IF;

	-- return 1 for same alliance, 0 for NAPs

	IF r_user1.alliance_id = r_user2.alliance_id THEN

		RETURN 1;

	ELSE

		PERFORM 1 FROM alliances_wars WHERE ((allianceid1 = r_user1.alliance_id AND allianceid2 = r_user2.alliance_id) OR (allianceid1 = r_user2.alliance_id AND allianceid2 = r_user1.alliance_id)) AND can_fight < now();

		IF FOUND THEN

			RETURN -2;

		END IF;

		PERFORM allianceid1 FROM alliances_naps WHERE allianceid1 = r_user1.alliance_id AND allianceid2 = r_user2.alliance_id;

		IF FOUND THEN

			RETURN 0;

		END IF;

	END IF;

	RETURN -1;

END;$_$;


ALTER FUNCTION static.sp_relation(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_relation(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_relation(integer, integer) IS 'Return relation between 2 players :

-3 = one of the player is null

-2 = in war

-1 = hostile

0 = friend/non aggression pact (nap)

1 = alliance

2 = same players';


--
-- Name: sp_reports_after_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_reports_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	cnt int4;

	aid int4;

BEGIN

	SELECT count(*) INTO cnt FROM reports WHERE ownerid = NEW.ownerid AND type=NEW.type;

	-- keep always 50 reports and reports not older than 2 days old to avoid report flooding

	cnt := cnt - 50;

	IF cnt > 0 THEN

		DELETE FROM reports WHERE id IN (SELECT id FROM reports WHERE ownerid=NEW.ownerid AND type=NEW.type AND datetime < now() - INTERVAL '2 days' ORDER BY datetime LIMIT cnt);

	END IF;

/*

	PERFORM 1 FROM users_reports WHERE userid=NEW.ownerid AND type=NEW.type AND subtype=NEW.subtype;

	IF FOUND THEN

		INSERT INTO reports_queue(ownerid, "type", subtype, datetime, battleid, fleetid, fleet_name, planetid, researchid, ore, hydrocarbon, scientists, soldiers, workers, credits, allianceid, userid, invasionid, spyid, commanderid, buildingid, description, planet_name, planet_relation, planet_ownername, data)

		VALUES(NEW.ownerid, NEW.type, NEW.subtype, NEW.datetime, NEW.battleid, NEW.fleetid, NEW.fleet_name, NEW.planetid, NEW.researchid, NEW.ore, NEW.hydrocarbon, NEW.scientists, NEW.soldiers, NEW.workers, NEW.credits, NEW.allianceid, NEW.userid, NEW.invasionid, NEW.spyid, NEW.commanderid, NEW.buildingid, NEW.description, NEW.planet_name, NEW.planet_relation, NEW.planet_ownername, NEW.data);

	END IF;*/

	IF NEW.type = 2 OR NEW.type = 8 THEN

		SELECT INTO aid alliance_id FROM users WHERE id=NEW.ownerid;

		IF aid IS NOT NULL THEN

			IF NEW.type = 2 AND NEW.battleid IS NOT NULL THEN

				PERFORM 1 FROM alliances_reports WHERE ownerallianceid=aid AND "type"=2 AND battleid=NEW.battleid;

				IF FOUND THEN

					RETURN NEW;

				END IF;

			END IF;

			INSERT INTO alliances_reports(ownerallianceid, ownerid, "type", subtype, datetime, battleid, fleetid, fleet_name, planetid, researchid, ore, hydrocarbon, scientists, soldiers, workers, credits, allianceid, userid, invasionid, spyid, commanderid, buildingid, description, planet_name, planet_relation, planet_ownername, data)

			VALUES(aid, NEW.ownerid, NEW.type, NEW.subtype, NEW.datetime, NEW.battleid, NEW.fleetid, NEW.fleet_name, NEW.planetid, NEW.researchid, NEW.ore, NEW.hydrocarbon, NEW.scientists, NEW.soldiers, NEW.workers, NEW.credits, NEW.allianceid, NEW.userid, NEW.invasionid, NEW.spyid, NEW.commanderid, NEW.buildingid, NEW.description, NEW.planet_name, NEW.planet_relation, NEW.planet_ownername, NEW.data);

		END IF;

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_reports_after_insert() OWNER TO exileng;

--
-- Name: sp_reports_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_reports_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r_planet record;

BEGIN

	IF NEW.planetid IS NOT NULL THEN

		SELECT INTO r_planet ownerid, name FROM nav_planet WHERE id=NEW.planetid;

		IF FOUND THEN

			NEW.planet_relation := sp_relation(r_planet.ownerid, NEW.ownerid);

			NEW.planet_ownername := sp_get_user(r_planet.ownerid);

			IF NEW.planet_relation = 2 THEN

				NEW.planet_name := r_planet.name;

			ELSE

				NEW.planet_name := NEW.planet_ownername;

			END IF;

		END IF;

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_reports_before_insert() OWNER TO exileng;

--
-- Name: sp_researches_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_researches_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE researches SET level = level + 1 WHERE userid=NEW.userid AND researchid=NEW.researchid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_researches_beforeinsert() OWNER TO exileng;

--
-- Name: sp_researches_pending_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_researches_pending_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- check that requirements are met before being able to add a research to the pending researches

BEGIN

	PERFORM id

	FROM db_research

	WHERE id=NEW.researchid AND

		NOT EXISTS

		(SELECT required_buildingid

		FROM db_research_req_building 

		WHERE (researchid = NEW.researchid) AND (required_buildingid NOT IN 

			(SELECT planet_buildings.buildingid

			FROM nav_planet LEFT JOIN planet_buildings ON (nav_planet.id = planet_buildings.planetid)

			WHERE nav_planet.ownerid=NEW.userid

			GROUP BY planet_buildings.buildingid

			HAVING sum(planet_buildings.quantity) >= required_buildingcount)))

	AND

		NOT EXISTS

		(SELECT required_researchid, required_researchlevel

		FROM db_research_req_research

		WHERE (researchid = NEW.researchid) AND (required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=NEW.userid AND level >= required_researchlevel)));

	IF NOT FOUND THEN

		RAISE EXCEPTION 'Requirements not met.';

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_researches_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_reset_account(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_reset_account(integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- triggered when a new user is added to the users table

-- create a new planet with the user login suffixed by a " I"

-- create a building on the new planet of type 1 (colony)

-- create a commander with the user login

DECLARE

	r_user record;

	planet_name text;

	new_planet_id integer;

	lastplanet int4;

	--lastcolonizedplanet int8;

BEGIN

	-- check that the user has no planets

	SELECT INTO r_user id, login, planets, resets, score_research, lcid, resets FROM users WHERE id=$1;

	IF NOT FOUND OR r_user.planets > 0 THEN

		-- user already has at least 1 planet

		RETURN 1;

	END IF;

	-- give the fleets to the lost nations

	UPDATE fleets SET ownerid=2 WHERE ownerid=$1;

	-- reset the commander

	PERFORM sp_reset_account_commanders($1);

	planet_name := r_user.login || ' I';

	LOOP

		BEGIN

			IF $2 = 0 THEN

				SELECT INTO new_planet_id

					nav_planet.id

				FROM nav_planet

					INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

				WHERE --nav_planet.id > lastcolonizedplanet AND

					ownerid IS NULL AND (planet % 2 = 0) AND

					(sector % 10 = 0 OR sector % 10 = 1 OR sector <= 10 OR sector > 90) AND

					colonization_datetime IS NULL AND 

					planet_floor > 0 AND planet_space > 0 AND

					colonies < 1500 AND allow_new_players

				ORDER BY colonies / 50 DESC, random()

				LIMIT 1 FOR UPDATE;

			ELSE

				PERFORM 1 FROM sp_get_galaxy_info($1) WHERE id=$2;

				IF NOT FOUND THEN

					RETURN 4;

				END IF;

				SELECT INTO new_planet_id

					nav_planet.id

				FROM nav_planet

					INNER JOIN nav_galaxies ON (nav_galaxies.id=nav_planet.galaxy)

				WHERE ownerid IS NULL AND (nav_galaxies.id = $2) AND (planet % 2 = 0) AND

					(sector % 10 = 0 OR sector % 10 = 1 OR sector <= 10 OR sector > 90) AND

					planet_floor > 0 AND planet_space > 0 AND allow_new_players

				ORDER BY random()

				LIMIT 1 FOR UPDATE;

			END IF;

			IF NOT FOUND THEN

				-- no available planet found

				RETURN 4;

			END IF;

			-- make enemy/ally/friend fleets to go elsewhere

			PERFORM nav_planet.id, sp_move_fleet(fleets.ownerid, fleets.id, sp_ai_find_nearest_planet(fleets.ownerid, nav_planet.id))

			FROM nav_planet

				INNER JOIN fleets ON (fleets.action <> -1 AND fleets.action <> 1 AND fleets.planetid=nav_planet.id AND fleets.ownerid <> nav_planet.ownerid)

			WHERE nav_planet.id=new_planet_id;

			-- reset researches

			DELETE FROM researches_pending WHERE userid=$1;

			--DELETE FROM researches WHERE userid=$1 AND EXISTS(SELECT 1 FROM db_research WHERE id=researchid AND (rank > 6 /*OR rank < 0*/));

			--UPDATE researches SET level=GREATEST(level-LEAST(level/3, 3), 1) WHERE userid=$1 AND (SELECT rank FROM db_research WHERE id=researchid) < 0;

			INSERT INTO researches(userid, researchid, level)

			SELECT $1, id, defaultlevel FROM db_research WHERE defaultlevel > 0 AND NOT EXISTS(SELECT 1 FROM researches WHERE userid=$1 AND researchid=db_research.id);

			PERFORM sp_update_researches($1);

			-- remove commanders

			--DELETE FROM commanders WHERE ownerid=$1 AND delete_on_reset;

			PERFORM sp_clear_planet(new_planet_id);

			-- setup the planet with some resources

			DELETE FROM planet_ships WHERE planetid=new_planet_id;

			UPDATE nav_planet SET

				name = planet_name,

				ownerid = $1,

				ore = 10000,

				ore_capacity=10000,

				hydrocarbon = 7500,

				hydrocarbon_capacity=10000,

				workers = 10000,

				workers_capacity = 10000,

				scientists=50,

				scientists_capacity=100,

				soldiers=50,

				soldiers_capacity=100

			WHERE id=new_planet_id;

			IF FOUND THEN

				-- add a colony building (id 1)

				INSERT INTO planet_buildings(planetid, buildingid, quantity) VALUES(new_planet_id, 101, 1);

				--BEGIN

					-- add a commander with the name of the player into commanders table

					--INSERT INTO commanders(ownerid, name, can_be_fired, points) VALUES($1, r_user.login, false, 15);

				--EXCEPTION

				--	WHEN UNIQUE_VIOLATION THEN --

				--END;

				-- assign this commander to the first planet of the player

				UPDATE nav_planet SET

					commanderid=(SELECT id FROM commanders WHERE ownerid=$1 LIMIT 1),

					mood=100

				WHERE id=new_planet_id;

			END IF;

			UPDATE users SET

				credits = DEFAULT,

				alliance_id = null,

				alliance_rank = 0, 

				alliance_joined = null,

				last_holidays = null,

				protection_enabled = DEFAULT,

				protection_datetime = DEFAULT,

				remaining_colonizations = DEFAULT,

				resets = resets + 1,

				game_started = DEFAULT,

				credits_bankruptcy = DEFAULT,

				upkeep_last_cost = DEFAULT,

				upkeep_commanders = DEFAULT,

				upkeep_planets = DEFAULT,

				upkeep_scientists = DEFAULT,

				upkeep_soldiers = DEFAULT,

				upkeep_ships = DEFAULT,

				upkeep_ships_in_position = DEFAULT,

				upkeep_ships_parked = DEFAULT,

				score = DEFAULT,

				score_prestige = DEFAULT,

				prestige_points = DEFAULT,

				credits_produced = DEFAULT,

				leave_alliance_datetime = NULL

			WHERE id=$1;

			-- reset chats where user is

			DELETE FROM users_chats WHERE userid=$1;

			DELETE FROM chat_onlineusers WHERE userid=$1;

			DELETE FROM messages_addressee_history WHERE addresseeid=$1;

			DELETE FROM messages_ignore_list WHERE ignored_userid=$1;

			IF r_user.resets = 0 THEN

				PERFORM sp_send_sys_message($1, 1, r_user.lcid);

				PERFORM sp_send_sys_message($1, 5, r_user.lcid);

			END IF;

			RETURN 0;

		EXCEPTION

			WHEN UNIQUE_VIOLATION THEN

				RETURN 2;

		END;

	END LOOP;

	-- oops should already have exited the function

	RETURN 3;

END;$_$;


ALTER FUNCTION static.sp_reset_account(integer, integer) OWNER TO exileng;

--
-- Name: sp_reset_account_commanders(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_reset_account_commanders(_user_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_user record;

BEGIN

	DELETE FROM commanders WHERE ownerid=$1;

	SELECT INTO r_user login, orientation FROM users WHERE id=$1;

	IF NOT FOUND THEN

		RETURN;

	END IF;

	IF r_user.orientation = 2 THEN

		INSERT INTO commanders(ownerid, recruited, points, mod_fleet_shield, mod_fleet_handling, mod_fleet_tracking_speed, mod_fleet_damage)

		VALUES($1, now(), 10, 1.10, 1.10, 1.10, 1.10);

	ELSE

		INSERT INTO commanders(ownerid, recruited, points, mod_fleet_shield, mod_fleet_handling, mod_fleet_tracking_speed, mod_fleet_damage)

		VALUES($1, now(), 15, 1.0, 1.0, 1.0, 1.0);

	END IF;

END;$_$;


ALTER FUNCTION static.sp_reset_account_commanders(_user_id integer) OWNER TO exileng;

--
-- Name: sp_routes_continue(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_routes_continue(integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: FleetId

DECLARE

	r_fleet record;

	r_waypoint record;

	i int2;

BEGIN

	SELECT INTO r_fleet next_waypointid, action_end_time, planetid

	FROM fleets

	WHERE ownerid=$1 AND id=$2 /*AND NOT engaged*/;

	IF NOT FOUND OR r_fleet.next_waypointid IS NULL OR r_fleet.action_end_time IS NOT NULL THEN

		-- fleet not found

		RETURN;

	END IF;

	-- retrieve info about the next waypoint

	SELECT INTO r_waypoint

		routeid, next_waypointid, "action", planetid, ore, hydrocarbon, scientists, soldiers, workers, waittime

	FROM routes_waypoints AS r

	WHERE r.id=r_fleet.next_waypointid;

	IF r_waypoint.action = 1 THEN

		-- move

		i := sp_move_fleet($1, $2, r_waypoint.planetid);

		IF i <> 0 AND i <> -2 THEN

			--RAISE NOTICE 'move %/% to % : %', $1, $2, r_waypoint.planetid, i;

			-- not enough money or any other error

			-- make fleet wait a few minutes and retry later

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '10 minutes',

				next_waypointid = r_fleet.next_waypointid

			WHERE ownerid=$1 AND id=$2;

			RETURN;

		END IF;

	ELSEIF r_waypoint.action = 2 THEN

		-- recycle

		i := sp_start_recycling($1, $2);

		IF i <> 0 THEN

			-- make fleet wait a few seconds and continue later

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '5 second'

			WHERE ownerid=$1 AND id=$2;

		END IF;

	ELSEIF r_waypoint.action = 0 THEN

		-- transfer resources

		PERFORM sp_transfer_resources_with_planet($1, $2, r_waypoint.ore, r_waypoint.hydrocarbon, r_waypoint.scientists, r_waypoint.soldiers, r_waypoint.workers);

		--RAISE NOTICE 'transfer % % % : %', $2, r_waypoint.ore, r_waypoint.hydrocarbon, i;

		-- Make the fleet wait xx minutes after this action

		IF r_waypoint.next_waypointid IS NOT NULL THEN

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '2 minutes'

			WHERE ownerid=$1 AND id=$2;

		END IF;

	ELSEIF r_waypoint.action = 4 THEN

		-- wait

		UPDATE fleets SET

			action = 4,

			action_start_time = now(),

			action_end_time = now() + r_waypoint.waittime * INTERVAL '1 second',

			idle_since = now()

		WHERE ownerid=$1 AND id=$2;

	ELSEIF r_waypoint.action = 5 THEN

		-- invade

		i := sp_invade_planet($1, $2, 1000000);

		--RAISE NOTICE 'invade : %', i;

		-- Make the fleet wait xx minutes after this action

		IF r_waypoint.next_waypointid IS NOT NULL THEN

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '2 minutes'

			WHERE ownerid=$1 AND id=$2;

		END IF;

	ELSEIF r_waypoint.action = 6 THEN

		-- plunder planet resource

		i := sp_plunder_planet($1, $2);

		-- Make the fleet wait xx minutes after this action

		IF r_waypoint.next_waypointid IS NOT NULL THEN

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '2 minutes'

			WHERE ownerid=$1 AND id=$2;

		END IF;

	ELSEIF r_waypoint.action = 9 THEN

		IF r_waypoint.waittime IS NULL THEN

			r_waypoint.waittime := 8*60*60;

		END IF;

		-- go in hyperspace (null planet)

		UPDATE fleets SET

			action = 1,

			action_start_time = now(),

			action_end_time = now() + r_waypoint.waittime * INTERVAL '1 second',

			dest_planetid=null,

			idle_since = now()

		WHERE ownerid=$1 AND id=$2;

	ELSEIF r_waypoint.action = -1 THEN

		PERFORM sp_destroy_planet(r_fleet.planetid);

		-- Make the fleet wait xx minutes after this action

		IF r_waypoint.next_waypointid IS NOT NULL THEN

			UPDATE fleets SET

				action = 4,

				action_start_time = now(),

				action_end_time = now() + INTERVAL '2 minutes'

			WHERE ownerid=$1 AND id=$2;

		END IF;

	END IF;

	UPDATE routes SET last_used=now() WHERE id=r_waypoint.routeid;

	UPDATE fleets SET

		next_waypointid=r_waypoint.next_waypointid

	WHERE ownerid=$1 AND id=$2;

END;$_$;


ALTER FUNCTION static.sp_routes_continue(integer, integer) OWNER TO exileng;

--
-- Name: sp_routes_waypoints_after_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_routes_waypoints_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- a new waypoint has been append to a route, assign the "next_waypointid" of the last waypoint of the given routeid

	UPDATE routes_waypoints SET

		next_waypointid = NEW.id

	WHERE id = (SELECT max(id) FROM routes_waypoints WHERE routeid=NEW.routeid AND id < NEW.id);

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_routes_waypoints_after_insert() OWNER TO exileng;

--
-- Name: sp_sell_resources(integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_sell_resources(integer, integer, integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Put resources for sale

-- Param1: User ID

-- Param2: Planet ID

-- Param3: ore

-- Param4: hydrocarbon

-- Param5: ore price

-- Param6: hydrocarbon price

DECLARE

	time int4;

	cr int4;

	fleet_id int4;

	route_id int8;

	waypoint_id int8;

	total int4;

	r_user record;

	r_planet record;

BEGIN

	IF ($3 < 0) OR ($4 < 0) THEN

		RETURN 1;

	END IF;

	-- check that the planet exists and is owned by the given user

	SELECT INTO r_planet space, sp_get_planet_blocus_strength($2) >= space AS blocked

	FROM vw_planets

	WHERE ownerid=$1 AND id=$2 AND workers >= workers_for_maintenance / 2 AND (SELECT has_merchants FROM nav_galaxies WHERE id=galaxy);

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- check if enough enemy fleets are orbiting the planet to block the planet

	IF r_planet.blocked THEN

		RETURN 4;

	END IF;

	PERFORM sp_update_planet_production($2);

	-- update resources, raise an exception if not enough resources

	UPDATE nav_planet SET ore=ore-$3, hydrocarbon=hydrocarbon-$4 WHERE id=$2 AND ownerid=$1;

	time := int4((4 - ($3+$4) / 100000.0)*3600);

	IF time < 5000 THEN

		time := 5000;

	END IF;

	time := int4(time + random()*3600);

	SELECT INTO r_user mod_merchant_speed FROM users WHERE id=$1;

	IF FOUND THEN

		time := int4(time * 100/(100.0+r_user.mod_merchant_speed));

	END IF;

	total := $3 + $4;

	-- compute total credits from the sale

	cr := $5*$3/1000 + $6*$4/1000;

	-- insert the sale to market table, raise an exception if there's already a sale for the same planet

	INSERT INTO market_sales(planetid, ore, hydrocarbon, ore_price, hydrocarbon_price, credits, sale_time)

	VALUES($2, $3, $4, $5, $6, cr, now() + time * interval '1 second');

	-- insert the sale to the market history

	INSERT INTO market_history(ore_sold, hydrocarbon_sold, credits, username)

	SELECT $3, $4, cr, login FROM users WHERE id=$1;

	cr := sp_apply_tax($1, cr/2);

	UPDATE users SET credits = credits + cr WHERE id = $1;

	-- order a merchant fleet to go take resources from the planet

	SELECT INTO fleet_id id

	FROM fleets

	WHERE ownerid=3 AND action=0 AND cargo_capacity >= total AND cargo_capacity < total+100000

	ORDER BY cargo_capacity

	LIMIT 1

	FOR UPDATE;

	-- if no fleets could be sent, create a new one

	IF NOT FOUND THEN

		fleet_id := nextval('fleets_id_seq');

		INSERT INTO fleets(id, uid, ownerid, name/*, planetid, dest_planetid, action_start_time, action_end_time, action*/)

		VALUES(fleet_id, nextval('npc_fleet_uid_seq'), 3, 'Flotte marchande'/*, NULL, $2, now(), now()+time/2.0 * interval '1 second', 1*/);

		-- add merchant ships to the fleet

		INSERT INTO fleets_ships(fleetid, shipid, quantity)

		VALUES(fleet_id, 910, 1+total / (SELECT capacity FROM db_ships WHERE id=910));

	END IF;

	-- create route

	route_id := sp_create_route(null, 'mct_' || fleet_id);

	waypoint_id := sp_wp_append_wait(route_id, 5*60); -- wait 5 minutes

	PERFORM sp_wp_append_disappear(route_id, time/2); -- go back to hyperspace

	-- send the merchant fleet

	UPDATE fleets SET

		planetid=NULL,

		dest_planetid=$2,

		action_start_time=now(),

		action_end_time=now()+time/2.0 * interval '1 second',

		action=1,

		next_waypointid=waypoint_id,

		speed=8000

	WHERE id=fleet_id;

	RETURN 0;

EXCEPTION

	WHEN CHECK_VIOLATION THEN

		RETURN 3;

	WHEN UNIQUE_VIOLATION THEN

		RETURN 4;

END;$_$;


ALTER FUNCTION static.sp_sell_resources(integer, integer, integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_send_message(integer, character varying, character varying, text, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_send_message(_senderid integer, _to character varying, _subject character varying, _body text, _credits integer, _bbcode boolean) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- sp_send_message

-- add a message to a user message list

-- param1: senderid (from)

-- param2: addressee (to)

-- param3: subject

-- param4: body

-- param5: credits

-- param6: bbcode enabled

DECLARE

	r_from record;

	r_to record;

	cr int4;

	from_name varchar;

BEGIN

	IF $5 < 0 THEN

		cr := 0;

	ELSE

		cr := $5;

	END IF;

	-- retrieve the name from who this message is sent

	SELECT INTO r_from

		login, privilege, alliance_id, alliance_rank, 

		now()-game_started > INTERVAL '2 weeks' AND security_level >= 3 AS can_sendmoney,

		r.can_mail_alliance,

		(SELECT count(DISTINCT galaxy) FROM nav_planet WHERE ownerid=users.id) AS galaxies,

		(SELECT galaxy FROM nav_planet WHERE ownerid=users.id LIMIT 1) AS galaxy

	FROM users

		LEFT JOIN alliances_ranks AS r ON (r.allianceid=users.alliance_id AND r.rankid=users.alliance_rank)

	WHERE id=$1;

	IF NOT FOUND THEN

		from_name := '';

	ELSE

		from_name := r_from.login;

		-- prevent new users from sending money to players

		IF NOT r_from.can_sendmoney THEN

			cr := 0;

		END IF;

	END IF;

	IF $2 = ':all' AND r_from.privilege >= 500 THEN

		INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

		SELECT id, $2, null, from_name, $3, $4, $6 FROM users WHERE privilege=0;

		-- add a "sent" message for the admin

		INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

		VALUES(null, $2, $1, from_name, $3, $4, $6);

	ELSEIF $2 = ':admins' THEN

		-- send message to admins

		INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

		SELECT id, $2, null, from_name, $3, $4, $6 FROM users WHERE privilege >= 500 AND id <> $1;

		-- add a "sent" message

		INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

		VALUES(null, $2, $1, from_name, $3, $4, $6);

	ELSEIF $2 = ':alliance' THEN

		IF r_from.can_mail_alliance THEN

			INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

			SELECT id, $2, null, from_name, $3, $4, $6 FROM users WHERE alliance_id = r_from.alliance_id AND id <> $1;

			-- add a "sent" message

			INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, bbcode)

			VALUES(null, $2, $1, from_name, $3, $4, $6);

		ELSE

			RETURN 10;

		END IF;

	ELSE

		-- retrieve addressee id

		SELECT INTO r_to

			id,

			login, 

			now()-game_started > INTERVAL '2 weeks' AND security_level >= 3 AS can_receivemoney,

			(SELECT count(DISTINCT galaxy) FROM nav_planet WHERE ownerid=users.id) AS galaxies,

			(SELECT galaxy FROM nav_planet WHERE ownerid=users.id LIMIT 1) AS galaxy

		FROM users

		WHERE upper(login)=upper($2) AND (privilege <> -1);

		IF NOT FOUND THEN

			RETURN 2;

		END IF;

		IF cr > 0 THEN

			IF NOT r_to.can_receivemoney THEN

				cr := 0;

			ELSE

				IF r_to.galaxies = 1 AND (r_from.galaxies > 1 OR r_to.galaxy <> r_from.galaxy) THEN

					-- "to" is only on 1 galaxy and sender is either not in same galaxy or in multiple so check if "to" is in a protected galaxy

					PERFORM 1 FROM nav_galaxies WHERE id=r_to.galaxy AND protected_until > now();

					IF FOUND THEN

						cr := 0;

					END IF;

				END IF;

			END IF;

		END IF;

		-- check that we are not sending a message from and to the same person

		IF r_from.privilege < 100 AND $1 = r_to.id THEN

			RETURN 3;

		END IF;

		PERFORM 1 FROM messages_ignore_list WHERE userid=r_to.id AND ignored_userid=$1;

		IF FOUND THEN

			UPDATE messages_ignore_list SET blocked=blocked+1 WHERE userid=r_to.id AND ignored_userid=$1;

			RETURN 9; -- ignored user

		END IF;

		-- add message to messages table

		INSERT INTO messages(ownerid, owner, senderid, sender, subject, body, datetime, credits, bbcode)

		VALUES(r_to.id, r_to.login, $1, from_name, $3, $4, now(), cr, $6);

		-- add addressee id to messages_addressee_history table

		IF NOT $1 IS NULL THEN

			INSERT INTO messages_addressee_history(ownerid, addresseeid) VALUES($1, r_to.id);

		END IF;

		IF cr > 0 AND $1 IS NOT NULL THEN

			IF sp_transfer_credits($1, r_to.id, cr) <> 0 THEN

				RAISE EXCEPTION 'not enough credits';

			END IF;

		END IF;

	END IF;

	RETURN 0;

EXCEPTION

	WHEN FOREIGN_KEY_VIOLATION THEN

		RETURN 0;

	-- check violation when sender has not enough money

	WHEN RAISE_EXCEPTION THEN

		RETURN 4;

END;$_$;


ALTER FUNCTION static.sp_send_message(_senderid integer, _to character varying, _subject character varying, _body text, _credits integer, _bbcode boolean) OWNER TO exileng;

--
-- Name: sp_send_sys_message(integer, integer, smallint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_send_sys_message(_user_id integer, _msg_id integer, _lcid smallint) RETURNS integer
    LANGUAGE plpgsql
    AS $$DECLARE

	r_msg record;

BEGIN

	SELECT INTO r_msg

		subject, body, sender

	FROM db_messages

	WHERE id=_msg_id AND lcid=_lcid;

	IF NOT FOUND THEN

		SELECT INTO r_msg

			subject, body, sender

		FROM db_messages

		WHERE id=_msg_id LIMIT 1;

		IF NOT FOUND THEN

			RETURN 1;

		END IF;

	END IF;

	INSERT INTO messages(ownerid, owner, sender, subject, body)

	VALUES(_user_id, (SELECT login FROM users WHERE id=_user_id), r_msg.sender, r_msg.subject, r_msg.body);

	RETURN 0;

END;$$;


ALTER FUNCTION static.sp_send_sys_message(_user_id integer, _msg_id integer, _lcid smallint) OWNER TO exileng;

--
-- Name: sp_send_sys_message(integer, integer, smallint, character varying, character varying); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_send_sys_message(_user_id integer, _msg_id integer, _lcid smallint, _param1 character varying, _param2 character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$DECLARE

	r_msg record;

BEGIN

	SELECT INTO r_msg

		subject, body, sender

	FROM db_messages

	WHERE id=_msg_id AND lcid=_lcid;

	IF NOT FOUND THEN

		SELECT INTO r_msg

			subject, body, sender

		FROM db_messages

		WHERE id=_msg_id LIMIT 1;

		IF NOT FOUND THEN

			RETURN 1;

		END IF;

	END IF;

	INSERT INTO messages(ownerid, owner, sender, subject, body)

	VALUES(_user_id, (SELECT login FROM users WHERE id=_user_id), r_msg.sender, r_msg.subject, replace(replace(r_msg.body, '$1', _param1), '$2', _param2));

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_send_sys_message(_user_id integer, _msg_id integer, _lcid smallint, _param1 character varying, _param2 character varying) OWNER TO exileng;

--
-- Name: sp_session_isalive(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_session_isalive(_playerid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- sp_session_isalive

-- return whether a player is connected

BEGIN

	PERFORM 1 FROM sessions WHERE userid=$1 AND lastactivity > now() - INTERVAL '10 minutes';

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_session_isalive(_playerid integer) OWNER TO exileng;

--
-- Name: sp_session_keepalive(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_session_keepalive(_playerid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- sp_session_keepalive

-- keep alive a session

-- return false is no session for the given playerid can be found

BEGIN

	UPDATE sessions SET lastactivity = now() WHERE userid=$1;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION static.sp_session_keepalive(_playerid integer) OWNER TO exileng;

--
-- Name: sp_session_start(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_session_start(_playerid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- sp_session_start

BEGIN

	PERFORM sp_session_stop(_playerid);

	-- create a new session

	INSERT INTO sessions(userid) VALUES($1);

	RETURN true;

END;$_$;


ALTER FUNCTION static.sp_session_start(_playerid integer) OWNER TO exileng;

--
-- Name: sp_session_stop(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_session_stop(_playerid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	DELETE FROM sessions WHERE userid=_playerid;

	DELETE FROM sessions_notifications WHERE userid=_playerid;

	DELETE FROM chat_users WHERE userid=_playerid;

END;$$;


ALTER FUNCTION static.sp_session_stop(_playerid integer) OWNER TO exileng;

--
-- Name: sp_start_blocus(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_blocus(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: FleetId

BEGIN

	UPDATE fleets SET action=3, action_start_time=now(), action_end_time=now()+interval '1 hour' WHERE id=$1;

END;$_$;


ALTER FUNCTION static.sp_start_blocus(integer) OWNER TO exileng;

--
-- Name: sp_start_building(integer, integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_building(integer, integer, integer, boolean) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- begin the construction of a new building on a planet

-- param1: user id

-- param2: planet id

-- param3: building id

-- param4: if should loop constructions

DECLARE

	r_building record;

	r_planet record;

	c int4;

BEGIN

	PERFORM 1 FROM users WHERE id=$1 FOR UPDATE;

	SELECT INTO r_planet 

		mod_construction_speed_buildings, energy_production-energy_consumption AS energy_available

	FROM nav_planet

	WHERE id=$2 AND ownerid=$1 FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 5;

	END IF;

	-- retrieve building info

	SELECT INTO r_building

		energy_consumption, cost_ore, cost_hydrocarbon, cost_credits, cost_energy, cost_prestige, construction_time, construction_time_exp_per_building

	FROM db_buildings

	WHERE id=$3 AND NOT is_planet_element AND buildable;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

--	IF r_building.energy_consumption > 0 AND r_building.energy_consumption > r_planet.energy_available THEN

--		RETURN 2;

--	END IF;

	-- update planet resources before trying to remove any resources

	PERFORM sp_update_planet_production($2);

	-- use resources

	BEGIN

		UPDATE nav_planet SET

			ore = ore - r_building.cost_ore,

			hydrocarbon = hydrocarbon - r_building.cost_hydrocarbon,

			energy = energy - r_building.cost_energy

		WHERE id=$2;

		IF r_building.cost_prestige > 0 THEN

			-- remove user prestige points

			UPDATE users SET

				prestige_points = prestige_points - r_building.cost_prestige

			WHERE id=$1;

		END IF;

		IF r_building.cost_credits > 0 THEN

			-- remove user credits

			UPDATE users SET

				credits = credits - r_building.cost_credits		

			WHERE id=$1;

		END IF;

		INSERT INTO users_expenses(userid, credits_delta, planetid, buildingid)

		VALUES($1, -r_building.cost_credits, $2, $3);

		IF r_building.construction_time_exp_per_building <> 1.0 THEN

			SELECT INTO c quantity FROM planet_buildings WHERE planetid=$2 AND buildingid=$3;

		ELSE

			c := 0;

		END IF;

		r_building.construction_time := sp_get_construction_time(r_building.construction_time, r_building.construction_time_exp_per_building, c, r_planet.mod_construction_speed_buildings);

		-- build the building

		INSERT INTO planet_buildings_pending(planetid, buildingid, start_time, end_time, loop)

		VALUES($2, $3, now(), now() + r_building.construction_time * INTERVAL '1 second', $4);

		PERFORM sp_update_planet($2);

	EXCEPTION

		-- check violation in case not enough resources, money, space/ground or prestige

		WHEN CHECK_VIOLATION THEN

			RETURN 2;

		-- raised exception when building/research not met or maximum reached or not enough energy

		WHEN RAISE_EXCEPTION THEN

			RETURN 3;

		-- already building this type of building

		WHEN UNIQUE_VIOLATION THEN

			RETURN 4;

	END;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_start_building(integer, integer, integer, boolean) OWNER TO exileng;

--
-- Name: sp_start_recycling(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_recycling(_userid integer, _fleetid integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: FleetId

DECLARE

	r_fleet record;

BEGIN

	SELECT INTO r_fleet planetid

	FROM fleets

	WHERE ownerid=_userid AND id=_fleetid;

	-- check if a fleet is already recycling at the fleet position

	PERFORM 1 FROM fleets

	WHERE ownerid=_userid AND action=2 AND id <> _fleetid AND planetid=r_fleet.planetid;

	IF FOUND THEN

		RETURN -2;

	END IF;

	-- make the fleet recycle

	UPDATE fleets SET

		action_start_time = now(),

		action_end_time = now() + INTERVAL '10 minutes' / mod_recycling,

		action = 2

	WHERE ownerid=_userid AND id=_fleetid AND action=0 AND not engaged AND recycler_output > 0;

	IF NOT FOUND THEN

		RETURN -1;

	ELSE

		PERFORM sp_update_fleets_recycler_percent(r_fleet.planetid);

		RETURN 0;

	END IF;

END;$$;


ALTER FUNCTION static.sp_start_recycling(_userid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_start_research(integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_research(integer, integer, boolean) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- begin the research of a technology

-- param1: user id

-- param2: research id

-- param3: if should loop reseaches

DECLARE

	r_research record;

BEGIN

	-- retrieve research info

	SELECT INTO r_research

		label, total_cost, total_time

	FROM sp_list_researches($1)

	WHERE researchid=$2 AND (level < levels OR expiration_time IS NOT NULL) AND researchable AND buildings_requirements_met AND status IS NULL;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	BEGIN

		--PERFORM sp_log_credits($1, -r_research.total_cost, 'start research: ' || r_research.label);

		INSERT INTO users_expenses(userid, credits_delta, researchid)

		VALUES($1, -r_research.total_cost, $2);

		-- subtract the credits

		UPDATE users SET

			credits = credits - r_research.total_cost

		WHERE id = $1;

		-- start the research

		INSERT INTO researches_pending(userid, researchid, start_time, end_time, looping)

		VALUES($1, $2, now(), now() + r_research.total_time * INTERVAL '1 seconds', $3);

	EXCEPTION

		-- check violation when not enough money

		WHEN CHECK_VIOLATION THEN

			RETURN 2;

		-- raised exception when building/research not met

		WHEN RAISE_EXCEPTION THEN

			RETURN 3;

		-- when already researching

		WHEN UNIQUE_VIOLATION THEN

			RETURN 4;

	END;

	IF r_research.total_time = 0 THEN

		PERFORM sp_process_researches();

	END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_start_research(integer, integer, boolean) OWNER TO exileng;

--
-- Name: sp_start_ship(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_ship(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$BEGIN

	RETURN sp_start_ship($1, $2, $3, true);

END;$_$;


ALTER FUNCTION static.sp_start_ship(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_start_ship(integer, integer, integer, boolean); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_ship(_planetid integer, _shipid integer, _quantity integer, _take_resources boolean) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- begin the construction of a new building on a planet

-- param1: planet id

-- param2: ship id

-- param3: number of constructions

-- param4: if take resources immediately

DECLARE

	r_ship record;

	b_construction_time int2;

	count int4;

	r_user record;

BEGIN

	IF $3 <= 0 THEN

		RETURN 0;

	END IF;

	-- retrieve ship info

	SELECT INTO r_ship

		label, crew, cost_ore, cost_hydrocarbon, cost_credits, workers, required_shipid

	FROM db_ships

	WHERE id=$2;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	BEGIN

		IF _take_resources THEN

			-- retrieve user id that owns the planetid $1

			SELECT INTO r_user ownerid AS id FROM nav_planet WHERE id=$1 LIMIT 1;

			IF NOT FOUND THEN

				RETURN 1;

			END IF;

			-- update planet resources before trying to remove any resources

			PERFORM sp_update_planet_production($1);

			-- get how many ships we can build at maximum

			IF r_ship.crew > 0 THEN

				SELECT LEAST(LEAST(ore / r_ship.cost_ore, hydrocarbon / r_ship.cost_hydrocarbon), (workers-GREATEST(workers_busy,500,workers_for_maintenance/2)-r_ship.workers) / r_ship.crew) INTO count FROM nav_planet WHERE id=$1;

			ELSE

				SELECT LEAST(ore / r_ship.cost_ore, hydrocarbon / r_ship.cost_hydrocarbon) INTO count FROM nav_planet WHERE id=$1;

			END IF;

			-- get how many ships we can build at maximum

			IF r_ship.cost_credits > 0 THEN

				SELECT LEAST(count, credits / r_ship.cost_credits) INTO count FROM users WHERE id=r_user.id;

			END IF;

			count := LEAST(count, $3);

			-- limit number of ships buildable to the number of required ship available on the planet

			IF r_ship.required_shipid IS NOT NULL THEN

				SELECT INTO count

					LEAST(count, quantity)

				FROM planet_ships

				WHERE planetid=$1 AND shipid=r_ship.required_shipid;

				IF NOT FOUND THEN

					count := 0;

				END IF;

			END IF;

			-- can't build any ship with the available resources

			IF count < 1 THEN

				RETURN 5;

			END IF;

			-- remove resources

			UPDATE nav_planet SET

				ore = ore - count*r_ship.cost_ore,

				hydrocarbon = hydrocarbon - count*r_ship.cost_hydrocarbon,

				workers = workers - count*r_ship.crew

			WHERE id=$1;

			INSERT INTO users_expenses(userid, credits_delta, planetid, shipid, quantity)

			VALUES(r_user.id, -count*r_ship.cost_credits, $1, $2, count);

			-- remove user credits

			UPDATE users SET

				credits = credits - count*r_ship.cost_credits

			WHERE id=r_user.id;

			IF r_ship.required_shipid IS NOT NULL THEN

				UPDATE planet_ships SET

					quantity = quantity - count

				WHERE planetid=$1 AND shipid=r_ship.required_shipid AND quantity >= count;

				IF NOT FOUND THEN

					RAISE EXCEPTION 'not enough required ship';

				END IF;

			END IF;

		ELSE

			count := _quantity;

		END IF;

		-- queue the ship

		INSERT INTO planet_ships_pending(planetid, shipid, start_time, quantity, take_resources)

		VALUES($1, $2, now(), count, NOT $4);

		PERFORM sp_continue_ships_construction($1);

		PERFORM sp_update_planet_production($1);

	EXCEPTION

		-- check violation in case not enough resources, money or space/floor

		WHEN CHECK_VIOLATION THEN

			RETURN 2;

		-- raised exception when building/research not met or maximum reached

		WHEN RAISE_EXCEPTION THEN

			RETURN 3;

		-- already building this type of building

		WHEN UNIQUE_VIOLATION THEN

			RETURN 4;

	END;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_start_ship(_planetid integer, _shipid integer, _quantity integer, _take_resources boolean) OWNER TO exileng;

--
-- Name: sp_start_ship_building_installation(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_ship_building_installation(integer, integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: Userid

-- Param2: Fleetid

-- Param3: Shipid

DECLARE

	fleet_planetid int4;

	ship_building record;

	r_planet record;

	r_user record;

	x float;

	maxcolonizations bool;

	_colonized_in_safe_space int4;

BEGIN

	maxcolonizations := false;

	-- check that the fleet belongs to the given user and retrieve the planetid where the fleet is

	SELECT planetid INTO fleet_planetid 

	FROM fleets 

	WHERE ownerid=$1 AND id=$2 AND NOT engaged AND dest_planetid IS NULL LIMIT 1;

	IF NOT FOUND THEN

		-- doesn't exist, engaged, dest_planet is not null (moving) or doesn't belong to the user

		RETURN -1;

	END IF;

	-- check that the ship exists in the given fleet and retrieve the buildingid and crew

	SELECT INTO ship_building buildingid AS id, db_ships.crew, db_buildings.lifetime

	FROM fleets_ships

		INNER JOIN db_ships ON (fleets_ships.shipid = db_ships.id)

		INNER JOIN db_buildings ON (db_ships.buildingid = db_buildings.id)

	WHERE fleetid=$2 AND shipid=$3;

	IF NOT FOUND THEN

		RETURN -2;

	END IF;

	-- check that the planet where the fleet is, belongs to the given user or to nobody

	SELECT INTO r_planet

		nav_planet.id, ownerid, planet_floor, planet_space, vortex_strength, nav_galaxies.protected_until > now() AS is_protected

	FROM nav_planet

		INNER JOIN nav_galaxies ON nav_galaxies.id = nav_planet.galaxy

	WHERE nav_planet.id=fleet_planetid;

	IF NOT (FOUND AND (r_planet.ownerid IS NULL OR r_planet.ownerid=$1 OR sp_relation(r_planet.ownerid, $1) >= -1)) THEN

		-- forbidden to install on this planet

		RETURN -3;

	END IF;

	-- forbid to install buildings with a lifetime on a real planet that is not owned by someone

	IF ship_building.lifetime > 0 AND r_planet.ownerid IS NULL AND (r_planet.planet_floor > 0 OR r_planet.planet_space > 0) THEN

		-- forbidden to install on this planet

		RETURN -3;

	END IF;

	IF sp_can_build_on(fleet_planetid, ship_building.id, COALESCE(r_planet.ownerid, $1)) <> 0 THEN

		-- max buildings reached or requirements not met

		RETURN -5;

	END IF;

	-- check if can colonize planet only if floor > 0 and space > 0 (if floor = 0 and space = 0 then it is not counted as a planet)

	IF r_planet.ownerid IS NULL AND r_planet.planet_floor > 0 AND r_planet.planet_space > 0 THEN

		PERFORM 1 FROM users WHERE id=$1 AND planets < max_colonizable_planets AND planets < mod_planets;

		IF NOT FOUND THEN

			-- player has too many planets

			RETURN -7;

		END IF;

		IF r_planet.is_protected THEN

			SELECT INTO _colonized_in_safe_space

				count(*)

			FROM nav_planet

			WHERE ownerid=$1 AND planet_floor > 0 AND (SELECT protected_until FROM nav_galaxies WHERE id=nav_planet.galaxy) > now();

			IF _colonized_in_safe_space >= 2 THEN

				-- player can't colonize more planets in protected regions

				RETURN -11;

			END IF;

		END IF;

		-- check if there are enemy fleets nearby

		PERFORM 1 FROM fleets WHERE planetid=fleet_planetid AND firepower > 0 AND sp_relation(ownerid, $1) < -1 AND action <> -1 AND action <> 1;

		IF FOUND THEN

			RETURN -8;

		END IF;

	END IF;

	-- verifications ok, start building

	BEGIN

		-- set the player as the owner

		UPDATE nav_planet SET

			name=sp_get_user($1),

			ownerid = $1,

			recruit_workers=true,

			mood = 100

		WHERE id=fleet_planetid AND ownerid IS NULL;

		IF NOT FOUND THEN

			-- planet already belongs to the player, try to unload the crew

		ELSE

			maxcolonizations := true;

			UPDATE users SET

				remaining_colonizations=remaining_colonizations-1,

				prestige_points = prestige_points - sp_get_prestige_cost_for_new_planet(planets)

			WHERE id=$1 AND prestige_points >= sp_get_prestige_cost_for_new_planet(planets);

			IF NOT FOUND THEN

				RAISE EXCEPTION 'Not enough prestige';

			END IF;

			maxcolonizations := false;

		END IF;

		IF ship_building.lifetime > 0 THEN

			UPDATE planet_buildings SET

				destroy_datetime = now()+ship_building.lifetime*INTERVAL '1 second'

			WHERE planetid=r_planet.id AND buildingid = ship_building.id;

			IF NOT FOUND THEN

				INSERT INTO planet_buildings(planetid, buildingid, quantity, destroy_datetime)

				VALUES(fleet_planetid, ship_building.id, 1, now()+ship_building.lifetime*INTERVAL '1 second');

			END IF;

		ELSE

			-- insert the deployed building on the planet

			INSERT INTO planet_buildings(planetid, buildingid, quantity)

			VALUES(fleet_planetid, ship_building.id, 1);

			PERFORM sp_update_planet(fleet_planetid);

			-- add the ship crew to the planet workers

			UPDATE nav_planet SET

				workers = LEAST(workers_capacity, workers+ship_building.crew)

			WHERE id=fleet_planetid;

		END IF;

		PERFORM sp_update_planet(fleet_planetid);

		UPDATE fleets_ships SET

			quantity = quantity - 1

		WHERE fleetid=$2 AND shipid=$3;

		RETURN fleet_planetid;

	EXCEPTION

		-- check violation in case not enough resources, money or space/floor

		WHEN CHECK_VIOLATION THEN

			IF maxcolonizations THEN

				RETURN -7;

			ELSE

				RETURN -4;

			END IF;

		-- raised exception when building/research not met or maximum reached

		WHEN RAISE_EXCEPTION THEN

			IF SQLERRM = 'Not enough prestige' THEN

				RETURN -10;

			END IF;

			RETURN -5;

		-- already building this type of building

		WHEN UNIQUE_VIOLATION THEN

			RETURN -6;

	END;

END;$_$;


ALTER FUNCTION static.sp_start_ship_building_installation(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_start_ship_building_installation(integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_start_ship_building_installation(integer, integer, integer) IS 'Install the ship building on the planet, the planet must either be owned by the ship owner or nobody, in the latter case, the planet is claimed by the ship owner.

Returns the PlanetId in case of success or negative number';


--
-- Name: sp_start_ship_recycling(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_ship_recycling(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- begin the construction of a new building on a planet

-- param1: planet id

-- param2: ship id

-- param3: number of ships

DECLARE

	r_ship record;

	count int4;

BEGIN

	-- check the user wants to recycle at least 1 ship

	IF $3 <= 0 THEN

		RETURN 0;

	END IF;

	-- retrieve ship info

	SELECT INTO r_ship

		label, crew, cost_ore, cost_hydrocarbon, cost_credits, workers, required_shipid

	FROM db_ships

	WHERE id=$2;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	BEGIN

		-- get how many ships we can recycle at maximum

		SELECT INTO count quantity FROM planet_ships WHERE planetid=$1 AND shipid=$2;

		count := LEAST(count, $3);

		-- there are no ships to recycle

		IF count < 1 THEN

			RETURN 5;

		END IF;

/*

		-- remove ships

		UPDATE planet_ships SET

			quantity = quantity - count

		WHERE planetid=$1 AND shipid=$2 AND quantity >= count;

		IF NOT FOUND THEN

			RAISE EXCEPTION 'Trying to recycle more ships than available';

		END IF;

*/

		-- queue the order

		INSERT INTO planet_ships_pending(planetid, shipid, start_time, quantity, recycle)

		VALUES($1, $2, now(), count, true);

		INSERT INTO users_expenses(userid, credits_delta, planetid, shipid, quantity)

		VALUES(sp_get_planet_owner($1), 0, $1, $2, -count);

		PERFORM sp_continue_ships_construction($1);

	EXCEPTION

		-- check violation in case not enough resources, money or space/floor

		WHEN CHECK_VIOLATION THEN

			RETURN 2;

		-- raised exception when trying to recycle more ships than available (should not happen)

		WHEN RAISE_EXCEPTION THEN

			RETURN 3;

	END;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_start_ship_recycling(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_start_training(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_start_training(_userid integer, _planetid integer, _scientists integer, _soldiers integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: PlanetId

-- Param3: number of scientists

-- Param4: number of soldiers

DECLARE

	r_planet record;

	r_user record;

	prices training_price;

	t_scientists int4;

	t_soldiers int4;

	code int2;

BEGIN

	code := 0;

	-- check that the planet belongs to the given userid

	PERFORM 1

	FROM nav_planet

	WHERE id=_planetid AND ownerid=_userid;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve training price

	prices := sp_get_training_price(_userid);

	PERFORM sp_update_planet_production(_planetid);

	-- retrieve player credits

	SELECT INTO r_user credits FROM users WHERE id=_userid;

	-- retrieve planet stats

	-- also, retrieve how many scientists/soldiers can be trained every "batch"

	SELECT INTO r_planet

		ore,

		hydrocarbon,

		workers-workers_for_maintenance AS workers,

		training_scientists, training_soldiers

	FROM nav_planet

	WHERE id=_planetid;

	IF r_planet.workers <= 0 THEN

		RETURN 6;	-- no available workers

	END IF;

	--RAISE NOTICE 'sc: %, %, %, %, %', _scientists, r_planet.workers, r_user.credits / prices.scientist_credits, r_planet.ore / prices.scientist_ore, r_planet.hydrocarbon / prices.scientist_hydrocarbon;

	-- limit scientists

	t_scientists := LEAST(_scientists, r_planet.workers, r_user.credits / prices.scientist_credits, r_planet.ore / prices.scientist_ore, r_planet.hydrocarbon / prices.scientist_hydrocarbon);

	IF t_scientists < 0 THEN

		t_scientists := 0;

	ELSEIF _scientists > t_scientists THEN

		code := 4;	-- scientists have been limited in number

	END IF;

	r_user.credits := r_user.credits - t_scientists * prices.scientist_credits;

	r_planet.ore := r_planet.ore - t_scientists * prices.scientist_ore;

	r_planet.hydrocarbon := r_planet.hydrocarbon - t_scientists * prices.scientist_hydrocarbon;

	r_planet.workers := r_planet.workers - t_scientists;

	--RAISE NOTICE 'sol: %, %, %, %, %', _scientists, r_planet.workers, r_user.credits / prices.scientist_credits, r_planet.ore / prices.scientist_ore, r_planet.hydrocarbon / prices.scientist_hydrocarbon;

	-- limit soldiers

	t_soldiers := LEAST(_soldiers, r_planet.workers, r_user.credits / prices.soldier_credits, r_planet.ore / prices.soldier_ore, r_planet.hydrocarbon / prices.soldier_hydrocarbon);

	IF t_soldiers < 0 THEN

		t_soldiers := 0;

	ELSEIF _soldiers > t_soldiers THEN

		code := 4;	-- soldiers have been limited in number

	END IF;

	-- check if it is possible to train scientists

	IF _scientists > 0 AND r_planet.training_scientists = 0 THEN

		t_scientists := 0;

		code := 5;

	END IF;

	-- check if it is possible to train soldiers

	IF _soldiers > 0 AND r_planet.training_soldiers = 0 THEN

		t_soldiers := 0;

		code := 5;

	END IF;

	BEGIN

		UPDATE nav_planet SET

			workers = workers - t_scientists - t_soldiers,

			ore = ore - t_scientists * prices.scientist_ore - t_soldiers * prices.soldier_ore,

			hydrocarbon = hydrocarbon - t_scientists * prices.scientist_hydrocarbon - t_soldiers * prices.soldier_hydrocarbon

		WHERE id=_planetid;

		--PERFORM sp_log_credits($1, -t_price, 'trained ' || t_scientists || ' scientists and ' || t_soldiers || ' soldiers');

		INSERT INTO users_expenses(userid, credits_delta, planetid, scientists, soldiers)

		VALUES(_userid, -t_scientists * prices.scientist_credits - t_soldiers * prices.soldier_credits, _planetid, _scientists, _soldiers);

		UPDATE users SET credits = credits - t_scientists * prices.scientist_credits - t_soldiers * prices.soldier_credits WHERE id=_userid;

		IF t_scientists > 0 THEN

			INSERT INTO planet_training_pending(planetid, scientists)

			VALUES(_planetid, t_scientists);

		END IF;

		IF t_soldiers > 0 THEN

			INSERT INTO planet_training_pending(planetid, soldiers)

			VALUES(_planetid, t_soldiers);

		END IF;

		PERFORM sp_continue_training(_planetid);

	EXCEPTION

		-- check violation in case not enough resources, money or space/floor

		WHEN CHECK_VIOLATION THEN

			RETURN 2;

	END;

	RETURN code;

END;$_$;


ALTER FUNCTION static.sp_start_training(_userid integer, _planetid integer, _scientists integer, _soldiers integer) OWNER TO exileng;

--
-- Name: sp_stop_all_buildings(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_stop_all_buildings(integer, integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: PlanetId

DECLARE

	r_planet record;

BEGIN

	PERFORM sp_cancel_building($1, $2, buildingid)

	FROM planet_buildings_pending

	WHERE planetid=$2;

--	SELECT INTO r_planet scientists, workers, workers_busy FROM nav_planet WHERE id=$2;

--	RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

	UPDATE planet_buildings SET

		destroy_datetime=NULL

	WHERE planetid=$2 AND NOT (SELECT lifetime > 0 OR is_planet_element OR NOT buildable FROM db_buildings WHERE id=buildingid);

	PERFORM sp_update_planet($2);

--	SELECT INTO r_planet scientists, workers, workers_busy FROM nav_planet WHERE id=$2;

--	RAISE NOTICE '% % %', r_planet.scientists, r_planet.workers, r_planet.workers_busy;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_stop_all_buildings(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_stop_all_buildings(integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_stop_all_buildings(integer, integer) IS 'Stop all buildings on a planet';


--
-- Name: sp_stop_all_ships(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_stop_all_ships(_userid integer, _planetid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: PlanetId

BEGIN

	PERFORM sp_cancel_ship(_planetid, id)

	FROM planet_ships_pending

	WHERE planetid=_planetid;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_stop_all_ships(_userid integer, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_stop_all_ships(_userid integer, _planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_stop_all_ships(_userid integer, _planetid integer) IS 'Stop construction of all ships on a planet';


--
-- Name: sp_stop_all_training(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_stop_all_training(_userid integer, _planetid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$-- Param1: UserId

-- Param2: PlanetId

BEGIN

	PERFORM sp_cancel_training(_planetid, id)

	FROM planet_training_pending

	WHERE planetid=_planetid;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_stop_all_training(_userid integer, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_stop_all_training(_userid integer, _planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_stop_all_training(_userid integer, _planetid integer) IS 'Stop all trainings on a planet';


--
-- Name: sp_stop_holidays(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_stop_holidays(integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

DECLARE

	remaining_time INTERVAL;

BEGIN

	SELECT INTO remaining_time end_time-now() FROM users_holidays WHERE userid=$1 AND activated FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	IF remaining_time > INTERVAL '0 seconds' THEN

	-- remove remaining_time from buildings

	UPDATE planet_buildings_pending SET end_time=end_time-remaining_time WHERE end_time IS NOT NULL AND planetid IN (SELECT id FROM nav_planet WHERE ownerid=$1);

	-- remove remaining_time from ships

	UPDATE planet_ships_pending SET end_time=end_time-remaining_time WHERE end_time IS NOT NULL AND planetid IN (SELECT id FROM nav_planet WHERE ownerid=$1);

	-- remove remaining_time from research

	UPDATE researches_pending SET end_time=end_time-remaining_time WHERE userid=$1;

	END IF;

	-- resume all planets productions

	UPDATE nav_planet SET production_lastupdate=now(), production_frozen=false WHERE ownerid=$1 AND production_frozen;

	PERFORM sp_update_planet(id) FROM nav_planet WHERE ownerid=$1;

	-- remove user from holidays mode

	UPDATE users SET privilege=0, last_holidays=now() WHERE id=$1;

	DELETE FROM users_holidays WHERE userid=$1;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_stop_holidays(integer) OWNER TO exileng;

--
-- Name: sp_transfer_credits(integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_transfer_credits(_from integer, _to integer, _credits integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$-- Param1: From User

-- Param2: To User

-- Param3: credits

DECLARE

	r_from record;

	r_to record;

BEGIN

	-- remove credits from the sender

	UPDATE users SET credits = credits - $3 WHERE id=_from AND credits - $3 >= 0 RETURNING login INTO r_from;

	IF NOT FOUND THEN

		RETURN -1;

	END IF;

	UPDATE users SET credits = credits + $3 WHERE id=_to RETURNING login INTO r_to;

	--SELECT sp_log_credits($1, -$3, 'Transfer money to ' || r_to.login);

	INSERT INTO users_expenses(userid, credits_delta, to_user)

	VALUES(_from, -_credits, _to);

	INSERT INTO messages_money_transfers(senderid, sendername, toid, toname, credits)

	VALUES(_from, r_from.login, $2, r_to.login, _credits);

	INSERT INTO reports(ownerid, type, subtype, userid, credits, data)

	VALUES(_to, 5, 2, _from, _credits, '{from:' || sp__quote(r_from.login) || ', credits:' || _credits || '}');

	RETURN 0;

EXCEPTION

	WHEN restrict_violation THEN

		RETURN -1;

END;$_$;


ALTER FUNCTION static.sp_transfer_credits(_from integer, _to integer, _credits integer) OWNER TO exileng;

--
-- Name: sp_transfer_resources_with_planet(integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_transfer_resources_with_planet(integer, integer, integer, integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- transfer resources between a fleet and a planet

-- if ore > 0, it means "we take from planet : load into the fleet"

-- if ore < 0, it means "we take from the fleet : unload from the fleet"

-- param1: user id

-- param2: fleet id

-- param3: ore

-- param4: hydrocarbon

-- param5: scientists

-- param6: soldiers

-- param7: workers

DECLARE

	r_fleet record;

	r_planet record;

	t_ore int4;

	t_hydrocarbon int4;

	t_scientists int4;

	t_soldiers int4;

	t_workers int4;

	remaining_space int4;

	tmp int4;

	price integer;

	cr integer;

	do_report boolean;

BEGIN

	-- retrieve fleet info, cargo and lock the fleet and the planet at the same time for update

	SELECT INTO r_fleet

		f.id, f.name, f.ownerid,

		f.planetid, sp_relation(f.ownerid, p.ownerid) AS planet_relation,

		f.cargo_ore, f.cargo_hydrocarbon, f.cargo_scientists, f.cargo_soldiers, f.cargo_workers, f.cargo_capacity,

		COALESCE(p.buy_ore, 0) AS buy_ore,

		COALESCE(p.buy_hydrocarbon, 0) AS buy_hydrocarbon

	FROM fleets AS f

		INNER JOIN nav_planet AS p ON (f.planetid=p.id)

	WHERE f.ownerid=$1 AND f.id=$2 AND f.action_end_time IS NULL AND NOT f.engaged FOR UPDATE;

	-- fleet either moving or fleet not found

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- check the planet relation with the owner of the fleet

	IF NOT FOUND OR r_fleet.planet_relation < -1 THEN

		RETURN 2;

	END IF;

	-- update planet resources before trying to add/remove any resources

	PERFORM sp_update_planet_production(r_fleet.planetid);

	-- retrieve the max resources that can be taken from planet

	SELECT INTO r_planet

		ownerid,

		ore, ore_capacity,

		hydrocarbon, hydrocarbon_capacity,

		scientists, scientists_capacity,

		soldiers, soldiers_capacity,

		workers-workers_busy AS workers, workers AS totalworkers, workers_capacity, workers_for_maintenance

	FROM nav_planet

	WHERE id=r_fleet.planetid FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 3;

	END IF;

	t_ore := $3;

	t_hydrocarbon := $4;

	t_scientists := $5;

	t_soldiers := $6;

	t_workers := $7;

	-- if we try to load the ship with ore/hydrocarbon, check that there are enough workers

	IF $3 > 0 OR $4 > 0 THEN

		-- check that the planet has enough workers

		PERFORM 1

		FROM vw_planets

		WHERE id=r_fleet.planetid AND workers > workers_for_maintenance / 2;

		-- not found if not enough workers

		IF NOT FOUND THEN

			t_ore := LEAST(0, t_ore);

			t_hydrocarbon := LEAST(0, t_hydrocarbon);

		END IF;

	END IF;

	-- if the planet owner <> fleet owner, it is not possible to load resources (only unload)

	IF r_fleet.planet_relation < 2 THEN

		IF t_ore > 0 THEN t_ore := 0; END IF;

		IF t_hydrocarbon > 0 THEN t_hydrocarbon := 0; END IF;

		IF t_scientists > 0 THEN t_scientists := 0; END IF;

		IF t_soldiers > 0 THEN t_soldiers := 0; END IF;

		IF t_workers > 0 THEN t_workers := 0; END IF;

	END IF;

	--RAISE NOTICE 'ore: %', t_ore;

	--RAISE NOTICE 'hydro: %', t_hydrocarbon;

	-- retrieve the quantities that can be taken from either the planet or the fleet

	IF t_ore > 0 THEN

		--RAISE NOTICE 'ore(planet): %', r_planet.ore;

		t_ore := LEAST(t_ore, r_planet.ore);

	ELSE

		t_ore := -LEAST(-t_ore, r_fleet.cargo_ore);

		--RAISE NOTICE 'ore: %', t_ore;

		-- if it exceed the ore capacity, limit the quantity that will be transfered to planet

		IF r_planet.ore - t_ore > r_planet.ore_capacity THEN

			t_ore := r_planet.ore - r_planet.ore_capacity;

		END IF;

		r_fleet.cargo_ore := r_fleet.cargo_ore + t_ore;

	END IF;

	IF t_hydrocarbon > 0 THEN

		--RAISE NOTICE 'hydro(planet): %', r_planet.hydrocarbon;

		t_hydrocarbon := LEAST(t_hydrocarbon, r_planet.hydrocarbon);

	ELSE

		t_hydrocarbon := -LEAST(-t_hydrocarbon, r_fleet.cargo_hydrocarbon);

		--RAISE NOTICE 'hydro: %', t_hydrocarbon;

		-- if it exceed the hydrocarbon capacity, limit the quantity that will be transfered to planet

		IF r_planet.hydrocarbon - t_hydrocarbon > r_planet.hydrocarbon_capacity THEN

			t_hydrocarbon := r_planet.hydrocarbon - r_planet.hydrocarbon_capacity;

		END IF;

		r_fleet.cargo_hydrocarbon := r_fleet.cargo_hydrocarbon + t_hydrocarbon;

	END IF;

	IF t_scientists > 0 THEN

		t_scientists := LEAST(t_scientists, r_planet.scientists);

	ELSE

		t_scientists := -LEAST(-t_scientists, r_fleet.cargo_scientists);

		-- if it exceed the scientists capacity, limit the quantity that will be transfered to planet

		IF r_planet.scientists - t_scientists > r_planet.scientists_capacity THEN

			t_scientists := r_planet.scientists - r_planet.scientists_capacity;

		END IF;

		r_fleet.cargo_scientists := r_fleet.cargo_scientists + t_scientists;

	END IF;

	IF t_soldiers > 0 THEN

		t_soldiers := LEAST(t_soldiers, r_planet.soldiers);

	ELSE

		t_soldiers := -LEAST(-t_soldiers, r_fleet.cargo_soldiers);

		-- if it exceed the soldiers capacity, limit the quantity that will be transfered to planet

		IF r_planet.soldiers - t_soldiers > r_planet.soldiers_capacity THEN

			t_soldiers := LEAST(0, r_planet.soldiers - r_planet.soldiers_capacity);

		END IF;

		r_fleet.cargo_soldiers := r_fleet.cargo_soldiers + t_soldiers;

	END IF;

	IF t_workers > 0 THEN

		IF r_planet.totalworkers - t_workers <= r_planet.workers_for_maintenance / 2 THEN

			t_workers := GREATEST(0, r_planet.totalworkers - r_planet.workers_for_maintenance / 2 -1);

		END IF;

		t_workers := LEAST(t_workers, GREATEST(0, r_planet.workers));

	ELSE

		t_workers := -LEAST(-t_workers, r_fleet.cargo_workers);

		-- if it exceed the workers capacity, limit the quantity that will be transfered to planet

		IF r_planet.totalworkers - t_workers > r_planet.workers_capacity THEN

			t_workers := r_planet.totalworkers - r_planet.workers_capacity;

		END IF;

		r_fleet.cargo_workers := r_fleet.cargo_workers + t_workers;

	END IF;

/*

	RAISE NOTICE 'id: %', $2;

	RAISE NOTICE 'ore: %', t_ore;

	RAISE NOTICE 'hydro: %', t_hydrocarbon;

*/

	-- store in "remaining_space" the remaining capacity of the fleet

	remaining_space := r_fleet.cargo_capacity - r_fleet.cargo_ore - r_fleet.cargo_hydrocarbon - r_fleet.cargo_scientists - r_fleet.cargo_soldiers - r_fleet.cargo_workers;

	--RAISE NOTICE 'cargo space: %', r_fleet.cargo_soldiers;--remaining_space;

	-- compute the maximum resources that can be loaded according to given cargo space

	IF t_ore > remaining_space THEN

		t_ore := remaining_space;

	END IF;

	IF t_ore > 0 THEN

		remaining_space := remaining_space - t_ore;

	END IF;

	--RAISE NOTICE 'cargo space: %', remaining_space;

	IF t_hydrocarbon > remaining_space THEN

		t_hydrocarbon := remaining_space;

	END IF;

	IF t_hydrocarbon > 0 THEN

		remaining_space := remaining_space - t_hydrocarbon;

	END IF;

	--RAISE NOTICE 'cargo space: %', remaining_space;

	IF t_scientists > remaining_space THEN

		t_scientists := remaining_space;

	END IF;

	IF t_scientists > 0 THEN

		remaining_space := remaining_space - t_scientists;

	END IF;

	--RAISE NOTICE 'cargo space: %', remaining_space;

	IF t_soldiers > remaining_space THEN

		t_soldiers := remaining_space;

	END IF;

	IF t_soldiers > 0 THEN

		remaining_space := remaining_space - t_soldiers;

	END IF;

	--RAISE NOTICE 'cargo space: %', remaining_space;

	IF t_workers > remaining_space THEN

		t_workers := remaining_space;

	END IF;

	IF t_workers > 0 THEN

		remaining_space := remaining_space - t_workers;

	END IF;

	--RAISE NOTICE 'cargo space: %', remaining_space;

	IF t_ore = 0 AND t_hydrocarbon = 0 AND t_scientists = 0 AND t_soldiers = 0 AND t_workers = 0 THEN

		-- no resources to move

		RETURN 4;

	END IF;

	do_report := true;

	IF r_fleet.planet_relation < 2 AND r_planet.ownerid >= 5 AND ((r_fleet.buy_ore > 0 AND t_ore < 0) OR (r_fleet.buy_hydrocarbon > 0 AND t_hydrocarbon < 0)) THEN

		price := GREATEST(0, int4(floor(-t_ore/1000.0 * r_fleet.buy_ore - t_hydrocarbon/1000.0 * r_fleet.buy_hydrocarbon)));

		UPDATE users SET credits=credits-price WHERE id=r_planet.ownerid AND credits >= price;

		IF NOT FOUND THEN

			RETURN 9;

		END IF;

		cr := sp_apply_tax(r_fleet.ownerid, price);

		UPDATE users SET credits=credits+cr WHERE id=r_fleet.ownerid;

		INSERT INTO reports(ownerid, type, subtype, planetid, credits, ore, hydrocarbon, scientists, soldiers, workers)

		VALUES(r_fleet.ownerid, 5, 4, r_fleet.planetid, price, -t_ore, -t_hydrocarbon, -t_scientists, -t_soldiers, -t_workers);

		INSERT INTO reports(ownerid, type, subtype, fleetid, fleet_name, planetid, ore, hydrocarbon, scientists, soldiers, workers, userid, credits)

		VALUES(r_planet.ownerid, 5, 5, r_fleet.id, r_fleet.name, r_fleet.planetid, -t_ore, -t_hydrocarbon, -t_scientists, -t_soldiers, -t_workers, $1, price);

		do_report := false;

	END IF;

	-- transfer resources on the planet

	UPDATE nav_planet SET

		ore = ore - t_ore,

		hydrocarbon = hydrocarbon - t_hydrocarbon,

		scientists = scientists - t_scientists,

		soldiers = soldiers - t_soldiers,

		workers = workers - t_workers

	WHERE id=r_fleet.planetid;

	-- transfer resources on the fleet

	UPDATE fleets SET

		cargo_ore = cargo_ore + t_ore,

		cargo_hydrocarbon = cargo_hydrocarbon + t_hydrocarbon,

		cargo_scientists = cargo_scientists + t_scientists,

		cargo_soldiers = cargo_soldiers + t_soldiers,

		cargo_workers = cargo_workers + t_workers

	WHERE ownerid=$1 AND id=$2;

	IF do_report AND r_fleet.planet_relation < 2 AND (t_ore < 0 OR t_hydrocarbon < 0 OR t_scientists < 0 OR t_soldiers < 0 OR t_workers < 0) THEN

		INSERT INTO reports(ownerid, type, subtype, fleetid, fleet_name, planetid, ore, hydrocarbon, scientists, soldiers, workers, userid)

		VALUES(r_planet.ownerid, 5, 1, r_fleet.id, r_fleet.name, r_fleet.planetid, -t_ore, -t_hydrocarbon, -t_scientists, -t_soldiers, -t_workers, $1);

	END IF;

	PERFORM sp_update_planet_production(r_fleet.planetid);

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_transfer_resources_with_planet(integer, integer, integer, integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_transfer_resources_with_planet(integer, integer, integer, integer, integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_transfer_resources_with_planet(integer, integer, integer, integer, integer, integer, integer) IS 'Exchange resources between a planet and a fleet';


--
-- Name: sp_transfer_ships_to_fleet(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_transfer_ships_to_fleet(integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- transfer ships to a fleet

-- param1: user id

-- param2: fleet id

-- param3: ship id

-- param4: quantity

DECLARE

	ships_quantity int4;

	planet_id int4;

BEGIN

	IF $4 <= 0 THEN

		RETURN 0;

	END IF;

	-- retrieve the planetid where the fleet is and if it is not moving and not engaged in battle

	SELECT planetid INTO planet_id 

	FROM fleets 

	WHERE id=$2 AND ownerid=$1 AND action=0 /*AND NOT engaged*/;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- check that the planet belongs to the same player

	PERFORM 1

	FROM nav_planet

	WHERE id=planet_id AND ownerid=$1;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- check that the user has the researches to use this ship

	PERFORM 1

	FROM db_ships_req_research

	WHERE shipid = $3 AND required_researchid NOT IN (SELECT researchid FROM researches WHERE userid=$1 AND level >= required_researchlevel);

	IF FOUND THEN

		RETURN 3;

	END IF;

	-- retrieve the maximum quantity of ships that can be transferred from the planet

	SELECT quantity INTO ships_quantity

	FROM planet_ships

	WHERE planetid=planet_id AND shipid=$3 FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- update or delete ships from planets

	IF ships_quantity > $4 THEN

		ships_quantity := $4;

		UPDATE planet_ships SET quantity = quantity - $4 WHERE planetid=planet_id AND shipid=$3;

	ELSE

		DELETE FROM planet_ships WHERE planetid=planet_id AND shipid=$3;

	END IF;

	-- add ships to the fleet

	--UPDATE fleets_ships SET quantity = quantity + ships_quantity WHERE fleetid=$2 AND shipid=$3;

	--IF NOT FOUND THEN

	INSERT INTO fleets_ships(fleetid, shipid, quantity) VALUES($2,$3,ships_quantity);

	--END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_transfer_ships_to_fleet(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_transfer_ships_to_planet(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_transfer_ships_to_planet(integer, integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- transfer ships to a planet

-- param1: user id

-- param2: fleet id

-- param3: ship id

-- param4: quantity

DECLARE

	ships_quantity int4;

	planet_id int4;

BEGIN

	IF $4 <= 0 THEN

		RETURN 0;

	END IF;

	-- check the ship can be parked to planet

	/*PERFORM 1 FROM db_ships WHERE id=$3 AND can_be_parked;

	IF NOT FOUND THEN

		RETURN 3;

	END IF;*/

	-- retrieve the planetid where the fleet is and if it is not moving and not engaged in battle

	SELECT planetid INTO planet_id 

	FROM fleets 

	WHERE id=$2 AND ownerid=$1 AND action=0 AND NOT engaged;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- check that the planet belongs to the same player

	PERFORM id

	FROM nav_planet

	WHERE id=planet_id AND ownerid=$1;

	IF NOT FOUND THEN

		RETURN 1;

	END IF;

	-- retrieve the maximum quantity of ships that can be transferred from the fleet

	SELECT INTO ships_quantity quantity 

	FROM fleets_ships

	WHERE fleetid=$2 AND shipid=$3 FOR UPDATE;

	IF NOT FOUND THEN

		RETURN 2;

	END IF;

	-- update or delete ships from fleet

	IF ships_quantity > $4 THEN

		ships_quantity := $4;

		UPDATE fleets_ships SET quantity = quantity - $4 WHERE fleetid=$2 AND shipid=$3;

	ELSE

		DELETE FROM fleets_ships WHERE fleetid=$2 AND shipid=$3;

	END IF;

	-- add ships to the fleet

	--UPDATE fleets_ships SET quantity = quantity + ships_quantity WHERE fleetid=$2 AND shipid=$3;

	--IF NOT FOUND THEN

	INSERT INTO planet_ships(planetid, shipid, quantity) VALUES(planet_id,$3,ships_quantity);

	--END IF;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_transfer_ships_to_planet(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_transfer_ships_to_planet(integer, integer, integer, integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_transfer_ships_to_planet(integer, integer, integer, integer) IS 'transfers ships from a fleet to the planet';


--
-- Name: sp_travel_distance(integer, integer, integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_travel_distance(integer, integer, integer, integer) RETURNS double precision
    LANGUAGE plpgsql IMMUTABLE
    AS $_$-- Compute travel distance between 2 galaxy points (sector/planet)

-- Param1: Sector1

-- Param2: Planet1

-- Param3: Sector2

-- Param4: Planet2

BEGIN

	IF $1 <> $3 THEN

		-- compute travel distance between the 2 sectors

		RETURN 6*sqrt(( ($1-1)/10 - ($3-1)/10 )^2 + ( ($1-1)%10 - ($3-1)%10 )^2);

	ELSE

		-- compute travel distance between the 2 planets

		-- distance between 0 (min) and around 5.65 (max)

		RETURN sqrt(( ($2-1)/5 - ($4-1)/5 )^2 + ( ($2-1)%5 - ($4-1)%5 )^2);

	END IF;

END;$_$;


ALTER FUNCTION static.sp_travel_distance(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_update_fleet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_fleet(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Update fleets cargo capacity, signature, number of ships, max speed 

-- and if it is attackonsight (fleets of only cargo are defensive only)

-- Param1: fleet id

DECLARE

	FleetExists bool;

BEGIN

	FleetExists := sp_update_fleet_stats($1);

	-- Update the fleet before trying to delete it so that constraints are checked

	IF FleetExists THEN

		PERFORM sp_update_fleet_bonus($1);

	END IF;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_update_fleet(integer) OWNER TO exileng;

--
-- Name: sp_update_fleet_bonus(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_fleet_bonus(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- param1: Fleetid

DECLARE

	r_mod record;

	r_user record;

	r_fleet record;

BEGIN

	SELECT INTO r_fleet ownerid, commanderid, size-leadership AS size FROM fleets WHERE id=$1;

	IF NOT FOUND THEN

		RETURN FALSE;

	END IF;

	-- special ships bonus

	SELECT INTO r_mod

		float8_mult(1.0 + mod_speed) AS speed,

		float8_mult(1.0 + mod_shield) AS shield,

		float8_mult(1.0 + mod_handling) AS handling,

		float8_mult(1.0 + mod_tracking_speed) AS tracking_speed,

		float8_mult(1.0 + mod_damage) AS damage,

		float8_mult(1.0 + mod_signature) AS signature,

		float8_mult(1.0 + mod_recycling) AS recycling

	FROM fleets_ships

		INNER JOIN db_ships ON db_ships.id=fleets_ships.shipid

	WHERE fleetid=$1;

	-- user research bonus

	SELECT INTO r_user

		mod_fleet_speed,

		mod_fleet_shield,

		mod_fleet_handling,

		mod_fleet_tracking_speed,

		mod_fleet_damage,

		mod_fleet_signature,

		mod_recycling

	FROM users

	WHERE id=r_fleet.ownerid;

	-- commander bonus if any is assigned

	IF r_fleet.commanderid IS NOT NULL THEN

		SELECT INTO r_user

			r_user.mod_fleet_speed * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_speed) AS mod_fleet_speed,

			r_user.mod_fleet_shield * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_shield) AS mod_fleet_shield,

			r_user.mod_fleet_handling * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_handling) AS mod_fleet_handling,

			r_user.mod_fleet_tracking_speed * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_tracking_speed) AS mod_fleet_tracking_speed,

			r_user.mod_fleet_damage * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_damage) AS mod_fleet_damage,

			r_user.mod_fleet_signature * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_fleet_signature) AS mod_fleet_signature,

			r_user.mod_recycling * sp_commander_fleet_bonus_efficiency(r_fleet.size, mod_recycling) AS mod_recycling

		FROM commanders

		WHERE id=r_fleet.commanderid;

	END IF;

	UPDATE fleets SET

		mod_speed = 100*r_mod.speed*r_user.mod_fleet_speed,

		mod_shield = 100*r_mod.shield*r_user.mod_fleet_shield,

		mod_handling = 100*r_mod.handling*r_user.mod_fleet_handling,

		mod_tracking_speed = 100*r_mod.tracking_speed*r_user.mod_fleet_tracking_speed,

		mod_damage = 100*r_mod.damage*r_user.mod_fleet_damage,

		mod_recycling = r_mod.recycling*r_user.mod_recycling,

		mod_signature = r_mod.signature*r_user.mod_fleet_signature,

		signature = int4(real_signature/(r_mod.signature*r_user.mod_fleet_signature))

	WHERE id = $1;

	RETURN TRUE;

END;$_$;


ALTER FUNCTION static.sp_update_fleet_bonus(integer) OWNER TO exileng;

--
-- Name: sp_update_fleet_stats(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_fleet_stats(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$-- Param1: FleetId

DECLARE

	rec record;

BEGIN

	-- action 10 prevents update of the fleet stats (mainly used in merge)

	PERFORM 1 FROM fleets WHERE id=$1 AND action<>10;

	IF NOT FOUND THEN

		RETURN FALSE;

	END IF;

	SELECT INTO rec

		COALESCE(sum(int8(db_ships.weapon_ammo)*int8(db_ships.weapon_turrets)*int8(db_ships.weapon_power)), 0) as firepower,

		COALESCE(sum(int8(db_ships.capacity)*int8(fleets_ships.quantity)), 0) as capacity,

		COALESCE(sum(db_ships.signature*fleets_ships.quantity), 0) as signature,

		COALESCE(sum(CASE WHEN db_ships.weapon_power > 0 THEN int8(db_ships.signature)*int8(fleets_ships.quantity) ELSE 0 END), 0) as military_signature,

		COALESCE(sum(db_ships.recycler_output*fleets_ships.quantity), 0) as recycler_output,

		COALESCE(sum(db_ships.droppods*fleets_ships.quantity), 0) as droppods,

		COALESCE(sum(db_ships.long_distance_capacity*fleets_ships.quantity), 0) as long_distance_capacity,

		COALESCE(sum(fleets_ships.quantity), 0) as count,

		COALESCE(min(speed), 0) as speed,

		COALESCE(int8(sum(int8(cost_ore)*quantity)*const_value_ore() + sum(int8(cost_hydrocarbon)*quantity)*const_value_hydrocarbon() + sum(int8(cost_credits)*quantity) + sum(int8(crew)*quantity)*const_value_crew()), 0) as score,

		COALESCE(sum(int8(db_ships.upkeep)*fleets_ships.quantity), 0) as upkeep,

		COALESCE(max(required_vortex_strength), 0) as required_vortex_strength,

		COALESCE(sum(db_ships.leadership*fleets_ships.quantity), 0) AS leadership

	FROM fleets_ships

		INNER JOIN db_ships ON (fleets_ships.shipid = db_ships.id)

	WHERE fleets_ships.fleetid = $1;

	UPDATE fleets SET

		cargo_capacity = int4(rec.capacity),

		signature = int4(rec.signature*mod_signature),

		military_signature = rec.military_signature,

		real_signature = rec.signature,

		size = rec.count,

		speed = rec.speed,

		attackonsight = attackonsight AND rec.firepower > 0,

		firepower = rec.firepower,

		recycler_output = rec.recycler_output,

		droppods = rec.droppods,

		long_distance_capacity = rec.long_distance_capacity,

		score = rec.score,

		upkeep = rec.upkeep,

		required_vortex_strength = rec.required_vortex_strength,

		leadership = rec.leadership

	WHERE id = $1;

	IF rec.count = 0 THEN

		DELETE FROM fleets WHERE id = $1;

	END IF;

	RETURN rec.count > 0;

END;$_$;


ALTER FUNCTION static.sp_update_fleet_stats(integer) OWNER TO exileng;

--
-- Name: sp_update_fleets_recycler_percent(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_fleets_recycler_percent(_planetid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_fleets record;

BEGIN

	-- retrieve total recycling capacity of fleets orbiting this _planetid

	SELECT INTO r_fleets sum(recycler_output) as total_recyclers_output

	FROM fleets

	WHERE planetid=_planetid AND action=2;

	UPDATE fleets SET

		recycler_percent = 1.0 * recycler_output / r_fleets.total_recyclers_output

	WHERE planetid=_planetid AND action=2;

	RETURN;

END;$$;


ALTER FUNCTION static.sp_update_fleets_recycler_percent(_planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_update_fleets_recycler_percent(_planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_update_fleets_recycler_percent(_planetid integer) IS 'Update the recycling capacity of fleets orbiting a resource point';


--
-- Name: sp_update_planet(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_planet(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- update planet data

-- param1: planet id

DECLARE

	r_pending record;

	r_pending_ship record;

	r_commander record;

	r_buildings record;

	r_research record;

	r_planet record;

	r_energy_received record;

	r_energy_sent record;

	b_production_ore real;

	b_production_hydrocarbon real;

	b_production_energy real;

	b_production_workers real;

	b_building_construction_speed real;

	b_ship_construction_speed real;

	b_research_effectiveness real;

	mod_energy float;

	energy_produced int4;

	energy_used int4;

BEGIN

	SELECT INTO r_planet

		ownerid,

		commanderid,

		int8(LEAST(energy + (energy_production-energy_consumption) * date_part('epoch', now()-production_lastupdate)/3600.0, energy_capacity)) AS energy,

		pct_ore,

		pct_hydrocarbon

	FROM nav_planet

	WHERE id=$1 AND NOT production_frozen;

	IF NOT FOUND THEN

		--RAISE NOTICE 'sp_update_planet : planet % not found', $1;

		RETURN;

	END IF;

	-- compute how much floor, space, energy is used by buildings being built

	SELECT INTO r_pending

		COALESCE( sum( CASE WHEN floor > 0 THEN floor ELSE 0 END ), 0) AS floor,

		COALESCE( sum( CASE WHEN space > 0 THEN space ELSE 0 END ), 0) AS space,

		COALESCE( sum( energy_consumption ), 0) AS energy_consumption,

		COALESCE( sum( workers ), 0) AS workers,

		COALESCE( sum(cost_ore)*const_value_ore() + sum(cost_hydrocarbon)*const_value_hydrocarbon() + sum(cost_credits), 0) AS score

	FROM planet_buildings_pending

		LEFT JOIN db_buildings ON (planet_buildings_pending.buildingid = db_buildings.id)

	WHERE planet_buildings_pending.planetid=$1;

	-- how many workers and energy is used by ships being built

	SELECT INTO r_pending_ship

		COALESCE( sum( workers ), 0) AS workers

	FROM planet_ships_pending

		LEFT JOIN db_ships ON (planet_ships_pending.shipid = db_ships.id)

	WHERE planet_ships_pending.planetid=$1 AND NOT end_time IS NULL;

	-- compute how much floor, space, energy is used by buildings and

	-- capacities of ore, hydrocarbon, energy and workers and

	-- production of ore, hydrocarbon and energy

	-- retrieve also the buildings mods (bonus)

	SELECT INTO r_buildings

		COALESCE( sum( cost_ore*quantity)*const_value_ore() + sum(cost_hydrocarbon*quantity)*const_value_hydrocarbon(), 0) AS score,

		COALESCE( sum( CASE WHEN destroy_datetime IS NOT NULL THEN workers / 2 ELSE 0 END ), 0) AS busy_workers, -- when destroying a building, half the workers are needed

		COALESCE( sum( quantity * CASE WHEN floor > 0 THEN floor ELSE 0 END ), 0) AS floor,

		COALESCE( sum( quantity * CASE WHEN space > 0 THEN space ELSE 0 END ), 0) AS space,

		COALESCE( sum( quantity * CASE WHEN floor < 0 THEN -floor ELSE 0 END ), 0) AS floor_bonus,

		COALESCE( sum( quantity * CASE WHEN space < 0 THEN -space ELSE 0 END ), 0) AS space_bonus,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_ore ), 0) AS storage_ore,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_hydrocarbon ), 0) AS storage_hydrocarbon,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_energy ), 0) AS storage_energy,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_workers ), 0) AS storage_workers,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_scientists ), 0) AS storage_scientists,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * storage_soldiers ), 0) AS storage_soldiers,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * energy_production ), 0) AS energy_production,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * production_ore * CASE WHEN use_planet_production_pct THEN r_planet.pct_ore/100.0 ELSE 1 END), 0) AS production_ore,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * production_hydrocarbon * CASE WHEN use_planet_production_pct THEN r_planet.pct_hydrocarbon/100.0 ELSE 1 END), 0) AS production_hydrocarbon,

		COALESCE( sum( sp_factor(consumption_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled*0.95)) * energy_consumption ), 0) AS energy_consumption,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_production_ore ) AS mod_production_ore,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_production_hydrocarbon ) AS mod_production_hydrocarbon,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_production_energy ) AS mod_production_energy,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_production_workers ) AS mod_production_workers,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_construction_speed_buildings ) AS mod_construction_speed_buildings,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_construction_speed_ships ) AS mod_construction_speed_ships,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_research_effectiveness ) AS mod_research_effectiveness,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * radar_strength ), 0) AS radar_strength,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * radar_jamming ), 0) AS radar_jamming,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled*0.95) * workers * maintenance_factor ), 0)/100 AS maintenanceworkers,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled*0.95) * workers * security_factor ), 0)/100 AS securitysoldiers,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * training_scientists ), 0) AS training_scientists,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * training_soldiers ), 0) AS training_soldiers,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * sandworm_activity ), 0) AS sandworm_activity,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * seismic_activity ), 0) AS seismic_activity,

		COALESCE( max( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * vortex_strength ), 0) AS vortex_strength,

		COALESCE( min( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * vortex_strength ), 0) AS vortex_jammer,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * production_credits ), 0) AS production_credits,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * production_credits_random ), 0) AS production_credits_random,

		COALESCE( sum( sp_factor(production_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled)) * production_prestige ), 0) AS production_prestige,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * energy_receive_antennas ), 0) AS energy_receive_antennas,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * energy_send_antennas ), 0) AS energy_send_antennas,

		COALESCE( sum( sp_factor(consumption_exp_per_building, GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled*0.95)) * upkeep ), 0) AS upkeep,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_planet_need_ore ) AS mod_planet_need_ore,

		float8_mult( 1.0 + GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * mod_planet_need_hydrocarbon ) AS mod_planet_need_hydrocarbon,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * bonus_planet_need_ore ), 0) AS bonus_planet_need_ore,

		COALESCE( sum( GREATEST(0, CASE WHEN destroy_datetime IS NULL OR active_when_destroying THEN quantity ELSE quantity-1 END - disabled) * bonus_planet_need_hydrocarbon ), 0) AS bonus_planet_need_hydrocarbon

	FROM planet_buildings

		INNER JOIN db_buildings ON (planet_buildings.buildingid = db_buildings.id)

	WHERE planet_buildings.planetid=$1;

	-- retrieve energy received from other planets

	SELECT INTO r_energy_received

		COALESCE(sum(effective_energy), 0) as quantity

	FROM planet_energy_transfer

	WHERE target_planetid=$1 AND enabled;

	-- retrieve energy sent to other planets

	SELECT INTO r_energy_sent

		COALESCE(sum(energy), 0) as quantity

	FROM planet_energy_transfer

	WHERE planetid=$1 AND enabled;

	-- retrieve commander bonus

	SELECT INTO r_commander

		mod_production_ore,

		mod_production_hydrocarbon,

		mod_production_energy,

		mod_production_workers,

		mod_construction_speed_buildings,

		mod_construction_speed_ships,

		mod_research_effectiveness

	FROM commanders

	WHERE id=r_planet.commanderid;

	IF NOT FOUND THEN

		r_commander.mod_production_ore := 1.0;

		r_commander.mod_production_hydrocarbon := 1.0;

		r_commander.mod_production_energy := 1.0;

		r_commander.mod_production_workers := 1.0;

		r_commander.mod_construction_speed_buildings := 1.0;

		r_commander.mod_construction_speed_ships := 1.0;

		r_commander.mod_research_effectiveness := 1.0;

	END IF;

	-- retrieve research modifiers

	SELECT INTO r_research

		mod_production_ore,

		mod_production_hydrocarbon,

		mod_production_energy,

		mod_production_workers,

		mod_construction_speed_buildings,

		mod_construction_speed_ships,

		mod_research_effectiveness,

		mod_planet_need_ore,

		mod_planet_need_hydrocarbon

	FROM users

	WHERE id=r_planet.ownerid;

	IF NOT FOUND THEN

		r_research.mod_production_ore := 1.0;

		r_research.mod_production_hydrocarbon := 1.0;

		r_research.mod_production_energy := 1.0;

		r_research.mod_production_workers := 1.0;

		r_research.mod_construction_speed_buildings := 1.0;

		r_research.mod_construction_speed_ships := 1.0;

		r_research.mod_research_effectiveness := 1.0;

		r_research.mod_planet_need_ore := 1.0;

		r_research.mod_planet_need_hydrocarbon := 1.0;

	END IF;

	-- compute energy bonus

	b_production_energy := r_commander.mod_production_energy * r_research.mod_production_energy * r_buildings.mod_production_energy;

	energy_produced := int4(r_buildings.energy_production * b_production_energy + r_energy_received.quantity);

	energy_used := int4(r_pending.energy_consumption + r_buildings.energy_consumption + r_energy_sent.quantity);

	IF r_planet.energy <= 100 THEN

		IF energy_used > energy_produced AND r_energy_sent.quantity > 0 THEN

			UPDATE planet_energy_transfer SET

				enabled = false

			WHERE planetid=$1 AND target_planetid=(SELECT target_planetid FROM planet_energy_transfer WHERE planetid=$1 AND enabled ORDER BY activation_datetime DESC LIMIT 1);

			PERFORM sp_update_planet($1);

			RETURN;

		END IF;

	END IF;

	-- compute a modifier according to energy, if not enough energy is produced then production is reduced

	IF (energy_produced = energy_used) OR (r_planet.energy > 100) THEN

		mod_energy := 1.0;	-- it can be 0 prod and 0 usage

	ELSE

		mod_energy := 1.0 * energy_produced / GREATEST(energy_used, 1);

	END IF;

	IF mod_energy > 1.0 THEN

		mod_energy := 1.0;

	ELSEIF mod_energy < 0.001 THEN

		mod_energy := 0.001;

	END IF;

	-- compute bonus to apply to the planet

	b_production_ore := COALESCE(mod_energy * r_research.mod_production_ore * r_buildings.mod_production_ore * r_commander.mod_production_ore, 1.0);

	b_production_hydrocarbon := COALESCE(mod_energy * r_buildings.mod_production_hydrocarbon * r_research.mod_production_hydrocarbon * r_commander.mod_production_hydrocarbon, 1.0);

	b_production_workers := COALESCE(mod_energy * GREATEST(5, 10*r_research.mod_production_workers * r_buildings.mod_production_workers * r_commander.mod_production_workers), 1.0);

	IF mod_energy < 1.0 THEN

		-- constructions and research get a bigger malus when lacking energy : -10% at least

		mod_energy := GREATEST(mod_energy - 0.1, 0.001);

	END IF;

	b_building_construction_speed := COALESCE(GREATEST(mod_energy * r_buildings.mod_construction_speed_buildings * r_research.mod_construction_speed_buildings * r_commander.mod_construction_speed_buildings, 1.0), 1.0);

	b_ship_construction_speed := COALESCE(GREATEST(mod_energy * r_buildings.mod_construction_speed_ships * r_research.mod_construction_speed_ships * r_commander.mod_construction_speed_ships, 1.0), 1.0);

	b_research_effectiveness := COALESCE(GREATEST(mod_energy * r_buildings.mod_research_effectiveness * r_research.mod_research_effectiveness * r_commander.mod_research_effectiveness, 1.0), 1.0);

	IF NOT sp_update_planet_production($1) THEN

		RETURN;

	END IF;

	-- update planet capacities

	UPDATE nav_planet SET

		ore_capacity = r_buildings.storage_ore,

		hydrocarbon_capacity = r_buildings.storage_hydrocarbon,

		energy_capacity = r_buildings.storage_energy,

		workers_capacity = r_buildings.storage_workers,

		workers_busy = r_pending.workers + r_pending_ship.workers + r_buildings.busy_workers,

		production_percent = GREATEST(0, LEAST(1.1, 1.0*workers / GREATEST(1.0,r_buildings.maintenanceworkers)-buildings_dilapidation/10000.0)),

		ore_production_raw = int4(r_buildings.production_ore),

		hydrocarbon_production_raw = int4(r_buildings.production_hydrocarbon),

		ore_production= int4(GREATEST(0, LEAST(1.1, 1.0*workers / GREATEST(1.0,r_buildings.maintenanceworkers)-buildings_dilapidation/10000.0)) * r_buildings.production_ore * b_production_ore),

		hydrocarbon_production= int4(GREATEST(0, LEAST(1.1, 1.0*workers / GREATEST(1.0,r_buildings.maintenanceworkers)-buildings_dilapidation/10000.0)) * r_buildings.production_hydrocarbon * b_production_hydrocarbon),

		energy_consumption = energy_used,

		energy_production = energy_produced,

		mod_production_ore = 100*b_production_ore,

		mod_production_hydrocarbon = 100*b_production_hydrocarbon,

		mod_production_energy = 100*b_production_energy,

		mod_production_workers = CASE WHEN recruit_workers THEN b_production_workers ELSE 0 END,

		mod_construction_speed_buildings = 100*b_building_construction_speed,

		mod_construction_speed_ships = 100*b_ship_construction_speed,

		mod_research_effectiveness = 1000*b_research_effectiveness,

		floor_occupied = r_pending.floor + r_buildings.floor,

		space_occupied = r_pending.space + r_buildings.space,

		floor = planet_floor + int2(r_buildings.floor_bonus),

		space = planet_space + int2(r_buildings.space_bonus),

		scientists_capacity = r_buildings.storage_scientists,

		soldiers_capacity = r_buildings.storage_soldiers,

		radar_strength = GREATEST(0, int4(mod_energy*r_buildings.radar_strength)),

		radar_jamming = int4(mod_energy*r_buildings.radar_jamming),

		score = int8(r_buildings.score + r_pending.score),

		workers_for_maintenance = r_buildings.maintenanceworkers,

		soldiers_for_security = r_buildings.securitysoldiers,

		training_scientists = r_buildings.training_scientists,

		training_soldiers = r_buildings.training_soldiers,

		sandworm_activity = r_buildings.sandworm_activity,

		seismic_activity = r_buildings.seismic_activity,

		credits_production = int4(mod_energy * r_buildings.production_credits/24.0),

		credits_random_production = int4(mod_energy * r_buildings.production_credits_random/24.0),

		production_prestige = r_buildings.production_prestige,

		energy_receive_antennas = r_buildings.energy_receive_antennas,

		energy_send_antennas = r_buildings.energy_send_antennas,

		upkeep = r_buildings.upkeep,

		vortex_strength = planet_vortex_strength + r_buildings.vortex_strength + LEAST(0, r_buildings.vortex_jammer),

		next_planet_update = CASE WHEN energy > 0 AND energy_used > energy_produced THEN now() + 1.0*energy / (energy_used - energy_produced) * INTERVAL '1 hour' ELSE Null END,

		planet_need_ore = LEAST(500000, (LEAST(2.0, r_research.mod_planet_need_ore) * r_buildings.bonus_planet_need_ore * GREATEST(0, r_buildings.mod_planet_need_ore))::integer),

		planet_need_hydrocarbon = LEAST(500000, (LEAST(2.0, r_research.mod_planet_need_ore) * r_buildings.bonus_planet_need_hydrocarbon * GREATEST(0, r_buildings.mod_planet_need_hydrocarbon))::integer)

	WHERE id=$1;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_update_planet(integer) OWNER TO exileng;

--
-- Name: sp_update_planet_buildings_construction(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_planet_buildings_construction(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: PlanetId

DECLARE

	total_time int4;

	r_pending planet_buildings_pending;

	pct float8;

BEGIN

	-- when a buildings speed bonus change, construction times have to be recalculated

	-- update buildings construction time

	FOR r_pending IN

		SELECT * FROM planet_buildings_pending WHERE planetid=$1 FOR UPDATE

	LOOP

		-- compute percentage of building done

		IF r_pending.end_time > r_pending.start_time THEN

			pct := date_part('epoch', r_pending.end_time - now()) / date_part('epoch', r_pending.end_time - r_pending.start_time);

		ELSE

			pct := 1;

		END IF;

		-- retrieve building time

		SELECT INTO total_time int4(construction_time)

		FROM vw_buildings WHERE planetid=$1 AND id=r_pending.buildingid;

		UPDATE planet_buildings_pending SET start_time=now()-((1-pct)*total_time*INTERVAL '1 second'), end_time = now() + pct*total_time*INTERVAL '1 second' WHERE id=r_pending.id;

	END LOOP;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_update_planet_buildings_construction(integer) OWNER TO exileng;

--
-- Name: sp_update_planet_production(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_planet_production(_planetid integer) RETURNS boolean
    LANGUAGE plpgsql STRICT
    AS $$-- Param1: PlanetId

BEGIN

	--RAISE NOTICE '%', _planetid;

	UPDATE nav_planet SET

		ore = int4(LEAST(ore + ore_production * date_part('epoch', now()-production_lastupdate)/3600.0, ore_capacity)),

		hydrocarbon = int4(LEAST(hydrocarbon + hydrocarbon_production * date_part('epoch', now()-production_lastupdate)/3600.0, hydrocarbon_capacity)),

		energy = int4(GREATEST(0, LEAST(energy + (energy_production-energy_consumption) * date_part('epoch', now()-production_lastupdate)/3600.0, energy_capacity))),

		workers = int4(LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity)),

		production_percent = GREATEST(0, LEAST(1.1, 1.0* int4(LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity)) / GREATEST(1.0,workers_for_maintenance)-buildings_dilapidation/10000.0)),

		ore_production = int4(GREATEST(0, LEAST(1.1, 1.0* int4(LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity)) / GREATEST(1.0,workers_for_maintenance)-buildings_dilapidation/10000.0)) * ore_production_raw * mod_production_ore / 100.0),

		hydrocarbon_production = int4(GREATEST(0, LEAST(1.1, 1.0* int4(LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity)) / GREATEST(1.0,workers_for_maintenance)-buildings_dilapidation/10000.0)) * hydrocarbon_production_raw * mod_production_hydrocarbon / 100.0),

		previous_buildings_dilapidation = buildings_dilapidation,

		planet_stock_ore = int4(GREATEST(const_planet_market_stock_min(), LEAST(const_planet_market_stock_max(), planet_stock_ore - planet_need_ore * date_part('epoch', now()-production_lastupdate)/3600.0))),

		planet_stock_hydrocarbon = int4(GREATEST(const_planet_market_stock_min(), LEAST(const_planet_market_stock_max(), planet_stock_hydrocarbon - planet_need_hydrocarbon * date_part('epoch', now()-production_lastupdate)/3600.0))),

		production_lastupdate = now()

	WHERE id=_planetid AND not production_frozen;

	IF NOT FOUND THEN

		-- planet not found or likely to be frozen

		RETURN false;

	END IF;

	RETURN TRUE;

END;$$;


ALTER FUNCTION static.sp_update_planet_production(_planetid integer) OWNER TO exileng;

--
-- Name: sp_update_planet_ships_construction(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_planet_ships_construction(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: PlanetId

DECLARE

	total_time int4;

	r_pending record;

	pct float8;

BEGIN

	-- update buildings construction time

	FOR r_pending IN

		SELECT id, shipid, start_time, end_time, remaining_time

		FROM vw_ships_under_construction

		WHERE planetid=$1 AND end_time IS NOT NULL

	LOOP

		-- compute percentage of research done

		pct := date_part('epoch', r_pending.end_time - now()) / date_part('epoch', r_pending.end_time - r_pending.start_time);

		-- retrieve building time

		SELECT INTO total_time int4(construction_time)

		FROM vw_ships WHERE planetid=$1 AND id=r_pending.shipid;

		UPDATE planet_ships_pending SET start_time=now()-((1-pct)*total_time*INTERVAL '1 second'), end_time = now() + pct*total_time*INTERVAL '1 second' WHERE id=r_pending.id;

	END LOOP;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_update_planet_ships_construction(integer) OWNER TO exileng;

--
-- Name: sp_update_player(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_player(_userid integer, _hour integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Update player planets conditions

-- Param1: UserId

-- Param2: Hour

DECLARE

	r_commanders record;

	r_fleets record;

	r_fleets_in_position record; -- fleets near enemy planets

	r_ships_parked record;

	r_planets record;

	r_research record;

	r_user record;

BEGIN

	-- set dilapidation to -1 if was set to 0 to prevent updates of the planet

	UPDATE nav_planet SET

		buildings_dilapidation = -1

	WHERE ownerid = $1 AND buildings_dilapidation = 0;

	-- "damage"/"repair" buildings

	UPDATE nav_planet SET

		buildings_dilapidation = LEAST(10000, workers_for_maintenance, GREATEST(0, buildings_dilapidation + int4((100.0*(workers_for_maintenance- LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity) ))/workers_for_maintenance) ) )

	WHERE ownerid = $1 AND workers_for_maintenance > 0 AND ((LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity) < workers_for_maintenance) OR (LEAST(workers * power(1.0+mod_production_workers/1000.0, LEAST(date_part('epoch', now()-production_lastupdate)/3600.0, 1500)), workers_capacity) > workers_for_maintenance AND buildings_dilapidation > 0));

	-- update planet production

	PERFORM sp_update_planet_production(id)

	FROM nav_planet

	WHERE ownerid = $1 AND buildings_dilapidation >= 0 AND previous_buildings_dilapidation <> buildings_dilapidation;

	-- update mood/control on players planets

	UPDATE nav_planet SET

		mood=LEAST(120, GREATEST(0, mood + CASE WHEN soldiers > 0 AND soldiers*250 >= workers + scientists THEN 2 ELSE -1 END + CASE WHEN commanderid IS NOT NULL THEN 1 ELSE 0 END) )

	WHERE ownerid = $1;

	-- upkeep

	-- upkeep of ships_parked

	SELECT INTO r_ships_parked

		COALESCE(sum(db_ships.upkeep*quantity), 0) AS upkeep

	FROM planet_ships

		INNER JOIN nav_planet ON nav_planet.id = planet_ships.planetid

		INNER JOIN db_ships ON db_ships.id = planet_ships.shipid

	WHERE ownerid=$1;

	-- upkeep of fleets

	SELECT INTO r_fleets

		COALESCE(sum(cargo_scientists), 0) AS scientists,

		COALESCE(sum(cargo_soldiers), 0) AS soldiers,

		COALESCE(sum(fleets.upkeep), 0) AS upkeep

	FROM fleets

		LEFT JOIN nav_planet ON (nav_planet.id = fleets.planetid AND fleets.dest_planetid IS NULL)

	WHERE fleets.ownerid=$1 AND (nav_planet.ownerid IS NULL OR nav_planet.ownerid=$1 OR EXISTS(SELECT 1 FROM vw_friends WHERE userid=$1 AND friend=nav_planet.ownerid) );

	-- upkeep of fleets in position near enemy planets

	SELECT INTO r_fleets_in_position

		COALESCE(sum(cargo_scientists), 0) AS scientists,

		COALESCE(sum(cargo_soldiers), 0) AS soldiers,

		COALESCE(sum(fleets.upkeep), 0) AS upkeep

	FROM fleets

		LEFT JOIN nav_planet ON (nav_planet.id = fleets.planetid AND fleets.dest_planetid IS NULL)

	WHERE fleets.ownerid=$1 AND nav_planet.ownerid IS NOT NULL AND nav_planet.ownerid <> $1 AND nav_planet.floor > 0 AND NOT EXISTS(SELECT 1 FROM vw_friends WHERE userid=$1 AND friend=nav_planet.ownerid);

	-- upkeep of planets

	SELECT INTO r_planets

		COALESCE(sum(scientists), 0) AS scientists,

		COALESCE(sum(soldiers), 0) AS soldiers,

		count(*) AS count,

		sum(upkeep) as upkeep

	FROM nav_planet

	WHERE ownerid=$1 AND planet_floor > 0;

	-- upkeep of commanders

	SELECT INTO r_commanders

		COALESCE(sum(salary), 0) AS salary

	FROM commanders

	WHERE ownerid=$1 AND recruited <= NOW();

	UPDATE users SET

		commanders_loyalty = LEAST(100, commanders_loyalty + 1),

		upkeep_commanders = upkeep_commanders + r_commanders.salary * mod_upkeep_commanders_cost/24.0,

		upkeep_scientists = upkeep_scientists + (r_fleets.scientists + r_fleets_in_position.scientists + r_planets.scientists) * const_upkeep_scientists() * mod_upkeep_scientists_cost/24.0,

		upkeep_soldiers = upkeep_soldiers + (r_fleets.soldiers + r_fleets_in_position.soldiers + r_planets.soldiers) * const_upkeep_soldiers() * mod_upkeep_soldiers_cost/24.0,

		upkeep_ships = upkeep_ships + r_fleets.upkeep * const_upkeep_ships() * mod_upkeep_ships_cost/24.0,

		upkeep_ships_in_position = upkeep_ships_in_position + r_fleets_in_position.upkeep * const_upkeep_ships_in_position() * mod_upkeep_ships_cost/24.0,

		upkeep_ships_parked = upkeep_ships_parked + r_ships_parked.upkeep * const_upkeep_ships_parked() * mod_upkeep_ships_cost/24.0,

		upkeep_planets = upkeep_planets + r_planets.upkeep * mod_upkeep_planets_cost/24.0

	WHERE id=$1;

	IF _hour = 0 THEN

		UPDATE users SET

			production_prestige = COALESCE((SELECT sum(production_prestige) FROM nav_planet WHERE ownerid=users.id), 0)

		WHERE id=$1;

		SELECT INTO r_user

			upkeep_commanders,

			upkeep_planets,

			upkeep_scientists,

			upkeep_ships,

			upkeep_ships_in_position,

			upkeep_ships_parked,

			upkeep_soldiers,

			production_prestige,

			mod_prestige_from_buildings,

			credits_produced,

			score_visibility = 2 AND score_visibility_last_change < now() - INTERVAL '1 day' AS score_visible

		FROM users

		WHERE id=$1;

		UPDATE users SET

			credits = credits + credits_produced - (upkeep_commanders + upkeep_planets + upkeep_scientists + upkeep_ships + upkeep_ships_in_position + upkeep_ships_parked + upkeep_soldiers),

			upkeep_last_cost = upkeep_commanders + upkeep_planets + upkeep_scientists + upkeep_ships + upkeep_ships_in_position + upkeep_ships_parked + upkeep_soldiers,

			upkeep_commanders = 0,

			upkeep_planets = 0,

			upkeep_scientists = 0,

			upkeep_ships = 0,

			upkeep_ships_in_position = 0,

			upkeep_ships_parked = 0,

			upkeep_soldiers = 0,

			prestige_points = prestige_points + (production_prestige * mod_prestige_from_buildings)::integer,

			score_prestige = score_prestige + production_prestige,

			credits_produced = 0

		WHERE id=$1;

		r_user.production_prestige := (r_user.mod_prestige_from_buildings*r_user.production_prestige)::integer;

		-- increase r_user.production_prestige by 10% if score is visible

		IF r_user.score_visible THEN

			r_user.production_prestige := (1.1*r_user.production_prestige)::integer;

		END IF;

		INSERT INTO reports(ownerid, type, subtype, upkeep_commanders, upkeep_planets, upkeep_scientists, upkeep_ships, upkeep_ships_in_position, upkeep_ships_parked, upkeep_soldiers, credits, scientists, soldiers, data)

		VALUES($1, 3, 10, r_user.upkeep_commanders, r_user.upkeep_planets, r_user.upkeep_scientists, r_user.upkeep_ships, r_user.upkeep_ships_in_position, r_user.upkeep_ships_parked, r_user.upkeep_soldiers, r_user.upkeep_commanders + r_user.upkeep_scientists + r_user.upkeep_soldiers + r_user.upkeep_ships + r_user.upkeep_ships_in_position + r_user.upkeep_ships_parked + r_user.upkeep_planets, r_user.production_prestige, r_user.credits_produced,

		'{upkeep_commanders:' || r_user.upkeep_commanders || ',upkeep_planets:' || r_user.upkeep_planets || ',upkeep_scientists:' || r_user.upkeep_scientists || ',upkeep_soldiers:' || r_user.upkeep_soldiers || ',upkeep_ships:' || r_user.upkeep_ships || ',upkeep_ships_in_position:' || r_user.upkeep_ships_in_position || ',upkeep_ships_parked:' || r_user.upkeep_ships_parked || ',credits:' || r_user.upkeep_commanders + r_user.upkeep_scientists + r_user.upkeep_soldiers + r_user.upkeep_ships + r_user.upkeep_ships_in_position + r_user.upkeep_ships_parked + r_user.upkeep_planets || '}');

		--INSERT INTO users_expenses(userid, credits_delta, planetid, shipid, quantity)

		--VALUES(r_user.id, -count*r_ship.cost_credits, $1, $2, count);

	END IF;

	-- check bankruptcy

	SELECT INTO r_user credits, credits_bankruptcy FROM users WHERE id=$1;

	IF r_user.credits < 0 THEN

		UPDATE users SET

			credits_bankruptcy = credits_bankruptcy - 1

		WHERE id=$1 AND credits < 0;

		IF FOUND THEN

			IF r_user.credits_bankruptcy = 120 THEN

				PERFORM 1 FROM reports WHERE ownerid=$1 AND type=7 AND subtype=95 AND datetime > NOW() - INTERVAL '1 day';

				IF NOT FOUND THEN

					INSERT INTO reports(ownerid, type, subtype) VALUES($1, 7, 95);

				END IF;

			ELSEIF r_user.credits_bankruptcy = 72 THEN

				PERFORM 1 FROM reports WHERE ownerid=$1 AND type=7 AND subtype=96 AND datetime > NOW() - INTERVAL '1 day';

				IF NOT FOUND THEN

					INSERT INTO reports(ownerid, type, subtype) VALUES($1, 7, 96);

				END IF;

			ELSEIF r_user.credits_bankruptcy = 36 THEN

				PERFORM 1 FROM reports WHERE ownerid=$1 AND type=7 AND subtype=97 AND datetime > NOW() - INTERVAL '1 day';

				IF NOT FOUND THEN

					INSERT INTO reports(ownerid, type, subtype) VALUES($1, 7, 97);

				END IF;

			ELSEIF r_user.credits_bankruptcy = 24 THEN

				PERFORM 1 FROM reports WHERE ownerid=$1 AND type=7 AND subtype=98 AND datetime > NOW() - INTERVAL '1 day';

				IF NOT FOUND THEN

					INSERT INTO reports(ownerid, type, subtype) VALUES($1, 7, 98);

				END IF;

			ELSEIF r_user.credits_bankruptcy = 1 THEN

				-- player is now bankrupt, lose his planets, stop researches

				UPDATE nav_planet SET

					production_lastupdate=now(),

					ownerid=2,

					recruit_workers=true

				WHERE ownerid=$1;

				DELETE FROM researches_pending WHERE userid=$1;

			END IF;

		END IF;

	ELSE

		UPDATE users SET

			credits_bankruptcy = credits_bankruptcy + 1

		WHERE id=$1 AND credits_bankruptcy < const_hours_before_bankruptcy() ;

	END IF;

END;$_$;


ALTER FUNCTION static.sp_update_player(_userid integer, _hour integer) OWNER TO exileng;

--
-- Name: sp_update_research(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_research(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

DECLARE

	research record;

	r_pending researches_pending;

	pct float8;

BEGIN

	FOR r_pending IN

		SELECT * FROM researches_pending WHERE userid=$1

	LOOP

		-- compute percentage of research done

		pct := date_part('epoch', r_pending.end_time - now()) / date_part('epoch', r_pending.end_time - r_pending.start_time);

		-- retrieve research time

		SELECT INTO research total_time

		FROM sp_list_researches($1)

		WHERE researchid=r_pending.researchid AND researchable;

		-- if not found then no more research can be done

		IF research.total_time IS NOT NULL THEN

			UPDATE researches_pending SET start_time=now()-((1-pct)*research.total_time*INTERVAL '1 second'), end_time = now() + pct*research.total_time*INTERVAL '1 second' WHERE id=r_pending.id;

		ELSE

			DELETE FROM researches_pending WHERE id=r_pending.id;

		END IF;

	END LOOP;

	RETURN;

END;$_$;


ALTER FUNCTION static.sp_update_research(integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_update_research(integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_update_research(integer) IS 'Update a user current research time according to the new number of scientists available';


--
-- Name: sp_update_researches(integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_update_researches(_userid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$DECLARE

	r_research record;

BEGIN

	SELECT INTO r_research

		float8_mult( 1.0 + mod_production_ore * level ) AS mod_production_ore,

		float8_mult( 1.0 + mod_production_hydrocarbon * level ) AS mod_production_hydrocarbon,

		float8_mult( 1.0 + mod_production_energy * level ) AS mod_production_energy,

		float8_mult( 1.0 + mod_production_workers * level )AS mod_production_workers,

		float8_mult( 1.0 + mod_construction_speed_buildings * level ) AS mod_construction_speed_buildings,

		float8_mult( 1.0 + mod_construction_speed_ships * level ) AS mod_construction_speed_ships,

		float8_mult( 1.0 + mod_fleet_damage * level ) AS mod_fleet_damage,

		float8_mult( 1.0 + mod_fleet_speed * level ) AS mod_fleet_speed,

		float8_mult( 1.0 + mod_fleet_shield * level ) AS mod_fleet_shield,

		float8_mult( 1.0 + mod_fleet_handling * level ) AS mod_fleet_handling,

		float8_mult( 1.0 + mod_fleet_tracking_speed * level ) AS mod_fleet_tracking_speed,

		float8_mult( 1.0 + mod_fleet_energy_capacity * level ) AS mod_fleet_energy_capacity,

		float8_mult( 1.0 + mod_fleet_energy_usage * level ) AS mod_fleet_energy_usage,

		float8_mult( 1.0 + mod_fleet_signature * level ) AS mod_fleet_signature,

		float8_mult( 1.0 + mod_merchant_buy_price * level ) AS mod_merchant_buy_price,

		float8_mult( 1.0 + mod_merchant_sell_price * level ) AS mod_merchant_sell_price,

		float8_mult( 1.0 + mod_merchant_speed * level ) AS mod_merchant_speed,

		float8_mult( 1.0 + mod_upkeep_commanders_cost * level ) AS mod_upkeep_commanders_cost,

		float8_mult( 1.0 + mod_upkeep_planets_cost * level ) AS mod_upkeep_planets_cost,

		float8_mult( 1.0 + mod_upkeep_scientists_cost * level ) AS mod_upkeep_scientists_cost,

		float8_mult( 1.0 + mod_upkeep_soldiers_cost * level ) AS mod_upkeep_soldiers_cost,

		float8_mult( 1.0 + mod_upkeep_ships_cost * level ) AS mod_upkeep_ships_cost,

		float8_mult( 1.0 + mod_research_cost * level ) AS mod_research_cost,

		float8_mult( 1.0 + mod_research_time * level ) AS mod_research_time,

		float8_mult( 1.0 + mod_recycling * level ) AS mod_recycling,

		COALESCE( sum( mod_planets * level ), 0) AS mod_planets,

		COALESCE( sum( mod_commanders * level ), 0) AS mod_commanders,

		float8_mult( 1.0 + mod_research_effectiveness * level ) AS mod_research_effectiveness,

		float8_mult( 1.0 + mod_energy_transfer_effectiveness * level ) AS mod_energy_transfer_effectiveness,

		float8_mult( 1.0 + mod_prestige_from_buildings * level ) AS mod_prestige_from_buildings,

		float8_mult( 1.0 + mod_prestige_from_ships * level ) AS mod_prestige_from_ships,

		float8_mult( 1.0 + mod_planet_need_ore * level ) AS mod_planet_need_ore,

		float8_mult( 1.0 + mod_planet_need_hydrocarbon * level ) AS mod_planet_need_hydrocarbon,

		float8_mult( 1.0 + modf_bounty * level ) AS modf_bounty

	FROM researches

		INNER JOIN db_research ON (researches.researchid = db_research.id)

	WHERE userid = _userid;

	UPDATE users SET

		mod_production_ore = r_research.mod_production_ore,

		mod_production_hydrocarbon = r_research.mod_production_hydrocarbon,

		mod_production_energy = r_research.mod_production_energy,

		mod_production_workers = r_research.mod_production_workers,

		mod_construction_speed_buildings = r_research.mod_construction_speed_buildings,

		mod_construction_speed_ships = r_research.mod_construction_speed_ships,

		mod_fleet_damage = r_research.mod_fleet_damage,

		mod_fleet_speed = r_research.mod_fleet_speed,

		mod_fleet_shield = r_research.mod_fleet_shield,

		mod_fleet_handling = r_research.mod_fleet_handling,

		mod_fleet_tracking_speed = r_research.mod_fleet_tracking_speed,

		mod_fleet_energy_capacity = r_research.mod_fleet_energy_capacity,

		mod_fleet_energy_usage = r_research.mod_fleet_energy_usage,

		mod_fleet_signature = r_research.mod_fleet_signature,

		mod_merchant_buy_price = r_research.mod_merchant_buy_price,

		mod_merchant_sell_price = r_research.mod_merchant_sell_price,

		mod_merchant_speed = r_research.mod_merchant_speed,

		mod_upkeep_commanders_cost = r_research.mod_upkeep_commanders_cost,

		mod_upkeep_planets_cost = r_research.mod_upkeep_planets_cost,

		mod_upkeep_scientists_cost = r_research.mod_upkeep_scientists_cost,

		mod_upkeep_soldiers_cost = r_research.mod_upkeep_soldiers_cost,

		mod_upkeep_ships_cost = r_research.mod_upkeep_ships_cost,

		mod_research_cost = r_research.mod_research_cost,

		mod_research_time = r_research.mod_research_time,

		mod_recycling = r_research.mod_recycling,

		mod_planets = LEAST((SELECT max_planets FROM db_security_levels WHERE id=users.security_level), r_research.mod_planets),

		mod_commanders = LEAST((SELECT max_commanders FROM db_security_levels WHERE id=users.security_level), r_research.mod_commanders),

		mod_research_effectiveness = r_research.mod_research_effectiveness,

		mod_energy_transfer_effectiveness = r_research.mod_energy_transfer_effectiveness,

		mod_prestige_from_buildings = r_research.mod_prestige_from_buildings,

		mod_prestige_from_ships = r_research.mod_prestige_from_ships,

		mod_planet_need_ore = r_research.mod_planet_need_ore,

		mod_planet_need_hydrocarbon = r_research.mod_planet_need_hydrocarbon,

		modf_bounty = r_research.modf_bounty

	WHERE id=_userid;

END;$$;


ALTER FUNCTION static.sp_update_researches(_userid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_update_researches(_userid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_update_researches(_userid integer) IS 'Update user researches modifiers';


--
-- Name: sp_users_after_leave_alliance(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_after_leave_alliance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	left_alliance bool;

BEGIN

	left_alliance := False;

	IF (TG_OP = 'DELETE') THEN

		left_alliance := true;

	ELSEIF (OLD.alliance_id IS DISTINCT FROM NEW.alliance_id) AND (OLD.alliance_id IS NOT NULL) THEN

		left_alliance := true;

	ELSEIF (OLD.alliance_rank = 0 AND NEW.alliance_rank > 0) THEN

		PERFORM sp_alliance_check_for_leader(OLD.alliance_id);

	END IF;

	IF left_alliance THEN

		-- remove user contributed combat score from alliance score_combat

		UPDATE alliances SET score_combat = score_combat - OLD.alliance_score_combat WHERE id=OLD.alliance_id;

		DELETE FROM alliances_wallet_requests WHERE allianceid=OLD.alliance_id AND userid=OLD.id;

		PERFORM sp_alliance_check_for_leader(OLD.alliance_id);

	END IF;

	RETURN OLD;

END;$$;


ALTER FUNCTION static.sp_users_after_leave_alliance() OWNER TO exileng;

--
-- Name: sp_users_before_changes(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_before_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	-- user is game over

	IF OLD.planets > 0 AND NEW.planets = 0 THEN

		-- make him leave his alliance

		NEW.alliance_id := NULL;

		-- give his fleets to a npc

		UPDATE fleets SET ownerid=2, attackonsight=false, uid=nextval('npc_fleet_uid_seq') WHERE ownerid=OLD.id;

	END IF;

	IF OLD.login <> NEW.login THEN

		DELETE FROM messages_ignore_list WHERE ignored_userid = NEW.id;

		UPDATE alliances_reports SET userid=null WHERE userid = NEW.id;

		UPDATE reports SET userid=null WHERE userid = NEW.id;

	END IF;

	-- update the player protection

	IF NEW.protection_enabled THEN

		IF NEW.protection_colonies_to_unprotect > 0 AND NEW.colonies > protection_colonies_to_unprotect THEN

			NEW.protection_enabled := false;

		END IF;

	END IF;

	-- user leaves his alliance

	IF (OLD.alliance_id IS DISTINCT FROM NEW.alliance_id) AND (OLD.alliance_id IS NOT NULL) AND (OLD.alliance_joined IS NOT NULL) THEN

		INSERT INTO users_alliance_history(userid, alliance_tag, alliance_name, joined, "left", taxes_paid, credits_given, credits_taken)

		SELECT OLD.id, tag, name, OLD.alliance_joined, now(), OLD.alliance_taxes_paid, OLD.alliance_credits_given, OLD.alliance_credits_taken FROM alliances WHERE id=OLD.alliance_id;

		-- reset the stats, ranks .. of the player

		NEW.alliance_score_combat := 0;

		NEW.alliance_left := now() + const_interval_before_join_new_alliance();

		NEW.alliance_rank := 100;

		NEW.alliance_joined := now();

		NEW.alliance_taxes_paid := 0;

		NEW.alliance_credits_given := 0;

		NEW.alliance_credits_taken := 0;

	END IF;

	IF OLD.score_visibility <> NEW.score_visibility THEN

		NEW.score_visibility_last_change := now();

	END IF;

	IF NEW.score_visibility = 2 AND NEW.score_visibility_last_change < now() - INTERVAL '1 day' AND NEW.prestige_points - OLD.prestige_points > 0 THEN

		NEW.prestige_points := OLD.prestige_points + (1.1*(NEW.prestige_points - OLD.prestige_points))::integer;

		NEW.score_prestige := OLD.score_prestige + (1.1*(NEW.score_prestige - OLD.score_prestige))::integer;

	END IF;

	IF NEW.prestige_points_refund - OLD.prestige_points_refund > 0 THEN

		NEW.prestige_points := NEW.prestige_points + (NEW.prestige_points_refund - OLD.prestige_points_refund);

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_users_before_changes() OWNER TO exileng;

--
-- Name: sp_users_before_deletion(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_before_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	DELETE FROM commanders WHERE ownerid=OLD.id;

	DELETE FROM researches_pending WHERE userid=OLD.id;

	UPDATE nav_planet SET commanderid=null, ownerid=2 WHERE ownerid=OLD.id AND score >= 80000;

	UPDATE nav_planet SET commanderid=null, ownerid=NULL WHERE ownerid=OLD.id;

/*

	-- if it is a leader of an alliance, assign a new leader

	IF OLD.alliance_id IS NOT NULL AND OLD.alliance_rank = 0 THEN

		SELECT INTO r_user * FROM users WHERE id <> OLD.id AND alliance_id=OLD.alliance_id ORDER BY alliance_rank, alliance_joined LIMIT 1;

		IF FOUND AND r_user.alliance_rank <> 0 THEN

			-- promote this user as the new alliance leader

			UPDATE users SET

				alliance_rank = 0

			WHERE id=r_user.id AND alliance_id=OLD.alliance_id;

		END IF;

	END IF;

*/

	RETURN OLD;

END;$$;


ALTER FUNCTION static.sp_users_before_deletion() OWNER TO exileng;

--
-- Name: sp_users_bounty_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_bounty_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users_bounty SET

		bounty = bounty + NEW.bounty,

		reward_time = DEFAULT

	WHERE userid=NEW.userid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_users_bounty_before_insert() OWNER TO exileng;

--
-- Name: sp_users_expenses_before_insert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_expenses_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	r_user record;

BEGIN

	IF NEW.userid < 100 THEN

		RETURN NULL;

	END IF;

	SELECT INTO r_user credits, lastlogin FROM users WHERE id=NEW.userid;

	IF NOT FOUND THEN

		RAISE EXCEPTION 'unknown userid';

	END IF;

	IF NEW.credits IS NULL THEN

		NEW.credits := r_user.credits;

	END IF;

	NEW.login := r_user.lastlogin;

	RETURN NEW;

END;$$;


ALTER FUNCTION static.sp_users_expenses_before_insert() OWNER TO exileng;

--
-- Name: sp_users_ships_kills_beforeinsert(); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_users_ships_kills_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET

		prestige_points = prestige_points + int4(NEW.killed*(SELECT prestige_reward FROM db_ships WHERE id=NEW.shipid) * mod_prestige_from_ships),

		score_prestige = score_prestige + NEW.killed*(SELECT prestige_reward FROM db_ships WHERE id=NEW.shipid)

	WHERE id=NEW.userid;

	INSERT INTO users_bounty(userid, bounty)

	VALUES(NEW.userid, NEW.killed * (SELECT bounty FROM db_ships WHERE id=NEW.shipid));

	UPDATE users_ships_kills SET

		killed = killed + NEW.killed, 

		lost = lost + NEW.lost

	WHERE userid=NEW.userid AND shipid=NEW.shipid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION static.sp_users_ships_kills_beforeinsert() OWNER TO exileng;

--
-- Name: sp_warp_fleet(integer, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_warp_fleet(integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$-- Make a fleet use the vortex/warp gate where the fleet is

-- Param1: UserId

-- Param2: FleetId

DECLARE

	r_fleet record;

	r_planet record;

BEGIN

	-- retrieve fleet info

	SELECT INTO r_fleet

		id, name, planetid

	FROM fleets

	WHERE ownerid=$1 AND id=$2 AND action=0 AND not engaged FOR UPDATE;

	IF NOT FOUND THEN

		-- can't warp : fleet either doing something or fleet not found

		RETURN 1;

	END IF;

	-- retrieve planet info

	SELECT INTO r_planet

		id, warp_to

	FROM nav_planet

	WHERE id=r_fleet.planetid AND warp_to IS NOT NULL;

	IF NOT FOUND THEN

		-- can't warp : there is no vortex/warp gate

		RETURN 2;

	END IF;

	-- make the fleet move

	UPDATE fleets SET

		planetid=null,

		dest_planetid = r_planet.warp_to,

		action_start_time = now(),

		action_end_time = now() + INTERVAL '2 days',

		action = 1,

		idle_since = null

	WHERE ownerid=$1 AND id = $2 AND action=0 AND not engaged;

	RETURN 0;

END;$_$;


ALTER FUNCTION static.sp_warp_fleet(integer, integer) OWNER TO exileng;

--
-- Name: sp_wp_append_destruction(bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_destruction(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	-- destroy the planet where the fleet is

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action")

	VALUES(waypointid, _routeid, -1);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_destruction(_routeid bigint) OWNER TO exileng;

--
-- Name: sp_wp_append_disappear(bigint, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_disappear(_routeid bigint, _seconds integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", waittime)

	VALUES(waypointid, _routeid, 9, _seconds);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_disappear(_routeid bigint, _seconds integer) OWNER TO exileng;

--
-- Name: sp_wp_append_loadall(bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_loadall(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", ore, hydrocarbon, scientists, soldiers, workers)

	VALUES(waypointid, _routeid, 0, 99999999, 99999999, 99999999, 99999999, 99999999);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_loadall(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_loadall(_routeid bigint); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_wp_append_loadall(_routeid bigint) IS 'Append an "load all" action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_move(bigint, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_move(_routeid bigint, _planetid integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", planetid)

	VALUES(waypointid, _routeid, 1, _planetid);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_move(_routeid bigint, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_move(_routeid bigint, _planetid integer); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_wp_append_move(_routeid bigint, _planetid integer) IS 'Append a move action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_recycle(bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_recycle(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action")

	VALUES(waypointid, _routeid, 2);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_recycle(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_recycle(_routeid bigint); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_wp_append_recycle(_routeid bigint) IS 'Append a recycle action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_unloadall(bigint); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_unloadall(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", ore, hydrocarbon, scientists, soldiers, workers)

	VALUES(waypointid, _routeid, 0, -999999999, -999999999, -999999999, -999999999, -999999999);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_unloadall(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_unloadall(_routeid bigint); Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON FUNCTION static.sp_wp_append_unloadall(_routeid bigint) IS 'Append an "unload all" action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_wait(bigint, integer); Type: FUNCTION; Schema: static; Owner: exileng
--

CREATE FUNCTION static.sp_wp_append_wait(_routeid bigint, _seconds integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", waittime)

	VALUES(waypointid, _routeid, 4, _seconds);

	RETURN waypointid;

END;$$;


ALTER FUNCTION static.sp_wp_append_wait(_routeid bigint, _seconds integer) OWNER TO exileng;

--
-- Name: array_accum(anyelement); Type: AGGREGATE; Schema: static; Owner: exileng
--

CREATE AGGREGATE static.array_accum(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}'
);


ALTER AGGREGATE static.array_accum(anyelement) OWNER TO exileng;

--
-- Name: float8_mult(double precision); Type: AGGREGATE; Schema: static; Owner: exileng
--

CREATE AGGREGATE static.float8_mult(double precision) (
    SFUNC = float8mul,
    STYPE = double precision,
    INITCOND = '1.0'
);


ALTER AGGREGATE static.float8_mult(double precision) OWNER TO exileng;

--
-- Name: db_buildings_req_building; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_buildings_req_building (
    buildingid integer NOT NULL,
    required_buildingid integer NOT NULL
);


ALTER TABLE static.db_buildings_req_building OWNER TO exileng;

--
-- Name: db_buildings_req_research; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_buildings_req_research (
    buildingid integer NOT NULL,
    required_researchid integer NOT NULL,
    required_researchlevel smallint NOT NULL
);


ALTER TABLE static.db_buildings_req_research OWNER TO exileng;

--
-- Name: db_research_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_research_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_research_id_seq OWNER TO exileng;

--
-- Name: db_research; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_research (
    id integer DEFAULT nextval('static.db_research_id_seq'::regclass) NOT NULL,
    category smallint DEFAULT 1 NOT NULL,
    name character varying(32) NOT NULL,
    label character varying(64) NOT NULL,
    description text NOT NULL,
    rank integer DEFAULT 1 NOT NULL,
    levels smallint DEFAULT 5 NOT NULL,
    defaultlevel smallint DEFAULT 0 NOT NULL,
    cost_credits integer DEFAULT 0 NOT NULL,
    mod_production_ore real DEFAULT 0 NOT NULL,
    mod_production_hydrocarbon real DEFAULT 0 NOT NULL,
    mod_production_energy real DEFAULT 0 NOT NULL,
    mod_production_workers real DEFAULT 0 NOT NULL,
    mod_construction_speed_buildings real DEFAULT 0 NOT NULL,
    mod_construction_speed_ships real DEFAULT 0 NOT NULL,
    mod_fleet_damage real DEFAULT 0 NOT NULL,
    mod_fleet_speed real DEFAULT 0 NOT NULL,
    mod_fleet_shield real DEFAULT 0 NOT NULL,
    mod_fleet_handling real DEFAULT 0 NOT NULL,
    mod_fleet_tracking_speed real DEFAULT 0 NOT NULL,
    mod_fleet_energy_capacity real DEFAULT 0 NOT NULL,
    mod_fleet_energy_usage real DEFAULT 0 NOT NULL,
    mod_fleet_signature real DEFAULT 0 NOT NULL,
    mod_merchant_buy_price real DEFAULT 0 NOT NULL,
    mod_merchant_sell_price real DEFAULT 0 NOT NULL,
    mod_merchant_speed real DEFAULT 0 NOT NULL,
    mod_upkeep_commanders_cost real DEFAULT 0 NOT NULL,
    mod_upkeep_planets_cost real DEFAULT 0 NOT NULL,
    mod_upkeep_scientists_cost real DEFAULT 0 NOT NULL,
    mod_upkeep_soldiers_cost real DEFAULT 0 NOT NULL,
    mod_upkeep_ships_cost real DEFAULT 0 NOT NULL,
    mod_research_cost real DEFAULT 0 NOT NULL,
    mod_research_time real DEFAULT 0 NOT NULL,
    mod_recycling real DEFAULT 0 NOT NULL,
    mod_commanders real DEFAULT 0 NOT NULL,
    mod_planets real DEFAULT 0 NOT NULL,
    mod_research_effectiveness real DEFAULT 0 NOT NULL,
    mod_energy_transfer_effectiveness real DEFAULT 0 NOT NULL,
    mod_prestige_from_ships real DEFAULT 0 NOT NULL,
    modf_bounty real DEFAULT 1.0 NOT NULL,
    mod_prestige_from_buildings real DEFAULT 0 NOT NULL,
    mod_planet_need_ore real DEFAULT 0 NOT NULL,
    mod_planet_need_hydrocarbon real DEFAULT 0 NOT NULL,
    mod_fleet_jump_speed real DEFAULT 0 NOT NULL,
    expiration interval
);


ALTER TABLE static.db_research OWNER TO exileng;

--
-- Name: COLUMN db_research.rank; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.rank IS 'Research rank, the higher the longer it is to research';


--
-- Name: COLUMN db_research.levels; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.levels IS 'Number of levels this research has';


--
-- Name: COLUMN db_research.defaultlevel; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.defaultlevel IS 'Research value to set when account is reset, it allows to have default researches';


--
-- Name: COLUMN db_research.mod_production_ore; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_production_ore IS 'bonus to ore production per level';


--
-- Name: COLUMN db_research.mod_production_hydrocarbon; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_production_hydrocarbon IS 'bonus to hydrocarbon production per level';


--
-- Name: COLUMN db_research.mod_production_energy; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_production_energy IS 'bonus to energy production per level';


--
-- Name: COLUMN db_research.mod_production_workers; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_production_workers IS 'bonus to workers production per level';


--
-- Name: COLUMN db_research.mod_construction_speed_buildings; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_construction_speed_buildings IS 'modifier to construction speed of buildings per level';


--
-- Name: COLUMN db_research.mod_upkeep_planets_cost; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_upkeep_planets_cost IS 'Cost reduction of planets upkeep';


--
-- Name: COLUMN db_research.mod_recycling; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON COLUMN static.db_research.mod_recycling IS 'Modifier to recycling and building destruction';


--
-- Name: db_research_req_building; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_research_req_building (
    researchid integer NOT NULL,
    required_buildingid integer NOT NULL,
    required_buildingcount smallint DEFAULT 1 NOT NULL
);


ALTER TABLE static.db_research_req_building OWNER TO exileng;

--
-- Name: db_research_req_research; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_research_req_research (
    researchid integer NOT NULL,
    required_researchid integer NOT NULL,
    required_researchlevel smallint DEFAULT 1 NOT NULL
);


ALTER TABLE static.db_research_req_research OWNER TO exileng;

--
-- Name: db_ships_req_building; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_ships_req_building (
    shipid integer NOT NULL,
    required_buildingid integer NOT NULL
);


ALTER TABLE static.db_ships_req_building OWNER TO exileng;

--
-- Name: db_ships_req_research; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_ships_req_research (
    shipid integer NOT NULL,
    required_researchid integer NOT NULL,
    required_researchlevel smallint NOT NULL
);


ALTER TABLE static.db_ships_req_research OWNER TO exileng;

--
-- Name: admin_db_buildings_req_building; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_db_buildings_req_building AS
 SELECT db_buildings.label AS building,
    b2.label AS required_building
   FROM ((static.db_buildings_req_building
     JOIN static.db_buildings ON ((db_buildings.id = db_buildings_req_building.buildingid)))
     JOIN static.db_buildings b2 ON ((b2.id = db_buildings_req_building.required_buildingid)))
  ORDER BY db_buildings.label, b2.label;


ALTER TABLE static.admin_db_buildings_req_building OWNER TO exileng;

--
-- Name: admin_db_buildings_req_research; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_db_buildings_req_research AS
 SELECT db_buildings.label AS building,
    db_research.label AS research,
    db_buildings_req_research.required_researchlevel AS level
   FROM ((static.db_buildings_req_research
     JOIN static.db_buildings ON ((db_buildings.id = db_buildings_req_research.buildingid)))
     JOIN static.db_research ON ((db_research.id = db_buildings_req_research.required_researchid)))
  ORDER BY db_buildings.label, db_research.label;


ALTER TABLE static.admin_db_buildings_req_research OWNER TO exileng;

--
-- Name: admin_db_research_req_research_view; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_db_research_req_research_view AS
 SELECT r1.label AS research,
    r2.label AS required_research,
    db_research_req_research.required_researchlevel AS level
   FROM ((static.db_research_req_research
     JOIN static.db_research r1 ON ((r1.id = db_research_req_research.researchid)))
     JOIN static.db_research r2 ON ((r2.id = db_research_req_research.required_researchid)))
  ORDER BY r1.label, r2.label;


ALTER TABLE static.admin_db_research_req_research_view OWNER TO exileng;

--
-- Name: admin_db_ships_req_building_view; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_db_ships_req_building_view AS
 SELECT db_ships.label AS ship,
    db_buildings.label AS building
   FROM ((static.db_ships_req_building
     JOIN static.db_ships ON ((db_ships.id = db_ships_req_building.shipid)))
     JOIN static.db_buildings ON ((db_buildings.id = db_ships_req_building.required_buildingid)))
  ORDER BY db_ships.label, db_buildings.label;


ALTER TABLE static.admin_db_ships_req_building_view OWNER TO exileng;

--
-- Name: admin_db_ships_req_research_view; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_db_ships_req_research_view AS
 SELECT db_ships.label AS ship,
    db_research.label AS research,
    db_ships_req_research.required_researchlevel AS level
   FROM ((static.db_ships_req_research
     JOIN static.db_ships ON ((db_ships.id = db_ships_req_research.shipid)))
     JOIN static.db_research ON ((db_research.id = db_ships_req_research.required_researchid)))
  ORDER BY db_ships.label, db_research.label;


ALTER TABLE static.admin_db_ships_req_research_view OWNER TO exileng;

--
-- Name: admin_tables_sizes; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_tables_sizes AS
 SELECT pg_tables.tablename,
    pg_total_relation_size(((pg_tables.tablename)::text)::regclass) AS pg_total_relation_size
   FROM pg_tables
  WHERE (pg_tables.schemaname = 'public'::name)
  ORDER BY (pg_total_relation_size(((pg_tables.tablename)::text)::regclass));


ALTER TABLE static.admin_tables_sizes OWNER TO exileng;

--
-- Name: log_jobs; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_jobs (
    task character varying(128) NOT NULL,
    lastupdate timestamp without time zone DEFAULT now() NOT NULL,
    state character varying(128) DEFAULT ''::character varying NOT NULL,
    processid integer DEFAULT '-1'::integer NOT NULL
);


ALTER TABLE static.log_jobs OWNER TO exileng;

--
-- Name: admin_view_jobs; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_view_jobs AS
 SELECT (now() - (jobs.lastupdate)::timestamp with time zone) AS processus_lastupdate,
    jobs.task AS processus_filename,
    jobs.state AS processus_status,
    jobs.processid AS pid
   FROM static.log_jobs jobs
  ORDER BY (now() - (jobs.lastupdate)::timestamp with time zone);


ALTER TABLE static.admin_view_jobs OWNER TO exileng;

--
-- Name: log_pages_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_pages_id_seq OWNER TO exileng;

--
-- Name: log_pages; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_pages (
    id bigint DEFAULT nextval('static.log_pages_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    userid integer NOT NULL,
    webpage character varying(256) NOT NULL,
    elapsed real NOT NULL
);


ALTER TABLE static.log_pages OWNER TO exileng;

--
-- Name: admin_view_log_pages; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_view_log_pages AS
 SELECT (((("substring"((log_pages.webpage)::text, '/game/([[:alnum:]_/.]*)'::text) || '?'::text) || COALESCE("substring"((log_pages.webpage)::text, '(action=[[:alnum:]_/.=]*)'::text), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(a=[[:alnum:]_/.=]*)'::text)), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(b=[[:alnum:]_/.=]*)'::text)), ''::text)),
    sum(log_pages.elapsed) AS elapsed,
    count(*) AS calls,
    int4((sum(log_pages.elapsed) / (count(*))::double precision)) AS avg
   FROM static.log_pages
  GROUP BY (((("substring"((log_pages.webpage)::text, '/game/([[:alnum:]_/.]*)'::text) || '?'::text) || COALESCE("substring"((log_pages.webpage)::text, '(action=[[:alnum:]_/.=]*)'::text), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(a=[[:alnum:]_/.=]*)'::text)), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(b=[[:alnum:]_/.=]*)'::text)), ''::text))
  ORDER BY (sum(log_pages.elapsed));


ALTER TABLE static.admin_view_log_pages OWNER TO exileng;

--
-- Name: log_multi_simultaneous_warnings; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_multi_simultaneous_warnings (
    datetime timestamp without time zone NOT NULL,
    userid1 integer NOT NULL,
    userid2 integer NOT NULL
);


ALTER TABLE static.log_multi_simultaneous_warnings OWNER TO exileng;

--
-- Name: TABLE log_multi_simultaneous_warnings; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON TABLE static.log_multi_simultaneous_warnings IS 'Maintain a list of simultaneous accesses to accounts from same browser and ip';


--
-- Name: admin_view_multi_simultaneous; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_view_multi_simultaneous AS
 SELECT DISTINCT log_multi_simultaneous_warnings.datetime,
    LEAST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2) AS userid1,
    GREATEST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2) AS userid2
   FROM static.log_multi_simultaneous_warnings
  ORDER BY log_multi_simultaneous_warnings.datetime, LEAST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2), GREATEST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2);


ALTER TABLE static.admin_view_multi_simultaneous OWNER TO exileng;

--
-- Name: VIEW admin_view_multi_simultaneous; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON VIEW static.admin_view_multi_simultaneous IS 'List simultaneous web page requests';


--
-- Name: admin_view_multi_simultaneous2; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_view_multi_simultaneous2 AS
 SELECT static.sp_get_user(admin_view_multi_simultaneous.userid1) AS u1,
    static.sp_get_user(admin_view_multi_simultaneous.userid2) AS u2,
    ((count(*))::double precision / (date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))) / (3600)::double precision)) AS ratio,
    count(*) AS count,
    (date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))) / (3600)::double precision),
    max(admin_view_multi_simultaneous.datetime) AS max
   FROM static.admin_view_multi_simultaneous
  GROUP BY (static.sp_get_user(admin_view_multi_simultaneous.userid1)), (static.sp_get_user(admin_view_multi_simultaneous.userid2))
 HAVING ((count(*) > 1) AND ((max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime)) > '01:00:00'::interval))
  ORDER BY ((count(*))::double precision / date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))));


ALTER TABLE static.admin_view_multi_simultaneous2 OWNER TO exileng;

--
-- Name: admin_view_ships_cost_per_hour; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.admin_view_ships_cost_per_hour AS
 SELECT db_ships.label,
    (((1.0 * (db_ships.cost_ore)::numeric) / (db_ships.construction_time)::numeric) * (3600)::numeric) AS ore_by_hour,
    (((1.0 * (db_ships.cost_hydrocarbon)::numeric) / (db_ships.construction_time)::numeric) * (3600)::numeric) AS hydro_by_hour
   FROM static.db_ships
  ORDER BY (((1.0 * (db_ships.cost_ore)::numeric) / (db_ships.construction_time)::numeric) * (3600)::numeric), (((1.0 * (db_ships.cost_hydrocarbon)::numeric) / (db_ships.construction_time)::numeric) * (3600)::numeric);


ALTER TABLE static.admin_view_ships_cost_per_hour OWNER TO exileng;

--
-- Name: banned_domains; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.banned_domains (
    domain character varying(64) NOT NULL
);


ALTER TABLE static.banned_domains OWNER TO exileng;

--
-- Name: TABLE banned_domains; Type: COMMENT; Schema: static; Owner: exileng
--

COMMENT ON TABLE static.banned_domains IS 'List of banned mail domains';


--
-- Name: banned_logins; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.banned_logins (
    login character varying NOT NULL
);


ALTER TABLE static.banned_logins OWNER TO exileng;

--
-- Name: chat_banned_words; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.chat_banned_words (
    regexp character varying NOT NULL,
    replace_by character varying NOT NULL
);


ALTER TABLE static.chat_banned_words OWNER TO exileng;

--
-- Name: db_buildings_categories; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_buildings_categories (
    id smallint NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE static.db_buildings_categories OWNER TO exileng;

--
-- Name: db_firstnames; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_firstnames (
    name character varying(16) NOT NULL
);


ALTER TABLE static.db_firstnames OWNER TO exileng;

--
-- Name: db_items; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_items (
    id integer NOT NULL,
    category smallint DEFAULT 0 NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    label character varying(64) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    virtual boolean DEFAULT false NOT NULL,
    movable boolean DEFAULT true NOT NULL,
    volume real DEFAULT 0 NOT NULL
);


ALTER TABLE static.db_items OWNER TO exileng;

--
-- Name: db_items_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_items_id_seq OWNER TO exileng;

--
-- Name: db_items_id_seq; Type: SEQUENCE OWNED BY; Schema: static; Owner: exileng
--

ALTER SEQUENCE static.db_items_id_seq OWNED BY static.db_items.id;


--
-- Name: db_lcid; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_lcid (
    lcid integer NOT NULL,
    name character varying NOT NULL,
    label character varying NOT NULL
);


ALTER TABLE static.db_lcid OWNER TO exileng;

--
-- Name: db_messages; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_messages (
    id integer NOT NULL,
    lcid smallint DEFAULT 1036 NOT NULL,
    subject character varying NOT NULL,
    body character varying NOT NULL,
    sender character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE static.db_messages OWNER TO exileng;

--
-- Name: db_messages_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_messages_id_seq OWNER TO exileng;

--
-- Name: db_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: static; Owner: exileng
--

ALTER SEQUENCE static.db_messages_id_seq OWNED BY static.db_messages.id;


--
-- Name: db_names; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_names (
    name character varying(16) NOT NULL
);


ALTER TABLE static.db_names OWNER TO exileng;

--
-- Name: db_orientations; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_orientations (
    id integer NOT NULL,
    name character varying NOT NULL,
    selectable boolean DEFAULT false NOT NULL
);


ALTER TABLE static.db_orientations OWNER TO exileng;

--
-- Name: db_orientations_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_orientations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_orientations_id_seq OWNER TO exileng;

--
-- Name: db_orientations_id_seq; Type: SEQUENCE OWNED BY; Schema: static; Owner: exileng
--

ALTER SEQUENCE static.db_orientations_id_seq OWNED BY static.db_orientations.id;


--
-- Name: db_security_levels; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_security_levels (
    id integer NOT NULL,
    max_planets integer DEFAULT 10000 NOT NULL,
    max_commanders integer DEFAULT 10000 NOT NULL
);


ALTER TABLE static.db_security_levels OWNER TO exileng;

--
-- Name: db_ship_modules_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_ship_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_ship_modules_id_seq OWNER TO exileng;

--
-- Name: db_ship_modules; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_ship_modules (
    id integer DEFAULT nextval('static.db_ship_modules_id_seq'::regclass) NOT NULL,
    category smallint DEFAULT 0 NOT NULL,
    label character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    cost_ore integer DEFAULT 0 NOT NULL,
    cost_hydrocarbon integer DEFAULT 0 NOT NULL,
    cost_credits integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    crew smallint DEFAULT 0 NOT NULL,
    capacity integer DEFAULT 0 NOT NULL,
    construction_time integer DEFAULT 180 NOT NULL,
    maximum smallint DEFAULT 0 NOT NULL,
    hull integer DEFAULT 0 NOT NULL,
    shield integer DEFAULT 0 NOT NULL,
    weapon_power smallint DEFAULT 0 NOT NULL,
    weapon_ammo smallint DEFAULT 0 NOT NULL,
    weapon_tracking_speed smallint DEFAULT 0 NOT NULL,
    weapon_turrets smallint DEFAULT 0 NOT NULL,
    signature smallint DEFAULT 0 NOT NULL,
    speed integer DEFAULT 0 NOT NULL,
    handling integer DEFAULT 0 NOT NULL,
    recycler_output integer DEFAULT 0 NOT NULL,
    droppods smallint DEFAULT 0 NOT NULL,
    long_distance_capacity smallint DEFAULT 0 NOT NULL,
    mod_speed smallint DEFAULT 0 NOT NULL,
    mod_shield smallint DEFAULT 0 NOT NULL,
    mod_handling smallint DEFAULT 0 NOT NULL,
    mod_tracking_speed smallint DEFAULT 0 NOT NULL,
    mod_damage smallint DEFAULT 0 NOT NULL,
    mod_signature smallint DEFAULT 0 NOT NULL,
    mod_recycling smallint DEFAULT 0 NOT NULL,
    cpu smallint DEFAULT 0 NOT NULL,
    power smallint DEFAULT 0 NOT NULL,
    usage_cpu smallint DEFAULT 0 NOT NULL,
    usage_power smallint DEFAULT 0 NOT NULL,
    usage_slot_low smallint DEFAULT 0 NOT NULL,
    usage_slot_middle smallint DEFAULT 0 NOT NULL,
    usage_slot_high smallint DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL
);


ALTER TABLE static.db_ship_modules OWNER TO exileng;

--
-- Name: db_ship_structures_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_ship_structures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_ship_structures_id_seq OWNER TO exileng;

--
-- Name: db_ship_structures; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_ship_structures (
    id integer DEFAULT nextval('static.db_ship_structures_id_seq'::regclass) NOT NULL,
    category smallint DEFAULT 0 NOT NULL,
    label character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    cost_ore integer DEFAULT 0 NOT NULL,
    cost_hydrocarbon integer DEFAULT 0 NOT NULL,
    cost_credits integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    crew integer DEFAULT 0 NOT NULL,
    capacity integer DEFAULT 0 NOT NULL,
    construction_time integer DEFAULT 180 NOT NULL,
    hull integer DEFAULT 0 NOT NULL,
    signature smallint DEFAULT 0 NOT NULL,
    handling integer DEFAULT 0 NOT NULL,
    buildingid integer,
    cpu smallint DEFAULT 0 NOT NULL,
    power smallint DEFAULT 0 NOT NULL,
    slot_low smallint DEFAULT 0 NOT NULL,
    slot_middle smallint DEFAULT 0 NOT NULL,
    slot_high smallint DEFAULT 0 NOT NULL,
    "Weight" integer DEFAULT 0 NOT NULL
);


ALTER TABLE static.db_ship_structures OWNER TO exileng;

--
-- Name: db_successes; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.db_successes (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE static.db_successes OWNER TO exileng;

--
-- Name: db_successes_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.db_successes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.db_successes_id_seq OWNER TO exileng;

--
-- Name: db_successes_id_seq; Type: SEQUENCE OWNED BY; Schema: static; Owner: exileng
--

ALTER SEQUENCE static.db_successes_id_seq OWNED BY static.db_successes.id;


--
-- Name: gsc_levels; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.gsc_levels (
    id integer NOT NULL
);


ALTER TABLE static.gsc_levels OWNER TO exileng;

--
-- Name: gsc_levels_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.gsc_levels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.gsc_levels_id_seq OWNER TO exileng;

--
-- Name: gsc_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: static; Owner: exileng
--

ALTER SEQUENCE static.gsc_levels_id_seq OWNED BY static.gsc_levels.id;


--
-- Name: log_admin_actions; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_admin_actions (
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    adminuserid integer NOT NULL,
    userid integer NOT NULL,
    action smallint NOT NULL,
    reason character varying(128),
    reason_public character varying(128),
    admin_notes text DEFAULT ''::text NOT NULL
);


ALTER TABLE static.log_admin_actions OWNER TO exileng;

--
-- Name: log_failed_logins_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_failed_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_failed_logins_id_seq OWNER TO exileng;

--
-- Name: log_failed_logins; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_failed_logins (
    id bigint DEFAULT nextval('static.log_failed_logins_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    login character varying NOT NULL,
    address bigint NOT NULL,
    forwarded_address character varying,
    browser character varying(128) NOT NULL,
    browserid bigint
);


ALTER TABLE static.log_failed_logins OWNER TO exileng;

--
-- Name: log_http_errors_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_http_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_http_errors_id_seq OWNER TO exileng;

--
-- Name: log_http_errors; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_http_errors (
    id integer DEFAULT nextval('static.log_http_errors_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    "user" character varying(32),
    http_error_code text,
    err_asp_code text,
    err_number text,
    err_source text,
    err_category text,
    err_file text,
    err_line text,
    err_column text,
    err_description text,
    err_aspdescription text,
    details character varying(128) DEFAULT ''::character varying NOT NULL,
    url character varying(128) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE static.log_http_errors OWNER TO exileng;

--
-- Name: log_multi_account_warnings; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_multi_account_warnings (
    id bigint NOT NULL,
    withid bigint NOT NULL
);


ALTER TABLE static.log_multi_account_warnings OWNER TO exileng;

--
-- Name: log_notices_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_notices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_notices_id_seq OWNER TO exileng;

--
-- Name: log_notices; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_notices (
    id integer DEFAULT nextval('static.log_notices_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    username character varying(32),
    title character varying(128) DEFAULT ''::character varying NOT NULL,
    details character varying(128) DEFAULT ''::character varying NOT NULL,
    url character varying(128) DEFAULT ''::character varying NOT NULL,
    repeats integer DEFAULT 0 NOT NULL,
    level smallint DEFAULT 0 NOT NULL
);


ALTER TABLE static.log_notices OWNER TO exileng;

--
-- Name: log_referers_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_referers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_referers_id_seq OWNER TO exileng;

--
-- Name: log_referers; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_referers (
    id integer DEFAULT nextval('static.log_referers_id_seq'::regclass) NOT NULL,
    referer text NOT NULL,
    page text,
    pages text[] DEFAULT ARRAY[''::text] NOT NULL
);


ALTER TABLE static.log_referers OWNER TO exileng;

--
-- Name: log_referers_users; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_referers_users (
    refererid integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    userid integer NOT NULL,
    page text
);


ALTER TABLE static.log_referers_users OWNER TO exileng;

--
-- Name: log_sys_errors_id_seq; Type: SEQUENCE; Schema: static; Owner: exileng
--

CREATE SEQUENCE static.log_sys_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static.log_sys_errors_id_seq OWNER TO exileng;

--
-- Name: log_sys_errors; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.log_sys_errors (
    id integer DEFAULT nextval('static.log_sys_errors_id_seq'::regclass) NOT NULL,
    procedure character varying NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    error character varying NOT NULL
);


ALTER TABLE static.log_sys_errors OWNER TO exileng;

--
-- Name: sys_daily_updates; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.sys_daily_updates (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval DEFAULT '01:00:00'::interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE static.sys_daily_updates OWNER TO exileng;

--
-- Name: sys_events; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.sys_events (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE static.sys_events OWNER TO exileng;

--
-- Name: sys_processes; Type: TABLE; Schema: static; Owner: exileng
--

CREATE TABLE static.sys_processes (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE static.sys_processes OWNER TO exileng;

--
-- Name: sys_executions; Type: VIEW; Schema: static; Owner: exileng
--

CREATE VIEW static.sys_executions AS
 SELECT 'event'::text AS category,
    sys_events.enabled,
    sys_events.procedure,
    sys_events.last_runtime,
    sys_events.run_every,
    sys_events.last_result,
    ((((((((((sys_events.last_executiontimes[1] + sys_events.last_executiontimes[2]) + sys_events.last_executiontimes[3]) + sys_events.last_executiontimes[4]) + sys_events.last_executiontimes[5]) + sys_events.last_executiontimes[6]) + sys_events.last_executiontimes[7]) + sys_events.last_executiontimes[8]) + sys_events.last_executiontimes[9]) + sys_events.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM static.sys_events
UNION
 SELECT 'process'::text AS category,
    sys_processes.enabled,
    sys_processes.procedure,
    sys_processes.last_runtime,
    sys_processes.run_every,
    sys_processes.last_result,
    ((((((((((sys_processes.last_executiontimes[1] + sys_processes.last_executiontimes[2]) + sys_processes.last_executiontimes[3]) + sys_processes.last_executiontimes[4]) + sys_processes.last_executiontimes[5]) + sys_processes.last_executiontimes[6]) + sys_processes.last_executiontimes[7]) + sys_processes.last_executiontimes[8]) + sys_processes.last_executiontimes[9]) + sys_processes.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM static.sys_processes
UNION
 SELECT 'daily'::text AS category,
    sys_daily_updates.enabled,
    sys_daily_updates.procedure,
    sys_daily_updates.last_runtime,
    sys_daily_updates.run_every,
    sys_daily_updates.last_result,
    ((((((((((sys_daily_updates.last_executiontimes[1] + sys_daily_updates.last_executiontimes[2]) + sys_daily_updates.last_executiontimes[3]) + sys_daily_updates.last_executiontimes[4]) + sys_daily_updates.last_executiontimes[5]) + sys_daily_updates.last_executiontimes[6]) + sys_daily_updates.last_executiontimes[7]) + sys_daily_updates.last_executiontimes[8]) + sys_daily_updates.last_executiontimes[9]) + sys_daily_updates.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM static.sys_daily_updates;


ALTER TABLE static.sys_executions OWNER TO exileng;

--
-- Name: db_items id; Type: DEFAULT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_items ALTER COLUMN id SET DEFAULT nextval('static.db_items_id_seq'::regclass);


--
-- Name: db_messages id; Type: DEFAULT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_messages ALTER COLUMN id SET DEFAULT nextval('static.db_messages_id_seq'::regclass);


--
-- Name: db_orientations id; Type: DEFAULT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_orientations ALTER COLUMN id SET DEFAULT nextval('static.db_orientations_id_seq'::regclass);


--
-- Name: db_successes id; Type: DEFAULT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_successes ALTER COLUMN id SET DEFAULT nextval('static.db_successes_id_seq'::regclass);


--
-- Name: gsc_levels id; Type: DEFAULT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.gsc_levels ALTER COLUMN id SET DEFAULT nextval('static.gsc_levels_id_seq'::regclass);


--
-- Data for Name: banned_domains; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.banned_domains VALUES ('@jetable.org$');
INSERT INTO static.banned_domains VALUES ('@modmailcom.com$');
INSERT INTO static.banned_domains VALUES ('@mailinator.com$');


--
-- Data for Name: banned_logins; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.banned_logins VALUES ('^modo$');
INSERT INTO static.banned_logins VALUES ('^admin');
INSERT INTO static.banned_logins VALUES ('^chob$');
INSERT INTO static.banned_logins VALUES ('^duke$');
INSERT INTO static.banned_logins VALUES ('^exile$');
INSERT INTO static.banned_logins VALUES ('^moderat');
INSERT INTO static.banned_logins VALUES ('^f[0o]ss[0o]*');


--
-- Data for Name: chat_banned_words; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*tem[\-]la[\-]firme[\.]com[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*idpz[\.]net[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*fourmigration[\.]com[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*bitefight[\.]fr[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*prizee[\.]com[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*woodwar[\.]fr[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*miniville[\.]fr[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*wood-war[\.]net[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*myminicity[\.]fr[[:alnum:]_\./:\?=]*

', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*ville-virtuelle[\.]com[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*floodinator[\.]keuf[\.]net[[:alnum:]_\./:\?=]*', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\-.]*labrute[\.]fr[[:alnum:]_\./:\?=]*', 'http://exile.labrute.fr');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\-.]*labrute[\.]com[[:alnum:]_\./:\?=]*', 'http://exile.labrute.com');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\-.]*gladiatus[\.][[:alnum:]_\./:\?=]*

', ':)');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*clodogame[\.]fr[[:alnum:]_\./:\?=]*

', ':(');
INSERT INTO static.chat_banned_words VALUES ('[[:alnum:]_/:\.]*armygames[\.]fr[[:alnum:]_\./:\?=]*', ':)');


--
-- Data for Name: db_buildings; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_buildings VALUES (52, 110, 'hydro_bonus', 'Gisements d''hydrocarbure', 'De riches gisements d''hydrocarbure ont été découverts, la production en hydrocarbure est augmentée.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (80, 100, 'shame_on_you', 'Monument de la honte', 'Votre peuple a honte de vous.', 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, false, -0.8, -0.8, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (90, 100, 'magnetic_clouds', 'Nuages magnétiques', 'Un amas de nuages entoure le système de la planète agissant comme un brouilleur radar géant.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (91, 100, 'electromagnetic_storm', 'Tempête électromagnétique', 'Nous subissons actuellement une tempête électromagétique, la production s''en voit grandement diminuée.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, -0.6, -0.6, -0.3, 0, -0.99, -0.99, 0, 0, 0, 20, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (125, 32, 'ship_hangar1', 'Hangar à vaisseaux', 'Ce hangar augmente la capacité de stockage des vaisseaux de 25 000 signature.', 40000, 35000, 0, 25000, 250, 0, 2, 0, 0, 0, 0, 0, 0, 200, 28000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 25000);
INSERT INTO static.db_buildings VALUES (93, 100, 'oil_rich', 'Riche en hydrocarbure', 'Nous avons découvert un gros gisement de pétrôle, nos puits d''hydrocarbures carburent à fond.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0.15, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (94, 100, 'extraordinary_planet', 'Planète extraordinaire', 'Cette planète se trouve proche d''une déformation gravitationnelle dans l''espace temps, le temps passe plus vite par rapport aux autres colonies.<br/>

La construction, la production et la formation des nouveaux travailleurs est plus rapide sur cette planète.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0.3, 0.3, 0, 0.8, 2, 2, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (217, 23, 'nuclear_power_plant', 'Centrale nucléaire', 'Cette centrale à énergie accueille plusieurs réacteurs nucléaires dont le principe repose sur la fission nucléaire.<br/>

L''énergie produite est importante.', 28000, 14000, 0, 7500, 200, 2000, 2, 0, 0, 0, 0, 0, 0, 200, 43200, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 150, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (115, 20, 'ore_mine1', 'Mine de minerai', 'Un système automatisé extrait le minerai de la planète continuellement.<br/>

Chaque bâtiment augmente la production de minerai de 1% mais réduit la demande en minerai de la planète.', 500, 1000, 0, 2000, 25, 0, 2, 0, 400, 0, 0, 0, 0, 200, 7200, true, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 50, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, -0.015, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (901, 90, 'TEST BUILDING', 'TEST BUILDING', 'description here

ì‹œí—˜é à ^ $ Â£ Â¤', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 5, true, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 60, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (1001, 10, 'merchant_colony', 'Colonie marchande', 'Colonie marchande.', 900000, 600000, 0, 100000, 0, 20000, 20, 0, 0, 0, 400000, 400000, 600000, 1, 900000, false, 0, 0, 0, 0, 0, 0, 100000, 100000, 4, 0, false, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1000000, false, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (310, 80, 'send_energy_satellite', 'Satellite émetteur d''énergie', 'Ce satellite permet de créer un lien avec un satellite de réception d''une autre planète située dans la même galaxie et de lui envoyer de l''énergie.<br/>

Un satellite émetteur ne peut envoyer qu''un seul flux à la fois.', 120000, 80000, 0, 25000, 200, 0, 0, 1, 0, 0, 0, 0, 0, 100, 100000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (117, 23, 'solar_power_plant', 'Capteurs solaires', 'Des capteurs solaires tapissent des champs entiers et convertissent les rayons du soleil en énergie.', 200, 300, 0, 1000, 0, 200, 1, 0, 0, 0, 0, 0, 0, 200, 1200, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (401, 31, 'ore_storage_complex', 'Complexe de stockage de minerai', 'Ce complexe de stockage augmente la capacité de stockage du minerai de 2 000 000.', 500000, 400000, 0, 25000, 1000, 0, 2, 0, 0, 0, 2000000, 0, 0, 200, 128000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 200, 0, true, NULL, NULL, 0, 0, 10000, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (403, 23, 'star_belt', 'Ceinture d''étoile', 'Il s''agit certainement du projet le plus fou mais aussi le plus ambitieux à entreprendre : créer une ceinture tout autour de l''étoile du système afin de capter le plus possible d''énergie.<br/>

Une production d''au moins 50 000 énergie/heure est prévue. De plus, il sera possible d''augmenter cette production en ajoutant jusqu''à 5 capteurs supplémentaires fournissant chacun 10 000 énergie/heure.', 2000000, 1600000, 0, 50000, 0, 50000, 0, 2, 0, 0, 0, 0, 0, 1, 512000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 10000, 0, true, NULL, NULL, 0, 0, 200000, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (602, 23, 'energy_cell', 'Caisse d''énergie', 'Ce bâtiment apporte un flux minimum de 10000 unités d''énergie pour une durée d''environ 5 heures.', 0, 0, 0, 0, 0, 10000, 1, 0, 0, 0, 0, 0, 0, 1, 3600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 18000, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (402, 32, 'hydrocarbon_storage_complex', 'Complexe de stockage d''hydrocarbure', 'Ce complexe de stockage augmente la capacité de stockage en hydrocarbure de 2 000 000.', 500000, 400000, 0, 25000, 1000, 0, 2, 0, 0, 0, 0, 2000000, 0, 200, 128000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 200, 0, true, NULL, NULL, 0, 0, 10000, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (231, 20, 'manufactured_products_factory', 'Usine de produits manufacturés', 'De ces usines sortent des produits manufacturés vendus à la population.<br/>

Chaque usine génère entre 8 000 et 10 000 crédits par jour.', 30000, 25000, 0, 10000, 3000, 0, 4, 0, 0, 0, 0, 0, 0, 100, 54000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 50, 1, 0, 0, 8000, 2000, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (1, 100, 'boost_x_server', 'Boost serveur X', 'description here', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, false, 0, 0);
INSERT INTO static.db_buildings VALUES (96, 100, 'sandworm_activity', 'Présence de vers de sable', 'De gigantesques vers de sable sont présents sur la planète et attaquent tout ce qui émet des vibrations régulières.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3600, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (600, 80, 'space_radar', 'Radar renforcé', 'Station temporaire déployée permettant le balayage radar d''un secteur pour une durée limitée (puissance radar 1)', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3600, true, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 28800, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (601, 80, 'space_jammer', 'Brouillage renforcé', 'Station temporaire déployée permettant le brouillage de l''emplacement avec une puissance de 10.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 28800, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (11, 100, 'titan_frame_relic', 'Epave de chassis', 'Il s''agit d''un chassis d''un immense vaisseau. Le matériaux utilisé semble extrêmement résistant, nos scientifiques devraient être capables de le reproduire pour créer un nouveau type de chassis.<br/>Il faudra tout d''abord créer un site d''étude tout autour de l''épave afin que vos scientifiques puissent mener leurs recherches.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (10, 100, 'titan_engine_relic', 'Epave de moteurs', 'Il s''agit de l''épave des moteurs d''un vaisseau qui devait être immense. Il n''en reste aujourd''hui plus grand chose cependant l''étude de cette épave pourrait nous aider à concevoir un nouveau type de moteurs.<br/>Il faudra tout d''abord créer un site d''étude tout autour de l''épave afin que vos scientifiques puissent mener leurs recherches.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (50, 110, 'babyboom', 'Baby boom', 'La population est heureuse et la croissance augmente.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0, 0, 0.2, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (51, 110, 'ore_bonus', 'Filon de minerai', 'De riches filons de minerai ont été découverts, la production de minerai est augmentée.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (903, 90, 'large_energy_shield', 'Bouclier énergétique II', 'description here', 100000, 50000, 0, 20000, 1000, 0, 1, 0, 0, 0, 0, 0, 0, 5, 72000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (904, 90, 'missile_launcher', 'Batterie de missiles', 'description here', 3000, 500, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 300, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (102, 11, 'construction_plant1', 'Usine de préfabriqués', 'Cette usine est spécialisée dans la préfabrication, des ouvriers préfabriquent certains éléments qui sont ensuite assemblés sur place ce qui donne une augmentation globale de la vitesse de construction des bâtiments.<br/>

Ce bâtiment est requis avant de pouvoir construire des structures plus avancées.', 2000, 1250, 0, 5000, 50, 0, 1, 0, 0, 0, 0, 0, 0, 1, 43200, true, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (303, 40, 'heavyweapon_factory', 'Usine d''armement lourd', 'Cette usine permet de construire les différentes armes dont vous aurez besoin pour construire vos défenses plus évoluées et équiper vos vaisseaux de combat.', 180000, 160000, 0, 32000, 600, 0, 12, 0, 0, 0, 0, 0, 0, 1, 172800, true, 0, 0, 0, 0, 0, 0.02, 0, 0, 0, 0, false, false, 0, 0, 20, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 1000, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (1021, 32, 'merchant_hydrocarbon_storage', 'Entrepôt marchand d''hydrocarbure', 'Les entrepôts marchand sont immenses et peuvent contenir des millions d''unités de ressources.', 3000000, 2000000, 0, 120000, 0, 0, 5, 0, 0, 0, 0, 900000000, 0, 100, 1000000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (99, 100, 'bonus', 'Bonus de production (12 heures)', 'Suite aux récents problèmes rencontrés par notre nation, tous les effectifs travaillent à 120% de leurs capacités pour rattraper le temps perdu. Au travail !', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0.2, 0.2, 0, 0, 0.2, 0.2, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (203, 40, 'light_weapon_factory', 'Usine d''armement léger', 'Cette usine permet de construire différentes armes légères dont vous aurez besoin pour construire vos défenses et équiper vos vaisseaux.', 32000, 25000, 0, 17500, 250, 0, 6, 0, 0, 0, 0, 0, 0, 1, 50400, true, 0, 0, 0, 0, 0, 0.02, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 300, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (120, 31, 'ore_hangar1', 'Réserve à minerai', 'Ce petit entrepôt augmente la capacité de stockage du minerai de 50 000.', 1000, 500, 0, 5000, 0, 0, 1, 0, 0, 0, 50000, 0, 0, 200, 9000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 10, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (218, 23, 'solar_power_satellite', 'Satellite solaire', 'Un satelite solaire est envoyé en orbite géostationnaire, transforme l''énergie solaire en électricité puis redirige celle-ci vers la rectenna de la colonie sous forme de micro-ondes.', 4000, 7000, 0, 2500, 0, 600, 0, 1, 0, 0, 0, 0, 0, 200, 32000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 125, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (317, 23, 'energy_plant3', 'Tokamak', 'Cet énorme bâtiment accueille plusieurs machines qui reproduisent la fusion nucléaire semblable à celle qui se produit en permanence au coeur des étoiles.<br/>

L''énergie produite est très importante.<br/>

De plus, cet édifice vous rapportera 100 points de prestige par jour.', 140000, 90000, 0, 40000, 500, 10000, 4, 0, 0, 0, 0, 0, 0, 1, 172800, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 600, 0, true, NULL, NULL, 0, 100, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (302, 11, 'synthesis_plant', 'Usine de synthèse', 'Une technique avancée permet de créer de nouveaux matériaux uniquement à partir d''énergie.<br/>

La qualité de ces matériaux exempts de tout défaut, les rend beaucoup plus résistants.', 100000, 80000, 0, 35000, 800, 0, 1, 0, 0, 0, 0, 0, 0, 1, 172800, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 150, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (391, 10, 'artificial_moon', 'Lune artificielle', 'La création d''une lune artificielle ajoute 10 unités d''espace exploitable.<br/>

Ce bâtiment ne peut être détruit après construction. Il n''est possible d''en construire qu''une seule.', 700000, 150000, 0, 55000, 0, 0, 0, -10, 0, 0, 0, 0, 0, 1, 432000, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (390, 10, 'steel_caves', 'Cavernes d''acier', 'La transformation d''une partie des sous-sols en espace utilisable permet d''étendre le terrain de la planète de 4 unités.<br/>

Ce bâtiment ne peut être détruit après construction. Il n''est possible d''en construire que 5 par planète.', 400000, 300000, 0, 45000, 0, 0, -4, 0, 0, 0, 0, 0, 0, 5, 345600, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (370, 40, 'sandworm_proctection', 'Barrières électromagnétiques', 'Des barrières sont disposées tout autour de la colonie repoussant les attaques des vers de sable. La probabilité qu''un vers s''attaque à un bâtiment de la colonie est grandement réduite.', 100000, 80000, 0, 30000, 2500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 172800, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 10, 1, -19, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 500, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (309, 80, 'jammer', 'Brouilleur radar', 'Ce satellite est capable de brouiller les radars ennemis.<br/>

Lancez plusieurs satellites afin de brouiller efficacement les radars ennemis pour cacher vos flottes en orbite et les caractéristiques de votre planète.<br/>

Chaque satellite augmente le brouillage de la planète de 2 points.', 90000, 65000, 0, 25000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 200, 100000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, false, true, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (1020, 31, 'merchant_ore_storage', 'Entrepôt marchand de minerai', 'Les entrepôts marchand sont immenses et peuvent contenir des millions d''unités de ressources.', 3000000, 2000000, 0, 120000, 0, 0, 5, 0, 0, 0, 900000000, 0, 0, 100, 1000000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (381, 40, 'seism_protection', 'Déflecteur', 'Des capteurs sont disséminés sur toute la surface de la planète afin de prévenir les séismes et amoindrir les secousses à la surface.', 420000, 31000, 0, 10000, 3000, 0, 4, 0, 0, 0, 0, 0, 0, 1, 18000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 1, 0, 0, -19, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 500, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (222, 33, 'energy_storage', 'Réserve d''énergie', 'Ce bâtiment permet de stocker 100 000 unités d''énergie supplémentaire.', 30000, 20000, 0, 15000, 100, 0, 1, 0, 0, 0, 0, 0, 0, 200, 30800, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 100000, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (95, 100, 'big_seismic_activity', 'Grande activité sismique', 'Activité sismique très importante pouvant détruire des bâtiments', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3600, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (232, 80, 'commercial_station', 'Station commerciale orbitale', 'Les stations commerciales orbitales permettent la vente de minerai et d''hydrocarbure aux autres planètes de la galaxie', 30000, 20000, 0, 5000, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1, 3600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (220, 31, 'ore_hangar2', 'Hangar à minerai', 'Un entrepôt qui augmente la capacité de stockage du minerai de 200 000.', 25000, 14000, 0, 10000, 100, 0, 2, 0, 0, 0, 200000, 0, 0, 200, 28000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (221, 32, 'hydrocarbon_hangar2', 'Hangar à hydrocarbure', 'Un entrepôt qui augmente la capacité de stockage en hydrocarbure de 200 000.', 25000, 14000, 0, 10000, 100, 0, 2, 0, 0, 0, 0, 200000, 0, 200, 30800, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (320, 31, 'ore_hangar3', 'Entrepôt à minerai', 'Un entrepôt souterrain sur plusieurs niveaux qui augmente considérablement la capacité de stockage du minerai de 1 000 000.', 80000, 55000, 0, 15000, 500, 0, 3, 0, 0, 0, 1000000, 0, 0, 200, 56000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (321, 32, 'hydrocarbon_hangar3', 'Entrepôt à hydrocarbure', 'Un entrepôt souterrain sur plusieurs niveaux qui augmente considérablement la capacité de stockage en hydrocarbure de 1 000 000.', 80000, 55000, 0, 15000, 500, 0, 3, 0, 0, 0, 0, 1000000, 0, 200, 61600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (116, 20, 'hydrocarbon_mine1', 'Puits d''hydrocarbures', 'Un système automatisé extrait les hydrocarbures de la planète continuellement.<br/>

Chaque bâtiment augmente la production d''hydrocarbure de 1% mais réduit la demande en hydrocarbure de la planète.', 1000, 500, 0, 2000, 25, 0, 2, 0, 0, 400, 0, 0, 0, 200, 7200, true, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 50, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, -0.015, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (308, 30, 'military_base', 'Base militaire', 'La base militaire permet d''accueillir 10 000 soldats supplémentaires dans votre colonie et l''entraînement de 100 soldats à la fois.', 110000, 90000, 0, 30000, 600, 0, 3, 0, 0, 0, 0, 0, 0, 200, 172800, true, 0, 0, 0, 0, 0, 0, 0, 10000, 0, 0, false, false, 0, 100, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 250, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (510, 90, 'titan_engine_research_center', 'Centre d''étude de l''épave de moteurs', 'Afin d''étudier l''épave des gigantesques moteurs qui se trouve sur cette planète, nous avons besoin d''un centre d''étude dédié. Ce centre accueillera une équipe dirigée par nos scientifiques afin d''étudier, analyser et rapporter toute information nécessaire à la compréhension de leur fonctionnement.', 300000, 190000, 0, 40000, 1400, 0, 6, 0, 0, 0, 0, 0, 0, 1, 320000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (207, 23, 'rectenna', 'Rectenna', 'La rectenna est une antenne qui convertit les micro-ondes envoyées par les satellites solaires en énergie utilisable par la colonie.<br/>

Vous ne pouvez construire ces satellites qu''une fois la rectenna construite.', 16000, 5000, 0, 6000, 50, 0, 2, 0, 0, 0, 0, 0, 0, 1, 42000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 25, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (902, 90, 'small_energy_shield', 'Bouclier énergétique I', '', 20000, 10000, 0, 3000, 200, 0, 1, 0, 0, 0, 0, 0, 0, 5, 14400, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (89, 100, 'vortex', 'Vortex', 'Présence d''un vortex stable à proximité', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 10, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (603, 80, 'deployed_vortex_short', 'Vortex artificiel', 'Vortex artificiel déployé par un groupe ayant connaissance de la science des vortex', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 1800, true, 0, 0, true, NULL, NULL, 1, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (604, 80, 'deployed_vortex_medium', 'Vortex artificiel', 'Vortex artificiel déployé par un groupe ayant connaissance de la science des vortex', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 43200, true, 0, 0, true, NULL, NULL, 2, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (605, 80, 'deployed_vortex_strong', 'Vortex artificiel', 'Vortex artificiel déployé par un groupe ayant connaissance de la science des vortex', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 1800, true, 0, 0, true, NULL, NULL, 4, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (606, 80, 'deployed_vortex_inhibitor', 'Inhibiteur de vortex', 'Déstabilisateur de vortex rendant son utilisation plus compliquée.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 172800, true, 0, 0, true, NULL, NULL, -8, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (204, 30, 'workshop1', 'Ateliers', 'Les ateliers fournissent des infrastructures de travail à votre population.<br/>

Votre colonie peut accueillir 3 000 nouveaux travailleurs.<br/>

L''atelier génère 200 crédits par jour et augmente légèrement la demande en minerai et hydrocarbure de la planète.', 8000, 4000, 0, 5000, 150, 0, 1, 0, 0, 0, 0, 0, 3000, 200, 21600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 200, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 800, 800, true, 0, 0);
INSERT INTO static.db_buildings VALUES (206, 30, 'research_center', 'Centre de recherche', 'Le centre de recherche est équipé de tout ce qui est nécessaire afin d''entreprendre des recherches avancée.<br/>

Votre planète peut accueillir 5 000 scientifiques de plus et permet la formation de 100 scientifiques par heure.', 28000, 21000, 0, 15000, 150, 0, 2, 0, 0, 0, 0, 0, 0, 1, 108000, true, 0, 0, 0, 0, 0, 0, 5000, 0, 0, 0, false, false, 100, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (101, 10, 'colony1', 'Colonie', 'Ce bâtiment est le centre administratif de votre colonie, il est essentiel pour la gestion de votre colonie.<br/>

Il dispose de petits extracteurs de minerai et d''hydrocarbures, d''une centrale géothermique pour produire de l''énergie à l''ensemble de la colonie et d''ateliers pour construire de nouveaux bâtiments.<br/>

La colonie offre une capacité de stockage de 100 000 unités de minerai, 100 000 unités d''hydrocarbure, 30 000 unités d''énergie et génère 2 500 crédits par jour.', 20000, 10000, 0, 2500, 0, 300, 2, 0, 100, 50, 100000, 100000, 20000, 1, 44800, false, 0, 0, 0, 0, 0, 0, 1000, 1000, 0, 0, false, false, 50, 50, 20, 1, 0, 0, 2500, 0, 0, 0, 0, 1, 30000, true, 0, false, 0, 0, true, NULL, NULL, 0, 10, 0, 0, 0, 8000, 8000, true, 0, 10000);
INSERT INTO static.db_buildings VALUES (400, 10, 'wonder', '12ème merveille', 'Cette reproduction de la douzième merveille de l''univers vous rapportera 100 points de prestige par jour.<br/>

Le tourisme associé à ce bâtiment rapporte entre 1000 et 2000 crédits par jour.', 600000, 150000, 0, 28000, 200, 0, 2, 0, 0, 0, 0, 0, 0, 1, 320000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 1, 1, 0, 0, 1000, 2000, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 100, 1000, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (208, 30, 'military_barracks', 'Caserne militaire', 'La caserne militaire permet d''accueillir 2 000 nouveaux soldats dans la colonie et l''entraînement de 100 soldats à la fois.', 22000, 10000, 0, 6000, 200, 0, 1, 0, 0, 0, 0, 0, 0, 200, 108000, true, 0, 0, 0, 0, 0, 0, 0, 2000, 0, 0, false, true, 0, 100, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (121, 32, 'hydrocarbon_hangar1', 'Réserve à hydrocarbure', 'Ce petit entrepôt augmente la capacité de stockage en hydrocarbure de 50 000.', 1000, 500, 0, 5000, 0, 0, 1, 0, 0, 0, 0, 50000, 0, 200, 9900, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, false, 10, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (404, 23, 'star_belt_panel', 'Ceinture d''étoile : capteur', 'Ajoute un capteur solaire à la ceinture d''étoile augmentant la production de 10 000 énergie/heure.', 400000, 300000, 0, 25000, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 5, 128000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 1000, 0, true, NULL, NULL, 0, 0, 10000, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (230, 30, 'housing', 'Habitations', 'Les habitations permettent d''augmenter la population civile au sein de la colonie et ainsi augmenter les besoins en minerai et hydrocarbure.<br/>

Les habitations génèrent 1 000 crédits par jour, la vitesse de formation des travailleurs augmente de 10% et les besoins en minerai et hydrocarbure augmentent sensiblement.', 30000, 18000, 0, 10000, 500, 0, 4, 0, 0, 0, 0, 0, 0, 10, 28000, true, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 10, 1, 0, 0, 1000, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0.1, 0.1, 18750, 18750, true, 0, 0);
INSERT INTO static.db_buildings VALUES (210, 80, 'receive_energy_satellite', 'Satellite de réception d''énergie', 'Ce satellite permet de recevoir un flux d''énergie provenant d''une autre planète située dans la même galaxie envoyé par un satellite émetteur.<br/>

L''énergie reçue est redirigée vers la rectenna et est ensuite utilisable par la colonie.', 9000, 6000, 0, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 200, 28000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, true, 0, false, 20, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (371, 40, 'sandworm_field', 'Champ de moissonneuses', 'Des moissonneuses récoltent une substance étrange à partir du sable de la planète où la présence de vers a été signalé récemment. Cette substance est ensuite exclusivement vendue à la guilde marchande qui y porte un très grand intérêt.<br/>

Suivant les récoltes, l''argent généré par jour varie entre 40 000 et 50 000 crédits.<br/>

De plus, chaque champ vous fait gagner 20 points de prestige par jour.', 30000, 17000, 0, 10000, 2000, 0, 7, 0, 0, 0, 0, 0, 0, 100, 78000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, true, 0, 0, 50, 1, 0, 0, 40000, 10000, 0, 0, 0, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 20, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (106, 30, 'laboratory', 'Laboratoire', 'Le laboratoire permet d''accueillir 1 000 scientifiques supplémentaire et la formation de 150 scientifiques par heure.', 2500, 2000, 0, 4000, 100, 0, 1, 0, 0, 0, 0, 0, 0, 200, 9600, true, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, false, false, 150, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (92, 100, 'ore_rich', 'Riche en minerai', 'De riches filons de minerai ont été découverts, nos mines de minerai minent plus vite.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0.15, 0, 0, 0, 0, 0, 0, 0, 0, 0, true, false, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 0, true, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (201, 10, 'colony2', 'Cité', 'De nouveaux bâtiment et ateliers sont construits à proximité de votre colonie ce qui vous permet d''emmagasiner 70 000 unités d''énergie supplémentaire et d''accueillir 10 000 nouveaux travailleurs.<br/>

La formation de vos travailleurs et l''efficacité de vos mines et puits sont légèrement augmentées.<br/>

La cité génère 1 500 crédits par jour.', 35000, 35000, 0, 6000, 100, 0, 2, 0, 0, 0, 0, 0, 10000, 1, 64800, true, 0.02, 0.02, 0.02, 0.1, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 1500, 0, 0, 0, 0, 1, 70000, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 15000);
INSERT INTO static.db_buildings VALUES (301, 10, 'colony3', 'Métropole', 'Votre colonie s''aggrandit encore et doit être, en partie, réorganisée.<br/>

Le contrôle de la production en minerai, hydrocarbures et énergie est désormais effectué par un centre dédié, la production s''en voit légérement augmentée.<br/>

Les anciens ateliers sont réaménagés et de nouveaux sont construits augmentant le nombre de travailleurs de 10 000.<br/>

La métropole génère 2 500 crédits par jour.', 200000, 200000, 0, 30000, 500, 0, 3, 1, 0, 0, 0, 0, 10000, 1, 259200, true, 0.02, 0.02, 0.02, 0.1, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 2500, 0, 0, 0, 0, 1, 0, true, 0, false, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 25000);
INSERT INTO static.db_buildings VALUES (202, 11, 'construction_plant2', 'Usine d''automates', 'Les ouvriers ne peuvent pas tout construire par eux-même, ils ont besoin d''aide méchanisée pour mener à bien les constructions, cette usine permet de construire de nouveaux bâtiments et augmente la vitesse de construction.', 22500, 15000, 0, 15000, 250, 0, 1, 0, 0, 0, 0, 0, 0, 1, 64800, true, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 100, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (118, 23, 'geothermal_power_plant', 'Centrale géothermique', 'Cette centrale transforme l''énergie thermique en provenance de l''intérieur de la planète en énergie.', 1500, 1250, 0, 1000, 0, 300, 1, 0, 0, 0, 0, 0, 0, 200, 3600, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 50, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (205, 80, 'shipyard', 'Chantier spatial', 'Le chantier spatial construit les vaisseaux de grande taille qu''il n''est pas possible d''assembler dans les usines de la colonie.', 40000, 30000, 0, 22000, 150, 0, 2, 6, 0, 0, 0, 0, 0, 1, 108000, true, 0, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 1500, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (105, 80, 'spaceport', 'Spatioport', 'Le spatioport permet la construction et le lancement en orbite de la plupart des vaisseaux utilitaires et des vaisseaux légers.<br/>

Pour les vaisseaux plus lourds, un chantier spatial est nécessaire, ceux-ci seront construits directement en orbite.', 2500, 2000, 0, 5000, 50, 0, 4, 0, 0, 0, 0, 0, 0, 1, 36000, true, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 200, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (103, 80, 'radar', 'Radar', 'Les radars vous permettent de scanner les planètes du secteur où se trouve votre planète.<br/>

Cela vous permet, par exemple, de connaître l''espace utilisable sur les planètes ou de visualiser les flottes proche d''une planète.<br/>

Construire plusieurs radars sur la même planète vous permettra de venir à bout des tentatives de brouillage radar ennemies.<br/>

Chaque radar augmente la puissance radar de la planète de 1.', 1000, 500, 0, 2000, 100, 0, 1, 0, 0, 0, 0, 0, 0, 200, 28800, true, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, true, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 150, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (209, 80, 'radar_satellite', 'Satellite radar', 'Les radars vous permettent de scanner les planètes du secteur où se trouve votre planète.<br/>

Chaque satellite augmente la puissance radar de la planète de 2.', 15000, 8500, 0, 7000, 300, 0, 0, 2, 0, 0, 0, 0, 0, 200, 39600, true, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, false, true, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, true, 0, false, 200, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, true, 0, 0);
INSERT INTO static.db_buildings VALUES (801, 110, 'prestige_ships_const_speed', 'Construction accélérée', 'Vous doublez la vitesse de construction de vos vaisseaux pour une durée de 24 heures.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 28800, true, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, false, false, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, false, 86400, true, 0, 0, true, NULL, NULL, 0, 0, 5000, 0, 0, 0, 0, true, 0, 0);


--
-- Data for Name: db_buildings_categories; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: db_buildings_req_building; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_buildings_req_building VALUES (201, 102);
INSERT INTO static.db_buildings_req_building VALUES (201, 101);
INSERT INTO static.db_buildings_req_building VALUES (202, 201);
INSERT INTO static.db_buildings_req_building VALUES (203, 201);
INSERT INTO static.db_buildings_req_building VALUES (205, 201);
INSERT INTO static.db_buildings_req_building VALUES (301, 202);
INSERT INTO static.db_buildings_req_building VALUES (301, 201);
INSERT INTO static.db_buildings_req_building VALUES (302, 301);
INSERT INTO static.db_buildings_req_building VALUES (303, 302);
INSERT INTO static.db_buildings_req_building VALUES (303, 301);
INSERT INTO static.db_buildings_req_building VALUES (303, 203);
INSERT INTO static.db_buildings_req_building VALUES (321, 301);
INSERT INTO static.db_buildings_req_building VALUES (320, 301);
INSERT INTO static.db_buildings_req_building VALUES (221, 201);
INSERT INTO static.db_buildings_req_building VALUES (220, 201);
INSERT INTO static.db_buildings_req_building VALUES (222, 201);
INSERT INTO static.db_buildings_req_building VALUES (207, 201);
INSERT INTO static.db_buildings_req_building VALUES (218, 207);
INSERT INTO static.db_buildings_req_building VALUES (208, 201);
INSERT INTO static.db_buildings_req_building VALUES (308, 301);
INSERT INTO static.db_buildings_req_building VALUES (206, 201);
INSERT INTO static.db_buildings_req_building VALUES (204, 201);
INSERT INTO static.db_buildings_req_building VALUES (309, 301);
INSERT INTO static.db_buildings_req_building VALUES (391, 301);
INSERT INTO static.db_buildings_req_building VALUES (209, 201);
INSERT INTO static.db_buildings_req_building VALUES (390, 201);
INSERT INTO static.db_buildings_req_building VALUES (390, 202);
INSERT INTO static.db_buildings_req_building VALUES (510, 10);
INSERT INTO static.db_buildings_req_building VALUES (102, 101);
INSERT INTO static.db_buildings_req_building VALUES (115, 101);
INSERT INTO static.db_buildings_req_building VALUES (116, 101);
INSERT INTO static.db_buildings_req_building VALUES (117, 101);
INSERT INTO static.db_buildings_req_building VALUES (103, 101);
INSERT INTO static.db_buildings_req_building VALUES (105, 101);
INSERT INTO static.db_buildings_req_building VALUES (106, 101);
INSERT INTO static.db_buildings_req_building VALUES (120, 101);
INSERT INTO static.db_buildings_req_building VALUES (121, 101);
INSERT INTO static.db_buildings_req_building VALUES (1020, 1001);
INSERT INTO static.db_buildings_req_building VALUES (1021, 1001);
INSERT INTO static.db_buildings_req_building VALUES (118, 101);
INSERT INTO static.db_buildings_req_building VALUES (370, 96);
INSERT INTO static.db_buildings_req_building VALUES (371, 96);
INSERT INTO static.db_buildings_req_building VALUES (310, 302);
INSERT INTO static.db_buildings_req_building VALUES (210, 207);
INSERT INTO static.db_buildings_req_building VALUES (310, 207);
INSERT INTO static.db_buildings_req_building VALUES (217, 202);
INSERT INTO static.db_buildings_req_building VALUES (317, 302);
INSERT INTO static.db_buildings_req_building VALUES (602, 101);
INSERT INTO static.db_buildings_req_building VALUES (401, 301);
INSERT INTO static.db_buildings_req_building VALUES (400, 301);
INSERT INTO static.db_buildings_req_building VALUES (402, 301);
INSERT INTO static.db_buildings_req_building VALUES (230, 201);
INSERT INTO static.db_buildings_req_building VALUES (801, 101);
INSERT INTO static.db_buildings_req_building VALUES (404, 403);
INSERT INTO static.db_buildings_req_building VALUES (403, 207);
INSERT INTO static.db_buildings_req_building VALUES (231, 201);
INSERT INTO static.db_buildings_req_building VALUES (125, 101);


--
-- Data for Name: db_buildings_req_research; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_buildings_req_research VALUES (80, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (1001, 3, 1);
INSERT INTO static.db_buildings_req_research VALUES (317, 402, 3);
INSERT INTO static.db_buildings_req_research VALUES (317, 404, 3);
INSERT INTO static.db_buildings_req_research VALUES (101, 0, 1);
INSERT INTO static.db_buildings_req_research VALUES (217, 402, 2);
INSERT INTO static.db_buildings_req_research VALUES (317, 403, 3);
INSERT INTO static.db_buildings_req_research VALUES (118, 401, 2);
INSERT INTO static.db_buildings_req_research VALUES (391, 405, 1);
INSERT INTO static.db_buildings_req_research VALUES (390, 405, 1);
INSERT INTO static.db_buildings_req_research VALUES (901, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (902, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (903, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (904, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (10, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (11, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (50, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (51, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (52, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (90, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (91, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (92, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (93, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (94, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (99, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (95, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (96, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (381, 1, 1);
INSERT INTO static.db_buildings_req_research VALUES (370, 410, 1);
INSERT INTO static.db_buildings_req_research VALUES (371, 410, 1);
INSERT INTO static.db_buildings_req_research VALUES (210, 420, 1);
INSERT INTO static.db_buildings_req_research VALUES (310, 420, 1);
INSERT INTO static.db_buildings_req_research VALUES (403, 402, 3);
INSERT INTO static.db_buildings_req_research VALUES (403, 403, 3);
INSERT INTO static.db_buildings_req_research VALUES (403, 404, 3);


--
-- Data for Name: db_firstnames; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_firstnames VALUES ('Alia');
INSERT INTO static.db_firstnames VALUES ('Leto');
INSERT INTO static.db_firstnames VALUES ('Siona');
INSERT INTO static.db_firstnames VALUES ('Gurney');
INSERT INTO static.db_firstnames VALUES ('Vladimir');
INSERT INTO static.db_firstnames VALUES ('Darwi');
INSERT INTO static.db_firstnames VALUES ('Duncan');
INSERT INTO static.db_firstnames VALUES ('Paul');
INSERT INTO static.db_firstnames VALUES ('Ben');
INSERT INTO static.db_firstnames VALUES ('Jacen');
INSERT INTO static.db_firstnames VALUES ('Maximus');
INSERT INTO static.db_firstnames VALUES ('Yan');
INSERT INTO static.db_firstnames VALUES ('John');
INSERT INTO static.db_firstnames VALUES ('Alexandre');
INSERT INTO static.db_firstnames VALUES ('Charles');
INSERT INTO static.db_firstnames VALUES ('Robert');
INSERT INTO static.db_firstnames VALUES ('Pavel');
INSERT INTO static.db_firstnames VALUES ('Travis');
INSERT INTO static.db_firstnames VALUES ('Leonard');
INSERT INTO static.db_firstnames VALUES ('Tina');
INSERT INTO static.db_firstnames VALUES ('Kira');
INSERT INTO static.db_firstnames VALUES ('Janice');
INSERT INTO static.db_firstnames VALUES ('Alfred');
INSERT INTO static.db_firstnames VALUES ('Marcus');
INSERT INTO static.db_firstnames VALUES ('Thomas');
INSERT INTO static.db_firstnames VALUES ('Oliver');
INSERT INTO static.db_firstnames VALUES ('Douglas');
INSERT INTO static.db_firstnames VALUES ('Conrad');
INSERT INTO static.db_firstnames VALUES ('Jane');
INSERT INTO static.db_firstnames VALUES ('James');
INSERT INTO static.db_firstnames VALUES ('Frank');
INSERT INTO static.db_firstnames VALUES ('Arthur');
INSERT INTO static.db_firstnames VALUES ('Richard');
INSERT INTO static.db_firstnames VALUES ('Steve');
INSERT INTO static.db_firstnames VALUES ('Julian');
INSERT INTO static.db_firstnames VALUES ('Dave');
INSERT INTO static.db_firstnames VALUES ('William');
INSERT INTO static.db_firstnames VALUES ('Walter');
INSERT INTO static.db_firstnames VALUES ('Eric');
INSERT INTO static.db_firstnames VALUES ('Tony');
INSERT INTO static.db_firstnames VALUES ('Peter');
INSERT INTO static.db_firstnames VALUES ('Max');
INSERT INTO static.db_firstnames VALUES ('Martin');
INSERT INTO static.db_firstnames VALUES ('David');
INSERT INTO static.db_firstnames VALUES ('Leo');
INSERT INTO static.db_firstnames VALUES ('Howard');
INSERT INTO static.db_firstnames VALUES ('Julius');
INSERT INTO static.db_firstnames VALUES ('Chris');
INSERT INTO static.db_firstnames VALUES ('Cyril');
INSERT INTO static.db_firstnames VALUES ('Anne');
INSERT INTO static.db_firstnames VALUES ('Anke');
INSERT INTO static.db_firstnames VALUES ('Alberto');
INSERT INTO static.db_firstnames VALUES ('Nicolas');
INSERT INTO static.db_firstnames VALUES ('Arkan');
INSERT INTO static.db_firstnames VALUES ('André');
INSERT INTO static.db_firstnames VALUES ('Mike');


--
-- Data for Name: db_items; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_items VALUES (7, 0, 'food', 'Nourriture', '', false, true, 0);
INSERT INTO static.db_items VALUES (8, 0, 'water', 'Eau', '', false, true, 0);
INSERT INTO static.db_items VALUES (6, 0, 'energy', 'Energie', '', false, true, 0);
INSERT INTO static.db_items VALUES (1, 0, 'ore', 'Minerai', '', false, true, 1);
INSERT INTO static.db_items VALUES (2, 0, 'hydrocarbon', 'Hydrocarbure', '', false, true, 1);
INSERT INTO static.db_items VALUES (3, 0, 'worker', 'Travailleur', '', false, true, 5);
INSERT INTO static.db_items VALUES (4, 0, 'scientist', 'Ingénieur', '', false, true, 5);
INSERT INTO static.db_items VALUES (5, 0, 'soldier', 'Soldat', '', false, true, 5);


--
-- Data for Name: db_lcid; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: db_messages; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_messages VALUES (1, 1036, 'Rapport de colonisation', 'Notre nouvelle colonie est prête à accueillir nos colons !

Nous devrions commencer à produire de l''énergie, à extraire du minerai et des hydrocarbures dès que possible afin d''assurer le développement de la colonie.

Vous pouvez lancer la construction de nouveaux bâtiments à partir de la page Planète / Infrastructures.

Gagnez des crédits en vendant des ressources dans la page Planète / Marché, un marchand de la Guilde Marchande (géré par ordinateur) viendra au bout de 3 à 4 heures sur la planète pour prendre les ressources vendues. Les marchands payent la moitié de l''argent à la vente puis la seconde moitié est payée une fois que leurs vaisseaux sont revenus sur leur planète.

Cet argent vous servira à l''entretien de vos infrastructures et vaisseaux, à faire des recherches afin de débloquer de nouveaux bâtiments et d''autres recherches, à construire de nouveaux vaisseaux et pour les salaires de vos commandants (notez que votre premier commandant ne vous coûte rien).

En tant que nouvelle nation, vos planètes ne peuvent être attaquées pendant deux semaines. Profitez-en pour faire connaissance avec les nations autour de vous.

Pendant cette période de protection, vous ne pourrez ni recevoir ni envoyer d''argent par la messagerie du jeu ou par la demande de financement de l''alliance.

Développez-vous, augmentez votre production en construisant des mines de minerai et des puits d''hydrocarbure.

Fin de transmission.', '');
INSERT INTO static.db_messages VALUES (4, 1036, 'Fin de contrat', 'Cher client,

J''ai le regret de vous annoncer la fin du contrat vous procurant un bonus sur les ventes de ressources que vous effectuez avec nous.

Cordialement,

Votre représentant de la Guilde Marchande', 'Guilde Marchande');
INSERT INTO static.db_messages VALUES (3, 1036, 'Reconduction tacite de notre contrat', 'Cher client,

Je suis heureux de vous apprendre que notre contrat se prolonge pour une durée de 7 nouveaux jours.

Cordialement,

Votre représentant de la Guilde Marchande', 'Guilde Marchande');
INSERT INTO static.db_messages VALUES (2, 1036, 'Contrat spécial de vente', 'Cher client,

Votre nation fait parti de nos vingt plus importants fournisseurs de ressources aussi nous avons le plaisir de vous annoncer qu''à partir de maintenant et ceci pour une durée d''une semaine, vous bénéficierez d''un bonus de 5% sur le prix de vente de votre minerai et hydrocarbure.

Continuez ainsi et je ne doute pas que ce contrat sera reconduit.

Cordialement,

Votre représentant de la Guilde Marchande', 'Guilde Marchande');
INSERT INTO static.db_messages VALUES (5, 1036, 'Recherches', 'Votre équipe de scientifiques attend vos ordres. Vous pouvez choisir une recherche en allant sur la page "Recherche" du menu Empire.

Nous ne connaissons pas bien les environs de notre colonie, nous pouvons construire un radar mais nous n''aurons que les informations relatives aux planètes de notre secteur.

Il serait bien de débloquer les sondes qui sont de petits appareils très rapides idéaux pour découvrir les planètes d''autres secteurs.

Pour cela, nous avons besoin de faire des recherches en mécanique et nous aurons aussi besoin d''un spatioport pour construire les vaisseaux.

Afin de construire le vaisseau de colonisation, nous avons besoin de "Mécanique" niveau 1 et de "Vaisseau Utilitaire" niveau 3.

Fin de transmission.', '');
INSERT INTO static.db_messages VALUES (7, 1036, 'Premier vaisseau de colonisation', 'Il est désormais temps d''agrandir notre empire en colonisant de nouvelles planètes.

Pour coloniser, vous allez avoir besoin de former une flotte avec votre vaisseau de colonisation et trouver une planète non occupée pour établir votre colonie dans un secteur autre que votre secteur de départ (notez les coordonnées de cette planète).

Lorsque votre future planète est choisie, déplacez votre flotte contenant votre vaisseau de colonisation vers cette planète. Les vaisseaux de colonisation sont très lent et cela prendra plusieurs heures (ou jours suivant la distance à parcourir).

Une fois arrivée à destination, allez dans la page de votre flotte et déployer votre vaisseau de colonisation : bouton "déployer" tout à droite de la page.

Bravo, vous avez désormais une colonie supplémentaire à faire évoluer.

Notez que vous avez besoin de la recherche "Gestion d''Empire" au niveau 2 pour coloniser une deuxième planète.

Fin de transmission.', '');
INSERT INTO static.db_messages VALUES (6, 1036, 'Premier vaisseau', 'Félicitation, vous venez de construire votre premier vaisseau !

Afin de pouvoir le déplacer, vous devez former une flotte à partir de la page "Orbite" de la planète où votre vaisseau a été construit.

Une fois formée, vous pouvez obtenir la liste de vos flottes à partir de la page "Flottes" du menu Empire.

Cliquez sur votre flotte pour observer sa composition et lui donner des ordres :

 - déplacer

 - charger/décharger des ressources

 - changer le mode d''engagement

 - regrouper/scinder

 - déployer un bâtiment

 - envahir une planète si votre flotte possède des barges et des soldats

 - récolter si votre flotte possède des récolteurs

Fin de transmission', '');
INSERT INTO static.db_messages VALUES (10, 1036, 'Résultat de la loterie', 'Vous avez misé un total de $1 crédits malheureusement vous n''avez pas gagné.', 'Guilde Marchande');
INSERT INTO static.db_messages VALUES (12, 1036, 'Début de la loterie ', 'Bonjour,

Nous avons le plaisir de vous annoncer le début de la prochaine loterie intergalactique dont le tirage a lieu chaque vendredi à minuit.

Le gagnant recevra un Dreadnought d''élite directement sorti de nos industries et envoyé à destination d''une de ses planètes.

Afin de piloter ce vaisseau d''exception, vous devrez posséder les connaissances nécessaire au pilotage des croiseurs d''élite.

Pour participer, envoyez-nous simplement un message en joignant la somme de crédit que vous voulez.

Plus la somme est élevée, plus vos chances de gagner augmentent et celles des autres diminuent.

Bon jeu !', 'Guilde Marchande');
INSERT INTO static.db_messages VALUES (11, 1036, 'Résultat de la loterie', 'Vous avez misé un total de $1 crédits dans notre loterie intergalactique et vous avez gagné !

Votre lot a déjà quitté nos hangars et nous vous en souhaitons une bonne réception.', 'Guilde Marchande');


--
-- Data for Name: db_names; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_names VALUES ('Burnett');
INSERT INTO static.db_names VALUES ('Adams');
INSERT INTO static.db_names VALUES ('Leary');
INSERT INTO static.db_names VALUES ('Page');
INSERT INTO static.db_names VALUES ('Keats');
INSERT INTO static.db_names VALUES ('Keller');
INSERT INTO static.db_names VALUES ('Anderson');
INSERT INTO static.db_names VALUES ('Aicard');
INSERT INTO static.db_names VALUES ('Allen');
INSERT INTO static.db_names VALUES ('Atwood');
INSERT INTO static.db_names VALUES ('Augustus');
INSERT INTO static.db_names VALUES ('Estrada');
INSERT INTO static.db_names VALUES ('Eckhart');
INSERT INTO static.db_names VALUES ('Hebey');
INSERT INTO static.db_names VALUES ('Huxley');
INSERT INTO static.db_names VALUES ('Harris');
INSERT INTO static.db_names VALUES ('Hnin Yu');
INSERT INTO static.db_names VALUES ('Muller');
INSERT INTO static.db_names VALUES ('Moore');
INSERT INTO static.db_names VALUES ('Monroe');
INSERT INTO static.db_names VALUES ('O''Neill');
INSERT INTO static.db_names VALUES ('Orban');
INSERT INTO static.db_names VALUES ('Orwell');
INSERT INTO static.db_names VALUES ('Thompson');
INSERT INTO static.db_names VALUES ('Carr');
INSERT INTO static.db_names VALUES ('Chen');
INSERT INTO static.db_names VALUES ('Claudius');
INSERT INTO static.db_names VALUES ('Gambetta');
INSERT INTO static.db_names VALUES ('Grant');
INSERT INTO static.db_names VALUES ('Newton');
INSERT INTO static.db_names VALUES ('Nietzsche');
INSERT INTO static.db_names VALUES ('Nerval');
INSERT INTO static.db_names VALUES ('Bonaparte');
INSERT INTO static.db_names VALUES ('Nin');
INSERT INTO static.db_names VALUES ('Neumann');
INSERT INTO static.db_names VALUES ('Rolland');
INSERT INTO static.db_names VALUES ('Rousseau');
INSERT INTO static.db_names VALUES ('Rostand');
INSERT INTO static.db_names VALUES ('Russel');
INSERT INTO static.db_names VALUES ('Ruskin');
INSERT INTO static.db_names VALUES ('Surcouffe');
INSERT INTO static.db_names VALUES ('Shepard');
INSERT INTO static.db_names VALUES ('Sheen');
INSERT INTO static.db_names VALUES ('Smith');
INSERT INTO static.db_names VALUES ('Doe');
INSERT INTO static.db_names VALUES ('Sterne');
INSERT INTO static.db_names VALUES ('Stuart');
INSERT INTO static.db_names VALUES ('Swift');
INSERT INTO static.db_names VALUES ('Scott');
INSERT INTO static.db_names VALUES ('Falcon');
INSERT INTO static.db_names VALUES ('Wartburg');
INSERT INTO static.db_names VALUES ('Wesley');
INSERT INTO static.db_names VALUES ('Wiesel');
INSERT INTO static.db_names VALUES ('Wolfe');
INSERT INTO static.db_names VALUES ('Wei');
INSERT INTO static.db_names VALUES ('Wellington');
INSERT INTO static.db_names VALUES ('Mairet');
INSERT INTO static.db_names VALUES ('Riker');


--
-- Data for Name: db_orientations; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: db_research; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_research VALUES (110, 10, 'advanced_deployement', 'Déploiement avancé de bâtiment', 'En améliorant la technologie des vaisseaux de colonisation, il sera possible de créer des vaisseaux spécialement prévus pour déployer un bâtiment très rapidement sur les bases d''une colonie déjà existante.<br/>

Malheureusement, tous les bâtiments ne peuvent pas être adaptés à cette technologie.', 2, 1, 0, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (501, 50, 'weaponry', 'Armement', 'Recherchez de nouvelles armes afin d''équiper vos vaisseaux. Sans armes, vous serez limités à vous déplacer en vaisseau cargo.<br/>

L''arme de base est le canon laser, facile à produire avec une bonne cadence de tir, il équipera vos premiers vaisseaux légers.', 3, 5, 1, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (203, 20, 'mining', 'Extraction de minerai', 'Des améliorations au niveau du rendement sont effectuées ce qui augmente légèrement la production de minerai.<br/>

Chaque niveau augmente la production de minerai de 1%.', 2, 5, 0, 90, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (206, 20, 'improved_refining', 'Extraction d''hydrocarbure améliorée', 'L''amélioration de vos raffineries réduit les pertes liées au traitement des hydrocarbures.<br/>

Chaque niveau augmente la production d''hydrocarbure de 1%.', 7, 5, 0, 2000, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (402, 40, 'nuclear_physics', 'Physique nucléaire', 'La physique nucléaire est l''étude du comportement du noyau atomique.<br/>

Effectuez des recherches dans ce domaine pour trouver des applications pratiques tel que des centrales d''énergie ou des armes.', 2, 3, 0, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (502, 50, 'rockets', 'Roquettes', 'Les roquettes sont des projectiles autopropulsés non guidés principalement utilisés par les vaisseaux de tailles moyennes pour endommager et détruire des cibles plus importantes.<br/>

Une usine d''armement léger est nécessaire pour construire les lance-roquettes.', 2, 1, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (503, 50, 'missiles', 'Missiles', 'Les missiles constituent une très grande amélioration des roquettes, une fois qu''une cible est acquise, le missile se dirige tout seul vers celle-ci ce qui le rend utilisable par n''importe quel vaisseau.<br/>

Les missiles se dirigent aussi facilement que le meilleur des chasseurs cependant ils peuvent être esquivés par ceux-ci. Lorsque le missile n''a plus de combustible, sa charge est automatiquement désactivée afin d''éviter de se faire endommager par ses propres missiles en les percutant ce qui arrive très rarement.<br/>

Une usine d''armement léger est nécessaire pour construire les lance-missiles.', 4, 1, 0, 110, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (504, 50, 'laser_turrets', 'Tourelles à canon laser', 'Les tourelles à canon laser donnent à vos vaisseaux moins maniables une chance de cibler les vaisseaux plus légers et plus maniables. Elles deviennent de plus en plus essentielles à mesure que vos vaisseaux s''allourdissent et perdent en maniabilité.<br/>

Une usine d''armement léger est nécessaire pour construire ces tourelles.', 2, 3, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (505, 50, 'railgun', 'Railgun', 'Le railgun est un nouveau type de tourelle reposant sur l''envoi de projectiles à très grande vitesse pour un effet dévastateur. Bien que le railgun soit aidé par un ordinateur qui anticipe la direction du vaisseau ciblé, il est assez facile d''éviter ses projectiles.<br/>

Les premiers types de railgun peuvent être construits dans une usine d''armement léger, cependant les railguns plus avancés demanderont une usine d''armement lourd.', 5, 3, 0, 210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (506, 50, 'ion_cannon', 'Canon à ion', 'Le canon à ion tire des jets de particules ionisées traversant les boucliers. Sa spécificité repose sur le fait qu''il n''inflige pas directement de dégats physique mais surcharge les circuits électriques de la cible pouvant provoquer d''importantes explosions.<br/>

Une usine d''armement lourd est nécessaire pour construire les canons à ion.', 6, 1, 0, 290, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (510, 50, 'enhanced_shield', 'Déflecteurs améliorés', 'L''amélioration des déflecteurs permet de mieux régler la force des boucliers sur les différentes parties de sa surface suivant l''origine de la menace.<br/>

Chaque niveau augmente l''efficacité des boucliers de 5%.', 6, 5, 0, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (902, 90, 'utility_ship_construction', 'Construction de vaisseaux utilitaires', 'Les vaisseaux utilitaires regroupent :<br/>

- Les vaisseaux de transport qui sont de grandes coques vides servant à transporter vos ressources ou du personnel vers une autre planète. Un grand équipage est nécessaire pour l''entretien de ces vaisseaux.<br/>

- Les vaisseaux de colonisation qui sont des vaisseaux construit pour se déployer automatiquement en un bâtiment fonctionnel.<br/>

- Les vaisseaux de recyclage qui vous serviront à récupérer des ressources parmi les débris laissés après des batailles.<br/>

Un chantier spatial est nécessaire pour construire la plupart de ces vaisseaux.', 1, 5, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (401, 40, 'science', 'Science', 'Cette branche vous permet de découvrir de nouvelles sources d''énergies pour un usage pacifique ou militaire.', 3, 5, 2, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (204, 20, 'improved_mining', 'Extraction de minerai améliorée', 'L''amélioration des machines d''extraction permet une légère augmentation de la production de minerai.<br/>

Chaque niveau augmente la production de minerai de 1%.', 7, 5, 0, 2000, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (22, 2, 'bonus_soldiers', 'Bonus d''entretient des soldats', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (301, 30, 'planet_control', 'Gestion d''empire', 'Permet d''augmenter le nombre maximum de planètes que vous pouvez gérer de 1 par niveau.', 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (101, 10, 'propulsion', 'Propulsion', 'L''élément primordial de tout vaisseau est la propulsion car un vaisseau immobile est une cible facile.<br/>

Avant de pouvoir élaborer de nouveaux chassis pour vos vaisseaux, vous devez rechercher des moteurs capables de propulser ceux-ci. Plus la propulsion sera puissante, plus les chassis seront importants.<br/>

Chaque niveau augmente la vitesse des vaisseaux de 1%.', 1, 5, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (32, 3, 'unlock_r_advanced_deployement', 'Déblocage du déploiement avancé de bâtiment', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (102, 10, 'energy_conservation', 'Conservation de l''énergie', 'La propulsion est le système qui consomme le plus de puissance sur un vaisseau.<br/>

Effectuez des recherches dans ce domaine pour pouvoir équiper vos plus gros vaisseaux de moteurs sans pour autant être un gouffre en énergie.<br/>

Ces recherches sont applicables à la gestion d''énergie de vos colonies et permet d''augmenter la production d''énergie de vos centrales.<br/>

Chaque niveau augmente la production d''énergie des centrales de 2%.', 3, 5, 0, 220, 0, 0, 0.02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (907, 90, 'cruiser_construction', 'Construction de croiseurs', 'Les croiseurs ont été pensés pour être robustes et avoir une bonne puissance de feu aussi la coque n''a pas été prévue pour accueillir un autre type d''arme que des railguns.<br/>

Un chantier spatial est nécessaire pour construire les croiseurs.', 6, 3, 0, 600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (1, 0, 'evil_science', 'Technologie des fossoyeurs', 'La science spécifique aux technologies des fossoyeurs', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.25, 0.3, 0.5, 0.45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (420, 40, 'energy_transfer', 'Transfert d''énergie', 'Cette technologie permet de transférer la  production d''énergie d''une planète vers une autre grâce à des satellites émetteurs et récepteurs placés en orbite.<br/>

Le système n''est pas parfait et une perte d''énergie est à prévoir suivant la distance séparant les planètes.<br/>

Une rectenna est requise pour faire le lien entre la colonie et les satellites.', 1, 1, 0, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.6, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (421, 40, 'enhanced_energy_transfer', 'Transfert d''énergie amélioré', 'Chaque niveau améliore l''efficacité de vos satellites émetteurs d''énergie de 5% pour une distance de 100 unités.', 6, 5, 0, 1500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (5, 0, 'special_merchant_contract', 'Special contrat marchand', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (12, 1, 'unlock_s_merchant_ship', 'Déblocage de la caravelle marchande', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (403, 40, 'plasma_physics', 'Physique des plasmas', 'La physique des plasmas est l''étude des propriétés des gaz ionisés à haute température, tels qu''on les trouve au coeur des étoiles.<br/>

Maîtriser cette énergie vous permettra de trouver des applications pratiques tel que des centrales d''énergie ou des armes.', 4, 3, 0, 1600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (404, 40, 'quantum_physics', 'Physique quantique', 'La physique quantique étudie les lois fondamentales de la physique au niveau subatomique. Faire des recherches dans ce domaine vous permettra sûrement de développer de nouvelles sources d''énergie.', 6, 3, 0, 700, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (31, 3, 'bonus_cheaper_research', 'Bonus recherche moins couteuse', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.2, 0, 0, -0.2, -0.05, 0, 0, 0, 0, 0, 0.03, 0, 0.03, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (406, 40, 'scalar_waves', 'Ondes scalaires', 'L''étude des ondes scalaires pourrait bien être l''étape majeure suivant la physique quantique. Nos scientifiques sont partagés quant à la réalité de ces ondes mais celles-ci pourraient être responsables de la gravité et de l''écoulement du temps.', 10, 5, 0, 4000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (901, 90, 'mechanic', 'Mécanique', 'La recherche en mécanique permet de trouver de nouveaux designs dans la construction de vaisseaux et l''amélioration de la vitesse de construction de ceux-ci en optimisant les étapes de construction.<br/>

Chaque niveau augmente la vitesse de construction des vaisseaux de 1%.', 3, 5, 1, 50, 0, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (405, 40, 'planetology', 'Planétologie', 'La planétologie est la science de l''étude des planètes. Faites des recherches dans ce domaine afin que vos scientifiques cherchent des solutions pour augmenter la place disponible sur vos planètes.<br/>

Vous avez besoin de 5 centres de recherche pour développer cette recherche.<br/>

Une fois débloqué, vous pourrez construire 2 nouveaux types de bâtiment sur vos colonies permettant d''augmenter la place sur celles-ci.', 8, 1, 0, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (3, 0, 'merchant_science', 'Technologie marchande', 'La science spécifique aux technologies marchandes.', 0, 1, 0, 0, 0.6, 0.6, 0, 0, 0.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (410, 40, 'sandworm_study', 'Etude des vers de sable', 'Les vers de sable peuvent être trouvés sur quelques rares planètes. Ils sont gigantesques et sont attirés par tout ce qui émet des vibrations régulières.<br/>

Nos scientifiques devraient être capables de concevoir une barrière capable de les tenir à l''écart de la colonie.<br/>

Nous avons besoin d''une planète ayant cette particularité afin que nos scientifiques puissent travailler dessus.', 5, 1, 0, 786, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (205, 20, 'refining', 'Extraction d''hydrocarbure', 'Des améliorations au niveau de l''extraction permet d''augmenter la production d''hydrocarbure.<br/>

Chaque niveau augmente la production d''hydrocarbure de 1%.', 2, 5, 0, 90, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (202, 20, 'mass_production', 'Production à la chaîne', 'La standardisation des produits et matériaux utilisés dans la plupart des constructions permet une diminution du temps de construction global des bâtiments et des vaisseaux spaciaux.<br/>

Chaque niveau augmente la vitesse de construction des bâtiments de 4% et de vos vaisseaux de 5%.', 3, 5, 0, 600, 0, 0, 0, 0, 0.04, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (20, 2, 'bonus_faster_ship_construction', 'Bonus vitesse de construction de vaisseaux', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0.2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (908, 90, 'dreadnought_construction', 'Construction de dreadnought', 'La classe de vaisseau dreadnought est le grand frère du croiseur. Nos scientifiques ont pensé l''architecture pour que toutes les armes puissent être adaptées à la coque. Pour se faire, le vaisseau a une forme allongée et ses moteurs délivrent une énorme puissance.<br/>

Un chantier spatial est nécessaire pour construire les dreadnoughts.', 10, 3, 0, 3500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (906, 90, 'frigate_construction', 'Construction de frégates', 'Les frégates sont des vaisseaux de taille moyenne dotés d''une coque très modulable qui permet d''accueillir des railguns, des missiles ou même un canon à ion.<br/>

Un chantier spatial est nécessaire pour construire les frégates.', 4, 3, 0, 350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (30, 3, 'bonus_faster_fleets_build', 'Bonus production d''énergie', 'Votre orientation de scientifique vous procure une production augmentée d''énergie.', 0, 1, 0, 0, 0, 0, 0.2, 0, 0.1, 0, 0, 0.2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (21, 2, 'bonus_combat', 'Bonus de combat', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 0, 0, 0, 0, 0, 0, 0, -0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.05, 0.1, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (40, 4, 'warlord_bonus', 'Seigneur de guerre', 'Votre orientation vous procure une production augmentée de minerai, d''hydrocarbure et d''énergie.', 0, 1, 0, 0, 4, 4, 4, 4, 4, 4, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.75, 0, 0, 0, 0, 0, 1, 1, 3, 3, 3, 0, NULL);
INSERT INTO static.db_research VALUES (903, 90, 'tactical_ship_construction', 'Construction de vaisseaux tactiques', 'Les vaisseaux tactiques regroupent :<br/>

 - Les vaisseaux mère qui donnent des bonus aux flottes auxquelles ils appartiennent<br/>

 - Les vaisseaux radar qui peuvent être déployés sur une de vos planètes, une planète alliée ou un emplacement vide afin d''obtenir une vision d''un secteur complet pour une durée limitée<br/>

 - Les vaisseaux de brouillage qui peuvent être déployés sur une de vos planètes, une planète alliée ou un emplacement vide pour une durée limitée', 8, 3, 0, 800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (303, 30, 'warlord_research', 'Gestion d''empire galactique', 'Permet d''augmenter le nombre maximum de planètes que vous pouvez gérer de 10 par niveau.', -4, 98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (905, 90, 'corvette_construction', 'Construction de corvettes', 'Les corvettes sont des vaisseaux un peu plus gros que les vaisseaux légers mais gardant néanmoins une bonne manoeuvrabilité.<br/>

 Ils bénéficient d''une plus grande puissance ce qui permet de les équiper avec des armes plus grosses ou en plus grand nombre ce qui offre une bonne base pour contrer les vaisseaux légers et attaquer les vaisseaux lourds.<br/>

Les corvettes devraient être équipées de tourelles laser ou de roquettes.<br/>

Vous aurez besoin d''un spatioport pour construire les corvettes.', 2, 3, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (201, 20, 'industry', 'Industrie', 'Vos scientifiques peuvent effectuer des recherches dans le domaine de l''industrie pour améliorer certains bâtiments et machines afin d''augmenter le rendement ou diminuer le temps de construction.<br/>

Chaque niveau augmente la vitesse de construction des bâtiments de 1%.', 3, 5, 0, 40, 0, 0, 0, 0, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (10, 1, 'bonus_buy_sell', 'Bonus achat/vente', '-', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (11, 1, 'bonus_better_production', 'Orientation de marchand', 'Votre orientation de marchand vous procure une production augmentée de minerai et d''hydrocarbure.', 0, 1, 0, 0, 0.05, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -0.05, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0, 0.05, 0.1, 0.1, 0, NULL);
INSERT INTO static.db_research VALUES (105, 10, 'jumpdrive', 'Saut hyperspatial', 'Les sauts dans l''hyper-espace permettent de traverser de grandes distances en utilisant les vortex.<br/>

Cette technologie est requise pour les voyages intergalactiques.<br/>

Vous avez besoin de 3 centres de recherche pour développer le saut hyperspatial.', 7, 1, 0, 4000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (904, 90, 'light_ship_construction', 'Construction de vaisseaux légers', 'La coque réduite ne permet pas une grande variété de modifications aussi les vaisseaux de ce type sont limités à deux canons lasers.<br/>

Il ne vous faudra qu''un simple spatioport pour pouvoir construire vos vaisseaux légers.', 1, 3, 1, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (109, 10, 'temp_bonus_speed', 'Surcharge de la propulsion', 'Cette recherche permet d''augmenter la vitesse de tous les vaisseaux de 10% pendant 48 heures.', 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '48:00:00');
INSERT INTO static.db_research VALUES (509, 50, 'temp_bonus_weapon', 'Surcharge de l''armement', 'Cette recherche permet d''augmenter la puissance de feu de tous les vaisseaux de 10% pendant 48 heures.', 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '48:00:00');
INSERT INTO static.db_research VALUES (519, 50, 'temp_bonus_shield', 'Surcharge des boucliers', 'Cette recherche permet d''augmenter l''efficacité des boucliers de 10% pendant 48 heures.', 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '48:00:00');
INSERT INTO static.db_research VALUES (302, 30, 'commanders_control', 'Hiérarchie de commandement', 'Permet d''augmenter le nombre maximum de commandants dont vous pouvez disposer de 1 par niveau.', 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (50, 5, 'exile_bonus', 'Exilé', 'Stats de base des exilés', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 80, 0, 0, 0, 1, 0, 0, 0, 0, NULL);
INSERT INTO static.db_research VALUES (0, 0, 'human_science', 'Technologie humaine', 'La science spécifique aux humains', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 0, NULL);


--
-- Data for Name: db_research_req_building; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_research_req_building VALUES (105, 206, 3);
INSERT INTO static.db_research_req_building VALUES (405, 206, 5);
INSERT INTO static.db_research_req_building VALUES (410, 96, 1);


--
-- Data for Name: db_research_req_research; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_research_req_research VALUES (202, 201, 3);
INSERT INTO static.db_research_req_research VALUES (203, 201, 2);
INSERT INTO static.db_research_req_research VALUES (204, 201, 5);
INSERT INTO static.db_research_req_research VALUES (204, 203, 5);
INSERT INTO static.db_research_req_research VALUES (205, 201, 3);
INSERT INTO static.db_research_req_research VALUES (206, 201, 5);
INSERT INTO static.db_research_req_research VALUES (206, 205, 5);
INSERT INTO static.db_research_req_research VALUES (403, 401, 5);
INSERT INTO static.db_research_req_research VALUES (404, 401, 3);
INSERT INTO static.db_research_req_research VALUES (502, 501, 2);
INSERT INTO static.db_research_req_research VALUES (505, 504, 3);
INSERT INTO static.db_research_req_research VALUES (501, 901, 1);
INSERT INTO static.db_research_req_research VALUES (405, 401, 4);
INSERT INTO static.db_research_req_research VALUES (406, 401, 5);
INSERT INTO static.db_research_req_research VALUES (3, 1, 1);
INSERT INTO static.db_research_req_research VALUES (902, 901, 1);
INSERT INTO static.db_research_req_research VALUES (421, 420, 1);
INSERT INTO static.db_research_req_research VALUES (503, 501, 3);
INSERT INTO static.db_research_req_research VALUES (504, 501, 3);
INSERT INTO static.db_research_req_research VALUES (503, 502, 1);
INSERT INTO static.db_research_req_research VALUES (506, 501, 5);
INSERT INTO static.db_research_req_research VALUES (505, 501, 4);
INSERT INTO static.db_research_req_research VALUES (403, 402, 3);
INSERT INTO static.db_research_req_research VALUES (506, 403, 1);
INSERT INTO static.db_research_req_research VALUES (105, 404, 3);
INSERT INTO static.db_research_req_research VALUES (406, 404, 9);
INSERT INTO static.db_research_req_research VALUES (402, 401, 2);
INSERT INTO static.db_research_req_research VALUES (510, 102, 5);
INSERT INTO static.db_research_req_research VALUES (102, 101, 3);
INSERT INTO static.db_research_req_research VALUES (110, 32, 1);
INSERT INTO static.db_research_req_research VALUES (110, 902, 3);
INSERT INTO static.db_research_req_research VALUES (908, 1, 1);
INSERT INTO static.db_research_req_research VALUES (908, 901, 5);
INSERT INTO static.db_research_req_research VALUES (908, 907, 4);
INSERT INTO static.db_research_req_research VALUES (907, 901, 5);
INSERT INTO static.db_research_req_research VALUES (907, 102, 4);
INSERT INTO static.db_research_req_research VALUES (906, 901, 4);
INSERT INTO static.db_research_req_research VALUES (906, 102, 3);
INSERT INTO static.db_research_req_research VALUES (905, 901, 3);
INSERT INTO static.db_research_req_research VALUES (905, 102, 1);
INSERT INTO static.db_research_req_research VALUES (904, 901, 2);
INSERT INTO static.db_research_req_research VALUES (903, 902, 5);
INSERT INTO static.db_research_req_research VALUES (903, 901, 5);
INSERT INTO static.db_research_req_research VALUES (303, 301, 10);
INSERT INTO static.db_research_req_research VALUES (303, 40, 1);
INSERT INTO static.db_research_req_research VALUES (509, 501, 5);
INSERT INTO static.db_research_req_research VALUES (519, 510, 5);
INSERT INTO static.db_research_req_research VALUES (109, 101, 5);


--
-- Data for Name: db_security_levels; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_security_levels VALUES (1, 5, 1);
INSERT INTO static.db_security_levels VALUES (2, 10, 3);
INSERT INTO static.db_security_levels VALUES (3, 100, 10);
INSERT INTO static.db_security_levels VALUES (4, 20000, 50000);


--
-- Data for Name: db_ship_modules; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_ship_modules VALUES (8, 30, 'Propulsion II', '', 300, 200, 0, 0, 0, 0, 180, 0, 0, 0, 0, 0, 0, 0, 0, 6000000, 45000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 15, 1, 0, 0, 2000);
INSERT INTO static.db_ship_modules VALUES (5, 30, 'Propulsion I', '', 100, 100, 0, 0, 0, 0, 180, 0, 0, 0, 0, 0, 0, 0, 0, 25000000, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 1, 0, 0, 500);
INSERT INTO static.db_ship_modules VALUES (9, 40, 'Canon C-1', '', 100, 100, 0, 0, 0, 0, 180, 0, 0, 0, 9, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 0, 0, 1, 500);
INSERT INTO static.db_ship_modules VALUES (10, 40, 'Canon C-2', '', 200, 200, 0, 0, 0, 0, 180, 0, 0, 0, 9, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 0, 0, 1, 500);
INSERT INTO static.db_ship_modules VALUES (4, 60, 'Container II', '', 2000, 1000, 0, 0, 0, 50000, 800, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 10000);
INSERT INTO static.db_ship_modules VALUES (3, 60, 'Container I', '', 1000, 500, 0, 0, 0, 25000, 300, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5000);
INSERT INTO static.db_ship_modules VALUES (2, 60, 'Soute II', '', 1000, 500, 0, 0, 0, 100, 180, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1000);
INSERT INTO static.db_ship_modules VALUES (1, 60, 'Soute I', '', 100, 50, 0, 0, 0, 15, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100);


--
-- Data for Name: db_ship_structures; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_ship_structures VALUES (5, 10, 'Vaisseau utilitaire V', '', 30000, 18000, 600, 0, 350, 0, 8000, 100, 96, 1, NULL, 200, 400, 0, 4, 1, 200000);
INSERT INTO static.db_ship_structures VALUES (4, 10, 'Vaisseau utilitaire IV', '', 20000, 15000, 400, 0, 300, 0, 7000, 100, 70, 1, NULL, 170, 320, 0, 2, 0, 150000);
INSERT INTO static.db_ship_structures VALUES (3, 10, 'Vaisseau utilitaire III', '', 15000, 10000, 300, 0, 200, 0, 5000, 100, 50, 1, NULL, 150, 300, 0, 2, 1, 120000);
INSERT INTO static.db_ship_structures VALUES (2, 10, 'Vaisseau utilitaire II', '', 8000, 5000, 100, 0, 100, 0, 3000, 100, 26, 1, NULL, 100, 200, 0, 1, 0, 100000);
INSERT INTO static.db_ship_structures VALUES (7, 20, 'Vaisseau léger II', '', 700, 300, 0, 0, 2, 0, 200, 40, 2, 3500, NULL, 25, 25, 1, 1, 1, 15000);
INSERT INTO static.db_ship_structures VALUES (1, 10, 'Vaisseau utilitaire I', '', 1500, 500, 0, 0, 0, 0, 600, 10, 1, 1, NULL, 5, 5, 1, 0, 0, 500);
INSERT INTO static.db_ship_structures VALUES (6, 20, 'Vaisseau léger I', '', 500, 200, 0, 0, 2, 0, 180, 30, 2, 3000, NULL, 25, 25, 1, 1, 1, 15000);
INSERT INTO static.db_ship_structures VALUES (8, 20, 'Vaisseau léger III', '', 800, 500, 0, 0, 2, 0, 300, 45, 3, 4000, NULL, 25, 25, 1, 1, 1, 10000);


--
-- Data for Name: db_ships; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_ships VALUES (999, 20, 'ship_remains', 'Débris de vaisseau', 'Restes de vaisseau détruit.', 1000, 200, 0, 0, 0, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (192, 10, 'upg_cargo_I_to_X', 'Upgrade du cargo I en X', 'Upgrade', 42000, 25000, 0, 0, 400, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 10, NULL, 0, 0, 0, true, 101, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (193, 10, 'upg_cargo_V_to_X', 'Upgrade du cargo V', 'upgrade', 25000, 15000, 0, 0, 250, 0, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 10, NULL, 0, 0, 0, true, 102, 103, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (199, 15, 'upg_mothership', 'Upgrade Vaisseau mère avec saut', 'Upgrade', 60000, 30000, 0, 0, 1000, 0, 18600, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 10, NULL, 0, 0, 0, true, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (102, 10, 'cargo_V', 'Cargo V', 'Avec une capacité de 100 000 unités et une bonne hyper propulsion, le cargo V est parfait pour le déplacement de ressources entre secteurs.', 21000, 18000, 0, 0, 350, 100000, 7200, 0, 9000, 4000, 0, 0, 0, 0, 78, 1100, 100, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 40, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (110, 10, 'recycler', 'Recolteur', 'Le récolteur est un vaisseau spécialisé dans le recyclage des carcasses de vaisseaux et l''exploitation d''astéroides.<br/>

Il peut récupérer et recycler jusqu''a 3000 ressources par heure. Equipé de systèmes de transfert de ressources, le récolteur peut ainsi stocker minerais et hydrocarbures dans les autres vaisseaux de sa flotte.', 10000, 7000, 0, 0, 100, 5000, 5760, 0, 6000, 5000, 0, 0, 0, 0, 34, 1000, 100, NULL, 3000, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 5, 500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (101, 10, 'cargo_I', 'Cargo I', 'Le cargo I est un vaisseau robuste qui peut transporter jusqu''à 30 000 unités de ressources ou de personnel.', 8000, 8000, 0, 0, 200, 30000, 3600, 0, 3000, 1000, 0, 0, 0, 0, 32, 1200, 200, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 20, 500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (103, 10, 'cargo_X', 'Cargo X', 'Le cargo X peut transporter jusqu''à 225 000 unités.', 48000, 27000, 0, 0, 600, 225000, 10800, 0, 25000, 20000, 0, 0, 0, 0, 150, 1000, 50, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 75, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (191, 10, 'upg_cargo_I_to_V', 'Upgrade du cargo I', 'Upgrade', 17000, 10000, 0, 0, 150, 0, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, true, 101, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (106, 10, 'jumper', 'Jumper', 'Le jumper permet à un groupe de vaisseaux d''effectuer des sauts permettant de relier les galaxies.<br/>

Ce vaisseau offre une capacité de saut intergalactique de 2000.', 45000, 35000, 0, 0, 16, 0, 20400, 0, 5000, 3000, 0, 0, 0, 0, 40, 800, 10, NULL, 0, 0, 2000, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 10, 8000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, true, 1);
INSERT INTO static.db_ships VALUES (140, 15, 'sector_probe', 'Vaisseau radar', 'Ce vaisseau permet de déployer un satellite qui augmente la puissance radar de 1 pour une durée de 8 heures.<br/>

Le vaisseau est détruit une fois déployé.', 30000, 20000, 0, 0, 0, 0, 19000, 0, 1, 0, 0, 0, 0, 0, 100, 22500, 1, 600, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 2500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (601, 60, 'redempteur', 'Rédempteur', '', 2000000, 1800000, 0, 0, 6000, 10000, 280000, 0, 1000000, 3200000, 1, 28, 900, 28, 7600, 450, 350, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 8000, 500000, 1500, 0, 0, 0, 40, 75, 30, 91, 5, 1000, 0, 100000, 1, 0, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (950, 50, 'imperial_cruiser', 'Croiseur impérial', '', 900000, 800000, 100000, 0, 25000, 25000, 240000, 0, 15000, 25000, 90, 7, 720, 7, 3400, 750, 470, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 200, 5000, 250, 0, 250, 0, 35, 60, 25, 90, 1, 10, 0, 0, 1, 0, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (901, 90, 'mine_field', 'Mine', 'Mine explosive', 20000, 10000, 0, 0, 0, 0, 700, 0, 1, 0, 0, 100, 200, 100, 100, 0, 1, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, true, 1);
INSERT INTO static.db_ships VALUES (910, 10, 'caravel', 'Caravelle marchande', 'La caravelle marchande est un petit vaisseau comparé au cargo X, cependant sa taille, sa forme, son aménagement de l''équipage et sa modularité pour accueillir les différents types de ressource lui confèrent une très nette supériorité aux autres vaisseaux de transport.<br/>

La caravelle peut transporter jusqu''à 100 000 unités de ressource.<br/>

Comparée au cargo X, la caravelle dispose de plusieurs atouts dont un blindage digne d''un vaisseau de guerre et une vitesse supérieure. De plus, à capacité égale, les caravelles marchandes demandent bien moins d''entretien.', 12000, 8000, 0, 0, 300, 100000, 3600, 0, 8000, 10000, 0, 0, 0, 0, 40, 1300, 200, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (952, 20, 'mower', 'Faucheur', '', 1100, 900, 15, 0, 3, 5, 500, 0, 300, 50, 10, 1, 2300, 2, 8, 1650, 1500, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 8, 100, 10, 0, 0, 10, -30, 50, 0, 5, 1, 1, 0, 0, 1, 250, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (953, 80, 'fortress', 'Forteresse', '', 10000000, 20000000, 0, 0, 30000, 10000000, 500000, 0, 63568, 53392, 15, 400, 100, 400, 20000, 150, 600, NULL, 20000, 10000, 32500, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 20000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1000, 0, 0, 1, 0, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (954, 40, 'escorter', 'Escorteur', '', 10000, 5000, 0, 0, 100, 50, 2880, 0, 200, 250, 40, 4, 400, 4, 26, 550, 330, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 26, 1000, 0, 50, 30, 70, 30, 40, 25, 50, 3, 7, 0, 0, 1, 450, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (955, 30, 'rogue_ctm', 'Foudroyeur', '', 4500, 2600, 0, 0, 32, 50, 2240, 0, 3000, 0, 0, 16, 2300, 16, 15, 1200, 900, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 10, 750, 0, 0, 0, 10, 0, 0, 0, 25, 2, 3, 0, 0, 1, 200, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (960, 10, 'rogue_recycler', 'Collecteur', '', 25000, 15000, 1000, 0, 100, 15000, 18000, 0, 6000, 1200, 0, 0, 0, 0, 80, 1000, 400, NULL, 15000, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 50, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (100, 10, 'probe', 'Sonde', 'Petit vaisseau de reconnaissance extrémement rapide équipé d''un petit dispositif permettant d''analyser la planète qu''il orbite.', 500, 500, 0, 0, 0, 0, 180, 0, 1, 0, 0, 0, 0, 0, 1, 25000, 1, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1, 50, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, false, 1);
INSERT INTO static.db_ships VALUES (104, 10, 'cargo_Z', 'Convoyeur', 'Le convoyeur est spécialisé dans le transport de ressources intergalactique. Ne possédant pas la vitesse d''une caravelle, il est cependant équipé d''un système de saut intégré qui le rend très utile dès lors qu''il s''agit de déplacer des ressources d''une galaxie à une autre.<br/>

Ce cargo peut transporter jusqu''à 1 000 000 d''unités.', 120000, 80000, 0, 0, 1000, 1000000, 36000, 0, 75000, 60000, 0, 0, 0, 0, 300, 1000, 25, NULL, 0, 0, 300, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 175, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, true, 1);
INSERT INTO static.db_ships VALUES (105, 10, 'droppods', 'Barge d''invasion', 'Les barges d''invasion sont utilisées lors de l''invasion de planètes, plus vous disposez de barges dans votre flotte, plus vous pouvez envoyer de soldats en même temps.<br/>

Cette barge augmente la capacité d''invasion de la flotte de 1 000 soldats.', 15000, 12000, 0, 0, 4, 1000, 4720, 0, 10000, 2000, 0, 0, 0, 0, 54, 1000, 10, NULL, 0, 1000, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 40, 200, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 3, 0, true, 1);
INSERT INTO static.db_ships VALUES (141, 15, 'jammer_probe', 'Vaisseau de brouillage', 'Ce vaisseau, une fois déployé, génère une onde qui augmente le brouillage radar de 10 pour une durée de 8 heures.<br/>

Le vaisseau est détruit à son utilisation.', 100000, 70000, 0, 0, 0, 0, 19000, 0, 1, 0, 0, 0, 0, 0, 340, 20000, 1, 601, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 200, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (142, 15, 'd_vortex_medium', 'Harmoniseur quantique', 'Ce vaisseau, une fois déployé, crée un vortex de stabilité 2 pour une durée de 12 heures.<br/>

Le vaisseau est détruit à son utilisation.', 100000, 70000, 0, 0, 0, 0, 19000, 0, 500, 0, 0, 0, 0, 0, 340, 2000, 1, 604, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 200, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 100, 1, 0, 1, 0, false, 1);
INSERT INTO static.db_ships VALUES (143, 15, 'd_vortex_strong', 'Stabilisateur quantique', 'Ce vaisseau, une fois déployé, déchire l''espace temps et crée un vortex permettant de faire passer les plus gros vaisseaux pour une durée de 30 minutes.<br/>

Le vaisseau est détruit à son utilisation.', 160000, 100000, 0, 0, 0, 0, 24000, 0, 500, 0, 0, 0, 0, 0, 520, 1200, 1, 605, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 260, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1000, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (144, 15, 'd_vortex_inhibitor', 'Inhibiteur quantique', 'Ce vaisseau, une fois déployé, déstabilise le vortex à proximité et réduit sa stabilité de 8 points pour une durée de 2 jours.<br/>

Le vaisseau est détruit à son utilisation.', 80000, 50000, 0, 0, 0, 0, 16000, 0, 500, 0, 0, 0, 0, 0, 260, 1200, 1, 606, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 130, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 2000, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (162, 11, 'd_workshop1', 'D: Atelier', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "atelier".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 13000, 6600, 0, 0, 2, 0, 37600, 0, 300, 0, 0, 0, 0, 0, 40, 450, 1, 204, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 12500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (120, 15, 'mothership_combat', 'Vaisseau mère de combat', 'Ce vaisseau mère de combat n''est pas un vaisseau de combat classique, en ce qu''il ne possède aucune arme. Cependant, il est capable d''augmenter significativement l''efficacité de la flotte à laquelle il appartient.<br/>

Les données de ses nombreux senseurs et relais géotactiques sont transmises à toute la flotte, ce qui permet aux pilotes et artilleurs des vaisseaux des manoeuvres plus précises et des tirs plus mortels.<br/>

Bonus conférés à la flotte contenant un vaisseau mère:<br/>

Boucliers augmentés de 10%<br/>

Manoeuvrabilité augmentée de 10%<br/>

Ciblage augmenté de 20%<br/>

Dégats augmentés de 10%', 300000, 250000, 0, 0, 30000, 100000, 76800, 0, 150000, 75000, 0, 0, 0, 0, 1100, 1000, 10, NULL, 0, 0, 1000, true, NULL, NULL, 0, 0.1, 0.1, 0.2, 0.1, 0, 0, 0, 2000, 80000, 0, 0, 0, 0, 0, 0, 0, 0, 5, 100, 0, 0, 1, 0, 4, 5000, false, 1);
INSERT INTO static.db_ships VALUES (401, 40, 'assault_frigate', 'Frégate d''assaut', 'La frégate d''assaut est un vaisseau lourd équipé de 3 railguns R-1. Moins maniable mais plus résistant que les corvettes, la frégate d''assaut offre un tir de soutien efficace.<br/><br/>

Arme: Railgun R-1', 9000, 5000, 0, 0, 50, 50, 2080, 0, 7500, 2500, 1, 3, 1000, 3, 28, 900, 680, NULL, 0, 0, 16, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 16, 1000, 0, 0, 130, 0, 55, 45, 25, 60, 3, 5, 0, 0, 1, 0, 3, 10, false, 1);
INSERT INTO static.db_ships VALUES (501, 50, 'cruiser', 'Croiseur', 'Conçu pour constituer le fer de lance de vos flottes de combat, le croiseur est un vaisseau puissament armé dont le blindage lui permet de résister à un feu nourri.<br/>

Bien que ses railguns améliorés le rendent dévastateur face aux vaisseaux lourds, il n''est pas équipé pour combattre efficacement les vaisseaux légers, contre lesquels son blindage le rend extrêmement résistant.<br/><br/>

Arme: Railgun R-2', 20000, 14000, 0, 0, 250, 200, 4400, 0, 10000, 20000, 1, 4, 720, 4, 68, 800, 400, NULL, 0, 0, 50, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 3000, 0, 0, 400, 0, 30, 65, 45, 85, 4, 10, 0, 0, 1, 0, 4, 50, false, 1);
INSERT INTO static.db_ships VALUES (504, 50, 'battle_cruiser', 'Croiseur de combat', 'Le croiseur de combat est une version du croiseur optimisée pour la destruction de vaisseaux lourds.<br/>

Bénéficiant d''un bouclier amélioré, la structure du chassis a été repensée pour accueillir 6 railguns à canon long et de grandes quantités de munitions perforantes lourdes.<br/>

Comme son petit frère, il reste inefficace contre les flottes de petits vaisseaux, bien que son blindage en alliage thermo-renforçé le rende très résistant.<br/><br/>

Arme: Railgun R-3', 35000, 25000, 0, 0, 500, 300, 7900, 0, 10000, 25000, 1, 6, 720, 6, 120, 800, 400, NULL, 0, 0, 100, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 90, 5000, 0, 0, 750, 0, 35, 70, 50, 85, 4, 10, 0, 0, 1, 0, 4, 50, false, 1);
INSERT INTO static.db_ships VALUES (302, 30, 'heavy_corvette', 'Corvette lourde', 'La corvette lourde se voit dotée d''un lance roquettes afin de cibler et endommager les vaisseaux les plus lourds en priorité.<br/>

La taille des lance roquettes n''étant pas vraiment adaptée au chassis des corvettes, une partie de la structure a du être allégée réduisant l''armure cependant la manoeuvrabilité du vaisseau reste correcte.<br/><br/>

Arme: Roquette', 2000, 2500, 0, 0, 8, 25, 800, 0, 1500, 0, 1, 1, 1100, 1, 9, 1200, 960, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 6, 500, 0, 225, 0, 0, 10, 35, 20, 35, 2, 2, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (163, 11, 'd_research_center', 'D: Centre de recherche', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "centre de recherche".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 33000, 23600, 0, 0, 2, 0, 117600, 0, 300, 0, 0, 0, 0, 0, 113, 450, 1, 206, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 25000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (164, 11, 'd_military_barracks', 'D: Caserne militaire', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "caserne militaire".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 27000, 12600, 0, 0, 2, 0, 117600, 0, 300, 0, 0, 0, 0, 0, 79, 450, 1, 208, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 25000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (304, 30, 'multi_gun_corvette', 'Corvette à tir multiple', 'Dotée de 5 tourelles T-1, cette corvette peut prendre pour cible plusieurs chasseurs à la fois et les abattre avec une précision redoutable.<br/><br/>

Arme: Laser C-1 sur tourelle', 2500, 2500, 0, 0, 10, 25, 950, 0, 1500, 0, 1, 5, 2300, 5, 10, 1200, 970, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 7, 750, 0, 0, 0, 15, 11, 36, 21, 36, 2, 2, 0, 0, 1, 0, 2, 4, true, 1);
INSERT INTO static.db_ships VALUES (205, 20, 'defense_drone', 'Drone de protection', 'Les drones sont des vaisseaux automatisés ne demandant pas de pilote.<br/>

Bien qu''ils soient armés d''un petit laser, leur principal atout est d''intercepter les tirs ennemis.<br/>

Ces drones sont construits par 10.', 2500, 250, 0, 0, 0, 0, 700, 0, 30, 0, 1, 1, 1, 1, 1, 3000, 1, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1, 100, 0, 0, 0, 1, -10000, -10000, -10000, -10000, 1, 0, 0, 0, 10, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (150, 10, 'colonizer_I', 'Vaisseau de colonisation', 'Le vaisseau de colonisation est prévu pour atterrir en toute sécurité sur la surface d''une planète vierge et déployer un bâtiment de type "colonie".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

<br/>

Note: le vaisseau de colonisation ne peut pas coloniser une planète déjà occupée.

', 25000, 11600, 0, 0, 2500, 0, 54400, 0, 10000, 2000, 0, 0, 0, 0, 72, 450, 1, 101, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 100, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (151, 11, 'd_construction_plant', 'D: Usine de préfabriqués', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "usine de préfabriqué".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 7000, 3800, 0, 0, 2, 0, 52800, 0, 300, 0, 0, 0, 0, 0, 21, 450, 1, 102, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (152, 11, 'd_geothermal_power', 'D: Centrale géothermique', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "centrale géothermique".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 6000, 3000, 0, 0, 2, 0, 20400, 0, 300, 0, 0, 0, 0, 0, 18, 450, 1, 118, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (153, 11, 'd_ore_hangar1', 'D: Réserve à minerai', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "réserve de minerai".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 6000, 3100, 0, 0, 2, 0, 18600, 0, 300, 0, 0, 0, 0, 0, 18, 450, 1, 120, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (404, 40, 'missile_frigate', 'Frégate à missiles', 'La frégate à missiles est équipée de lance-missiles de type M-1 capables de poursuivre efficacement les vaisseaux de taille moyenne tels que les corvettes.<br/><br/>

Arme: Missile M-1', 13000, 12000, 0, 0, 120, 50, 4000, 0, 6000, 2500, 1, 8, 2000, 8, 50, 950, 685, NULL, 0, 0, 16, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 35, 2000, 0, 50, 0, 0, 60, 45, 30, 65, 3, 5, 0, 0, 1, 0, 3, 5, false, 1);
INSERT INTO static.db_ships VALUES (166, 11, 'd_hydrocarbon_hangar2', 'D: Hangar à hydrocarbure', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "hangar à hydrocarbure".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 30000, 16600, 0, 0, 2, 0, 40400, 0, 300, 0, 0, 0, 0, 0, 93, 450, 1, 221, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 12500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (595, 50, 'upg_elite_cruiser', 'Upgrade Croiseur d''Elite', 'Upgrade', 15000, 10000, 0, 0, 0, 0, 3600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, true, 504, 505, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 100, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (154, 11, 'd_hydrocarbon_hangar1', 'D: Réserve à hydrocarbure', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "réserve d''hydrocarbure".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 6000, 3100, 0, 0, 2, 0, 19500, 0, 300, 0, 0, 0, 0, 0, 18, 450, 1, 121, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (155, 11, 'd_laboratory', 'D: Laboratoire', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "laboratoire".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 7500, 4600, 0, 0, 2, 0, 32200, 0, 300, 0, 0, 0, 0, 0, 24, 450, 1, 106, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (161, 11, 'd_construction_plant2', 'D: Usine d''automates', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "usine d''automates".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 27500, 17600, 0, 0, 2, 0, 103200, 0, 300, 0, 0, 0, 0, 0, 90, 450, 1, 202, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 25, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (165, 11, 'd_ore_hangar2', 'D: Hangar à minerai', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "hangar à minerai".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 30000, 16600, 0, 0, 2, 0, 37600, 0, 300, 0, 0, 0, 0, 0, 93, 450, 1, 220, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 50, 12500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, false, 1);
INSERT INTO static.db_ships VALUES (203, 20, 'predator', 'Prédateur', 'Le prédateur est basé sur l''intercepteur offrant ainsi une bonne maniabilité et vitesse, il est équipé d''un canon laser C-3 version améliorée du canon C-2 avec un temps de recharge plus court offrant encore plus de précision.<br/>

Offrant une puissance de feu légèrement supérieure à l''intercepteur, il est aussi prévu pour faciliter la formation d''escadrons composés de 5 vaisseaux.<br/>

<i>Élu modèle de l''année dans sa catégorie.</i><br/><br/>

Arme: Laser C-3', 1000, 1500, 0, 0, 2, 0, 590, 0, 275, 0, 1, 1, 2450, 1, 5, 1550, 1505, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 2, 75, 0, 0, 0, 35, 1, 91, 1, -24, 1, 1, 0, 5, 1, 0, 2, 5, true, 1);
INSERT INTO static.db_ships VALUES (505, 50, 'elite_cruiser', 'Croiseur d''élite', 'Le croiseur d''élite est un croiseur de combat bénéficiant d''améliorations au niveau de la vitesse de déplacement, de la manoeuvrabilité, de la précision de tir et de la puissance de feu.<br/>

<i>A reçu 5 étoiles au crash-test uni NCAP</i><br/><br/>

Arme: Railgun R-3', 35000, 25000, 0, 0, 500, 300, 8400, 0, 10000, 25000, 1, 6, 725, 6, 120, 900, 405, NULL, 0, 0, 100, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 80, 5000, 0, 0, 800, 0, 36, 71, 51, 90, 4, 10, 0, 100, 1, 0, 4, 100, false, 1);
INSERT INTO static.db_ships VALUES (171, 11, 'd_synthesis_plant', 'D: Usine de synthèse', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "usine de synthèse".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 105000, 82600, 0, 0, 2, 0, 182400, 0, 300, 0, 0, 0, 0, 0, 375, 450, 1, 302, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 100, 50000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 3, 0, false, 1);
INSERT INTO static.db_ships VALUES (180, 11, 'd_energy_cell', 'D: Caisse d''énergie', 'Ce vaisseau est prévu pour atterrir en toute sécurité sur la surface d''une planète colonisée et déployer un bâtiment de type "caisse d''énergie".<br/>

Ce "bâtiment volant" est extrêmement fragile et ne devrait être engagé dans aucun combat.<br/>

Les prérequis à la construction du bâtiment déployé doivent se trouver déjà construit sur la planète.', 45000, 25000, 0, 0, 2, 0, 76000, 0, 300, 0, 0, 0, 0, 0, 140, 450, 1, 602, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 75, 75000, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 200, 1, 0, 3, 0, false, 1);
INSERT INTO static.db_ships VALUES (402, 40, 'ion_frigate', 'Frégate à canon ionique', 'La frégate à canon ionique est un vaisseau atypique, celui-ci ne possède qu''une seule et unique arme : un canon ionique qui peut infliger d''énormes dégats. Cependant, ce canon est lent, non directionnel et la puissance demandée pour tirer est telle qu''il ne possède aucune autre arme pour se défendre le rendant complètement sans défense face à des vaisseaux rapides.<br/><br/>

Arme: Canon ionique', 9000, 7000, 0, 0, 80, 75, 2500, 0, 3500, 2500, 1, 1, 450, 1, 32, 900, 680, NULL, 0, 0, 16, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 20, 1500, 4000, 0, 0, 0, 60, 45, 30, 65, 3, 5, 0, 0, 1, 0, 3, 5, false, 1);
INSERT INTO static.db_ships VALUES (202, 20, 'interceptor', 'Intercepteur', 'Moins lourdement blindé que le chasseur, l''intercepteur est sans aucun doute le vaisseau le plus maniable de sa catégorie ce qui le rend très difficile à cibler. Il est équipé d''un canon laser fixe de type C-2 monté sous le cockpit de l''appareil, ce canon est plus puissant et permet un tir plus précis.<br/><br/>

Arme: Laser C-2', 1000, 1500, 0, 0, 2, 0, 550, 0, 275, 0, 1, 1, 2400, 1, 5, 1500, 1500, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 3, 75, 0, 0, 0, 30, 0, 90, 0, -25, 1, 1, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (201, 20, 'fighter', 'Chasseur', 'Le chasseur est un appareil de combat agile et rapide. Il est équipé d''un canon laser fixe C-1 monté sous le cockpit. Sa manoeuvrabilité le rend difficile à toucher et lui procure une grande précision de frappe. Utilisé en nombre, les chasseurs peuvent être fatals contre les flottes composées de vaisseaux moins maniables.<br/><br/>

Arme: Laser C-1', 800, 1200, 0, 0, 2, 15, 420, 0, 350, 0, 1, 1, 2200, 1, 4, 1450, 1400, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 2, 50, 0, 0, 0, 20, 0, 85, 0, -30, 1, 1, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (121, 15, 'mothership_logistic', 'Vaisseau mère de logistique', 'Ce vaisseau mère est capable d''améliorer significativement la coordination de la flotte à laquelle il appartient lors des opérations de recyclage.<br/>

De plus, son générateur de saut lui permet d''assister de nombreux vaisseaux pour des vols hyperspatiaux et d''augmenter la vitesse globale de la flotte.<br/>

Bonus conférés à la flotte contenant ce vaisseau mère:<br/>

Vitesse augmentée de 15%<br/>

Vitesse du recyclage augmentée de 20%

', 350000, 270000, 0, 0, 31000, 100000, 93600, 0, 100000, 50000, 0, 0, 0, 0, 1240, 1000, 10, NULL, 0, 0, 10000, true, NULL, NULL, 0.15, 0, 0, 0, 0, 0, 0.2, 0, 2000, 100000, 0, 0, 0, 0, 0, 0, 0, 0, 5, 100, 0, 0, 1, 0, 4, 2000, false, 1);
INSERT INTO static.db_ships VALUES (292, 20, 'upg_interceptor', 'Upgrade Intercepteur', 'Upgrade', 250, 350, 0, 0, 0, 0, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, true, 201, 202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (293, 20, 'upg_predator', 'Upgrade Prédateur', 'Upgrade', 100, 100, 0, 0, 0, 0, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, NULL, 0, 0, 0, true, 202, 203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 5, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (301, 30, 'light_corvette', 'Corvette légère', 'Dessinée pour remplacer le chasseur, la corvette légère possède 3 tourelles mobiles T-1 qui lui permettent de compenser sa mobilité plus réduite que celle des chasseurs.<br/><br/>

Arme: Laser C-1 sur tourelle', 1500, 2000, 0, 0, 4, 50, 600, 0, 1600, 0, 1, 3, 1500, 3, 7, 1200, 965, NULL, 0, 0, 0, true, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 4, 100, 0, 0, 0, 15, 5, 30, 15, 30, 2, 2, 0, 0, 1, 0, 2, 0, true, 1);
INSERT INTO static.db_ships VALUES (305, 30, 'elite_corvette', 'Corvette d''elite', 'Possédant 4 tourelle mobiles T-2, la corvette d''élite est une valeur sûre dans les affrontements contre les vaisseaux légers.<br/><br/>

Arme: Laser C-2 sur tourelle', 3000, 3000, 0, 0, 8, 50, 1300, 0, 1800, 0, 1, 4, 1700, 4, 12, 1350, 965, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 9, 600, 0, 0, 0, 20, 10, 35, 20, 35, 2, 5, 0, 10, 1, 0, 2, 7, true, 1);
INSERT INTO static.db_ships VALUES (959, 60, 'annihilator', 'Annihilateur', '', 2000000, 1500000, 0, 0, 30000, 30000, 300000, 0, 500000000, 500000000, 1, 200, 1500, 200, 1, 400, 200, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 20000, 5000, 5000, 5000, 5000, 20, 95, 95, 95, 5, 1000000, 0, 0, 1, 2000000, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (951, 60, 'obliterator', 'Oblitérateur', '', 200000, 200000, 0, 0, 30000, 30000, 300000, 0, 200000, 200000, 1, 20, 650, 20, 800, 600, 450, NULL, 0, 0, 0, false, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 20000, 500, 500, 500, 500, 20, 50, 50, 50, 5, 100, 0, 0, 1, 2000, 0, 0, false, 1);
INSERT INTO static.db_ships VALUES (605, 60, 'elite_dreadnought', 'Dreadnought d''élite', 'Véritable mastodonte, le dreadnought d''élite bénéficie des dernières découvertes en armement lourd permettant d''annihiler ses cibles avec une précision redoutable.<br/>

En plus d''un armement inégalé, il possède un blindage révolutionnaire offrant jusqu''à 99% de réduction de tout type de dégat et offre un bonus de 10% au bouclier à la flotte.<br/><br/>

Boucliers augmentés de 10%', 1300000, 1000000, 0, 0, 6000, 10000, 300000, 0, 1000000, 2000000, 1, 20, 1000, 20, 4600, 600, 300, NULL, 0, 0, 0, false, NULL, NULL, 0, 0.1, 0, 0, 0, 0, 0, 0, 2000, 300000, 10000, 0, 0, 0, 80, 99, 99, 99, 5, 1000, 0, 5000, 1, 0, 4, 1000, false, 1);


--
-- Data for Name: db_ships_req_building; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_ships_req_building VALUES (102, 205);
INSERT INTO static.db_ships_req_building VALUES (103, 205);
INSERT INTO static.db_ships_req_building VALUES (201, 105);
INSERT INTO static.db_ships_req_building VALUES (202, 105);
INSERT INTO static.db_ships_req_building VALUES (301, 105);
INSERT INTO static.db_ships_req_building VALUES (301, 203);
INSERT INTO static.db_ships_req_building VALUES (302, 203);
INSERT INTO static.db_ships_req_building VALUES (205, 105);
INSERT INTO static.db_ships_req_building VALUES (304, 203);
INSERT INTO static.db_ships_req_building VALUES (401, 205);
INSERT INTO static.db_ships_req_building VALUES (401, 203);
INSERT INTO static.db_ships_req_building VALUES (402, 205);
INSERT INTO static.db_ships_req_building VALUES (402, 303);
INSERT INTO static.db_ships_req_building VALUES (404, 205);
INSERT INTO static.db_ships_req_building VALUES (404, 203);
INSERT INTO static.db_ships_req_building VALUES (501, 205);
INSERT INTO static.db_ships_req_building VALUES (501, 303);
INSERT INTO static.db_ships_req_building VALUES (504, 205);
INSERT INTO static.db_ships_req_building VALUES (504, 303);
INSERT INTO static.db_ships_req_building VALUES (101, 105);
INSERT INTO static.db_ships_req_building VALUES (950, 205);
INSERT INTO static.db_ships_req_building VALUES (100, 105);
INSERT INTO static.db_ships_req_building VALUES (105, 205);
INSERT INTO static.db_ships_req_building VALUES (106, 205);
INSERT INTO static.db_ships_req_building VALUES (910, 205);
INSERT INTO static.db_ships_req_building VALUES (150, 105);
INSERT INTO static.db_ships_req_building VALUES (110, 105);
INSERT INTO static.db_ships_req_building VALUES (120, 205);
INSERT INTO static.db_ships_req_building VALUES (151, 205);
INSERT INTO static.db_ships_req_building VALUES (152, 205);
INSERT INTO static.db_ships_req_building VALUES (153, 205);
INSERT INTO static.db_ships_req_building VALUES (154, 205);
INSERT INTO static.db_ships_req_building VALUES (155, 205);
INSERT INTO static.db_ships_req_building VALUES (161, 205);
INSERT INTO static.db_ships_req_building VALUES (162, 205);
INSERT INTO static.db_ships_req_building VALUES (163, 205);
INSERT INTO static.db_ships_req_building VALUES (164, 205);
INSERT INTO static.db_ships_req_building VALUES (165, 205);
INSERT INTO static.db_ships_req_building VALUES (166, 205);
INSERT INTO static.db_ships_req_building VALUES (171, 205);
INSERT INTO static.db_ships_req_building VALUES (121, 205);
INSERT INTO static.db_ships_req_building VALUES (140, 205);
INSERT INTO static.db_ships_req_building VALUES (141, 205);
INSERT INTO static.db_ships_req_building VALUES (505, 205);
INSERT INTO static.db_ships_req_building VALUES (505, 303);
INSERT INTO static.db_ships_req_building VALUES (203, 105);
INSERT INTO static.db_ships_req_building VALUES (104, 205);
INSERT INTO static.db_ships_req_building VALUES (142, 205);
INSERT INTO static.db_ships_req_building VALUES (143, 205);
INSERT INTO static.db_ships_req_building VALUES (144, 205);
INSERT INTO static.db_ships_req_building VALUES (302, 105);
INSERT INTO static.db_ships_req_building VALUES (304, 105);


--
-- Data for Name: db_ships_req_research; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_ships_req_research VALUES (101, 902, 1);
INSERT INTO static.db_ships_req_research VALUES (201, 501, 1);
INSERT INTO static.db_ships_req_research VALUES (202, 501, 2);
INSERT INTO static.db_ships_req_research VALUES (501, 505, 2);
INSERT INTO static.db_ships_req_research VALUES (102, 902, 2);
INSERT INTO static.db_ships_req_research VALUES (103, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (910, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (910, 12, 1);
INSERT INTO static.db_ships_req_research VALUES (106, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (950, 1, 1);
INSERT INTO static.db_ships_req_research VALUES (105, 902, 2);
INSERT INTO static.db_ships_req_research VALUES (142, 903, 3);
INSERT INTO static.db_ships_req_research VALUES (402, 506, 1);
INSERT INTO static.db_ships_req_research VALUES (504, 505, 3);
INSERT INTO static.db_ships_req_research VALUES (401, 505, 1);
INSERT INTO static.db_ships_req_research VALUES (304, 504, 3);
INSERT INTO static.db_ships_req_research VALUES (301, 504, 1);
INSERT INTO static.db_ships_req_research VALUES (404, 503, 1);
INSERT INTO static.db_ships_req_research VALUES (302, 502, 1);
INSERT INTO static.db_ships_req_research VALUES (150, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (110, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (151, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (152, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (153, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (154, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (155, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (161, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (162, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (163, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (164, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (165, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (166, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (171, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (152, 401, 2);
INSERT INTO static.db_ships_req_research VALUES (161, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (155, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (154, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (153, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (152, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (151, 902, 3);
INSERT INTO static.db_ships_req_research VALUES (162, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (163, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (164, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (165, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (166, 902, 4);
INSERT INTO static.db_ships_req_research VALUES (171, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (121, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (106, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (501, 907, 1);
INSERT INTO static.db_ships_req_research VALUES (104, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (401, 906, 1);
INSERT INTO static.db_ships_req_research VALUES (402, 906, 2);
INSERT INTO static.db_ships_req_research VALUES (404, 906, 3);
INSERT INTO static.db_ships_req_research VALUES (301, 905, 1);
INSERT INTO static.db_ships_req_research VALUES (302, 905, 2);
INSERT INTO static.db_ships_req_research VALUES (304, 905, 3);
INSERT INTO static.db_ships_req_research VALUES (201, 904, 1);
INSERT INTO static.db_ships_req_research VALUES (104, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (140, 903, 2);
INSERT INTO static.db_ships_req_research VALUES (141, 903, 3);
INSERT INTO static.db_ships_req_research VALUES (120, 903, 1);
INSERT INTO static.db_ships_req_research VALUES (121, 903, 1);
INSERT INTO static.db_ships_req_research VALUES (505, 505, 3);
INSERT INTO static.db_ships_req_research VALUES (999, 1, 1);
INSERT INTO static.db_ships_req_research VALUES (504, 907, 2);
INSERT INTO static.db_ships_req_research VALUES (104, 12, 1);
INSERT INTO static.db_ships_req_research VALUES (203, 904, 3);
INSERT INTO static.db_ships_req_research VALUES (202, 904, 2);
INSERT INTO static.db_ships_req_research VALUES (203, 501, 3);
INSERT INTO static.db_ships_req_research VALUES (505, 907, 3);
INSERT INTO static.db_ships_req_research VALUES (180, 902, 5);
INSERT INTO static.db_ships_req_research VALUES (180, 110, 1);
INSERT INTO static.db_ships_req_research VALUES (100, 901, 1);
INSERT INTO static.db_ships_req_research VALUES (143, 903, 3);
INSERT INTO static.db_ships_req_research VALUES (144, 903, 3);
INSERT INTO static.db_ships_req_research VALUES (142, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (143, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (144, 105, 1);
INSERT INTO static.db_ships_req_research VALUES (143, 21, 1);
INSERT INTO static.db_ships_req_research VALUES (144, 31, 1);
INSERT INTO static.db_ships_req_research VALUES (605, 505, 3);
INSERT INTO static.db_ships_req_research VALUES (605, 907, 3);
INSERT INTO static.db_ships_req_research VALUES (205, 501, 3);
INSERT INTO static.db_ships_req_research VALUES (205, 904, 3);
INSERT INTO static.db_ships_req_research VALUES (305, 504, 3);
INSERT INTO static.db_ships_req_research VALUES (305, 905, 3);


--
-- Data for Name: db_successes; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.db_successes VALUES (1, 'Participant');
INSERT INTO static.db_successes VALUES (2, 'Survivant');
INSERT INTO static.db_successes VALUES (3, 'Vainqueur');
INSERT INTO static.db_successes VALUES (4, 'Gagnant de la loterie');


--
-- Data for Name: gsc_levels; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_admin_actions; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_failed_logins; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_http_errors; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_jobs; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_multi_account_warnings; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_multi_simultaneous_warnings; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_notices; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_pages; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_referers; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_referers_users; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: log_sys_errors; Type: TABLE DATA; Schema: static; Owner: exileng
--



--
-- Data for Name: sys_daily_updates; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.sys_daily_updates VALUES ('sp_daily_credits_production()', false, '2007-02-06 04:10:22.4907', '22:00:00', NULL, '{00:00:01.675299,00:00:00.447144,00:00:01.357681,00:00:00.577626,00:00:01.028507,00:00:00.193653,00:00:02.033776,00:00:00.201612,00:00:01.079752,00:00:01.914209}');
INSERT INTO static.sys_daily_updates VALUES ('sp_daily_update_scores()', false, '2006-11-20 00:00:00', '22:00:00', NULL, '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}');
INSERT INTO static.sys_daily_updates VALUES ('sp_daily_cleaning()', true, '2008-01-30 04:09:50.279533', '22:00:00', NULL, '{00:00:13.869816,00:00:08.827096,00:00:12.374063,00:00:09.327597,00:00:08.78746,00:00:09.458528,00:00:16.454975,00:00:12.765035,00:00:12.074814,00:00:12.369658}');


--
-- Data for Name: sys_events; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.sys_events VALUES ('sp_event_merchants_contract()', true, '2020-09-10 11:27:41.16976', '24:00:00', NULL, '{00:00:00.000584,00:00:00.001228,00:00:00.000117,00:00:00.000123,00:00:00.000111,00:00:00.000122,00:00:00.000114,00:00:00.000118,00:00:00.000119,00:00:00.000106}');
INSERT INTO static.sys_events VALUES ('sp_event_rogue_fleets_patrol()', true, '2020-09-10 11:27:41.16976', '01:30:00', NULL, '{00:00:00.001376,00:00:00.001786,00:00:00.000089,00:00:00.0001,00:00:00.000163,00:00:00.000076,00:00:00.000071,00:00:00.000071,00:00:00.000078,00:00:00.000153}');
INSERT INTO static.sys_events VALUES ('sp_event_rogue_fleets_rush_resources()', true, '2020-09-10 11:27:40.658983', '01:15:00', NULL, '{00:00:00.000568,00:00:00.000062,00:00:00.000062,00:00:00.000077,00:00:00.000057,00:00:00.000057,00:00:00.000067,00:00:00.00006,00:00:00.000062,00:00:00.000067}');
INSERT INTO static.sys_events VALUES ('sp_event_commanders_promotions()', true, '2020-09-10 11:27:41.16976', '00:30:00', NULL, '{00:00:00.00031,00:00:00.000131,00:00:00.000062,00:00:00.000063,00:00:00.000136,00:00:00.000056,00:00:00.000055,00:00:00.000069,00:00:00.00006,00:00:00.000086}');
INSERT INTO static.sys_events VALUES ('sp_event_planet_bonus()', true, '2020-09-10 11:27:41.16976', '00:10:00', NULL, '{00:00:00.001657,00:00:00.000195,00:00:00.000093,00:00:00.000062,00:00:00.000066,00:00:00.000063,00:00:00.000064,00:00:00.000065,00:00:00.000099,00:00:00.000065}');
INSERT INTO static.sys_events VALUES ('sp_event_robberies()', true, '2020-09-10 11:27:41.16976', '00:10:10', NULL, '{00:00:00.001424,00:00:00.000333,00:00:00.000083,00:00:00.000123,00:00:00.000092,00:00:00.000101,00:00:00.000137,00:00:00.000112,00:00:00.000096,00:00:00.000082}');
INSERT INTO static.sys_events VALUES ('sp_event_fleet_delayed()', true, '2020-09-10 11:27:41.16976', '00:10:30', NULL, '{00:00:00.000392,00:00:00.000123,00:00:00.000056,00:00:00.000067,00:00:00.00009,00:00:00.000058,00:00:00.000068,00:00:00.000057,00:00:00.000055,00:00:00.000089}');
INSERT INTO static.sys_events VALUES ('sp_event_spawn_new_resource_points()', true, '2008-07-23 06:19:03.238', '00:19:10', 'relation "events_spawned_resources" does not exist', '{00:00:00.000096,00:00:00.000094,00:00:00.000097,00:00:00.000097,00:00:00.000131,00:00:00.000146,00:00:00.000102,00:00:00.000115,00:00:00.000085,00:00:00.000136}');
INSERT INTO static.sys_events VALUES ('sp_event_sandworm()', true, '2020-09-10 11:27:40.658983', '00:11:10', NULL, '{00:00:00.002096,00:00:00.000068,00:00:00.000056,00:00:00.000057,00:00:00.000096,00:00:00.000057,00:00:00.000057,00:00:00.000064,00:00:00.000058,00:00:00.000055}');
INSERT INTO static.sys_events VALUES ('sp_event_lost_nations_abandon()', true, '2020-09-10 11:27:40.658983', '00:11:00', NULL, '{00:00:00.000344,00:00:00.000052,00:00:00.000051,00:00:00.000052,00:00:00.000089,00:00:00.000062,00:00:00.000052,00:00:00.000069,00:00:00.000054,00:00:00.00005}');
INSERT INTO static.sys_events VALUES ('sp_event_long()', true, '2020-09-10 11:27:40.658983', '00:10:40', NULL, '{00:00:00.000624,00:00:00.000059,00:00:00.000061,00:00:00.000094,00:00:00.00006,00:00:00.000064,00:00:00.00007,00:00:00.000057,00:00:00.000091,00:00:00.000059}');
INSERT INTO static.sys_events VALUES ('sp_event_spawn_orbit_resources()', true, '2020-09-10 11:27:40.658983', '00:01:00', NULL, '{00:00:00.000664,00:00:00.000055,00:00:00.000053,00:00:00.000076,00:00:00.000055,00:00:00.000084,00:00:00.000077,00:00:00.000064,00:00:00.000058,00:00:00.000053}');
INSERT INTO static.sys_events VALUES ('sp_event_riots()', true, '2020-09-10 11:27:41.16976', '00:10:50', NULL, '{00:00:00.000783,00:00:00.000151,00:00:00.000068,00:00:00.000065,00:00:00.000098,00:00:00.000067,00:00:00.000068,00:00:00.00007,00:00:00.000099,00:00:00.000095}');
INSERT INTO static.sys_events VALUES ('sp_event_laboratory_accident()', true, '2020-09-10 11:27:41.16976', '00:10:20', NULL, '{00:00:00.000673,00:00:00.000134,00:00:00.000108,00:00:00.000065,00:00:00.00007,00:00:00.000109,00:00:00.000069,00:00:00.00008,00:00:00.000089,00:00:00.00007}');


--
-- Data for Name: sys_processes; Type: TABLE DATA; Schema: static; Owner: exileng
--

INSERT INTO static.sys_processes VALUES ('sp_process_accounts_deletion()', true, '2020-08-31 15:02:25.924088', '00:01:00', 'relation "users" does not exist', '{00:00:00.000126,00:00:00.000112,00:00:00.00013,00:00:00.000119,00:00:00.000126,00:00:00.000124,00:00:00.000153,00:00:00.000112,00:00:00.000175,00:00:00.000113}');
INSERT INTO static.sys_processes VALUES ('sp_process_fleets_waiting()', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "fleets" does not exist', '{00:00:00.000061,00:00:00.000059,00:00:00.000091,00:00:00.000075,00:00:00.000076,00:00:00.000073,00:00:00.000088,00:00:00.00006,00:00:00.000073,00:00:00.000063}');
INSERT INTO static.sys_processes VALUES ('sp_process_leave_alliance(10)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "users" does not exist', '{00:00:00.000053,00:00:00.000053,00:00:00.000068,00:00:00.000058,00:00:00.000063,00:00:00.000072,00:00:00.000076,00:00:00.000055,00:00:00.000077,00:00:00.000058}');
INSERT INTO static.sys_processes VALUES ('sp_process_training(''0:00:01'', 10)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "planet_training_pending" does not exist', '{00:00:00.000062,00:00:00.000063,00:00:00.000073,00:00:00.000068,00:00:00.00007,00:00:00.000071,00:00:00.000074,00:00:00.0001,00:00:00.000071,00:00:00.000063}');
INSERT INTO static.sys_processes VALUES ('sp_process_fleets_recycling(''0:00:01'', 25)', true, '2020-08-31 15:02:41.554751', '00:00:00.5', 'relation "fleets" does not exist', '{00:00:00.000103,00:00:00.000065,00:00:00.000075,00:00:00.000071,00:00:00.000073,00:00:00.000073,00:00:00.000079,00:00:00.000099,00:00:00.000098,00:00:00.000078}');
INSERT INTO static.sys_processes VALUES ('sp_process_tributes(25)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "alliances_tributes" does not exist', '{00:00:00.000065,00:00:00.000129,00:00:00.000072,00:00:00.000064,00:00:00.000074,00:00:00.000092,00:00:00.000097,00:00:00.000062,00:00:00.0001,00:00:00.000072}');
INSERT INTO static.sys_processes VALUES ('sp_process_researches()', true, '2020-08-31 15:02:41.050236', '00:00:01', 'type "nav_planet" does not exist', '{00:00:00.000114,00:00:00.00007,00:00:00.000077,00:00:00.000077,00:00:00.00008,00:00:00.000081,00:00:00.000082,00:00:00.000068,00:00:00.000108,00:00:00.00009}');
INSERT INTO static.sys_processes VALUES ('sp_process_destroy_buildings(''0:00:01'', 10)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "planet_buildings" does not exist', '{00:00:00.000058,00:00:00.000056,00:00:00.000072,00:00:00.000068,00:00:00.000062,00:00:00.000062,00:00:00.000063,00:00:00.00006,00:00:00.000064,00:00:00.000067}');
INSERT INTO static.sys_processes VALUES ('sp_process_credits_production(''0:00:00'', 25)', true, '2020-08-31 15:02:41.554751', '00:00:00.5', 'relation "nav_planet" does not exist', '{00:00:00.000057,00:00:00.000057,00:00:00.000062,00:00:00.000058,00:00:00.000107,00:00:00.000064,00:00:00.000063,00:00:00.000058,00:00:00.000086,00:00:00.000066}');
INSERT INTO static.sys_processes VALUES ('sp_process_sessions_timeout()', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "sessions" does not exist', '{00:00:00.000047,00:00:00.000048,00:00:00.000051,00:00:00.000045,00:00:00.000047,00:00:00.000053,00:00:00.000052,00:00:00.000046,00:00:00.000047,00:00:00.000059}');
INSERT INTO static.sys_processes VALUES ('sp_process_bounties(10)', true, '2020-08-31 15:02:41.554751', '00:00:05', 'relation "users_bounty" does not exist', '{00:00:00.00005,00:00:00.000044,00:00:00.000052,00:00:00.000046,00:00:00.00005,00:00:00.000068,00:00:00.000047,00:00:00.000071,00:00:00.000045,00:00:00.00005}');
INSERT INTO static.sys_processes VALUES ('sp_process_clean_waiting_fleets()', true, '2020-08-31 15:02:25.924088', '00:10:00', 'relation "fleets" does not exist', '{00:00:00.000049,00:00:00.000044,00:00:00.000054,00:00:00.000051,00:00:00.000058,00:00:00.000064,00:00:00.000049,00:00:00.000048,00:00:00.000054,00:00:00.000055}');
INSERT INTO static.sys_processes VALUES ('sp_process_clean_alliances()', true, '2020-08-31 15:02:25.924088', '00:01:00', 'relation "alliances_invitations" does not exist', '{00:00:00.000059,00:00:00.000058,00:00:00.00007,00:00:00.000061,00:00:00.000087,00:00:00.000074,00:00:00.000065,00:00:00.000062,00:00:00.000068,00:00:00.000065}');
INSERT INTO static.sys_processes VALUES ('sp_process_clean_routes()', true, '2020-08-31 15:02:25.924088', '00:05:00', 'relation "routes" does not exist', '{00:00:00.000076,00:00:00.000107,00:00:00.000061,00:00:00.000056,00:00:00.000054,00:00:00.000064,00:00:00.000054,00:00:00.000093,00:00:00.000062,00:00:00.000065}');
INSERT INTO static.sys_processes VALUES ('sp_process_fleets_movements(''0:00:01'', 25)', true, '2020-08-31 15:02:41.554751', '00:00:00.5', 'relation "fleets" does not exist', '{00:00:00.000076,00:00:00.000067,00:00:00.000092,00:00:00.00007,00:00:00.000113,00:00:00.000075,00:00:00.000099,00:00:00.000095,00:00:00.00007,00:00:00.000068}');
INSERT INTO static.sys_processes VALUES ('sp_process_buildings()', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "planet_buildings_pending" does not exist', '{00:00:00.000083,00:00:00.000053,00:00:00.000075,00:00:00.000053,00:00:00.000056,00:00:00.000076,00:00:00.000074,00:00:00.000055,00:00:00.000056,00:00:00.000069}');
INSERT INTO static.sys_processes VALUES ('sp_process_market(''0:00:05'', 50)', true, '2020-08-31 15:02:41.050236', '00:00:05', 'relation "market_sales" does not exist', '{00:00:00.000059,00:00:00.000081,00:00:00.000088,00:00:00.000058,00:00:00.00006,00:00:00.000062,00:00:00.000073,00:00:00.000089,00:00:00.000085,00:00:00.000059}');
INSERT INTO static.sys_processes VALUES ('sp_process_holidays()', true, '2020-08-31 15:02:41.554751', '00:00:05', 'relation "users_holidays" does not exist', '{00:00:00.000073,00:00:00.000056,00:00:00.000082,00:00:00.000045,00:00:00.000047,00:00:00.000052,00:00:00.000049,00:00:00.000074,00:00:00.000051,00:00:00.000046}');
INSERT INTO static.sys_processes VALUES ('sp_process_naps(10)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "alliances_naps" does not exist', '{00:00:00.000057,00:00:00.000045,00:00:00.000049,00:00:00.000046,00:00:00.000083,00:00:00.000048,00:00:00.000048,00:00:00.000077,00:00:00.000046,00:00:00.000051}');
INSERT INTO static.sys_processes VALUES ('sp_process_wars(10)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "alliances_wars" does not exist', '{00:00:00.000045,00:00:00.000044,00:00:00.000048,00:00:00.000046,00:00:00.000051,00:00:00.000048,00:00:00.000048,00:00:00.00005,00:00:00.000085,00:00:00.000047}');
INSERT INTO static.sys_processes VALUES ('sp_process_ships(''0:00:01'', 20)', true, '2020-08-31 15:02:41.554751', '00:00:00.5', 'relation "planet_ships_pending" does not exist', '{00:00:00.000066,00:00:00.000113,00:00:00.000072,00:00:00.000064,00:00:00.000069,00:00:00.000065,00:00:00.000075,00:00:00.000062,00:00:00.000102,00:00:00.00006}');
INSERT INTO static.sys_processes VALUES ('sp_process_continue_shipyard(''0:00:01'', 20)', true, '2020-08-31 15:02:41.554751', '00:00:00.5', 'relation "nav_planet" does not exist', '{00:00:00.00006,00:00:00.00005,00:00:00.000053,00:00:00.000047,00:00:00.000051,00:00:00.00005,00:00:00.00005,00:00:00.000051,00:00:00.00008,00:00:00.000048}');
INSERT INTO static.sys_processes VALUES ('sp_process_score(''0:00:00'', 50)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "users" does not exist', '{00:00:00.000051,00:00:00.000071,00:00:00.000054,00:00:00.00005,00:00:00.000052,00:00:00.000052,00:00:00.000069,00:00:00.000051,00:00:00.000076,00:00:00.000053}');
INSERT INTO static.sys_processes VALUES ('sp_process_merchant_planets()', true, '2020-08-31 15:02:41.050236', '00:00:05', 'relation "reports" does not exist', '{00:00:00.00008,00:00:00.000056,00:00:00.000061,00:00:00.000057,00:00:00.000066,00:00:00.00006,00:00:00.000072,00:00:00.000073,00:00:00.000061,00:00:00.000103}');
INSERT INTO static.sys_processes VALUES ('sp_process_market_purchases()', true, '2020-08-31 15:02:41.050236', '00:00:05', 'relation "market_purchases" does not exist', '{00:00:00.000054,00:00:00.000052,00:00:00.000056,00:00:00.000053,00:00:00.000057,00:00:00.000054,00:00:00.000057,00:00:00.000055,00:00:00.000054,00:00:00.000065}');
INSERT INTO static.sys_processes VALUES ('sp_process_update_planets(''0:00:00'', 25)', true, '2020-08-31 15:02:41.050236', '00:00:01', 'relation "nav_planet" does not exist', '{00:00:00.00006,00:00:00.000046,00:00:00.00005,00:00:00.000048,00:00:00.000061,00:00:00.000049,00:00:00.00005,00:00:00.000072,00:00:00.000049,00:00:00.000051}');


--
-- Name: db_buildings_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_buildings_id_seq', 1, false);


--
-- Name: db_items_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_items_id_seq', 8, true);


--
-- Name: db_messages_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_messages_id_seq', 1, true);


--
-- Name: db_orientations_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_orientations_id_seq', 1, false);


--
-- Name: db_research_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_research_id_seq', 1, false);


--
-- Name: db_ship_modules_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_ship_modules_id_seq', 10, true);


--
-- Name: db_ship_structures_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_ship_structures_id_seq', 8, true);


--
-- Name: db_ships_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_ships_id_seq', 1, true);


--
-- Name: db_successes_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.db_successes_id_seq', 4, true);


--
-- Name: gsc_levels_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.gsc_levels_id_seq', 1, false);


--
-- Name: log_failed_logins_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_failed_logins_id_seq', 129778, true);


--
-- Name: log_http_errors_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_http_errors_id_seq', 21661, true);


--
-- Name: log_notices_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_notices_id_seq', 1341872, true);


--
-- Name: log_pages_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_pages_id_seq', 6062, true);


--
-- Name: log_referers_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_referers_id_seq', 1968, true);


--
-- Name: log_sys_errors_id_seq; Type: SEQUENCE SET; Schema: static; Owner: exileng
--

SELECT pg_catalog.setval('static.log_sys_errors_id_seq', 639059, true);


--
-- Name: banned_domains banned_domains_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.banned_domains
    ADD CONSTRAINT banned_domains_pkey PRIMARY KEY (domain);


--
-- Name: banned_logins banned_logins_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.banned_logins
    ADD CONSTRAINT banned_logins_pkey PRIMARY KEY (login);


--
-- Name: db_buildings db_buildings_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings
    ADD CONSTRAINT db_buildings_pkey PRIMARY KEY (id);


--
-- Name: db_buildings_req_building db_buildings_req_building_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_building
    ADD CONSTRAINT db_buildings_req_building_pkey PRIMARY KEY (buildingid, required_buildingid);


--
-- Name: db_buildings_req_research db_buildings_req_research_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_research
    ADD CONSTRAINT db_buildings_req_research_pkey PRIMARY KEY (buildingid, required_researchid);


--
-- Name: db_lcid db_lcid_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_lcid
    ADD CONSTRAINT db_lcid_pkey PRIMARY KEY (lcid);


--
-- Name: db_messages db_messages_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_messages
    ADD CONSTRAINT db_messages_pkey PRIMARY KEY (id, lcid);


--
-- Name: db_orientations db_orientations_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_orientations
    ADD CONSTRAINT db_orientations_pkey PRIMARY KEY (id);


--
-- Name: db_research db_research_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research
    ADD CONSTRAINT db_research_pkey PRIMARY KEY (id);


--
-- Name: db_research_req_building db_research_req_building_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_building
    ADD CONSTRAINT db_research_req_building_pkey PRIMARY KEY (researchid, required_buildingid);


--
-- Name: db_research_req_research db_research_req_research_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_research
    ADD CONSTRAINT db_research_req_research_pkey PRIMARY KEY (researchid, required_researchid);


--
-- Name: db_items db_resources_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_items
    ADD CONSTRAINT db_resources_pkey PRIMARY KEY (id);


--
-- Name: db_security_levels db_security_levels_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_security_levels
    ADD CONSTRAINT db_security_levels_pkey PRIMARY KEY (id);


--
-- Name: db_ship_structures db_ship_structure_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ship_structures
    ADD CONSTRAINT db_ship_structure_pkey PRIMARY KEY (id);


--
-- Name: db_ship_modules db_ship_utility_modules_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ship_modules
    ADD CONSTRAINT db_ship_utility_modules_pkey PRIMARY KEY (id);


--
-- Name: db_ships db_ships_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships
    ADD CONSTRAINT db_ships_pkey PRIMARY KEY (id);


--
-- Name: db_ships_req_building db_ships_req_building_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_building
    ADD CONSTRAINT db_ships_req_building_pkey PRIMARY KEY (shipid, required_buildingid);


--
-- Name: db_ships_req_research db_ships_req_research_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_research
    ADD CONSTRAINT db_ships_req_research_pkey PRIMARY KEY (shipid, required_researchid);


--
-- Name: db_successes db_successes_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_successes
    ADD CONSTRAINT db_successes_pkey PRIMARY KEY (id);


--
-- Name: sys_events events_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.sys_events
    ADD CONSTRAINT events_pkey PRIMARY KEY (procedure);


--
-- Name: log_failed_logins log_failed_logins_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_failed_logins
    ADD CONSTRAINT log_failed_logins_pkey PRIMARY KEY (id);


--
-- Name: log_http_errors log_http_errors_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_http_errors
    ADD CONSTRAINT log_http_errors_pkey PRIMARY KEY (id);


--
-- Name: log_jobs log_jobs_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_jobs
    ADD CONSTRAINT log_jobs_pkey PRIMARY KEY (task);


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_multi_simultaneous_warnings
    ADD CONSTRAINT log_multi_simultaneous_warnings_pkey PRIMARY KEY (datetime, userid1, userid2);


--
-- Name: log_notices log_notices_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_notices
    ADD CONSTRAINT log_notices_pkey PRIMARY KEY (id);


--
-- Name: log_pages log_pages_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_pages
    ADD CONSTRAINT log_pages_pkey PRIMARY KEY (id);


--
-- Name: log_referers log_referers_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_referers
    ADD CONSTRAINT log_referers_pkey PRIMARY KEY (id);


--
-- Name: log_sys_errors log_sys_errors_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_sys_errors
    ADD CONSTRAINT log_sys_errors_pkey PRIMARY KEY (id);


--
-- Name: sys_daily_updates sys_daily_updates_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.sys_daily_updates
    ADD CONSTRAINT sys_daily_updates_pkey PRIMARY KEY (procedure);


--
-- Name: sys_processes sys_processes_pkey; Type: CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.sys_processes
    ADD CONSTRAINT sys_processes_pkey PRIMARY KEY (procedure);


--
-- Name: db_buildings_id; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX db_buildings_id ON static.db_buildings USING btree (id);


--
-- Name: fki_buildingid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_buildingid_fk ON static.db_buildings_req_building USING btree (buildingid);


--
-- Name: fki_db_buildings_req_research_buildingid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_buildings_req_research_buildingid_fk ON static.db_buildings_req_research USING btree (buildingid);


--
-- Name: fki_db_buildings_req_research_required_research_id; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_buildings_req_research_required_research_id ON static.db_buildings_req_research USING btree (required_researchid);


--
-- Name: fki_db_research_req_building_buildingid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_research_req_building_buildingid_fk ON static.db_research_req_building USING btree (required_buildingid);


--
-- Name: fki_db_research_req_building_researchid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_research_req_building_researchid_fk ON static.db_research_req_building USING btree (researchid);


--
-- Name: fki_db_research_req_research_required_researchid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_research_req_research_required_researchid_fk ON static.db_research_req_research USING btree (required_researchid);


--
-- Name: fki_db_research_req_research_researchid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_research_req_research_researchid_fk ON static.db_research_req_research USING btree (researchid);


--
-- Name: fki_db_ships_buildingid_fkey; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_ships_buildingid_fkey ON static.db_ships USING btree (buildingid);


--
-- Name: fki_db_ships_req_building_required_buildingid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_ships_req_building_required_buildingid_fk ON static.db_ships_req_building USING btree (required_buildingid);


--
-- Name: fki_db_ships_req_building_shipid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_ships_req_building_shipid_fk ON static.db_ships_req_building USING btree (shipid);


--
-- Name: fki_db_ships_req_research_required_researchid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_ships_req_research_required_researchid_fk ON static.db_ships_req_research USING btree (required_researchid);


--
-- Name: fki_db_ships_req_research_shipid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_db_ships_req_research_shipid_fk ON static.db_ships_req_research USING btree (shipid);


--
-- Name: fki_log_multi_simultaneous_warnings_userid1_fkey; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_log_multi_simultaneous_warnings_userid1_fkey ON static.log_multi_simultaneous_warnings USING btree (userid1);


--
-- Name: fki_log_multi_simultaneous_warnings_userid2_fkey; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_log_multi_simultaneous_warnings_userid2_fkey ON static.log_multi_simultaneous_warnings USING btree (userid2);


--
-- Name: fki_required_buildingid_fk; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_required_buildingid_fk ON static.db_buildings_req_building USING btree (required_buildingid);


--
-- Name: fki_users_multi_account_warnings_id_fkey; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_users_multi_account_warnings_id_fkey ON static.log_multi_account_warnings USING btree (id);


--
-- Name: fki_users_multi_account_warnings_withid_fkey; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX fki_users_multi_account_warnings_withid_fkey ON static.log_multi_account_warnings USING btree (withid);


--
-- Name: log_notices_timestamp_idx; Type: INDEX; Schema: static; Owner: exileng
--

CREATE INDEX log_notices_timestamp_idx ON static.log_notices USING btree (datetime);


--
-- Name: log_notices before_log_notice_insert; Type: TRIGGER; Schema: static; Owner: exileng
--

CREATE TRIGGER before_log_notice_insert BEFORE INSERT ON static.log_notices FOR EACH ROW EXECUTE FUNCTION static.sp_log_notice_before_insert();


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_before_insert; Type: TRIGGER; Schema: static; Owner: exileng
--

CREATE TRIGGER log_multi_simultaneous_warnings_before_insert BEFORE INSERT ON static.log_multi_simultaneous_warnings FOR EACH ROW EXECUTE FUNCTION static.sp_log_multi_simultaneous_warnings_before_insert();


--
-- Name: db_buildings_req_building db_buildings_req_building_buildingid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_building
    ADD CONSTRAINT db_buildings_req_building_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_buildings_req_building db_buildings_req_building_required_buildingid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_building
    ADD CONSTRAINT db_buildings_req_building_required_buildingid_fk FOREIGN KEY (required_buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_buildings_req_research db_buildings_req_research_buildingid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_research
    ADD CONSTRAINT db_buildings_req_research_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_buildings_req_research db_buildings_req_research_required_research_id; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_buildings_req_research
    ADD CONSTRAINT db_buildings_req_research_required_research_id FOREIGN KEY (required_researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_research_req_building db_research_req_building_buildingid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_building
    ADD CONSTRAINT db_research_req_building_buildingid_fk FOREIGN KEY (required_buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_research_req_building db_research_req_building_researchid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_building
    ADD CONSTRAINT db_research_req_building_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_research_req_research db_research_req_research_required_researchid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_research
    ADD CONSTRAINT db_research_req_research_required_researchid_fk FOREIGN KEY (required_researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_research_req_research db_research_req_research_researchid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_research_req_research
    ADD CONSTRAINT db_research_req_research_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_ships db_ships_buildingid_fkey; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships
    ADD CONSTRAINT db_ships_buildingid_fkey FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: db_ships_req_building db_ships_req_building_required_buildingid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_building
    ADD CONSTRAINT db_ships_req_building_required_buildingid_fk FOREIGN KEY (required_buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_ships_req_building db_ships_req_building_shipid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_building
    ADD CONSTRAINT db_ships_req_building_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_ships_req_research db_ships_req_research_required_research_id; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_research
    ADD CONSTRAINT db_ships_req_research_required_research_id FOREIGN KEY (required_researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: db_ships_req_research db_ships_req_research_shipid_fk; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.db_ships_req_research
    ADD CONSTRAINT db_ships_req_research_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_referers_users log_referers_users_refererid; Type: FK CONSTRAINT; Schema: static; Owner: exileng
--

ALTER TABLE ONLY static.log_referers_users
    ADD CONSTRAINT log_referers_users_refererid FOREIGN KEY (refererid) REFERENCES static.log_referers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
