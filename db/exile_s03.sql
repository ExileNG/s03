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
-- Name: exile_s03; Type: SCHEMA; Schema: -; Owner: exileng
--

CREATE SCHEMA exile_s03;


ALTER SCHEMA exile_s03 OWNER TO exileng;

--
-- Name: battle_result; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.battle_result AS (
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


ALTER TYPE exile_s03.battle_result OWNER TO exileng;

--
-- Name: buildings_underconstruction; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.buildings_underconstruction AS (
	planet_id integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	building_id integer,
	building_name character varying,
	remaining_time integer
);


ALTER TYPE exile_s03.buildings_underconstruction OWNER TO exileng;

--
-- Name: fleet_details; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.fleet_details AS (
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


ALTER TYPE exile_s03.fleet_details OWNER TO exileng;

--
-- Name: fleet_movement; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.fleet_movement AS (
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


ALTER TYPE exile_s03.fleet_movement OWNER TO exileng;

--
-- Name: item_quantity; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.item_quantity AS (
	id integer,
	quantity bigint
);


ALTER TYPE exile_s03.item_quantity OWNER TO exileng;

--
-- Name: ships_underconstruction; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.ships_underconstruction AS (
	planet_id integer,
	planet_name character varying,
	planet_galaxy smallint,
	planet_sector smallint,
	planet_planet smallint,
	ship_id integer,
	ship_name character varying,
	remaining_time integer
);


ALTER TYPE exile_s03.ships_underconstruction OWNER TO exileng;

--
-- Name: training_price; Type: TYPE; Schema: exile_s03; Owner: exileng
--

CREATE TYPE exile_s03.training_price AS (
	scientist_ore smallint,
	scientist_hydrocarbon smallint,
	scientist_credits smallint,
	soldier_ore smallint,
	soldier_hydrocarbon smallint,
	soldier_credits smallint
);


ALTER TYPE exile_s03.training_price OWNER TO exileng;

--
-- Name: _sp_alliance_accept_nap(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03._sp_alliance_accept_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
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

	IF c > 100 THEN

		RETURN 1;

	END IF;

	SELECT INTO c count(*)

	FROM alliances_naps

	WHERE allianceid2=fromaid;

	IF c > 100 THEN

		RETURN 1;

	END IF;

	INSERT INTO alliances_naps(allianceid1, allianceid2, guarantee)

	VALUES(r_user.alliance_id, fromaid, offer.guarantee_asked);

	INSERT INTO alliances_naps(allianceid1, allianceid2, guarantee)

	VALUES(fromaid, r_user.alliance_id, offer.guarantee);

	DELETE FROM alliances_naps_offers

	WHERE allianceid=fromaid AND targetallianceid=r_user.alliance_id;

	RETURN 0;

END;$_$;


ALTER FUNCTION exile_s03._sp_alliance_accept_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: _sp_alliance_break_nap(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03._sp_alliance_break_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03._sp_alliance_break_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: const_universe_id(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.const_universe_id() RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $$SELECT 8;$$;


ALTER FUNCTION exile_s03.const_universe_id() OWNER TO exileng;

--
-- Name: notifications_chat_messages(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.notifications_chat_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$-- notifications_chat_messages

BEGIN

	PERFORM sp_player_addnotification(chat_users.userid, 'chat:say', '{channelid:' || NEW.channelid || ',tag:' || sp__quote(sp_alliance_get_tag(NEW.allianceid)) || ',name:' || sp__quote(NEW.name) || ',action:' || NEW.action || ',parameter:' || sp__quote(NEW.parameter) || '}')

	FROM chat_users

		INNER JOIN sessions ON (chat_users.userid = sessions.userid)

	WHERE channelid = NEW.channelid;

	RETURN null; -- result ignored as it is an after trigger

END;$$;


ALTER FUNCTION exile_s03.notifications_chat_messages() OWNER TO exileng;

--
-- Name: notifications_chat_users(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.notifications_chat_users() RETURNS trigger
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


ALTER FUNCTION exile_s03.notifications_chat_users() OWNER TO exileng;

--
-- Name: FUNCTION notifications_chat_users(); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.notifications_chat_users() IS 'Add a notification to users in the channel when a user joins/leaves';


--
-- Name: notifications_messages(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.notifications_messages() RETURNS trigger
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


ALTER FUNCTION exile_s03.notifications_messages() OWNER TO exileng;

--
-- Name: notifications_reports(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.notifications_reports() RETURNS trigger
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


ALTER FUNCTION exile_s03.notifications_reports() OWNER TO exileng;

--
-- Name: sp_alliance_accept_invitation(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_accept_invitation(_userid integer, _alliance_tag character varying) IS 'Accept the invitation of an alliance.

Returns 0 if no error';


--
-- Name: sp_alliance_cancel_invitation(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_cancel_invitation(_userid integer, _invited_user character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_cancel_invitation(_userid integer, _invited_user character varying) OWNER TO exileng;

--
-- Name: sp_alliance_check_for_leader(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_check_for_leader(_allianceid integer) RETURNS void
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


ALTER FUNCTION exile_s03.sp_alliance_check_for_leader(_allianceid integer) OWNER TO exileng;

--
-- Name: sp_alliance_decline_invitation(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_decline_invitation(_userid integer, _alliance_tag character varying) IS 'Decline the invitation of an alliance.

Returns 0 if no error';


--
-- Name: sp_alliance_decline_nap(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_decline_nap(_userid integer, _alliance_tag character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_decline_nap(_userid integer, _alliance_tag character varying) OWNER TO exileng;

--
-- Name: sp_alliance_get_leave_cost(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_get_leave_cost(_userid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $_$DECLARE

	r_fleets record;

	r_ships_parked record;

	r_user record;

BEGIN

	RETURN 0;

	/*

	SELECT INTO r_user COALESCE(planets, 0) AS planets FROM users WHERE id=_userid;

	SELECT INTO r_fleets COALESCE(sum(real_signature), 0) AS signature FROM fleets WHERE ownerid=_userid;

	SELECT INTO r_ships_parked

		COALESCE(sum(signature*quantity), 0) AS signature

	FROM planet_ships

		INNER JOIN nav_planet ON nav_planet.id = planet_ships.planetid

		INNER JOIN db_ships ON db_ships.id = planet_ships.shipid

	WHERE ownerid=$1;

	RETURN int4(r_user.planets*(r_user.planets / 4.0)*1000) + r_fleets.signature + r_ships_parked.signature;

*/

END;$_$;


ALTER FUNCTION exile_s03.sp_alliance_get_leave_cost(_userid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_get_leave_cost(_userid integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_get_leave_cost(_userid integer) IS 'Return the price of user to leave an alliance';


--
-- Name: sp_alliance_get_tag(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_get_tag(_allianceid integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$--sp_alliance_get_tag

SELECT COALESCE((SELECT alliances.tag

FROM alliances

WHERE id=$1), '');$_$;


ALTER FUNCTION exile_s03.sp_alliance_get_tag(_allianceid integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_accept(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_money_accept(_userid integer, _money_requestid integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_money_accept(_userid integer, _money_requestid integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_deny(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_money_deny(_userid integer, _money_requestid integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_money_deny(_userid integer, _money_requestid integer) OWNER TO exileng;

--
-- Name: sp_alliance_money_request(integer, integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_money_request(_userid integer, _credits integer, _reason character varying); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_money_request(_userid integer, _credits integer, _reason character varying) IS 'Request money from alliance, if the userid is the treasurer or the boss then they get the money immediatly';


--
-- Name: sp_alliance_request_nap(integer, character varying, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_request_nap(_userid integer, _alliance_tag character varying, _our_guarantee integer, _their_guarantee integer) IS 'Invite an alliance with the tag $2 to create a NAP.

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
-- Name: sp_alliance_transfer_money(integer, integer, character varying, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliance_transfer_money(integer, integer, character varying, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_alliance_transfer_money(integer, integer, character varying, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_alliance_transfer_money(integer, integer, character varying, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_alliance_transfer_money(integer, integer, character varying, integer) IS 'Transfer money from player to the alliance.';


--
-- Name: sp_alliances_wallet_journal_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_alliances_wallet_journal_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_alliances_wallet_journal_before_insert() OWNER TO exileng;

--
-- Name: sp_cancel_move(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_cancel_move(integer, integer) RETURNS void
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


ALTER FUNCTION exile_s03.sp_cancel_move(integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_move(integer, integer, boolean); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_cancel_move(integer, integer, boolean) RETURNS void
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


ALTER FUNCTION exile_s03.sp_cancel_move(integer, integer, boolean) OWNER TO exileng;

--
-- Name: sp_cancel_recycling(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_cancel_recycling(integer, integer) RETURNS void
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


ALTER FUNCTION exile_s03.sp_cancel_recycling(integer, integer) OWNER TO exileng;

--
-- Name: sp_cancel_waiting(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_cancel_waiting(_ownerid integer, _fleetid integer) RETURNS void
    LANGUAGE sql
    AS $_$-- sp_cancel_waiting

UPDATE fleets SET

	action_start_time = NULL,

	action_end_time = NULL,

	action = 0,

	next_waypointid = NULL

WHERE ownerid=$1 AND id=$2 AND action=4;$_$;


ALTER FUNCTION exile_s03.sp_cancel_waiting(_ownerid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_catastrophe_electromagnetic_storm(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_catastrophe_electromagnetic_storm(integer, integer, integer) RETURNS void
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


ALTER FUNCTION exile_s03.sp_catastrophe_electromagnetic_storm(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_chat_lines_after_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_chat_lines_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

/*

	-- keep only xx lines of chat

	DELETE FROM chat_lines

	WHERE chatid=NEW.chatid AND id < (SELECT min(id) FROM (SELECT id FROM chat_lines WHERE chatid=NEW.chatid ORDER BY datetime DESC LIMIT 100) as t);

*/

	RETURN NEW;

END;$$;


ALTER FUNCTION exile_s03.sp_chat_lines_after_insert() OWNER TO exileng;

--
-- Name: sp_chat_lines_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_chat_lines_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_chat_lines_before_insert() OWNER TO exileng;

--
-- Name: sp_chat_onlineusers_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_chat_onlineusers_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_chat_onlineusers_before_insert() OWNER TO exileng;

--
-- Name: sp_create_key(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_create_key() RETURNS character varying
    LANGUAGE sql
    AS $$SELECT substring(md5(int2(random()*1000) || chr(int2(65+random()*25)) || chr(int2(65+random()*25)) || date_part('epoch', now()) || chr(int2(65+random()*25)) || chr(int2(65+random()*25))) from 4 for 8);$$;


ALTER FUNCTION exile_s03.sp_create_key() OWNER TO exileng;

--
-- Name: sp_create_route(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_create_route(integer, character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $_$-- Param1: UserId

-- Param2: Route name

DECLARE

	routeid int4;

BEGIN

	routeid := nextval('routes_id_seq');

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


ALTER FUNCTION exile_s03.sp_create_route(integer, character varying) OWNER TO exileng;

--
-- Name: sp_create_route_recycle_move(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_create_route_recycle_move(integer) RETURNS bigint
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


ALTER FUNCTION exile_s03.sp_create_route_recycle_move(integer) OWNER TO exileng;

--
-- Name: sp_create_route_unload_move(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_create_route_unload_move(integer) RETURNS bigint
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


ALTER FUNCTION exile_s03.sp_create_route_unload_move(integer) OWNER TO exileng;

--
-- Name: sp_daily_credits_production(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_daily_credits_production() RETURNS void
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


ALTER FUNCTION exile_s03.sp_daily_credits_production() OWNER TO exileng;

--
-- Name: sp_daily_update_scores(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_daily_update_scores() RETURNS void
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


ALTER FUNCTION exile_s03.sp_daily_update_scores() OWNER TO exileng;

--
-- Name: sp_delete_account(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_delete_account(integer) RETURNS void
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


ALTER FUNCTION exile_s03.sp_delete_account(integer) OWNER TO exileng;

--
-- Name: sp_destroy_building(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_destroy_building(_userid integer, integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_destroy_building(_userid integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_destroy_building(_userid integer, integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_destroy_building(_userid integer, integer, integer) IS 'Destroy a building on a planet only if not building on this planet and no other buildings depend on the building';


--
-- Name: sp_destroy_ships(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_destroy_ships(integer, integer, integer) RETURNS void
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

		orbit_ore = orbit_ore + lost_ore + int4(ship.cost_ore*$3*(0.35+0.10*random())),

		orbit_hydrocarbon = orbit_hydrocarbon + lost_hydrocarbon + int4(ship.cost_hydrocarbon*$3*(0.25+0.05*random()))

	WHERE id=fleet.planetid;

	RETURN;

END;$_$;


ALTER FUNCTION exile_s03.sp_destroy_ships(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_destroy_ships(integer, integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_destroy_ships(integer, integer, integer) IS 'Destroy ships of a fleet and remove the necessary cargo';


--
-- Name: sp_dismiss_staff(integer, integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_dismiss_staff(integer, integer, integer, integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_dismiss_staff(integer, integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_dismiss_staff(integer, integer, integer, integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_dismiss_staff(integer, integer, integer, integer, integer) IS 'Dismiss scientists, soldiers or workers from planet';


--
-- Name: sp_fire_commander(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fire_commander(integer, integer) RETURNS smallint
    LANGUAGE sql
    AS $_$-- fire/delete a commander

DELETE FROM commanders WHERE ownerid=$1 AND id=$2;

SELECT int2(0);$_$;


ALTER FUNCTION exile_s03.sp_fire_commander(integer, integer) OWNER TO exileng;

--
-- Name: sp_first_planet(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_first_planet(integer, integer) RETURNS integer
    LANGUAGE sql IMMUTABLE
    AS $_$SELECT ($1-1)*25*99 + ($2-1)*25 + 1;$_$;


ALTER FUNCTION exile_s03.sp_first_planet(integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_first_planet(integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_first_planet(integer, integer) IS 'Return the first planet in a given galaxy:sector';


--
-- Name: sp_fleets_categories_add(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_categories_add(_userid integer, _label character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_fleets_categories_add(_userid integer, _label character varying) OWNER TO exileng;

--
-- Name: sp_fleets_categories_delete(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_categories_delete(_userid integer, _categoryid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	DELETE FROM users_fleets_categories WHERE userid=$1 AND category=$2;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION exile_s03.sp_fleets_categories_delete(_userid integer, _categoryid integer) OWNER TO exileng;

--
-- Name: sp_fleets_categories_rename(integer, integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_categories_rename(_userid integer, _categoryid integer, _label character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	UPDATE users_fleets_categories SET label=$3 WHERE userid=$1 AND category=$2;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION exile_s03.sp_fleets_categories_rename(_userid integer, _categoryid integer, _label character varying) OWNER TO exileng;

--
-- Name: sp_fleets_check_battle(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_check_battle() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_fleets_check_battle() OWNER TO exileng;

--
-- Name: sp_fleets_set_category(integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_set_category(_userid integer, _fleetid integer, _oldcategoryid integer, _newcategoryid integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$BEGIN

	UPDATE fleets SET categoryid=$4 WHERE ownerid=$1 AND id=$2 AND categoryid=$3;

	RETURN FOUND;

END;$_$;


ALTER FUNCTION exile_s03.sp_fleets_set_category(_userid integer, _fleetid integer, _oldcategoryid integer, _newcategoryid integer) OWNER TO exileng;

--
-- Name: sp_fleets_ships_afterchanges(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_ships_afterchanges() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_fleets_ships_afterchanges() OWNER TO exileng;

--
-- Name: sp_fleets_ships_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_fleets_ships_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE fleets_ships SET quantity = quantity + NEW.quantity WHERE fleetid=NEW.fleetid AND shipid=NEW.shipid;

	IF FOUND OR NEW.quantity = 0 THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION exile_s03.sp_fleets_ships_beforeinsert() OWNER TO exileng;

--
-- Name: sp_flush_unused_accounts(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_flush_unused_accounts() RETURNS void
    LANGUAGE sql
    AS $$DELETE FROM users WHERE privilege > -50 AND privilege < 100 AND orientation=0 AND (now() - regdate > INTERVAL '7 days');

DELETE FROM users WHERE privilege > -50 AND privilege < 100 AND (now() - regdate > INTERVAL '2 months');$$;


ALTER FUNCTION exile_s03.sp_flush_unused_accounts() OWNER TO exileng;

--
-- Name: sp_get_addressee_list(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_addressee_list(integer) RETURNS SETOF character varying
    LANGUAGE sql
    AS $_$-- return the list of addressee names

-- param1: id

SELECT login

FROM messages_addressee_history INNER JOIN users ON messages_addressee_history.addresseeid = users.id

WHERE ownerid=$1

ORDER BY upper(login);$_$;


ALTER FUNCTION exile_s03.sp_get_addressee_list(integer) OWNER TO exileng;

--
-- Name: sp_get_battle_result(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_battle_result(integer, integer, integer) RETURNS SETOF exile_s03.battle_result
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


ALTER FUNCTION exile_s03.sp_get_battle_result(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_get_construction_time(integer, real, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_construction_time(_time integer, _exp real, _buildings_built integer, _mod_speed integer) RETURNS integer
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

	--RAISE NOTICE '%,%,%,%', _time,_buildings_built, _mod_speed, mod;

	RETURN int4(LEAST(10*t, t * 100.0/mod));

END;$$;


ALTER FUNCTION exile_s03.sp_get_construction_time(_time integer, _exp real, _buildings_built integer, _mod_speed integer) OWNER TO exileng;

--
-- Name: sp_get_nav_galaxycount(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_nav_galaxycount() RETURNS smallint
    LANGUAGE sql STABLE
    AS $$SELECT int2(25)$$;


ALTER FUNCTION exile_s03.sp_get_nav_galaxycount() OWNER TO exileng;

--
-- Name: FUNCTION sp_get_nav_galaxycount(); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_get_nav_galaxycount() IS 'Return number of galaxies in the universe';


--
-- Name: sp_get_nav_sectorcount(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_nav_sectorcount(integer) RETURNS smallint
    LANGUAGE sql STABLE
    AS $$SELECT int2(99);$$;


ALTER FUNCTION exile_s03.sp_get_nav_sectorcount(integer) OWNER TO exileng;

--
-- Name: sp_get_planet_blocus_strength(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_planet_blocus_strength(_planetid integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_get_planet_blocus_strength(_planetid integer) OWNER TO exileng;

--
-- Name: sp_get_planet_name(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_planet_name(_userid integer, _planetid integer) RETURNS character varying
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


ALTER FUNCTION exile_s03.sp_get_planet_name(_userid integer, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_get_planet_name(_userid integer, _planetid integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_get_planet_name(_userid integer, _planetid integer) IS 'Return the planet name if it belongs to the player or the player name if a radar or a fleet is in orbit otherwise it returns nothing';


--
-- Name: sp_get_planet_owner(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_planet_owner(integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $_$-- return the ownerid of given planet id

-- Param1: planet id

SELECT ownerid FROM nav_planet WHERE id=$1 LIMIT 1;$_$;


ALTER FUNCTION exile_s03.sp_get_planet_owner(integer) OWNER TO exileng;

--
-- Name: sp_get_research_cost(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_research_cost(integer, integer) RETURNS integer
    LANGUAGE sql STABLE
    AS $_$-- Param1: UserId

-- Param2: ResearchId

SELECT int4((SELECT mod_research_cost FROM users WHERE id=$1) * cost_credits * power(2.35, 5-levels + COALESCE((SELECT level FROM researches WHERE researchid = db_research.id AND userid=$1), 0)))

FROM db_research

WHERE id=$2;$_$;


ALTER FUNCTION exile_s03.sp_get_research_cost(integer, integer) OWNER TO exileng;

--
-- Name: sp_get_research_time(integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_research_time(_userid integer, _rank integer, _levels integer, _level integer) RETURNS integer
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

		result := int4((SELECT (100+mod_research_time)/100.0 FROM users WHERE id=_userid)*(3600 + 

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

		result := int4((SELECT (100+mod_research_time)/100.0 FROM users WHERE id=_userid)*(3600 + 

			3.6/log(6, scientist_total) * 800 * research_rank * power(3.4+ GREATEST(-0.05, research_rank-scientist_total/1500.0)/10.0, 4)));

	END IF;

	RETURN int4(result * const_game_speed());

END;$$;


ALTER FUNCTION exile_s03.sp_get_research_time(_userid integer, _rank integer, _levels integer, _level integer) OWNER TO exileng;

--
-- Name: sp_get_user(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_get_user(integer) RETURNS character varying
    LANGUAGE sql STABLE
    AS $_$SELECT login FROM users WHERE id=$1;$_$;


ALTER FUNCTION exile_s03.sp_get_user(integer) OWNER TO exileng;

--
-- Name: sp_ignore_sender(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_ignore_sender(_userid integer, _ignored_user character varying) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_ignore_sender(_userid integer, _ignored_user character varying) OWNER TO exileng;

--
-- Name: FUNCTION sp_ignore_sender(_userid integer, _ignored_user character varying); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_ignore_sender(_userid integer, _ignored_user character varying) IS 'Add a name to a user ignore list so they can''t send him any message';


--
-- Name: sp_is_ally(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_is_ally(integer, integer) RETURNS boolean
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


ALTER FUNCTION exile_s03.sp_is_ally(integer, integer) OWNER TO exileng;

--
-- Name: sp_job_update(character varying, integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE log_jobs SET state=taskstate,"processid"=taskpid, lastupdate=now() WHERE lower(task)=lower(taskname);

	IF NOT FOUND THEN

		INSERT INTO log_jobs(task,state,"processid") VALUES(taskname,taskstate,taskpid);

	END IF;

END;$$;


ALTER FUNCTION exile_s03.sp_job_update(taskname character varying, taskpid integer, taskstate character varying) OWNER TO exileng;

--
-- Name: sp_list_available_buildings(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_list_available_buildings(integer) RETURNS SETOF static.db_buildings
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


ALTER FUNCTION exile_s03.sp_list_available_buildings(integer) OWNER TO exileng;

--
-- Name: sp_list_available_ships(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_list_available_ships(integer) RETURNS SETOF static.db_ships
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


ALTER FUNCTION exile_s03.sp_list_available_ships(integer) OWNER TO exileng;

--
-- Name: sp_list_fleets(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_list_fleets(integer, integer, integer) RETURNS SETOF exile_s03.fleet_details
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


ALTER FUNCTION exile_s03.sp_list_fleets(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_list_fleets_moving(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_list_fleets_moving(integer) RETURNS SETOF exile_s03.fleet_movement
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


ALTER FUNCTION exile_s03.sp_list_fleets_moving(integer) OWNER TO exileng;

--
-- Name: sp_log_activity(integer, character varying, bigint); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_activity(integer, character varying, bigint) RETURNS void
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


ALTER FUNCTION exile_s03.sp_log_activity(integer, character varying, bigint) OWNER TO exileng;

--
-- Name: sp_log_credits(integer, integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_credits(integer, integer, character varying) RETURNS void
    LANGUAGE sql
    AS $_$-- Param1: Userid

-- Param2: Credits delta

-- Param3: Description

INSERT INTO users_expenses(userid, credits, credits_delta, description)

VALUES($1, (SELECT credits FROM users WHERE id=$1), $2, $3);$_$;


ALTER FUNCTION exile_s03.sp_log_credits(integer, integer, character varying) OWNER TO exileng;

--
-- Name: sp_log_multi_simultaneous_warnings_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_multi_simultaneous_warnings_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	PERFORM 1 FROM log_multi_simultaneous_warnings WHERE datetime=NEW.datetime AND userid1=NEW.userid1 AND userid2=NEW.userid2;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION exile_s03.sp_log_multi_simultaneous_warnings_before_insert() OWNER TO exileng;

--
-- Name: sp_log_notice_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_notice_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_log_notice_before_insert() OWNER TO exileng;

--
-- Name: sp_log_referer(integer, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_referer(integer, character varying) RETURNS void
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


ALTER FUNCTION exile_s03.sp_log_referer(integer, character varying) OWNER TO exileng;

--
-- Name: sp_log_referer(integer, character varying, character varying); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_log_referer(integer, character varying, character varying) RETURNS void
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


ALTER FUNCTION exile_s03.sp_log_referer(integer, character varying, character varying) OWNER TO exileng;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users (
    id integer NOT NULL,
    privilege integer DEFAULT '-3'::integer NOT NULL,
    login character varying(16),
    password character varying(32),
    lastlogin timestamp without time zone DEFAULT now(),
    regdate timestamp without time zone DEFAULT now() NOT NULL,
    email character varying(128),
    credits integer DEFAULT 3500 NOT NULL,
    credits_bankruptcy smallint DEFAULT static.const_hours_before_bankruptcy(),
    lcid smallint DEFAULT 1036 NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    notes text,
    avatar_url character varying(255) DEFAULT ''::character varying NOT NULL,
    lastplanetid integer,
    deletion_date timestamp without time zone,
    score integer DEFAULT 0 NOT NULL,
    score_prestige bigint DEFAULT 0 NOT NULL,
    score_buildings bigint DEFAULT 0 NOT NULL,
    score_research bigint DEFAULT 0 NOT NULL,
    score_ships bigint DEFAULT 0 NOT NULL,
    alliance_id integer,
    alliance_rank smallint DEFAULT 0 NOT NULL,
    alliance_joined timestamp without time zone,
    alliance_left timestamp without time zone,
    alliance_taxes_paid bigint DEFAULT 0 NOT NULL,
    alliance_credits_given bigint DEFAULT 0 NOT NULL,
    alliance_credits_taken bigint DEFAULT 0 NOT NULL,
    alliance_score_combat integer DEFAULT 0 NOT NULL,
    newpassword character varying(32),
    lastactivity timestamp without time zone,
    planets integer DEFAULT 0 NOT NULL,
    noplanets_since timestamp without time zone,
    last_catastrophe timestamp without time zone DEFAULT now() NOT NULL,
    last_holidays timestamp without time zone,
    previous_score integer DEFAULT 0 NOT NULL,
    timers_enabled boolean DEFAULT true NOT NULL,
    ban_datetime timestamp without time zone,
    ban_expire timestamp without time zone DEFAULT '2009-01-01 17:00:00'::timestamp without time zone,
    ban_reason character varying(128),
    ban_reason_public character varying(128),
    ban_adminuserid integer,
    scientists integer DEFAULT 0 NOT NULL,
    soldiers integer DEFAULT 0 NOT NULL,
    dev_lasterror integer,
    dev_lastnotice integer,
    protection_enabled boolean DEFAULT false NOT NULL,
    protection_colonies_to_unprotect smallint DEFAULT 5 NOT NULL,
    protection_datetime timestamp without time zone DEFAULT (now() + '14 days'::interval) NOT NULL,
    max_colonizable_planets integer DEFAULT 50000 NOT NULL,
    remaining_colonizations integer DEFAULT 100000 NOT NULL,
    upkeep_last_cost integer DEFAULT 0 NOT NULL,
    upkeep_commanders real DEFAULT 0 NOT NULL,
    upkeep_planets real DEFAULT 0 NOT NULL,
    upkeep_scientists real DEFAULT 0 NOT NULL,
    upkeep_soldiers real DEFAULT 0 NOT NULL,
    upkeep_ships real DEFAULT 0 NOT NULL,
    upkeep_ships_in_position real DEFAULT 0 NOT NULL,
    upkeep_ships_parked real DEFAULT 0 NOT NULL,
    wallet_display boolean[],
    resets smallint DEFAULT 0 NOT NULL,
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
    commanders_loyalty smallint DEFAULT 100 NOT NULL,
    orientation smallint DEFAULT 0 NOT NULL,
    admin_notes text DEFAULT ''::text NOT NULL,
    paid_until timestamp without time zone,
    autosignature character varying(512) DEFAULT ''::character varying,
    game_started timestamp without time zone DEFAULT now() NOT NULL,
    mod_research_effectiveness real DEFAULT 0 NOT NULL,
    mod_energy_transfer_effectiveness real DEFAULT 0 NOT NULL,
    requests bigint DEFAULT 0,
    score_next_update timestamp without time zone DEFAULT (date_trunc('day'::text, now()) + '1 day'::interval) NOT NULL,
    display_alliance_planet_name boolean DEFAULT false NOT NULL,
    score_visibility smallint DEFAULT 0 NOT NULL,
    prestige_points integer DEFAULT 0 NOT NULL,
    mod_prestige_from_buildings real DEFAULT 1.0 NOT NULL,
    displays_ads bigint DEFAULT 0 NOT NULL,
    displays_pages bigint DEFAULT 0 NOT NULL,
    ad_bonus_code integer,
    regaddress inet DEFAULT '0.0.0.0'::inet NOT NULL,
    inframe boolean,
    modf_bounty real DEFAULT 1.0 NOT NULL,
    skin character varying,
    tutorial_first_ship_built boolean DEFAULT false NOT NULL,
    tutorial_first_colonisation_ship_built boolean DEFAULT false NOT NULL,
    leave_alliance_datetime timestamp without time zone,
    production_prestige integer DEFAULT 0 NOT NULL,
    score_visibility_last_change timestamp without time zone DEFAULT (now() - '1 day'::interval) NOT NULL,
    credits_produced bigint DEFAULT 0 NOT NULL,
    mod_prestige_from_ships real DEFAULT 1.0 NOT NULL,
    mod_planet_need_ore real DEFAULT 1.0 NOT NULL,
    mod_planet_need_hydrocarbon real DEFAULT 1.0 NOT NULL,
    mod_fleets real DEFAULT 200 NOT NULL,
    security_level integer DEFAULT 3 NOT NULL,
    prestige_points_refund integer DEFAULT 0 NOT NULL,
    CONSTRAINT users_prestige_points_check CHECK ((prestige_points >= 0)),
    CONSTRAINT users_remaining_colonizations_check CHECK ((remaining_colonizations >= 0))
);


ALTER TABLE exile_s03.users OWNER TO exileng;

--
-- Name: COLUMN users.privilege; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.privilege IS '>100 = admin

0 = active account

-1 = locked account

-2 = in holidays

-50 = faction in PNA with everyone

-100 = faction hostile with everyone';


--
-- Name: COLUMN users.credits_bankruptcy; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.credits_bankruptcy IS 'How many hours left before bankruptcy';


--
-- Name: COLUMN users.deletion_date; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.deletion_date IS 'Date when account is to be deleted';


--
-- Name: COLUMN users.alliance_left; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.alliance_left IS 'The player can''t create or join an alliance before this timestamp.';


--
-- Name: COLUMN users.alliance_taxes_paid; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.alliance_taxes_paid IS 'Taxes given to the alliance since the player joined';


--
-- Name: COLUMN users.alliance_credits_given; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.alliance_credits_given IS 'Credits the player gave to the alliance';


--
-- Name: COLUMN users.alliance_credits_taken; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.alliance_credits_taken IS 'Credits the alliance gave to the player';


--
-- Name: COLUMN users.protection_enabled; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.protection_enabled IS 'Whether the player is protected or not';


--
-- Name: COLUMN users.protection_colonies_to_unprotect; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.protection_colonies_to_unprotect IS 'Number of colonies the player has to have to turn protection off';


--
-- Name: COLUMN users.protection_datetime; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.protection_datetime IS 'Datetime until when the player is protected

protected = protection_enabled or protection_datetime < now()';


--
-- Name: COLUMN users.upkeep_last_cost; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.upkeep_last_cost IS 'Cost of the last upkeep';


--
-- Name: COLUMN users.upkeep_ships_in_position; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.upkeep_ships_in_position IS 'upkeep for ships that are near an enemy planet';


--
-- Name: COLUMN users.resets; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.resets IS 'Number of resets for this account';


--
-- Name: COLUMN users.mod_recycling; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.mod_recycling IS 'Modifier to recycling and buildings destruction (how much is retrieved when a building is destroyed)';


--
-- Name: COLUMN users.commanders_loyalty; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.commanders_loyalty IS 'Loyalty of your commanders. When a commander is fired, this value decreases. This value increases by 1 every hour';


--
-- Name: COLUMN users.game_started; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.game_started IS 'when the player started his new game, this value is reset after a gameover';


--
-- Name: COLUMN users.score_visibility; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users.score_visibility IS '0 = hidden

1 = visible for aliance

2 = visible for everyone';


--
-- Name: sp_login(character varying, character varying, character varying, character varying, character varying, bigint); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_login(character varying, character varying, character varying, character varying, character varying, bigint) RETURNS SETOF exile_s03.users
    LANGUAGE plpgsql
    AS $_$-- login a user with his username/password, return user row

-- param1: username

-- param2: password

-- param3: remote address

-- param4: forwarded address

-- param5: browser

-- param6: browserid (cookie)

DECLARE

	r_users users;

	t timestamp;

	other_userid int4;

	connection_id int8;

BEGIN

	SELECT INTO r_users * FROM users WHERE upper(login)=upper($1) AND password=sp_account_password($2) LIMIT 1;

	-- return user row if user was found

	IF FOUND THEN

		r_users.password := '';

		t := now();

		UPDATE users_connections SET

			disconnected = LEAST(t, r_users.lastactivity+INTERVAL '1 minutes')

		WHERE userid=r_users.id AND disconnected IS NULL;

		-- update lastlogin column

		UPDATE users SET lastlogin=t, lastactivity=t WHERE id=r_users.id AND privilege <> -1;

--		IF FOUND THEN

			r_users.lastlogin := t;

			r_users.lastactivity := t;

			connection_id := nextval('public.users_connections_id_seq');

			-- save clients address/brower info

			INSERT INTO users_connections(id, userid, address, forwarded_address, browser, browserid)

			VALUES(connection_id, r_users.id, sp__atoi($3), substr($4, 1, 64), substr($5, 1, 128), $6);

			-- add multiaccount warnings

			IF r_users.privilege = 0 THEN

				INSERT INTO log_multi_account_warnings(id, withid)

				SELECT DISTINCT ON (userid) connection_id, id FROM users_connections WHERE datetime > now()-INTERVAL '30 minutes' AND address=sp__atoi($3) AND userid <> r_users.id;

			END IF;

			RETURN NEXT r_users;

--		END IF;

	ELSE

		-- insert that a user failed to login

		INSERT INTO log_failed_logins(login, address, forwarded_address, browser, browserid)

		VALUES($1, sp__atoi($3), substr($4, 1, 64), substr($5, 1, 128), $6);

	END IF;

	RETURN;

END;$_$;


ALTER FUNCTION exile_s03.sp_login(character varying, character varying, character varying, character varying, character varying, bigint) OWNER TO exileng;

--
-- Name: sp_merge_fleets(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_merge_fleets(integer, integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_merge_fleets(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_merge_fleets(integer, integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_merge_fleets(integer, integer, integer) IS 'Merge the second fleet into the first fleet';


--
-- Name: sp_messages_addressee_history_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_messages_addressee_history_beforeinsert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_messages_addressee_history_beforeinsert() OWNER TO exileng;

--
-- Name: sp_messages_afterchanges(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_messages_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF NEW.ownerid IS NULL AND NEW.senderid IS NULL THEN

		DELETE FROM messages WHERE id= NEW.id;

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION exile_s03.sp_messages_afterchanges() OWNER TO exileng;

--
-- Name: sp_nav_planet_afterupdate(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_nav_planet_afterupdate() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE

	c int4;

BEGIN

	IF NEW.ownerid IS NOT NULL THEN

		IF OLD.mod_construction_speed_buildings <> NEW.mod_construction_speed_buildings THEN

			PERFORM sp_update_planet_buildings_construction(NEW.id);

		END IF;

		IF OLD.mod_construction_speed_ships <> NEW.mod_construction_speed_ships THEN

			PERFORM sp_update_planet_ships_construction(NEW.id);

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

		-- reset buy orders

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

		PERFORM sp_update_planet(NEW.id);

	ELSEIF (OLD.scientists <> NEW.scientists) OR (OLD.ownerid IS DISTINCT FROM NEW.ownerid) THEN

		IF NEW.planet_floor > 0 AND NEW.planet_space > 0 THEN

			IF OLD.ownerid IS NOT NULL THEN

				PERFORM sp_update_research(OLD.ownerid);

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


ALTER FUNCTION exile_s03.sp_nav_planet_afterupdate() OWNER TO exileng;

--
-- Name: sp_planet_buildings_pending_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_buildings_pending_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql STABLE
    AS $$BEGIN

	IF sp_can_build_on(NEW.planetid, NEW.buildingid, (SELECT ownerid FROM nav_planet WHERE id=NEW.planetid)) <> 0 THEN

		RAISE EXCEPTION 'max buildings reached or requirements not met';

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION exile_s03.sp_planet_buildings_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_energy_transfer_after_changes(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_energy_transfer_after_changes() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_planet_energy_transfer_after_changes() OWNER TO exileng;

--
-- Name: sp_planet_energy_transfer_before_changes(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_energy_transfer_before_changes() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_planet_energy_transfer_before_changes() OWNER TO exileng;

--
-- Name: sp_planet_ships_afterchanges(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_ships_afterchanges() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	IF NEW.quantity <= 0 THEN

		DELETE FROM planet_ships WHERE planetid = OLD.planetid AND shipid = OLD.shipid;

	END IF;

	RETURN NEW;

END;$$;


ALTER FUNCTION exile_s03.sp_planet_ships_afterchanges() OWNER TO exileng;

--
-- Name: sp_planet_ships_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_ships_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE planet_ships SET quantity = quantity + NEW.quantity WHERE planetid=NEW.planetid AND shipid=NEW.shipid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION exile_s03.sp_planet_ships_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_ships_pending_afterdelete(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_ships_pending_afterdelete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- if a ship that was being built is removed then 

	-- continue building another ship from the pending list

	IF OLD.end_time IS NOT NULL THEN

		PERFORM sp_continue_ships_construction(OLD.planetid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION exile_s03.sp_planet_ships_pending_afterdelete() OWNER TO exileng;

--
-- Name: FUNCTION sp_planet_ships_pending_afterdelete(); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_planet_ships_pending_afterdelete() IS 'Check if the deleted ship was a ship under construction, in this case, put the next ship order into construction if any';


--
-- Name: sp_planet_ships_pending_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_ships_pending_beforeinsert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_planet_ships_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_planet_training_pending_afterdelete(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_planet_training_pending_afterdelete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- if a training that was being done is removed then 

	-- continue another training from the pending list

	IF OLD.end_time IS NOT NULL THEN

		PERFORM sp_continue_training(OLD.planetid);

	END IF;

	RETURN NULL;

END;$$;


ALTER FUNCTION exile_s03.sp_planet_training_pending_afterdelete() OWNER TO exileng;

--
-- Name: FUNCTION sp_planet_training_pending_afterdelete(); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_planet_training_pending_afterdelete() IS 'Check if the deleted training was under way, in this case, do the next training if any';


--
-- Name: sp_plunder_planet(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_plunder_planet(_userid integer, _fleetid integer) RETURNS integer
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


ALTER FUNCTION exile_s03.sp_plunder_planet(_userid integer, _fleetid integer) OWNER TO exileng;

--
-- Name: sp_reports_after_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_reports_after_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_reports_after_insert() OWNER TO exileng;

--
-- Name: sp_reports_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_reports_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_reports_before_insert() OWNER TO exileng;

--
-- Name: sp_researches_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_researches_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE researches SET level = level + 1 WHERE userid=NEW.userid AND researchid=NEW.researchid;

	IF FOUND THEN

		RETURN NULL;

	ELSE

		RETURN NEW;

	END IF;

END;$$;


ALTER FUNCTION exile_s03.sp_researches_beforeinsert() OWNER TO exileng;

--
-- Name: sp_researches_pending_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_researches_pending_beforeinsert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_researches_pending_beforeinsert() OWNER TO exileng;

--
-- Name: sp_routes_waypoints_after_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_routes_waypoints_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	-- a new waypoint has been append to a route, assign the "next_waypointid" of the last waypoint of the given routeid

	UPDATE routes_waypoints SET

		next_waypointid = NEW.id

	WHERE id = (SELECT max(id) FROM routes_waypoints WHERE routeid=NEW.routeid AND id < NEW.id);

	RETURN NEW;

END;$$;


ALTER FUNCTION exile_s03.sp_routes_waypoints_after_insert() OWNER TO exileng;

--
-- Name: sp_start_blocus(integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_blocus(integer) RETURNS void
    LANGUAGE plpgsql
    AS $_$-- Param1: FleetId

BEGIN

	UPDATE fleets SET action=3, action_start_time=now(), action_end_time=now()+interval '1 hour' WHERE id=$1;

END;$_$;


ALTER FUNCTION exile_s03.sp_start_blocus(integer) OWNER TO exileng;

--
-- Name: sp_start_ship(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_ship(integer, integer, integer) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$BEGIN

	RETURN sp_start_ship($1, $2, $3, true);

END;$_$;


ALTER FUNCTION exile_s03.sp_start_ship(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_start_ship(integer, integer, integer, boolean); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_ship(_planetid integer, _shipid integer, _quantity integer, _take_resources boolean) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_start_ship(_planetid integer, _shipid integer, _quantity integer, _take_resources boolean) OWNER TO exileng;

--
-- Name: sp_start_ship_building_installation(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_ship_building_installation(integer, integer, integer) RETURNS integer
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

	SELECT INTO r_planet id, ownerid, planet_floor, planet_space, vortex_strength FROM nav_planet WHERE id=fleet_planetid;

	IF NOT (FOUND AND (r_planet.ownerid IS NULL OR r_planet.ownerid=$1 OR sp_relation(r_planet.ownerid, $1) >= -1)) THEN

--	IF NOT (FOUND AND (r_planet.ownerid IS NULL OR r_planet.ownerid=$1 OR sp_is_ally(r_planet.ownerid, $1))) THEN

		-- forbidden to install on this planet

		RETURN -3;

	END IF;

	-- forbid to install buildings with a lifetime on a real planet that is not owned by someone

	IF ship_building.lifetime > 0 AND r_planet.ownerid IS NULL AND (r_planet.planet_floor > 0 OR r_planet.planet_space > 0) THEN

		-- forbidden to install on this planet

		RETURN -3;

	END IF;

	IF sp_can_build_on(fleet_planetid, ship_building.id, COALESCE(r_planet.ownerid, $1)) <> 0 /*OR r_planet.vortex_strength > 5*/ THEN

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

			UPDATE users SET remaining_colonizations=remaining_colonizations-1 WHERE id=$1;

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

			RETURN -5;

		-- already building this type of building

		WHEN UNIQUE_VIOLATION THEN

			RETURN -6;

	END;

END;$_$;


ALTER FUNCTION exile_s03.sp_start_ship_building_installation(integer, integer, integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_start_ship_building_installation(integer, integer, integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_start_ship_building_installation(integer, integer, integer) IS 'Install the ship building on the planet, the planet must either be owned by the ship owner or nobody, in the latter case, the planet is claimed by the ship owner.

Returns the PlanetId in case of success or negative number';


--
-- Name: sp_start_ship_recycling(integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_ship_recycling(integer, integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_start_ship_recycling(integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_start_training(integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_start_training(_userid integer, _planetid integer, _scientists integer, _soldiers integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_start_training(_userid integer, _planetid integer, _scientists integer, _soldiers integer) OWNER TO exileng;

--
-- Name: sp_transfer_ships_to_fleet(integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_transfer_ships_to_fleet(integer, integer, integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_transfer_ships_to_fleet(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_travel_distance(integer, integer, integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_travel_distance(integer, integer, integer, integer) RETURNS double precision
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


ALTER FUNCTION exile_s03.sp_travel_distance(integer, integer, integer, integer) OWNER TO exileng;

--
-- Name: sp_users_bounty_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_users_bounty_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_users_bounty_before_insert() OWNER TO exileng;

--
-- Name: sp_users_expenses_before_insert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_users_expenses_before_insert() RETURNS trigger
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


ALTER FUNCTION exile_s03.sp_users_expenses_before_insert() OWNER TO exileng;

--
-- Name: sp_users_ships_kills_beforeinsert(); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_users_ships_kills_beforeinsert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN

	UPDATE users SET

		prestige_points = prestige_points + int4(NEW.killed*(SELECT prestige_reward FROM db_ships WHERE id=NEW.shipid) * (100+mod_prestige)/100.0),

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


ALTER FUNCTION exile_s03.sp_users_ships_kills_beforeinsert() OWNER TO exileng;

--
-- Name: sp_warp_fleet(integer, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_warp_fleet(integer, integer) RETURNS smallint
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


ALTER FUNCTION exile_s03.sp_warp_fleet(integer, integer) OWNER TO exileng;

--
-- Name: sp_wp_append_disappear(bigint, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_disappear(_routeid bigint, _seconds integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", waittime)

	VALUES(waypointid, _routeid, 9, _seconds);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_disappear(_routeid bigint, _seconds integer) OWNER TO exileng;

--
-- Name: sp_wp_append_loadall(bigint); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_loadall(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", ore, hydrocarbon, scientists, soldiers, workers)

	VALUES(waypointid, _routeid, 0, 99999999, 99999999, 99999999, 99999999, 99999999);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_loadall(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_loadall(_routeid bigint); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_wp_append_loadall(_routeid bigint) IS 'Append an "load all" action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_move(bigint, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_move(_routeid bigint, _planetid integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", planetid)

	VALUES(waypointid, _routeid, 1, _planetid);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_move(_routeid bigint, _planetid integer) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_move(_routeid bigint, _planetid integer); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_wp_append_move(_routeid bigint, _planetid integer) IS 'Append a move action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_recycle(bigint); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_recycle(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action")

	VALUES(waypointid, _routeid, 2);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_recycle(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_recycle(_routeid bigint); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_wp_append_recycle(_routeid bigint) IS 'Append a recycle action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_unloadall(bigint); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_unloadall(_routeid bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", ore, hydrocarbon, scientists, soldiers, workers)

	VALUES(waypointid, _routeid, 0, -999999999, -999999999, -999999999, -999999999, -999999999);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_unloadall(_routeid bigint) OWNER TO exileng;

--
-- Name: FUNCTION sp_wp_append_unloadall(_routeid bigint); Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON FUNCTION exile_s03.sp_wp_append_unloadall(_routeid bigint) IS 'Append an "unload all" action to a route and return the waypointid of this action';


--
-- Name: sp_wp_append_wait(bigint, integer); Type: FUNCTION; Schema: exile_s03; Owner: exileng
--

CREATE FUNCTION exile_s03.sp_wp_append_wait(_routeid bigint, _seconds integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE

	waypointid int8;

BEGIN

	waypointid := nextval('routes_waypoints_id_seq');

	INSERT INTO routes_waypoints(id, routeid, "action", waittime)

	VALUES(waypointid, _routeid, 4, _seconds);

	RETURN waypointid;

END;$$;


ALTER FUNCTION exile_s03.sp_wp_append_wait(_routeid bigint, _seconds integer) OWNER TO exileng;

--
-- Name: users_connections_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.users_connections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.users_connections_id_seq OWNER TO exileng;

--
-- Name: users_connections; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_connections (
    id bigint DEFAULT nextval('exile_s03.users_connections_id_seq'::regclass) NOT NULL,
    userid integer,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    forwarded_address character varying(64),
    browser character varying(128) DEFAULT ''::character varying NOT NULL,
    address bigint NOT NULL,
    browserid bigint NOT NULL,
    disconnected timestamp without time zone
);
ALTER TABLE ONLY exile_s03.users_connections ALTER COLUMN datetime SET STATISTICS 0;


ALTER TABLE exile_s03.users_connections OWNER TO exileng;

--
-- Name: admin_users_login; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_users_login AS
 SELECT users.id AS userid,
    users.login,
    count(*) AS count
   FROM (exile_s03.users
     JOIN exile_s03.users_connections users_remote_address_history ON ((users.id = users_remote_address_history.userid)))
  GROUP BY users.id, users.login
  ORDER BY (count(*));


ALTER TABLE exile_s03.admin_users_login OWNER TO exileng;

--
-- Name: admin_users_online; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_users_online AS
 SELECT count(*) AS count
   FROM exile_s03.users
  WHERE (users.lastactivity > (now() - '00:30:00'::interval));


ALTER TABLE exile_s03.admin_users_online OWNER TO exileng;

--
-- Name: alliances_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.alliances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.alliances_id_seq OWNER TO exileng;

--
-- Name: alliances; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances (
    id integer DEFAULT nextval('exile_s03.alliances_id_seq'::regclass) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    name character varying(32) NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    tag character varying(4) DEFAULT ''::character varying NOT NULL,
    logo_url character varying(255) DEFAULT ''::character varying NOT NULL,
    website_url character varying(255) DEFAULT ''::character varying NOT NULL,
    announce text DEFAULT ''::text NOT NULL,
    max_members integer DEFAULT 30 NOT NULL,
    tax smallint DEFAULT 0 NOT NULL,
    credits bigint DEFAULT 0 NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    previous_score integer DEFAULT 0 NOT NULL,
    score_combat integer DEFAULT 0 NOT NULL,
    defcon smallint DEFAULT 5 NOT NULL,
    chatid integer NOT NULL,
    announce_last_update timestamp without time zone DEFAULT now() NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    last_kick timestamp without time zone DEFAULT now() NOT NULL,
    last_dividends date DEFAULT now() NOT NULL,
    CONSTRAINT alliances_credits_check CHECK ((credits >= 0))
);


ALTER TABLE exile_s03.alliances OWNER TO exileng;

--
-- Name: COLUMN alliances.announce; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.alliances.announce IS 'This is the MotD (Message of the Day) of the alliance. Unfortunately, MotD is a reserved column name';


--
-- Name: COLUMN alliances.tax; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.alliances.tax IS 'Tax rates on all members sales';


--
-- Name: COLUMN alliances.defcon; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.alliances.defcon IS 'DEFCON 5 Normal peacetime readiness

DEFCON 4 Normal, increased intelligence and strengthened security measures 

DEFCON 3 Increase in force readiness above normal readiness 

DEFCON 2 Further Increase in force readiness, but less than maximum readiness 

DEFCON 1 Maximum force readiness';


--
-- Name: admin_view_alliances; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_alliances AS
 SELECT alliances.id,
    alliances.tag,
    alliances.name,
    ( SELECT count(*) AS count
           FROM exile_s03.users
          WHERE (users.alliance_id = alliances.id)) AS count
   FROM exile_s03.alliances;


ALTER TABLE exile_s03.admin_view_alliances OWNER TO exileng;

--
-- Name: battles_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.battles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.battles_id_seq OWNER TO exileng;

--
-- Name: battles; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles (
    id integer DEFAULT nextval('exile_s03.battles_id_seq'::regclass) NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    planetid integer NOT NULL,
    rounds smallint DEFAULT 10 NOT NULL,
    key character varying(8) DEFAULT 'key'::character varying NOT NULL
);


ALTER TABLE exile_s03.battles OWNER TO exileng;

--
-- Name: TABLE battles; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.battles IS 'List of battles that happened.';


--
-- Name: battles_ships; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_ships (
    battleid integer NOT NULL,
    owner_id integer NOT NULL,
    owner_name character varying(16) NOT NULL,
    fleet_name character varying(18),
    shipid integer NOT NULL,
    before integer DEFAULT 0 NOT NULL,
    after integer DEFAULT 0 NOT NULL,
    killed integer DEFAULT 0 NOT NULL,
    won boolean DEFAULT false NOT NULL,
    damages integer DEFAULT 0 NOT NULL,
    fleet_id integer DEFAULT 0 NOT NULL,
    attacked boolean,
    hull integer DEFAULT 0 NOT NULL,
    shield integer DEFAULT 0 NOT NULL,
    handling integer DEFAULT 0 NOT NULL,
    damage integer DEFAULT 0 NOT NULL,
    tracking integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.battles_ships OWNER TO exileng;

--
-- Name: COLUMN battles_ships.killed; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.battles_ships.killed IS 'Number of ships that have been destroyed by this group of ships';


--
-- Name: admin_view_battles_losses; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_battles_losses AS
 SELECT date_trunc('day'::text, battles."time") AS t,
    count(DISTINCT battles.id) AS count,
    sum((battles_ships.before - battles_ships.after)) AS sum
   FROM (exile_s03.battles
     JOIN exile_s03.battles_ships ON ((battles.id = battles_ships.battleid)))
  WHERE (battles."time" > (now() - '1 mon'::interval))
  GROUP BY (date_trunc('day'::text, battles."time"))
  ORDER BY (date_trunc('day'::text, battles."time"));


ALTER TABLE exile_s03.admin_view_battles_losses OWNER TO exileng;

--
-- Name: invasions_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.invasions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.invasions_id_seq OWNER TO exileng;

--
-- Name: invasions; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.invasions (
    id integer DEFAULT nextval('exile_s03.invasions_id_seq'::regclass) NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    planet_id integer NOT NULL,
    planet_name character varying(32) NOT NULL,
    attacker_name character varying(16) NOT NULL,
    defender_name character varying(16) NOT NULL,
    attacker_succeeded boolean NOT NULL,
    soldiers_total integer NOT NULL,
    soldiers_lost integer NOT NULL,
    def_scientists_total integer NOT NULL,
    def_scientists_lost integer NOT NULL,
    def_soldiers_total integer NOT NULL,
    def_soldiers_lost integer NOT NULL,
    def_workers_total integer NOT NULL,
    def_workers_lost integer NOT NULL
);


ALTER TABLE exile_s03.invasions OWNER TO exileng;

--
-- Name: admin_view_false_invasions; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_false_invasions AS
 SELECT invasions.attacker_name,
    invasions.defender_name,
    count(*) AS count
   FROM exile_s03.invasions
  WHERE ((invasions."time" > (now() - '2 days'::interval)) AND (invasions.def_workers_total < 2000) AND (invasions.def_soldiers_total = 0))
  GROUP BY invasions.attacker_name, invasions.defender_name
 HAVING (count(*) > 2);


ALTER TABLE exile_s03.admin_view_false_invasions OWNER TO exileng;

--
-- Name: nav_galaxies; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.nav_galaxies (
    id smallint NOT NULL,
    colonies integer DEFAULT 0 NOT NULL,
    visible boolean DEFAULT false NOT NULL,
    allow_new_players boolean DEFAULT true NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    reserved_for_gameover boolean DEFAULT false NOT NULL,
    planets integer DEFAULT 0 NOT NULL,
    protected_until timestamp without time zone,
    has_merchants boolean DEFAULT true NOT NULL,
    traded_ore bigint DEFAULT 0 NOT NULL,
    traded_hydrocarbon bigint DEFAULT 0 NOT NULL,
    price_ore real DEFAULT 120 NOT NULL,
    price_hydrocarbon real DEFAULT 160 NOT NULL
);


ALTER TABLE exile_s03.nav_galaxies OWNER TO exileng;

--
-- Name: COLUMN nav_galaxies.reserved_for_gameover; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_galaxies.reserved_for_gameover IS 'Whether it is a galaxy reserved for those that had a gameover';


--
-- Name: COLUMN nav_galaxies.protected_until; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_galaxies.protected_until IS 'Protection from hyperspace jumps from other galaxies';


--
-- Name: nav_planet_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.nav_planet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.nav_planet_id_seq OWNER TO exileng;

--
-- Name: nav_planet; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.nav_planet (
    id integer DEFAULT nextval('exile_s03.nav_planet_id_seq'::regclass) NOT NULL,
    ownerid integer,
    commanderid integer,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    galaxy smallint DEFAULT (0)::smallint NOT NULL,
    sector smallint DEFAULT (0)::smallint NOT NULL,
    planet smallint DEFAULT (0)::smallint NOT NULL,
    warp_to integer,
    planet_floor smallint DEFAULT 85 NOT NULL,
    planet_space smallint DEFAULT 10 NOT NULL,
    planet_pct_ore smallint DEFAULT 60 NOT NULL,
    planet_pct_hydrocarbon smallint DEFAULT 60 NOT NULL,
    pct_ore smallint DEFAULT 60 NOT NULL,
    pct_hydrocarbon smallint DEFAULT 60 NOT NULL,
    floor smallint DEFAULT (85)::smallint NOT NULL,
    space smallint DEFAULT (10)::smallint NOT NULL,
    floor_occupied smallint DEFAULT (0)::smallint NOT NULL,
    space_occupied smallint DEFAULT (0)::smallint NOT NULL,
    score bigint DEFAULT 0 NOT NULL,
    ore integer DEFAULT 0 NOT NULL,
    ore_capacity integer DEFAULT 0 NOT NULL,
    ore_production integer DEFAULT 0 NOT NULL,
    ore_production_raw integer DEFAULT 0 NOT NULL,
    hydrocarbon integer DEFAULT 0 NOT NULL,
    hydrocarbon_capacity integer DEFAULT 0 NOT NULL,
    hydrocarbon_production integer DEFAULT 0 NOT NULL,
    hydrocarbon_production_raw integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    workers_capacity integer DEFAULT 0 NOT NULL,
    workers_busy integer DEFAULT 0 NOT NULL,
    scientists integer DEFAULT 0 NOT NULL,
    scientists_capacity integer DEFAULT 0 NOT NULL,
    soldiers integer DEFAULT 0 NOT NULL,
    soldiers_capacity integer DEFAULT 0 NOT NULL,
    energy_consumption integer DEFAULT 0 NOT NULL,
    energy_production integer DEFAULT 0 NOT NULL,
    production_lastupdate timestamp without time zone DEFAULT now(),
    production_frozen boolean DEFAULT false NOT NULL,
    radar_strength smallint DEFAULT 0 NOT NULL,
    radar_jamming smallint DEFAULT 0 NOT NULL,
    spawn_ore integer DEFAULT 0 NOT NULL,
    spawn_hydrocarbon integer DEFAULT 0 NOT NULL,
    orbit_ore integer DEFAULT 0 NOT NULL,
    orbit_hydrocarbon integer DEFAULT 0 NOT NULL,
    mod_production_ore smallint DEFAULT 0 NOT NULL,
    mod_production_hydrocarbon smallint DEFAULT 0 NOT NULL,
    mod_production_energy smallint DEFAULT 0 NOT NULL,
    mod_production_workers smallint DEFAULT 0 NOT NULL,
    mod_construction_speed_buildings smallint DEFAULT 0 NOT NULL,
    mod_construction_speed_ships smallint DEFAULT 0 NOT NULL,
    training_scientists integer DEFAULT 0 NOT NULL,
    training_soldiers integer DEFAULT 0 NOT NULL,
    mood smallint DEFAULT 100 NOT NULL,
    buildings_dilapidation integer DEFAULT 0 NOT NULL,
    previous_buildings_dilapidation integer DEFAULT 0 NOT NULL,
    workers_for_maintenance integer DEFAULT 0 NOT NULL,
    soldiers_for_security integer DEFAULT 0 NOT NULL,
    next_battle timestamp without time zone,
    colonization_datetime timestamp without time zone,
    last_catastrophe timestamp without time zone DEFAULT now() NOT NULL,
    next_training_datetime timestamp without time zone DEFAULT now() NOT NULL,
    recruit_workers boolean DEFAULT true NOT NULL,
    sandworm_activity smallint DEFAULT 0 NOT NULL,
    seismic_activity smallint DEFAULT 0 NOT NULL,
    production_percent real DEFAULT 0 NOT NULL,
    blocus_strength smallint,
    credits_production integer DEFAULT 0 NOT NULL,
    credits_random_production integer DEFAULT 0 NOT NULL,
    mod_research_effectiveness smallint DEFAULT 0 NOT NULL,
    energy_receive_antennas smallint DEFAULT 0 NOT NULL,
    energy_send_antennas smallint DEFAULT 0 NOT NULL,
    energy_receive_links smallint DEFAULT 0 NOT NULL,
    energy_send_links smallint DEFAULT 0 NOT NULL,
    energy integer DEFAULT 0 NOT NULL,
    energy_capacity integer DEFAULT 0 NOT NULL,
    next_planet_update timestamp without time zone,
    upkeep integer DEFAULT 0 NOT NULL,
    shipyard_next_continue timestamp without time zone,
    shipyard_suspended boolean DEFAULT false NOT NULL,
    market_buy_ore_price smallint,
    market_buy_hydrocarbon_price smallint,
    credits_total integer DEFAULT 0 NOT NULL,
    credits_next_update timestamp without time zone DEFAULT now() NOT NULL,
    credits_updates smallint DEFAULT 0 NOT NULL,
    planet_vortex_strength integer DEFAULT 0 NOT NULL,
    vortex_strength integer DEFAULT 0 NOT NULL,
    production_prestige integer DEFAULT 0 NOT NULL,
    planet_stock_ore integer DEFAULT 0 NOT NULL,
    planet_stock_hydrocarbon integer DEFAULT 0 NOT NULL,
    planet_need_ore integer DEFAULT 0 NOT NULL,
    planet_need_hydrocarbon integer DEFAULT 0 NOT NULL,
    buy_ore integer DEFAULT 0 NOT NULL,
    buy_hydrocarbon integer DEFAULT 0 NOT NULL,
    invasion_defense integer DEFAULT 0 NOT NULL,
    min_security_level integer DEFAULT 3 NOT NULL,
    parked_ships_capacity integer DEFAULT 0 NOT NULL,
    CONSTRAINT nav_planet_energy_links_check CHECK ((((energy_receive_links <= 0) OR (energy_receive_links <= energy_receive_antennas)) AND ((energy_send_links <= 0) OR (energy_send_links <= energy_send_antennas)))),
    CONSTRAINT nav_planet_energy_receive_or_send_only CHECK (((energy_receive_links <= 0) OR (energy_send_links <= 0))),
    CONSTRAINT nav_planet_floor_space CHECK (((floor_occupied <= floor) AND (space_occupied <= space))),
    CONSTRAINT nav_planet_min_resources CHECK (((ore >= 0) AND (hydrocarbon >= 0) AND (scientists >= 0) AND (soldiers >= 0) AND (workers >= 0))),
    CONSTRAINT nav_planet_resources_capacity CHECK (((ore_capacity >= ore) AND (hydrocarbon_capacity >= hydrocarbon))),
    CONSTRAINT nav_planet_workers_busy CHECK ((workers_busy <= workers)),
    CONSTRAINT nav_planet_workers_capacity CHECK ((workers_capacity >= workers))
);


ALTER TABLE exile_s03.nav_planet OWNER TO exileng;

--
-- Name: COLUMN nav_planet.ore_production_raw; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.ore_production_raw IS 'total ore production from plants before applying production effectiveness';


--
-- Name: COLUMN nav_planet.hydrocarbon_production_raw; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.hydrocarbon_production_raw IS 'total hydrocarbon production from plants before applying production effectiveness';


--
-- Name: COLUMN nav_planet.colonization_datetime; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.colonization_datetime IS 'Datetime of first colonization';


--
-- Name: COLUMN nav_planet.recruit_workers; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.recruit_workers IS 'Whether the planet recruit new workers or not';


--
-- Name: COLUMN nav_planet.credits_production; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.credits_production IS 'Credits generated by the planet';


--
-- Name: COLUMN nav_planet.credits_random_production; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.credits_random_production IS 'random amount of credits generated';


--
-- Name: COLUMN nav_planet.energy_receive_links; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.energy_receive_links IS 'Number of links established';


--
-- Name: COLUMN nav_planet.energy_send_links; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.energy_send_links IS 'Number of send links established';


--
-- Name: COLUMN nav_planet.next_planet_update; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.nav_planet.next_planet_update IS 'Timestamp when to update the planet statistics because of a predicted energy shortage or anything else';


--
-- Name: admin_view_galaxies_stats; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_galaxies_stats AS
 SELECT nav_galaxies.id,
    nav_galaxies.allow_new_players,
    nav_galaxies.protected_until,
    (( SELECT (sum(t.score_research) / (count(*))::numeric)
           FROM ( SELECT DISTINCT nav_planet.ownerid,
                    users.score_research
                   FROM (exile_s03.nav_planet
                     JOIN exile_s03.users ON ((users.id = nav_planet.ownerid)))
                  WHERE ((nav_planet.galaxy = nav_galaxies.id) AND (nav_planet.ownerid > 100))
                  ORDER BY users.score_research DESC, nav_planet.ownerid
                 LIMIT 50) t))::integer AS average_research,
    (( SELECT count(DISTINCT nav_planet.ownerid) AS count
           FROM exile_s03.nav_planet
          WHERE (nav_planet.galaxy = nav_galaxies.id)))::integer AS players,
    (nav_galaxies.protected_until > (now() + '1 mon'::interval)) AS protected,
    (nav_galaxies.protected_until - static.const_interval_galaxy_protection()) AS open_since,
    (date_part('epoch'::text, ((now() + static.const_interval_galaxy_protection()) - (nav_galaxies.protected_until)::timestamp with time zone)) / ((3600 * 24))::double precision) AS galaxy_age,
    (nav_galaxies.colonies > ((nav_galaxies.planets * 2) / 3)) AS galaxy_full
   FROM exile_s03.nav_galaxies
  WHERE ((nav_galaxies.protected_until IS NOT NULL) AND nav_galaxies.visible)
  ORDER BY nav_galaxies.id;


ALTER TABLE exile_s03.admin_view_galaxies_stats OWNER TO exileng;

--
-- Name: log_jobs; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_jobs (
    task character varying(128) NOT NULL,
    lastupdate timestamp without time zone DEFAULT now() NOT NULL,
    state character varying(128) DEFAULT ''::character varying NOT NULL,
    processid integer DEFAULT '-1'::integer NOT NULL
);


ALTER TABLE exile_s03.log_jobs OWNER TO exileng;

--
-- Name: admin_view_jobs; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_jobs AS
 SELECT (now() - (jobs.lastupdate)::timestamp with time zone) AS processus_lastupdate,
    jobs.task AS processus_filename,
    jobs.state AS processus_status,
    jobs.processid AS pid
   FROM exile_s03.log_jobs jobs
  ORDER BY (now() - (jobs.lastupdate)::timestamp with time zone);


ALTER TABLE exile_s03.admin_view_jobs OWNER TO exileng;

--
-- Name: planet_owners_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.planet_owners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.planet_owners_id_seq OWNER TO exileng;

--
-- Name: planet_owners; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_owners (
    id integer DEFAULT nextval('exile_s03.planet_owners_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    planetid integer NOT NULL,
    ownerid integer,
    newownerid integer
);


ALTER TABLE exile_s03.planet_owners OWNER TO exileng;

--
-- Name: TABLE planet_owners; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.planet_owners IS 'Journal of owners of all the planets';


--
-- Name: admin_view_last_planets_taken; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_last_planets_taken AS
 SELECT o.planetid,
    p.name,
    p.galaxy,
    p.sector,
    p.planet,
    o.ownerid,
    u1.login AS oldownername,
    o.newownerid,
    u2.login AS newownername
   FROM (((exile_s03.planet_owners o
     LEFT JOIN exile_s03.nav_planet p ON ((o.planetid = p.id)))
     LEFT JOIN exile_s03.users u1 ON ((o.ownerid = u1.id)))
     LEFT JOIN exile_s03.users u2 ON ((o.newownerid = u2.id)))
  WHERE (o.datetime > (now() - '7 days'::interval))
  ORDER BY o.datetime;


ALTER TABLE exile_s03.admin_view_last_planets_taken OWNER TO exileng;

--
-- Name: log_pages_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_pages_id_seq OWNER TO exileng;

--
-- Name: log_pages; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_pages (
    id bigint DEFAULT nextval('exile_s03.log_pages_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    userid integer NOT NULL,
    webpage character varying(256) NOT NULL,
    elapsed real NOT NULL
);


ALTER TABLE exile_s03.log_pages OWNER TO exileng;

--
-- Name: admin_view_log_pages; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_log_pages AS
 SELECT (((("substring"((log_pages.webpage)::text, '/game/([[:alnum:]_/.]*)'::text) || '?'::text) || COALESCE("substring"((log_pages.webpage)::text, '(action=[[:alnum:]_/.=]*)'::text), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(a=[[:alnum:]_/.=]*)'::text)), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(b=[[:alnum:]_/.=]*)'::text)), ''::text)),
    sum(log_pages.elapsed) AS elapsed,
    count(*) AS calls,
    int4((sum(log_pages.elapsed) / (count(*))::double precision)) AS avg
   FROM exile_s03.log_pages
  GROUP BY (((("substring"((log_pages.webpage)::text, '/game/([[:alnum:]_/.]*)'::text) || '?'::text) || COALESCE("substring"((log_pages.webpage)::text, '(action=[[:alnum:]_/.=]*)'::text), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(a=[[:alnum:]_/.=]*)'::text)), ''::text)) || COALESCE(('&'::text || "substring"((log_pages.webpage)::text, '(b=[[:alnum:]_/.=]*)'::text)), ''::text))
  ORDER BY (sum(log_pages.elapsed));


ALTER TABLE exile_s03.admin_view_log_pages OWNER TO exileng;

--
-- Name: admin_view_logins; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_logins AS
 SELECT date_trunc('day'::text, users_remote_address_history.datetime) AS unique_logins,
    count(DISTINCT users_remote_address_history.userid) AS count,
    count(*) AS total_logins
   FROM exile_s03.users_connections users_remote_address_history
  GROUP BY (date_trunc('day'::text, users_remote_address_history.datetime))
  ORDER BY (date_trunc('day'::text, users_remote_address_history.datetime));


ALTER TABLE exile_s03.admin_view_logins OWNER TO exileng;

--
-- Name: market_history_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.market_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.market_history_id_seq OWNER TO exileng;

--
-- Name: market_history; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.market_history (
    id bigint DEFAULT nextval('exile_s03.market_history_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    ore_sold integer DEFAULT 0,
    hydrocarbon_sold integer DEFAULT 0 NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    username character varying(16),
    workers_sold integer DEFAULT 0 NOT NULL,
    scientists_sold integer DEFAULT 0 NOT NULL,
    soldiers_sold integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.market_history OWNER TO exileng;

--
-- Name: admin_view_market; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_market AS
 SELECT date_trunc('month'::text, market_history.datetime) AS date_trunc,
    sum(market_history.ore_sold) AS ore,
    sum(market_history.hydrocarbon_sold) AS hydrocarbon,
    sum(market_history.credits) AS credits
   FROM exile_s03.market_history
  GROUP BY (date_trunc('month'::text, market_history.datetime));


ALTER TABLE exile_s03.admin_view_market OWNER TO exileng;

--
-- Name: log_multi_account_warnings; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_multi_account_warnings (
    id bigint NOT NULL,
    withid bigint NOT NULL
);


ALTER TABLE exile_s03.log_multi_account_warnings OWNER TO exileng;

--
-- Name: messages_money_transfers; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.messages_money_transfers (
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    senderid integer,
    sendername character varying(20) NOT NULL,
    toid integer,
    toname character varying(16),
    credits integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.messages_money_transfers OWNER TO exileng;

--
-- Name: admin_view_multi_accounts; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_multi_accounts AS
 SELECT h1.datetime,
    h1.disconnected,
    h1.userid,
    a1.tag,
    u1.login,
    u1.privilege,
    u1.regdate,
    u1.email,
    h1.address,
    h1.forwarded_address,
    h1.browser,
    h1.browserid,
    h2.datetime AS datetime2,
    h2.disconnected AS disconnected2,
    h2.userid AS userid2,
    a2.tag AS tag2,
    u2.login AS login2,
    u2.privilege AS privilege2,
    u2.regdate AS regdate2,
    u2.email AS email2,
    h2.address AS address2,
    h2.forwarded_address AS forwarded_address2,
    h2.browser AS browser2,
    h2.browserid AS browserid2,
    ( SELECT sum(messages_money_transfers.credits) AS sum
           FROM exile_s03.messages_money_transfers
          WHERE ((messages_money_transfers.senderid = h1.userid) AND (messages_money_transfers.toid = h2.userid) AND (messages_money_transfers.datetime > (now() - '14 days'::interval)))) AS sent_to,
    ( SELECT sum(messages_money_transfers.credits) AS sum
           FROM exile_s03.messages_money_transfers
          WHERE ((messages_money_transfers.toid = h1.userid) AND (messages_money_transfers.senderid = h2.userid) AND (messages_money_transfers.datetime > (now() - '14 days'::interval)))) AS received_from,
    ((u1.password)::text = (u2.password)::text) AS samepassword,
    (u1.alliance_id = u2.alliance_id) AS samealliance,
    u1.alliance_credits_given AS a_given1,
    u1.alliance_credits_taken AS a_taken1,
    u2.alliance_credits_given AS a_given2,
    u2.alliance_credits_taken AS a_taken2
   FROM ((((((exile_s03.log_multi_account_warnings m
     JOIN exile_s03.users_connections h1 ON ((m.id = h1.id)))
     JOIN exile_s03.users_connections h2 ON ((m.withid = h2.id)))
     JOIN exile_s03.users u1 ON ((u1.id = h1.userid)))
     JOIN exile_s03.users u2 ON ((u2.id = h2.userid)))
     LEFT JOIN exile_s03.alliances a1 ON ((u1.alliance_id = a1.id)))
     LEFT JOIN exile_s03.alliances a2 ON ((u2.alliance_id = a2.id)))
  WHERE ((u1.regdate < (now() - '3 days'::interval)) AND (u2.regdate < (now() - '3 days'::interval)))
  ORDER BY h1.datetime DESC;


ALTER TABLE exile_s03.admin_view_multi_accounts OWNER TO exileng;

--
-- Name: log_multi_simultaneous_warnings; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_multi_simultaneous_warnings (
    datetime timestamp without time zone NOT NULL,
    userid1 integer NOT NULL,
    userid2 integer NOT NULL
);


ALTER TABLE exile_s03.log_multi_simultaneous_warnings OWNER TO exileng;

--
-- Name: TABLE log_multi_simultaneous_warnings; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.log_multi_simultaneous_warnings IS 'Maintain a list of simultaneous accesses to accounts from same browser and ip';


--
-- Name: admin_view_multi_simultaneous; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_multi_simultaneous AS
 SELECT DISTINCT log_multi_simultaneous_warnings.datetime,
    LEAST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2) AS userid1,
    GREATEST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2) AS userid2
   FROM exile_s03.log_multi_simultaneous_warnings
  ORDER BY log_multi_simultaneous_warnings.datetime, LEAST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2), GREATEST(log_multi_simultaneous_warnings.userid1, log_multi_simultaneous_warnings.userid2);


ALTER TABLE exile_s03.admin_view_multi_simultaneous OWNER TO exileng;

--
-- Name: VIEW admin_view_multi_simultaneous; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON VIEW exile_s03.admin_view_multi_simultaneous IS 'List simultaneous web page requests';


--
-- Name: admin_view_multi_simultaneous2; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_multi_simultaneous2 AS
 SELECT exile_s03.sp_get_user(admin_view_multi_simultaneous.userid1) AS u1,
    exile_s03.sp_get_user(admin_view_multi_simultaneous.userid2) AS u2,
    ((count(*))::double precision / (date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))) / (3600)::double precision)) AS ratio,
    count(*) AS count,
    (date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))) / (3600)::double precision),
    max(admin_view_multi_simultaneous.datetime) AS max
   FROM exile_s03.admin_view_multi_simultaneous
  GROUP BY (exile_s03.sp_get_user(admin_view_multi_simultaneous.userid1)), (exile_s03.sp_get_user(admin_view_multi_simultaneous.userid2))
 HAVING ((count(*) > 1) AND ((max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime)) > '01:00:00'::interval))
  ORDER BY ((count(*))::double precision / date_part('epoch'::text, (max(admin_view_multi_simultaneous.datetime) - min(admin_view_multi_simultaneous.datetime))));


ALTER TABLE exile_s03.admin_view_multi_simultaneous2 OWNER TO exileng;

--
-- Name: planet_buildings_pending_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.planet_buildings_pending_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.planet_buildings_pending_id_seq OWNER TO exileng;

--
-- Name: planet_buildings_pending; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_buildings_pending (
    id integer DEFAULT nextval('exile_s03.planet_buildings_pending_id_seq'::regclass) NOT NULL,
    planetid integer DEFAULT 0 NOT NULL,
    buildingid integer DEFAULT 0 NOT NULL,
    start_time timestamp without time zone DEFAULT now() NOT NULL,
    end_time timestamp without time zone,
    loop boolean DEFAULT false NOT NULL
);


ALTER TABLE exile_s03.planet_buildings_pending OWNER TO exileng;

--
-- Name: planet_ships_pending_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.planet_ships_pending_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.planet_ships_pending_id_seq OWNER TO exileng;

--
-- Name: planet_ships_pending; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_ships_pending (
    id integer DEFAULT nextval('exile_s03.planet_ships_pending_id_seq'::regclass) NOT NULL,
    planetid integer NOT NULL,
    shipid integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    quantity integer DEFAULT 1 NOT NULL,
    recycle boolean DEFAULT false NOT NULL,
    take_resources boolean DEFAULT false NOT NULL
);


ALTER TABLE exile_s03.planet_ships_pending OWNER TO exileng;

--
-- Name: admin_view_pendings; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_pendings AS
 SELECT ( SELECT count(*) AS count
           FROM exile_s03.planet_buildings_pending
          WHERE (planet_buildings_pending.end_time < now())) AS pending_buildings,
    ( SELECT count(*) AS count
           FROM exile_s03.planet_ships_pending
          WHERE (planet_ships_pending.end_time < now())) AS pending_ships;


ALTER TABLE exile_s03.admin_view_pendings OWNER TO exileng;

--
-- Name: admin_view_registrations; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_registrations AS
 SELECT t.week,
    t.days,
    t.registered,
    ((((t.registered * 7) * 24) * 3600) / LEAST(int4(date_part('epoch'::text, (now() - (t.week)::timestamp with time zone))), ((7 * 24) * 3600))) AS estimated
   FROM ( SELECT date_trunc('week'::text, users.regdate) AS week,
            LEAST(int4(date_part('days'::text, (now() - (date_trunc('week'::text, users.regdate))::timestamp with time zone))), 7) AS days,
            count(*) AS registered
           FROM exile_s03.users
          WHERE (((users.privilege = 0) OR (users.privilege = '-2'::integer)) AND (users.orientation > 0) AND (users.planets > 0) AND (users.credits_bankruptcy > 0))
          GROUP BY (date_trunc('week'::text, users.regdate)), LEAST(int4(date_part('days'::text, (now() - (date_trunc('week'::text, users.regdate))::timestamp with time zone))), 7)) t
  ORDER BY t.week;


ALTER TABLE exile_s03.admin_view_registrations OWNER TO exileng;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.reports_id_seq OWNER TO exileng;

--
-- Name: reports; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.reports (
    id integer DEFAULT nextval('exile_s03.reports_id_seq'::regclass) NOT NULL,
    ownerid integer NOT NULL,
    type smallint NOT NULL,
    subtype smallint DEFAULT 0 NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    read_date timestamp without time zone,
    battleid integer,
    fleetid integer,
    fleet_name character varying(18),
    planetid integer,
    researchid integer,
    ore integer DEFAULT 0 NOT NULL,
    hydrocarbon integer DEFAULT 0 NOT NULL,
    scientists integer DEFAULT 0 NOT NULL,
    soldiers integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    allianceid integer,
    userid integer,
    invasionid integer,
    spyid integer,
    commanderid integer,
    buildingid integer,
    description character varying(128),
    upkeep_planets integer,
    upkeep_scientists integer,
    upkeep_ships integer,
    upkeep_ships_in_position integer,
    upkeep_ships_parked integer,
    upkeep_soldiers integer,
    upkeep_commanders integer,
    planet_name character varying,
    planet_relation smallint,
    planet_ownername character varying,
    data character varying DEFAULT '{}'::character varying NOT NULL
);


ALTER TABLE exile_s03.reports OWNER TO exileng;

--
-- Name: COLUMN reports.type; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.reports.type IS '1 sub 0 - invitation to join an alliance

1 sub 1 - 

2 sub 0 - battle lost

2 sub 1 - battle won

3 sub 0- research finished

4 sub 0 - fleet arrived at destination

5 sub 0 - resources sold

6 sub 0 - colonization successful

';


--
-- Name: admin_view_reports; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_reports AS
 SELECT reports.id,
    users.login,
    reports.type,
    reports.subtype,
    reports.datetime,
    reports.read_date,
    reports.planetid,
    reports.researchid,
    reports.ore,
    reports.hydrocarbon,
    reports.scientists,
    reports.soldiers,
    reports.workers,
    reports.credits,
    reports.allianceid,
    reports.userid,
    reports.invasionid
   FROM (exile_s03.reports
     JOIN exile_s03.users ON ((users.id = reports.ownerid)));


ALTER TABLE exile_s03.admin_view_reports OWNER TO exileng;

--
-- Name: fleets_ships; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.fleets_ships (
    fleetid integer NOT NULL,
    shipid integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE exile_s03.fleets_ships OWNER TO exileng;

--
-- Name: admin_view_ships; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.admin_view_ships AS
 SELECT fleets_ships.shipid,
    ( SELECT db_ships.label
           FROM static.db_ships
          WHERE (db_ships.id = fleets_ships.shipid)) AS label,
    sum(fleets_ships.quantity) AS sum
   FROM exile_s03.fleets_ships
  GROUP BY fleets_ships.shipid
  ORDER BY (sum(fleets_ships.quantity));


ALTER TABLE exile_s03.admin_view_ships OWNER TO exileng;

--
-- Name: ai_planets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.ai_planets (
    planetid integer NOT NULL,
    nextupdate timestamp without time zone DEFAULT now() NOT NULL,
    enemysignature integer DEFAULT 0 NOT NULL,
    signaturesent integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.ai_planets OWNER TO exileng;

--
-- Name: ai_rogue_planets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.ai_rogue_planets (
    planetid integer NOT NULL,
    nextupdate timestamp without time zone DEFAULT now() NOT NULL,
    is_production boolean DEFAULT true NOT NULL
);


ALTER TABLE exile_s03.ai_rogue_planets OWNER TO exileng;

--
-- Name: ai_rogue_targets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.ai_rogue_targets (
    planetid integer NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.ai_rogue_targets OWNER TO exileng;

--
-- Name: COLUMN ai_rogue_targets.status; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.ai_rogue_targets.status IS '0 = unknown

1 = explored

2 = colonize

3 = invade';


--
-- Name: ai_watched_planets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.ai_watched_planets (
    planetid integer NOT NULL,
    watched_since timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.ai_watched_planets OWNER TO exileng;

--
-- Name: TABLE ai_watched_planets; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.ai_watched_planets IS 'List of enemy planets watched for invasion/raid';


--
-- Name: alliances_invitations; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_invitations (
    allianceid integer NOT NULL,
    userid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    recruiterid integer,
    declined boolean DEFAULT false NOT NULL,
    replied timestamp without time zone
);


ALTER TABLE exile_s03.alliances_invitations OWNER TO exileng;

--
-- Name: alliances_naps; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_naps (
    allianceid1 integer NOT NULL,
    allianceid2 integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    guarantee integer DEFAULT 0 NOT NULL,
    share_locs boolean DEFAULT true NOT NULL,
    share_radars boolean DEFAULT false NOT NULL,
    give_diplomacy_percent smallint DEFAULT 0 NOT NULL,
    break_on timestamp without time zone,
    break_interval interval DEFAULT '24:00:00'::interval NOT NULL
);


ALTER TABLE exile_s03.alliances_naps OWNER TO exileng;

--
-- Name: alliances_naps_offers; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_naps_offers (
    allianceid integer NOT NULL,
    targetallianceid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    recruiterid integer,
    declined boolean DEFAULT false NOT NULL,
    replied timestamp without time zone,
    guarantee integer DEFAULT 0 NOT NULL,
    guarantee_asked integer DEFAULT 0 NOT NULL,
    break_interval interval DEFAULT '24:00:00'::interval NOT NULL
);


ALTER TABLE exile_s03.alliances_naps_offers OWNER TO exileng;

--
-- Name: alliances_ranks; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_ranks (
    allianceid integer NOT NULL,
    rankid smallint NOT NULL,
    label character varying(32) NOT NULL,
    leader boolean DEFAULT false NOT NULL,
    can_invite_player boolean DEFAULT false NOT NULL,
    can_kick_player boolean DEFAULT false NOT NULL,
    can_create_nap boolean DEFAULT false NOT NULL,
    can_break_nap boolean DEFAULT false NOT NULL,
    can_ask_money boolean DEFAULT false NOT NULL,
    can_see_reports boolean DEFAULT false NOT NULL,
    can_accept_money_requests boolean DEFAULT false NOT NULL,
    can_change_tax_rate boolean DEFAULT false NOT NULL,
    can_mail_alliance boolean DEFAULT false NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    members_displayed boolean DEFAULT false NOT NULL,
    can_manage_description boolean DEFAULT false NOT NULL,
    can_manage_announce boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    can_see_members_info boolean DEFAULT false NOT NULL,
    tax smallint DEFAULT 0 NOT NULL,
    can_order_other_fleets boolean DEFAULT false NOT NULL,
    can_use_alliance_radars boolean DEFAULT false NOT NULL
);


ALTER TABLE exile_s03.alliances_ranks OWNER TO exileng;

--
-- Name: alliances_reports_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.alliances_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.alliances_reports_id_seq OWNER TO exileng;

--
-- Name: alliances_reports; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_reports (
    id bigint DEFAULT nextval('exile_s03.alliances_reports_id_seq'::regclass) NOT NULL,
    ownerallianceid integer NOT NULL,
    ownerid integer NOT NULL,
    type smallint NOT NULL,
    subtype smallint DEFAULT 0 NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    read_date timestamp without time zone,
    battleid integer,
    fleetid integer,
    fleet_name character varying(18),
    planetid integer,
    researchid integer,
    ore integer DEFAULT 0 NOT NULL,
    hydrocarbon integer DEFAULT 0 NOT NULL,
    scientists integer DEFAULT 0 NOT NULL,
    soldiers integer DEFAULT 0 NOT NULL,
    workers integer DEFAULT 0 NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    allianceid integer,
    userid integer,
    invasionid integer,
    spyid integer,
    commanderid integer,
    buildingid integer,
    description character varying(128),
    invited_username character varying(20),
    planet_name character varying,
    planet_relation smallint,
    planet_ownername character varying,
    data character varying DEFAULT '{}'::character varying NOT NULL
);


ALTER TABLE exile_s03.alliances_reports OWNER TO exileng;

--
-- Name: alliances_tributes; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_tributes (
    allianceid integer NOT NULL,
    target_allianceid integer NOT NULL,
    credits integer NOT NULL,
    next_transfer timestamp without time zone DEFAULT (date_trunc('day'::text, now()) + '1 day'::interval) NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.alliances_tributes OWNER TO exileng;

--
-- Name: alliances_wallet_journal_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.alliances_wallet_journal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.alliances_wallet_journal_id_seq OWNER TO exileng;

--
-- Name: alliances_wallet_journal; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_wallet_journal (
    id integer DEFAULT nextval('exile_s03.alliances_wallet_journal_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    allianceid integer NOT NULL,
    userid integer,
    credits integer DEFAULT 0 NOT NULL,
    description character varying(256),
    source character varying(38),
    type smallint DEFAULT 0 NOT NULL,
    destination character varying(38),
    groupid integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.alliances_wallet_journal OWNER TO exileng;

--
-- Name: COLUMN alliances_wallet_journal.type; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.alliances_wallet_journal.type IS '0 = gift

1 = taxes';


--
-- Name: alliances_wallet_requests_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.alliances_wallet_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.alliances_wallet_requests_id_seq OWNER TO exileng;

--
-- Name: alliances_wallet_requests; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_wallet_requests (
    id integer DEFAULT nextval('exile_s03.alliances_wallet_requests_id_seq'::regclass) NOT NULL,
    allianceid integer NOT NULL,
    userid integer NOT NULL,
    credits integer NOT NULL,
    description character varying(128) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    result boolean
);


ALTER TABLE exile_s03.alliances_wallet_requests OWNER TO exileng;

--
-- Name: alliances_wars; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.alliances_wars (
    allianceid1 integer NOT NULL,
    allianceid2 integer NOT NULL,
    cease_fire_requested integer,
    cease_fire_expire timestamp without time zone,
    created timestamp without time zone DEFAULT now() NOT NULL,
    next_bill timestamp without time zone DEFAULT now(),
    can_fight timestamp without time zone DEFAULT (now() + static.const_interval_before_can_fight()) NOT NULL
);


ALTER TABLE exile_s03.alliances_wars OWNER TO exileng;

--
-- Name: battles_buildings; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_buildings (
    battleid integer NOT NULL,
    owner_id integer NOT NULL,
    owner_name character varying(16) NOT NULL,
    planet_name character varying(18) NOT NULL,
    buildingid integer NOT NULL,
    before integer DEFAULT 0 NOT NULL,
    after integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.battles_buildings OWNER TO exileng;

--
-- Name: battles_fleets_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.battles_fleets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.battles_fleets_id_seq OWNER TO exileng;

--
-- Name: battles_fleets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_fleets (
    id bigint DEFAULT nextval('exile_s03.battles_fleets_id_seq'::regclass) NOT NULL,
    battleid integer NOT NULL,
    owner_id integer,
    owner_name character varying(16) NOT NULL,
    fleet_id integer,
    fleet_name character varying(18) NOT NULL,
    attackonsight boolean DEFAULT true NOT NULL,
    won boolean DEFAULT false NOT NULL,
    mod_shield smallint DEFAULT 0 NOT NULL,
    mod_handling smallint DEFAULT 0 NOT NULL,
    mod_tracking_speed smallint DEFAULT 0 NOT NULL,
    mod_damage smallint DEFAULT 0 NOT NULL,
    alliancetag character varying
);


ALTER TABLE exile_s03.battles_fleets OWNER TO exileng;

--
-- Name: battles_fleets_ships; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_fleets_ships (
    fleetid bigint NOT NULL,
    shipid integer NOT NULL,
    before integer DEFAULT 0 NOT NULL,
    after integer DEFAULT 0 NOT NULL,
    killed integer DEFAULT 0 NOT NULL,
    damages integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.battles_fleets_ships OWNER TO exileng;

--
-- Name: COLUMN battles_fleets_ships.killed; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.battles_fleets_ships.killed IS 'Number of ships that have been destroyed by this group of ships';


--
-- Name: battles_fleets_ships_kills; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_fleets_ships_kills (
    fleetid bigint NOT NULL,
    shipid integer NOT NULL,
    destroyed_shipid integer DEFAULT 0 NOT NULL,
    count integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.battles_fleets_ships_kills OWNER TO exileng;

--
-- Name: battles_relations; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.battles_relations (
    battleid integer NOT NULL,
    user1 integer NOT NULL,
    user2 integer NOT NULL,
    relation smallint DEFAULT 1 NOT NULL
);


ALTER TABLE exile_s03.battles_relations OWNER TO exileng;

--
-- Name: TABLE battles_relations; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.battles_relations IS 'List allied players in a battle';


--
-- Name: chat_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.chat_id_seq OWNER TO exileng;

--
-- Name: chat; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.chat (
    id integer DEFAULT nextval('exile_s03.chat_id_seq'::regclass) NOT NULL,
    name character varying(24),
    password character varying(16) DEFAULT ''::character varying NOT NULL,
    topic character varying(128) DEFAULT ''::character varying NOT NULL,
    public boolean DEFAULT false NOT NULL,
    CONSTRAINT chat_name_check CHECK (((name IS NULL) OR ((name)::text <> ''::text)))
);


ALTER TABLE exile_s03.chat OWNER TO exileng;

--
-- Name: chat_channels; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.chat_channels (
    id integer NOT NULL,
    name character varying(12),
    password character varying(16) DEFAULT ''::character varying NOT NULL,
    topic character varying(128) DEFAULT ''::character varying NOT NULL,
    public boolean DEFAULT false NOT NULL,
    allianceid integer,
    CONSTRAINT chat_channels_name_check CHECK (((name IS NULL) OR ((name)::text <> ''::text)))
);


ALTER TABLE exile_s03.chat_channels OWNER TO exileng;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.chat_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 10000000
    CACHE 1;


ALTER TABLE exile_s03.chat_channels_id_seq OWNER TO exileng;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.chat_channels_id_seq OWNED BY exile_s03.chat_channels.id;


--
-- Name: chat_lines_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.chat_lines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.chat_lines_id_seq OWNER TO exileng;

--
-- Name: chat_lines; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.chat_lines (
    id bigint DEFAULT nextval('exile_s03.chat_lines_id_seq'::regclass) NOT NULL,
    chatid integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    message character varying(512) NOT NULL,
    action smallint DEFAULT 0,
    login character varying(16) NOT NULL,
    allianceid integer,
    userid integer
);


ALTER TABLE exile_s03.chat_lines OWNER TO exileng;

--
-- Name: COLUMN chat_lines.action; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.chat_lines.action IS '0 = say

1 = join

2 = leave';


--
-- Name: chat_onlineusers; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.chat_onlineusers (
    chatid integer NOT NULL,
    userid integer NOT NULL,
    lastactivity timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.chat_onlineusers OWNER TO exileng;

--
-- Name: chat_users; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.chat_users (
    channelid integer NOT NULL,
    userid integer NOT NULL,
    joined timestamp without time zone DEFAULT now() NOT NULL,
    lastactivity timestamp without time zone DEFAULT now() NOT NULL,
    rights integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.chat_users OWNER TO exileng;

--
-- Name: commanders_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.commanders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.commanders_id_seq OWNER TO exileng;

--
-- Name: commanders; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.commanders (
    id integer DEFAULT nextval('exile_s03.commanders_id_seq'::regclass) NOT NULL,
    ownerid integer DEFAULT 0 NOT NULL,
    recruited timestamp without time zone,
    name character varying(32) DEFAULT static.sp_create_commander_name() NOT NULL,
    points smallint DEFAULT 10 NOT NULL,
    mod_production_ore real DEFAULT 1.0 NOT NULL,
    mod_production_hydrocarbon real DEFAULT 1.0 NOT NULL,
    mod_production_energy real DEFAULT 1.0 NOT NULL,
    mod_production_workers real DEFAULT 1.0 NOT NULL,
    mod_fleet_damage real DEFAULT 1.0 NOT NULL,
    mod_fleet_speed real DEFAULT 1.0 NOT NULL,
    mod_fleet_shield real DEFAULT 1.0 NOT NULL,
    mod_fleet_handling real DEFAULT 1.0 NOT NULL,
    mod_fleet_tracking_speed real DEFAULT 1.0 NOT NULL,
    mod_fleet_signature real DEFAULT 1.0 NOT NULL,
    mod_construction_speed_buildings real DEFAULT 1.0 NOT NULL,
    mod_construction_speed_ships real DEFAULT 1.0 NOT NULL,
    mod_recycling real DEFAULT 1.0 NOT NULL,
    can_be_fired boolean DEFAULT true NOT NULL,
    salary integer DEFAULT 0 NOT NULL,
    delete_on_reset boolean DEFAULT true NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    salary_increases smallint DEFAULT 0 NOT NULL,
    salary_last_increase timestamp without time zone DEFAULT now() NOT NULL,
    mod_research_effectiveness real DEFAULT 1.0 NOT NULL,
    mod_fleet_hull integer DEFAULT 0 NOT NULL,
    last_training timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.commanders OWNER TO exileng;

--
-- Name: COLUMN commanders.mod_fleet_damage; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.commanders.mod_fleet_damage IS 'Increase damages done by weapons by this percent.';


--
-- Name: COLUMN commanders.mod_fleet_shield; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.commanders.mod_fleet_shield IS 'By giving good orders in a battle, a commander can reduce the usage of the ships shield.

It increases the shield by this value in percent.';


--
-- Name: COLUMN commanders.mod_fleet_handling; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.commanders.mod_fleet_handling IS 'Increase the handling of the ships by this value, it may be more effective for slow ships';


--
-- Name: COLUMN commanders.mod_fleet_tracking_speed; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.commanders.mod_fleet_tracking_speed IS 'Increase ships tracking speed by this value.';


--
-- Name: fleets_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.fleets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.fleets_id_seq OWNER TO exileng;

--
-- Name: fleets; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.fleets (
    id integer DEFAULT nextval('exile_s03.fleets_id_seq'::regclass) NOT NULL,
    ownerid integer NOT NULL,
    uid integer DEFAULT 0 NOT NULL,
    name character varying(18) NOT NULL,
    commanderid integer,
    planetid integer,
    dest_planetid integer,
    action smallint DEFAULT 0 NOT NULL,
    action_start_time timestamp without time zone,
    action_end_time timestamp without time zone,
    attackonsight boolean DEFAULT false NOT NULL,
    engaged boolean DEFAULT false NOT NULL,
    cargo_capacity integer DEFAULT 0 NOT NULL,
    cargo_ore integer DEFAULT 0 NOT NULL,
    cargo_hydrocarbon integer DEFAULT 0 NOT NULL,
    cargo_workers integer DEFAULT 0 NOT NULL,
    cargo_scientists integer DEFAULT 0 NOT NULL,
    cargo_soldiers integer DEFAULT 0 NOT NULL,
    size integer DEFAULT 0 NOT NULL,
    speed integer DEFAULT 0 NOT NULL,
    signature integer DEFAULT 0 NOT NULL,
    military_signature integer DEFAULT 0 NOT NULL,
    real_signature integer DEFAULT 0 NOT NULL,
    recycler_output integer DEFAULT 0 NOT NULL,
    idle_since timestamp without time zone,
    droppods integer DEFAULT 0 NOT NULL,
    long_distance_capacity integer DEFAULT 0 NOT NULL,
    firepower bigint DEFAULT 0 NOT NULL,
    score bigint DEFAULT 0 NOT NULL,
    next_waypointid bigint,
    mod_speed smallint DEFAULT 0 NOT NULL,
    mod_shield smallint DEFAULT 0 NOT NULL,
    mod_handling smallint DEFAULT 0 NOT NULL,
    mod_tracking_speed smallint DEFAULT 0 NOT NULL,
    mod_damage smallint DEFAULT 0 NOT NULL,
    mod_recycling real DEFAULT 1.0 NOT NULL,
    mod_signature real DEFAULT 1.0 NOT NULL,
    upkeep integer DEFAULT 0 NOT NULL,
    recycler_percent real DEFAULT 0 NOT NULL,
    categoryid smallint DEFAULT 0 NOT NULL,
    required_vortex_strength integer DEFAULT 0 NOT NULL,
    leadership bigint DEFAULT 0 NOT NULL,
    shared boolean DEFAULT false NOT NULL,
    CONSTRAINT fleets_resources CHECK (((cargo_ore >= 0) AND (cargo_hydrocarbon >= 0) AND (cargo_scientists >= 0) AND (cargo_soldiers >= 0) AND (cargo_workers >= 0) AND (cargo_capacity >= 0)))
);


ALTER TABLE exile_s03.fleets OWNER TO exileng;

--
-- Name: COLUMN fleets.uid; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.uid IS 'Unique identifier for npc fleets so that they can all have the same fleet names';


--
-- Name: COLUMN fleets.action; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.action IS '0 = idle

-1 = moving (returning from a move)

1 = moving

2 = recycling

3 = blocus (planet can''t sell)

4 = waiting';


--
-- Name: COLUMN fleets.attackonsight; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.attackonsight IS 'Fleet stance, attackonsight by default';


--
-- Name: COLUMN fleets.engaged; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.engaged IS 'Is the fleet engaged in battle';


--
-- Name: COLUMN fleets.size; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.size IS 'Size of the fleet : number of ships';


--
-- Name: COLUMN fleets.speed; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.speed IS 'Maximum speed of the fleet, this is the speed of the slowest ship';


--
-- Name: COLUMN fleets.military_signature; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.military_signature IS 'Total signature of military ships';


--
-- Name: COLUMN fleets.long_distance_capacity; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.long_distance_capacity IS 'long_distance_capacity must be greater than fleet signature to be able to travel long distance';


--
-- Name: COLUMN fleets.mod_recycling; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.fleets.mod_recycling IS 'Increase or decrease resources effectivly used from planet orbit when recycling. 10% make the fleet recycle "recycler_output" resources but only 90% of the resources are taken off the planet orbit';


--
-- Name: fleets_items; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.fleets_items (
    fleetid integer NOT NULL,
    resourceid integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.fleets_items OWNER TO exileng;

--
-- Name: impersonate_impersonationlog; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.impersonate_impersonationlog (
    id integer NOT NULL,
    session_key character varying(40) NOT NULL,
    session_started_at timestamp with time zone,
    session_ended_at timestamp with time zone,
    impersonating_id integer NOT NULL,
    impersonator_id integer NOT NULL
);


ALTER TABLE exile_s03.impersonate_impersonationlog OWNER TO exileng;

--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.impersonate_impersonationlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.impersonate_impersonationlog_id_seq OWNER TO exileng;

--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.impersonate_impersonationlog_id_seq OWNED BY exile_s03.impersonate_impersonationlog.id;


--
-- Name: last_colonisation_planet_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.last_colonisation_planet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.last_colonisation_planet_seq OWNER TO exileng;

--
-- Name: log_admin_actions; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_admin_actions (
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    adminuserid integer NOT NULL,
    userid integer NOT NULL,
    action smallint NOT NULL,
    reason character varying(128),
    reason_public character varying(128),
    admin_notes text DEFAULT ''::text NOT NULL
);


ALTER TABLE exile_s03.log_admin_actions OWNER TO exileng;

--
-- Name: log_failed_logins_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_failed_logins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_failed_logins_id_seq OWNER TO exileng;

--
-- Name: log_http_errors_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_http_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_http_errors_id_seq OWNER TO exileng;

--
-- Name: log_http_errors; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_http_errors (
    id integer DEFAULT nextval('exile_s03.log_http_errors_id_seq'::regclass) NOT NULL,
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


ALTER TABLE exile_s03.log_http_errors OWNER TO exileng;

--
-- Name: log_notices_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_notices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_notices_id_seq OWNER TO exileng;

--
-- Name: log_notices; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_notices (
    id integer DEFAULT nextval('exile_s03.log_notices_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    username character varying(32),
    title character varying(128) DEFAULT ''::character varying NOT NULL,
    details character varying(128) DEFAULT ''::character varying NOT NULL,
    url character varying(128) DEFAULT ''::character varying NOT NULL,
    repeats integer DEFAULT 0 NOT NULL,
    level smallint DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.log_notices OWNER TO exileng;

--
-- Name: log_referers_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_referers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_referers_id_seq OWNER TO exileng;

--
-- Name: log_referers; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_referers (
    id integer DEFAULT nextval('exile_s03.log_referers_id_seq'::regclass) NOT NULL,
    referer text NOT NULL,
    page text,
    pages text[] DEFAULT ARRAY[''::text] NOT NULL
);


ALTER TABLE exile_s03.log_referers OWNER TO exileng;

--
-- Name: log_referers_users; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_referers_users (
    refererid integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    userid integer NOT NULL,
    page text
);


ALTER TABLE exile_s03.log_referers_users OWNER TO exileng;

--
-- Name: log_sys_errors_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.log_sys_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.log_sys_errors_id_seq OWNER TO exileng;

--
-- Name: log_sys_errors; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.log_sys_errors (
    id integer DEFAULT nextval('exile_s03.log_sys_errors_id_seq'::regclass) NOT NULL,
    procedure character varying NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    error character varying NOT NULL
);


ALTER TABLE exile_s03.log_sys_errors OWNER TO exileng;

--
-- Name: market_purchases; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.market_purchases (
    planetid integer NOT NULL,
    ore integer DEFAULT 0 NOT NULL,
    hydrocarbon integer DEFAULT 0 NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    delivery_time timestamp without time zone NOT NULL,
    ore_price smallint DEFAULT 0 NOT NULL,
    hydrocarbon_price smallint DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.market_purchases OWNER TO exileng;

--
-- Name: market_sales; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.market_sales (
    planetid integer NOT NULL,
    ore integer DEFAULT 0 NOT NULL,
    hydrocarbon integer DEFAULT 0 NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    sale_time timestamp without time zone NOT NULL,
    ore_price smallint DEFAULT 0 NOT NULL,
    hydrocarbon_price smallint DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.market_sales OWNER TO exileng;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.messages_id_seq OWNER TO exileng;

--
-- Name: messages; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.messages (
    id integer DEFAULT nextval('exile_s03.messages_id_seq'::regclass) NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    read_date timestamp without time zone,
    ownerid integer,
    owner character varying(20) NOT NULL,
    senderid integer,
    sender character varying(20) NOT NULL,
    subject character varying(80) NOT NULL,
    body text NOT NULL,
    credits integer DEFAULT 0 NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    bbcode boolean DEFAULT false NOT NULL
);


ALTER TABLE exile_s03.messages OWNER TO exileng;

--
-- Name: COLUMN messages.bbcode; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.messages.bbcode IS 'True if bbcode should be interpreted';


--
-- Name: messages_addressee_history_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.messages_addressee_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.messages_addressee_history_id_seq OWNER TO exileng;

--
-- Name: messages_addressee_history; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.messages_addressee_history (
    id integer DEFAULT nextval('exile_s03.messages_addressee_history_id_seq'::regclass) NOT NULL,
    ownerid integer NOT NULL,
    addresseeid integer NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.messages_addressee_history OWNER TO exileng;

--
-- Name: TABLE messages_addressee_history; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.messages_addressee_history IS 'Keep a list of the last addressees';


--
-- Name: messages_ignore_list; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.messages_ignore_list (
    userid integer NOT NULL,
    ignored_userid integer NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    blocked integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.messages_ignore_list OWNER TO exileng;

--
-- Name: nav_planet_location; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.nav_planet_location
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 61875
    CACHE 1
    CYCLE;


ALTER TABLE exile_s03.nav_planet_location OWNER TO exileng;

--
-- Name: npc_fleet_uid_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.npc_fleet_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.npc_fleet_uid_seq OWNER TO exileng;

--
-- Name: planet_buildings; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_buildings (
    planetid integer DEFAULT 0 NOT NULL,
    buildingid integer DEFAULT 0 NOT NULL,
    quantity smallint DEFAULT (1)::smallint NOT NULL,
    destroy_datetime timestamp without time zone,
    disabled smallint DEFAULT 0 NOT NULL,
    CONSTRAINT planet_buildings_disabled_strict_positive CHECK ((disabled >= 0))
);


ALTER TABLE exile_s03.planet_buildings OWNER TO exileng;

--
-- Name: COLUMN planet_buildings.disabled; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.planet_buildings.disabled IS 'Number of buildings disabled';


--
-- Name: planet_energy_transfer; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_energy_transfer (
    planetid integer NOT NULL,
    target_planetid integer NOT NULL,
    energy integer DEFAULT 0 NOT NULL,
    effective_energy integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    activation_datetime timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.planet_energy_transfer OWNER TO exileng;

--
-- Name: planet_ships; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_ships (
    planetid integer NOT NULL,
    shipid integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE exile_s03.planet_ships OWNER TO exileng;

--
-- Name: planet_training_pending_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.planet_training_pending_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.planet_training_pending_id_seq OWNER TO exileng;

--
-- Name: planet_training_pending; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.planet_training_pending (
    id integer DEFAULT nextval('exile_s03.planet_training_pending_id_seq'::regclass) NOT NULL,
    planetid integer NOT NULL,
    start_time timestamp without time zone DEFAULT now(),
    end_time timestamp without time zone,
    scientists integer DEFAULT 0 NOT NULL,
    soldiers integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.planet_training_pending OWNER TO exileng;

--
-- Name: precise_bbcode_bbcodetag; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.precise_bbcode_bbcodetag (
    id integer NOT NULL,
    tag_name character varying(20) NOT NULL,
    tag_definition text NOT NULL,
    html_replacement text NOT NULL,
    newline_closes boolean NOT NULL,
    same_tag_closes boolean NOT NULL,
    end_tag_closes boolean NOT NULL,
    standalone boolean NOT NULL,
    transform_newlines boolean NOT NULL,
    render_embedded boolean NOT NULL,
    escape_html boolean NOT NULL,
    replace_links boolean NOT NULL,
    strip boolean NOT NULL,
    swallow_trailing_newline boolean NOT NULL,
    helpline character varying(120),
    display_on_editor boolean NOT NULL
);


ALTER TABLE exile_s03.precise_bbcode_bbcodetag OWNER TO exileng;

--
-- Name: precise_bbcode_bbcodetag_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.precise_bbcode_bbcodetag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.precise_bbcode_bbcodetag_id_seq OWNER TO exileng;

--
-- Name: precise_bbcode_bbcodetag_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.precise_bbcode_bbcodetag_id_seq OWNED BY exile_s03.precise_bbcode_bbcodetag.id;


--
-- Name: precise_bbcode_smileytag; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.precise_bbcode_smileytag (
    id integer NOT NULL,
    code character varying(60) NOT NULL,
    image character varying(100) NOT NULL,
    image_width integer,
    image_height integer,
    emotion character varying(100),
    display_on_editor boolean NOT NULL,
    CONSTRAINT precise_bbcode_smileytag_image_height_check CHECK ((image_height >= 0)),
    CONSTRAINT precise_bbcode_smileytag_image_width_check CHECK ((image_width >= 0))
);


ALTER TABLE exile_s03.precise_bbcode_smileytag OWNER TO exileng;

--
-- Name: precise_bbcode_smileytag_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.precise_bbcode_smileytag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.precise_bbcode_smileytag_id_seq OWNER TO exileng;

--
-- Name: precise_bbcode_smileytag_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.precise_bbcode_smileytag_id_seq OWNED BY exile_s03.precise_bbcode_smileytag.id;


--
-- Name: researches; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.researches (
    userid integer NOT NULL,
    researchid integer NOT NULL,
    level smallint DEFAULT 1 NOT NULL,
    expires timestamp without time zone
);


ALTER TABLE exile_s03.researches OWNER TO exileng;

--
-- Name: researches_pending_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.researches_pending_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.researches_pending_id_seq OWNER TO exileng;

--
-- Name: researches_pending; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.researches_pending (
    id integer DEFAULT nextval('exile_s03.researches_pending_id_seq'::regclass) NOT NULL,
    userid integer NOT NULL,
    researchid integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    looping boolean DEFAULT false NOT NULL
);


ALTER TABLE exile_s03.researches_pending OWNER TO exileng;

--
-- Name: TABLE researches_pending; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.researches_pending IS 'List of pending researches

Only one research at a time per player';


--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.routes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.routes_id_seq OWNER TO exileng;

--
-- Name: routes; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.routes (
    id integer DEFAULT nextval('exile_s03.routes_id_seq'::regclass) NOT NULL,
    ownerid integer,
    name character varying(32) NOT NULL,
    repeat boolean DEFAULT false NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    last_used timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.routes OWNER TO exileng;

--
-- Name: COLUMN routes.last_used; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.routes.last_used IS 'Last time sp_routes_continue() used one of the waypoints of the route, it can help to speed up which routes to check for deletion';


--
-- Name: routes_waypoints_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.routes_waypoints_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.routes_waypoints_id_seq OWNER TO exileng;

--
-- Name: routes_waypoints; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.routes_waypoints (
    id bigint DEFAULT nextval('exile_s03.routes_waypoints_id_seq'::regclass) NOT NULL,
    next_waypointid bigint,
    routeid integer NOT NULL,
    action smallint NOT NULL,
    waittime smallint DEFAULT 0 NOT NULL,
    planetid integer,
    ore integer,
    hydrocarbon integer,
    scientists integer,
    soldiers integer,
    workers integer
);


ALTER TABLE exile_s03.routes_waypoints OWNER TO exileng;

--
-- Name: COLUMN routes_waypoints.action; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.routes_waypoints.action IS '0 = load/unload action

1 = move

2 = recycle

3 = blocus (to implement ?)

4 = wait

5 = invade';


--
-- Name: COLUMN routes_waypoints.waittime; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.routes_waypoints.waittime IS 'time to wait in seconds';


--
-- Name: COLUMN routes_waypoints.planetid; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.routes_waypoints.planetid IS 'planetid where to move to';


--
-- Name: sessions; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.sessions (
    userid integer NOT NULL,
    lastactivity timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.sessions OWNER TO exileng;

--
-- Name: sessions_notifications; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.sessions_notifications (
    id bigint NOT NULL,
    userid integer NOT NULL,
    type character varying(16) NOT NULL,
    data text NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.sessions_notifications OWNER TO exileng;

--
-- Name: sessions_notifications_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.sessions_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.sessions_notifications_id_seq OWNER TO exileng;

--
-- Name: sessions_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.sessions_notifications_id_seq OWNED BY exile_s03.sessions_notifications.id;


--
-- Name: spy_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.spy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.spy_id_seq OWNER TO exileng;

--
-- Name: spy; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.spy (
    id integer DEFAULT nextval('exile_s03.spy_id_seq'::regclass) NOT NULL,
    userid integer NOT NULL,
    date timestamp without time zone DEFAULT now() NOT NULL,
    credits integer,
    type smallint NOT NULL,
    key character varying(8),
    spotted boolean DEFAULT false NOT NULL,
    level smallint NOT NULL,
    target_id integer,
    target_name character varying(16)
);


ALTER TABLE exile_s03.spy OWNER TO exileng;

--
-- Name: TABLE spy; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.spy IS 'List of intelligence reports';


--
-- Name: spy_building; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.spy_building (
    spy_id integer NOT NULL,
    planet_id integer NOT NULL,
    building_id integer NOT NULL,
    endtime timestamp without time zone,
    quantity smallint
);


ALTER TABLE exile_s03.spy_building OWNER TO exileng;

--
-- Name: spy_fleet; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.spy_fleet (
    spy_id integer NOT NULL,
    fleet_name character varying(18) NOT NULL,
    galaxy smallint NOT NULL,
    sector smallint NOT NULL,
    planet smallint NOT NULL,
    size integer,
    signature integer,
    dest_galaxy smallint,
    dest_sector smallint,
    dest_planet smallint,
    fleet_id integer NOT NULL
);


ALTER TABLE exile_s03.spy_fleet OWNER TO exileng;

--
-- Name: spy_planet; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.spy_planet (
    spy_id integer NOT NULL,
    planet_id integer NOT NULL,
    planet_name character varying(32),
    floor smallint NOT NULL,
    space smallint NOT NULL,
    ground integer,
    ore integer,
    hydrocarbon integer,
    workers integer,
    ore_capacity integer,
    hydrocarbon_capacity integer,
    workers_capacity integer,
    ore_production integer,
    hydrocarbon_production integer,
    scientists integer,
    scientists_capacity integer,
    soldiers integer,
    soldiers_capacity integer,
    radar_strength smallint,
    radar_jamming smallint,
    orbit_ore integer,
    orbit_hydrocarbon integer,
    floor_occupied smallint,
    space_occupied smallint,
    owner_name character varying(16),
    energy_consumption integer,
    energy_production integer,
    pct_ore smallint,
    pct_hydrocarbon smallint
);


ALTER TABLE exile_s03.spy_planet OWNER TO exileng;

--
-- Name: spy_research; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.spy_research (
    spy_id integer NOT NULL,
    research_id integer NOT NULL,
    research_level integer NOT NULL
);


ALTER TABLE exile_s03.spy_research OWNER TO exileng;

--
-- Name: stats_requests; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.stats_requests
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.stats_requests OWNER TO exileng;

--
-- Name: sys_daily_updates; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.sys_daily_updates (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval DEFAULT '01:00:00'::interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE exile_s03.sys_daily_updates OWNER TO exileng;

--
-- Name: sys_events; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.sys_events (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE exile_s03.sys_events OWNER TO exileng;

--
-- Name: sys_processes; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.sys_processes (
    procedure character varying(64) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    last_runtime timestamp without time zone DEFAULT now() NOT NULL,
    run_every interval NOT NULL,
    last_result character varying,
    last_executiontimes interval[] DEFAULT '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}'::interval[] NOT NULL
);


ALTER TABLE exile_s03.sys_processes OWNER TO exileng;

--
-- Name: sys_executions; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.sys_executions AS
 SELECT 'event'::text AS category,
    sys_events.enabled,
    sys_events.procedure,
    sys_events.last_runtime,
    sys_events.run_every,
    sys_events.last_result,
    ((((((((((sys_events.last_executiontimes[1] + sys_events.last_executiontimes[2]) + sys_events.last_executiontimes[3]) + sys_events.last_executiontimes[4]) + sys_events.last_executiontimes[5]) + sys_events.last_executiontimes[6]) + sys_events.last_executiontimes[7]) + sys_events.last_executiontimes[8]) + sys_events.last_executiontimes[9]) + sys_events.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM exile_s03.sys_events
UNION
 SELECT 'process'::text AS category,
    sys_processes.enabled,
    sys_processes.procedure,
    sys_processes.last_runtime,
    sys_processes.run_every,
    sys_processes.last_result,
    ((((((((((sys_processes.last_executiontimes[1] + sys_processes.last_executiontimes[2]) + sys_processes.last_executiontimes[3]) + sys_processes.last_executiontimes[4]) + sys_processes.last_executiontimes[5]) + sys_processes.last_executiontimes[6]) + sys_processes.last_executiontimes[7]) + sys_processes.last_executiontimes[8]) + sys_processes.last_executiontimes[9]) + sys_processes.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM exile_s03.sys_processes
UNION
 SELECT 'daily'::text AS category,
    sys_daily_updates.enabled,
    sys_daily_updates.procedure,
    sys_daily_updates.last_runtime,
    sys_daily_updates.run_every,
    sys_daily_updates.last_result,
    ((((((((((sys_daily_updates.last_executiontimes[1] + sys_daily_updates.last_executiontimes[2]) + sys_daily_updates.last_executiontimes[3]) + sys_daily_updates.last_executiontimes[4]) + sys_daily_updates.last_executiontimes[5]) + sys_daily_updates.last_executiontimes[6]) + sys_daily_updates.last_executiontimes[7]) + sys_daily_updates.last_executiontimes[8]) + sys_daily_updates.last_executiontimes[9]) + sys_daily_updates.last_executiontimes[10]) / (10.0)::double precision) AS average_executiontime
   FROM exile_s03.sys_daily_updates;


ALTER TABLE exile_s03.sys_executions OWNER TO exileng;

--
-- Name: users_alliance_history; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_alliance_history (
    userid integer NOT NULL,
    joined timestamp without time zone NOT NULL,
    "left" timestamp without time zone NOT NULL,
    taxes_paid bigint DEFAULT 0 NOT NULL,
    credits_given bigint DEFAULT 0 NOT NULL,
    credits_taken bigint DEFAULT 0 NOT NULL,
    alliance_tag character varying(4) DEFAULT ''::character varying NOT NULL,
    alliance_name character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE exile_s03.users_alliance_history OWNER TO exileng;

--
-- Name: users_bounty; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_bounty (
    userid integer NOT NULL,
    bounty bigint DEFAULT 0 NOT NULL,
    reward_time timestamp without time zone DEFAULT (now() + '00:01:00'::interval) NOT NULL
);


ALTER TABLE exile_s03.users_bounty OWNER TO exileng;

--
-- Name: users_channels; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_channels (
    userid integer NOT NULL,
    channelid integer NOT NULL,
    password character varying(16) NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    lastactivity timestamp without time zone DEFAULT now() NOT NULL,
    rights integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.users_channels OWNER TO exileng;

--
-- Name: users_chats; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_chats (
    userid integer NOT NULL,
    chatid integer NOT NULL,
    password character varying(16) NOT NULL,
    added timestamp without time zone DEFAULT now() NOT NULL,
    lastactivity timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.users_chats OWNER TO exileng;

--
-- Name: users_expenses; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_expenses (
    userid integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    credits integer NOT NULL,
    credits_delta integer NOT NULL,
    buildingid integer,
    shipid integer,
    quantity integer,
    fleetid integer,
    planetid integer,
    ore integer,
    hydrocarbon integer,
    to_alliance integer,
    to_user integer,
    leave_alliance integer,
    spyid integer,
    scientists integer,
    soldiers integer,
    researchid integer,
    login timestamp without time zone
);


ALTER TABLE exile_s03.users_expenses OWNER TO exileng;

--
-- Name: users_favorite_locations; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_favorite_locations (
    userid integer NOT NULL,
    galaxy smallint NOT NULL,
    sector smallint,
    added timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE exile_s03.users_favorite_locations OWNER TO exileng;

--
-- Name: users_fleets_categories; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_fleets_categories (
    userid integer NOT NULL,
    category smallint NOT NULL,
    label character varying(32) NOT NULL
);


ALTER TABLE exile_s03.users_fleets_categories OWNER TO exileng;

--
-- Name: users_holidays; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_holidays (
    userid integer NOT NULL,
    start_time timestamp without time zone DEFAULT (now() + '24:00:00'::interval) NOT NULL,
    min_end_time timestamp without time zone,
    end_time timestamp without time zone,
    activated boolean DEFAULT false NOT NULL,
    CONSTRAINT users_holidays_check_end_time CHECK ((end_time >= min_end_time))
);


ALTER TABLE exile_s03.users_holidays OWNER TO exileng;

--
-- Name: COLUMN users_holidays.min_end_time; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users_holidays.min_end_time IS 'Timestamp when player can cancel his holidays';


--
-- Name: users_newemails; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_newemails (
    userid integer NOT NULL,
    email character varying(128) NOT NULL,
    key character varying(8) NOT NULL,
    expiration timestamp without time zone DEFAULT (now() + '2 days'::interval) NOT NULL
);


ALTER TABLE exile_s03.users_newemails OWNER TO exileng;

--
-- Name: users_options_history; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_options_history (
    id integer NOT NULL,
    userid integer NOT NULL,
    datetime timestamp without time zone DEFAULT now() NOT NULL,
    action smallint NOT NULL,
    info character varying DEFAULT ''::character varying NOT NULL,
    browser character varying DEFAULT ''::character varying NOT NULL,
    address bigint,
    forwarded_address character varying,
    browserid bigint NOT NULL
);


ALTER TABLE exile_s03.users_options_history OWNER TO exileng;

--
-- Name: COLUMN users_options_history.action; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON COLUMN exile_s03.users_options_history.action IS '0 = new password request

1 = new password activated

2 = email changed

3 = email activated

4 = password changed in options';


--
-- Name: users_options_history_id_seq; Type: SEQUENCE; Schema: exile_s03; Owner: exileng
--

CREATE SEQUENCE exile_s03.users_options_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exile_s03.users_options_history_id_seq OWNER TO exileng;

--
-- Name: users_options_history_id_seq; Type: SEQUENCE OWNED BY; Schema: exile_s03; Owner: exileng
--

ALTER SEQUENCE exile_s03.users_options_history_id_seq OWNED BY exile_s03.users_options_history.id;


--
-- Name: users_registration_address; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_registration_address (
    userid integer NOT NULL,
    address character varying NOT NULL
);


ALTER TABLE exile_s03.users_registration_address OWNER TO exileng;

--
-- Name: users_reports; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_reports (
    userid integer NOT NULL,
    type smallint NOT NULL,
    subtype smallint NOT NULL
);


ALTER TABLE exile_s03.users_reports OWNER TO exileng;

--
-- Name: TABLE users_reports; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TABLE exile_s03.users_reports IS 'List which reports to send/mail to users';


--
-- Name: users_ships_kills; Type: TABLE; Schema: exile_s03; Owner: exileng
--

CREATE TABLE exile_s03.users_ships_kills (
    userid integer NOT NULL,
    shipid integer NOT NULL,
    killed integer DEFAULT 0 NOT NULL,
    lost integer DEFAULT 0 NOT NULL
);


ALTER TABLE exile_s03.users_ships_kills OWNER TO exileng;

--
-- Name: vw_alliances_reports; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_alliances_reports AS
 SELECT r.ownerallianceid,
    r.ownerid,
    r.type,
    r.datetime,
    r.battleid,
    r.fleetid,
    r.fleet_name,
    r.planetid,
    r.planet_name,
    r.planet_relation,
    r.planet_ownername,
    nav_planet.galaxy,
    nav_planet.sector,
    nav_planet.planet,
    r.researchid,
    r.read_date,
    r.ore,
    r.hydrocarbon,
    r.credits,
    r.subtype,
    r.scientists,
    r.soldiers,
    r.workers,
    users.login AS username,
    alliances.tag AS alliance_tag,
    alliances.name AS alliance_name,
    r.invasionid,
    r.spyid,
    spy.key AS spy_key,
    r.commanderid,
    c.name,
    r.description,
    u_owner.login,
    r.invited_username,
    r.buildingid
   FROM ((((((exile_s03.alliances_reports r
     LEFT JOIN exile_s03.nav_planet ON ((nav_planet.id = r.planetid)))
     JOIN exile_s03.users u_owner ON ((u_owner.id = r.ownerid)))
     LEFT JOIN exile_s03.users ON ((users.id = r.userid)))
     LEFT JOIN exile_s03.alliances ON ((alliances.id = r.allianceid)))
     LEFT JOIN exile_s03.spy ON ((spy.id = r.spyid)))
     LEFT JOIN exile_s03.commanders c ON ((c.id = r.commanderid)))
  WHERE ((r.datetime <= now()) AND (r.datetime > (now() - '14 days'::interval)));


ALTER TABLE exile_s03.vw_alliances_reports OWNER TO exileng;

--
-- Name: vw_allies; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_allies AS
 SELECT u1.id AS userid,
    u2.id AS ally
   FROM (exile_s03.users u1
     JOIN exile_s03.users u2 ON (((u1.alliance_id = u2.alliance_id) OR (u1.id = u2.id))));


ALTER TABLE exile_s03.vw_allies OWNER TO exileng;

--
-- Name: vw_buildings; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_buildings AS
 SELECT p.id AS planetid,
    p.ownerid,
    b.id,
    b.category,
    b.name,
    b.label,
    b.description,
    b.cost_ore,
    b.cost_hydrocarbon,
    b.cost_credits,
    b.cost_energy,
    b.cost_prestige,
    b.workers,
    b.energy_consumption,
    b.energy_production,
    b.floor,
    b.space,
    (((((LEAST(1.0, ((1.0 * (p.energy_production)::numeric) / (GREATEST(p.energy_consumption, 1))::numeric)))::double precision * p.production_percent) * ((p.pct_ore)::numeric)::double precision) / (100.0)::double precision) * ((b.production_ore)::numeric)::double precision) AS production_ore,
    (((((LEAST(1.0, ((1.0 * (p.energy_production)::numeric) / (GREATEST(p.energy_consumption, 1))::numeric)))::double precision * p.production_percent) * ((p.pct_hydrocarbon)::numeric)::double precision) / (100.0)::double precision) * ((b.production_hydrocarbon)::numeric)::double precision) AS production_hydrocarbon,
    b.storage_ore,
    b.storage_hydrocarbon,
    b.storage_workers,
        CASE
            WHEN b.buildable THEN b.construction_maximum
            ELSE (0)::smallint
        END AS construction_maximum,
    exile_s03.sp_get_construction_time(b.construction_time, b.construction_time_exp_per_building,
        CASE
            WHEN (b.construction_time_exp_per_building <> (1.0)::double precision) THEN (( SELECT planet_buildings.quantity
               FROM exile_s03.planet_buildings
              WHERE ((planet_buildings.planetid = p.id) AND (planet_buildings.buildingid = b.id))))::integer
            ELSE 0
        END, (p.mod_construction_speed_buildings)::integer) AS construction_time,
    b.destroyable,
    b.mod_production_ore,
    b.mod_production_hydrocarbon,
    b.mod_production_energy,
    b.mod_production_workers,
    b.mod_construction_speed_buildings,
    b.mod_construction_speed_ships,
    b.storage_scientists,
    b.storage_soldiers,
    b.radar_strength,
    b.radar_jamming,
    b.is_planet_element,
    COALESCE(( SELECT planet_buildings.quantity
           FROM exile_s03.planet_buildings
          WHERE ((planet_buildings.buildingid = b.id) AND (planet_buildings.planetid = p.id))), int2(0)) AS quantity,
    ( SELECT int4(date_part('epoch'::text, ((planet_buildings_pending.end_time)::timestamp with time zone - now()))) AS int4
           FROM exile_s03.planet_buildings_pending
          WHERE ((planet_buildings_pending.buildingid = b.id) AND (planet_buildings_pending.planetid = p.id))) AS build_status,
    (NOT (EXISTS ( SELECT db_buildings_req_building.required_buildingid
           FROM static.db_buildings_req_building
          WHERE ((db_buildings_req_building.buildingid = b.id) AND (NOT (db_buildings_req_building.required_buildingid IN ( SELECT planet_buildings.buildingid
                   FROM exile_s03.planet_buildings
                  WHERE ((planet_buildings.planetid = p.id) AND ((planet_buildings.quantity > 1) OR ((planet_buildings.quantity >= 1) AND (planet_buildings.destroy_datetime IS NULL))))))))))) AS buildings_requirements_met,
    (NOT (EXISTS ( SELECT db_buildings_req_research.required_researchid,
            db_buildings_req_research.required_researchlevel
           FROM static.db_buildings_req_research
          WHERE ((db_buildings_req_research.buildingid = b.id) AND (NOT (db_buildings_req_research.required_researchid IN ( SELECT researches.researchid
                   FROM exile_s03.researches
                  WHERE ((researches.userid = p.ownerid) AND (researches.level >= db_buildings_req_research.required_researchlevel))))))))) AS research_requirements_met,
    ( SELECT int4(date_part('epoch'::text, ((planet_buildings.destroy_datetime)::timestamp with time zone - now()))) AS int4
           FROM exile_s03.planet_buildings
          WHERE ((planet_buildings.buildingid = b.id) AND (planet_buildings.planetid = p.id))) AS destruction_time,
    COALESCE(( SELECT GREATEST(0, (
                CASE
                    WHEN ((planet_buildings.destroy_datetime IS NULL) OR b.active_when_destroying) THEN (planet_buildings.quantity)::integer
                    ELSE (planet_buildings.quantity - 1)
                END - planet_buildings.disabled), 0) AS "greatest"
           FROM exile_s03.planet_buildings
          WHERE ((planet_buildings.buildingid = b.id) AND (planet_buildings.planetid = p.id))), 0) AS working_quantity,
    b.upkeep,
    b.buildable
   FROM exile_s03.nav_planet p,
    static.db_buildings b
  ORDER BY b.category, b.id;


ALTER TABLE exile_s03.vw_buildings OWNER TO exileng;

--
-- Name: vw_buildings_under_construction2; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_buildings_under_construction2 AS
 SELECT nav_planet.id AS planetid,
    planet_buildings_pending.buildingid,
    int4(date_part('epoch'::text, ((planet_buildings_pending.end_time)::timestamp with time zone - now()))) AS remaining_time,
    false AS destroying
   FROM (exile_s03.nav_planet
     JOIN exile_s03.planet_buildings_pending ON ((planet_buildings_pending.planetid = nav_planet.id)))
UNION
 SELECT planet_buildings.planetid,
    planet_buildings.buildingid,
    int4(date_part('epoch'::text, ((planet_buildings.destroy_datetime)::timestamp with time zone - now()))) AS remaining_time,
    true AS destroying
   FROM (exile_s03.planet_buildings
     JOIN static.db_buildings ON (((db_buildings.id = planet_buildings.buildingid) AND (NOT db_buildings.is_planet_element))))
  WHERE (planet_buildings.destroy_datetime IS NOT NULL);


ALTER TABLE exile_s03.vw_buildings_under_construction2 OWNER TO exileng;

--
-- Name: vw_commanders; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_commanders AS
 SELECT c.id,
    c.ownerid,
    c.name,
    f.id AS fleetid,
    f.name AS fleetname,
    n.id AS planetid,
    n.name AS planetname
   FROM ((exile_s03.commanders c
     LEFT JOIN exile_s03.fleets f ON (((f.ownerid = c.ownerid) AND (f.commanderid = c.id))))
     LEFT JOIN exile_s03.nav_planet n ON (((n.ownerid = c.ownerid) AND (n.commanderid = c.id))))
  WHERE (c.recruited <= now());


ALTER TABLE exile_s03.vw_commanders OWNER TO exileng;

--
-- Name: vw_friends; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_friends AS
 SELECT friends.userid,
    friends.friend
   FROM ( SELECT u1.id AS userid,
            u2.id AS friend
           FROM ((exile_s03.users u1
             JOIN exile_s03.alliances_naps naps ON ((u1.alliance_id = naps.allianceid1)))
             JOIN exile_s03.users u2 ON ((u2.alliance_id = naps.allianceid2)))
        UNION
         SELECT u1.id AS userid,
            u2.id AS friend
           FROM (exile_s03.users u1
             JOIN exile_s03.users u2 ON (((u1.alliance_id = u2.alliance_id) OR ((u2.alliance_id IS NULL) AND (u1.id = u2.id)) OR (u1.privilege = '-50'::integer) OR (u2.privilege = '-50'::integer))))) friends;


ALTER TABLE exile_s03.vw_friends OWNER TO exileng;

--
-- Name: vw_enemy_fleets; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_enemy_fleets AS
 SELECT nav_planet.id AS planetid,
    count(fleets.id) AS enemyfleets
   FROM (exile_s03.nav_planet
     LEFT JOIN exile_s03.fleets ON (((fleets.planetid = nav_planet.id) AND (fleets.action <> '-1'::integer) AND (fleets.action <> 1) AND fleets.attackonsight AND (NOT (EXISTS ( SELECT 1
           FROM exile_s03.vw_friends
          WHERE ((vw_friends.userid = nav_planet.ownerid) AND (vw_friends.friend = fleets.ownerid))))))))
  GROUP BY nav_planet.id;


ALTER TABLE exile_s03.vw_enemy_fleets OWNER TO exileng;

--
-- Name: VIEW vw_enemy_fleets; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON VIEW exile_s03.vw_enemy_fleets IS 'Returns number of enemy fleets orbiting the planets';


--
-- Name: vw_fleets; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_fleets AS
 SELECT fleets.id,
    fleets.ownerid,
    users.login AS owner_name,
    users.alliance_id AS owner_alliance_id,
    fleets.name,
    fleets.attackonsight,
    fleets.firepower,
    fleets.engaged,
    fleets.size,
    fleets.signature,
    fleets.real_signature,
    int4((((fleets.speed * fleets.mod_speed))::numeric / 100.0)) AS speed,
    fleets.action,
    int4(date_part('epoch'::text, (now() - (fleets.idle_since)::timestamp with time zone))) AS idle_time,
    int4(date_part('epoch'::text, (fleets.action_end_time - fleets.action_start_time))) AS total_time,
    int4(date_part('epoch'::text, ((fleets.action_end_time)::timestamp with time zone - now()))) AS remaining_time,
    fleets.action_start_time,
    fleets.action_end_time,
    fleets.droppods,
    fleets.commanderid,
    ( SELECT commanders.name
           FROM exile_s03.commanders
          WHERE (commanders.id = fleets.commanderid)) AS commandername,
    fleets.planetid,
    n1.name AS planet_name,
    n1.galaxy AS planet_galaxy,
    n1.sector AS planet_sector,
    n1.planet AS planet_planet,
    n1.ownerid AS planet_ownerid,
    n1.radar_strength,
    (COALESCE((n1.radar_jamming)::integer, 0))::smallint AS radar_jamming,
    static.sp_get_user(n1.ownerid) AS planet_owner_name,
    static.sp_relation(fleets.ownerid, n1.ownerid) AS planet_owner_relation,
    fleets.dest_planetid AS destplanetid,
    n2.name AS destplanet_name,
    n2.galaxy AS destplanet_galaxy,
    n2.sector AS destplanet_sector,
    n2.planet AS destplanet_planet,
    n2.ownerid AS destplanet_ownerid,
    n2.radar_strength AS destplanet_radar_strength,
    (COALESCE((n2.radar_jamming)::integer, 0))::smallint AS destplanet_radar_jamming,
    static.sp_get_user(n2.ownerid) AS destplanet_owner_name,
    static.sp_relation(fleets.ownerid, n2.ownerid) AS destplanet_owner_relation,
    fleets.cargo_capacity,
    (((((fleets.cargo_capacity - fleets.cargo_ore) - fleets.cargo_hydrocarbon) - fleets.cargo_scientists) - fleets.cargo_soldiers) - fleets.cargo_workers) AS cargo_free,
    fleets.cargo_ore,
    fleets.cargo_hydrocarbon,
    fleets.cargo_scientists,
    fleets.cargo_soldiers,
    fleets.cargo_workers,
    fleets.recycler_output,
    fleets.long_distance_capacity,
    fleets.next_waypointid,
    n1.orbit_ore,
    n1.orbit_hydrocarbon,
    n1.warp_to,
    n1.spawn_ore,
    n1.spawn_hydrocarbon,
    n1.planet_floor,
    n2.planet_floor AS destplanet_planet_floor,
    fleets.categoryid,
    fleets.required_vortex_strength,
    fleets.upkeep,
    fleets.leadership,
    fleets.shared
   FROM (((exile_s03.fleets
     JOIN exile_s03.users ON ((users.id = fleets.ownerid)))
     LEFT JOIN exile_s03.nav_planet n1 ON ((fleets.planetid = n1.id)))
     LEFT JOIN exile_s03.nav_planet n2 ON ((fleets.dest_planetid = n2.id)));


ALTER TABLE exile_s03.vw_fleets OWNER TO exileng;

--
-- Name: vw_fleets_moving; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_fleets_moving AS
 SELECT users.id AS userid,
    fleets.id,
    fleets.name,
    fleets.attackonsight,
    fleets.firepower,
    fleets.engaged,
    fleets.size,
    fleets.signature,
    fleets.upkeep,
    fleets.speed,
    COALESCE(fleets.remaining_time, 0) AS remaining_time,
    COALESCE(fleets.total_time, 0) AS total_time,
    fleets.ownerid,
    static.sp_relation(users.id, fleets.ownerid) AS owner_relation,
    fleets.owner_name,
    fleets.owner_alliance_id,
    fleets.planetid,
    fleets.planet_name,
    fleets.planet_galaxy,
    fleets.planet_sector,
    fleets.planet_planet,
    fleets.planet_ownerid,
    fleets.radar_jamming,
    fleets.planet_owner_name,
    static.sp_relation(users.id, fleets.planet_ownerid) AS planet_owner_relation,
    fleets.destplanetid,
    fleets.destplanet_name,
    fleets.destplanet_galaxy,
    fleets.destplanet_sector,
    fleets.destplanet_planet,
    fleets.destplanet_ownerid,
    fleets.destplanet_radar_jamming,
    fleets.destplanet_owner_name,
    static.sp_relation(users.id, fleets.destplanet_ownerid) AS destplanet_owner_relation,
    static.sp_get_user_rs(users.id, (fleets.planet_galaxy)::integer, (fleets.planet_sector)::integer) AS from_radarstrength,
    static.sp_get_user_rs(users.id, (fleets.destplanet_galaxy)::integer, (fleets.destplanet_sector)::integer) AS to_radarstrength,
    fleets.cargo_capacity,
    fleets.cargo_free,
    fleets.cargo_ore,
    fleets.cargo_hydrocarbon,
    fleets.cargo_scientists,
    fleets.cargo_soldiers,
    fleets.cargo_workers,
    fleets.next_waypointid,
    fleets.categoryid,
    fleets.leadership,
    fleets.shared
   FROM exile_s03.users,
    exile_s03.vw_fleets fleets
  WHERE ((fleets.action = 1) OR (fleets.action = '-1'::integer))
  ORDER BY fleets.ownerid, COALESCE(fleets.remaining_time, 0);


ALTER TABLE exile_s03.vw_fleets_moving OWNER TO exileng;

--
-- Name: vw_friends_radars; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_friends_radars AS
 SELECT friends.userid,
    friends.friend
   FROM ( SELECT u1.id AS userid,
            u2.id AS friend
           FROM ((exile_s03.users u1
             JOIN exile_s03.alliances_naps naps ON (((u1.alliance_id = naps.allianceid2) AND naps.share_radars)))
             JOIN exile_s03.users u2 ON ((u2.alliance_id = naps.allianceid1)))
        UNION
         SELECT u1.id AS userid,
            u2.id AS friend
           FROM (exile_s03.users u1
             JOIN exile_s03.users u2 ON (((u1.alliance_id = u2.alliance_id) OR ((u2.alliance_id IS NULL) AND (u1.id = u2.id)))))) friends;


ALTER TABLE exile_s03.vw_friends_radars OWNER TO exileng;

--
-- Name: vw_planet_buildings; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_planet_buildings AS
 SELECT planet_buildings.planetid,
    planet_buildings.buildingid,
    GREATEST(0, (
        CASE
            WHEN ((planet_buildings.destroy_datetime IS NULL) OR db_buildings.active_when_destroying) THEN (planet_buildings.quantity)::integer
            ELSE (planet_buildings.quantity - 1)
        END - planet_buildings.disabled)) AS quantity
   FROM (exile_s03.planet_buildings
     JOIN static.db_buildings ON ((db_buildings.id = planet_buildings.buildingid)));


ALTER TABLE exile_s03.vw_planet_buildings OWNER TO exileng;

--
-- Name: vw_planets; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_planets AS
 SELECT nav_planet.id,
    nav_planet.galaxy,
    nav_planet.sector,
    nav_planet.planet,
    nav_planet.name,
    nav_planet.planet_floor,
    nav_planet.planet_space,
    nav_planet.planet_pct_ore,
    nav_planet.planet_pct_hydrocarbon,
    nav_planet.floor,
    nav_planet.space,
    nav_planet.pct_ore,
    nav_planet.pct_hydrocarbon,
    nav_planet.ownerid,
    nav_planet.commanderid,
    int4(LEAST(((nav_planet.ore)::double precision + (((nav_planet.ore_production)::double precision * date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone))) / (3600.0)::double precision)), (nav_planet.ore_capacity)::double precision)) AS ore,
    int4(LEAST(((nav_planet.hydrocarbon)::double precision + (((nav_planet.hydrocarbon_production)::double precision * date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone))) / (3600.0)::double precision)), (nav_planet.hydrocarbon_capacity)::double precision)) AS hydrocarbon,
    int4(GREATEST((0)::double precision, LEAST(((nav_planet.energy)::double precision + ((((nav_planet.energy_production - nav_planet.energy_consumption))::double precision * date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone))) / (3600.0)::double precision)), (nav_planet.energy_capacity)::double precision))) AS energy,
    int4(LEAST(((nav_planet.workers)::double precision * power(((1.0 + ((nav_planet.mod_production_workers)::numeric / 1000.0)))::double precision, LEAST((date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone)) / (3600.0)::double precision), (1500)::double precision))), (nav_planet.workers_capacity)::double precision)) AS workers,
    nav_planet.ore_capacity,
    nav_planet.hydrocarbon_capacity,
    nav_planet.energy_capacity,
    nav_planet.workers_capacity,
    nav_planet.ore_production,
    nav_planet.hydrocarbon_production,
    nav_planet.energy_consumption,
    nav_planet.energy_production,
    nav_planet.floor_occupied,
    nav_planet.space_occupied,
    nav_planet.workers_busy,
    nav_planet.production_lastupdate,
    nav_planet.mod_production_ore,
    nav_planet.mod_production_hydrocarbon,
    nav_planet.mod_production_energy,
    nav_planet.mod_production_workers,
    nav_planet.mod_construction_speed_buildings,
    nav_planet.mod_construction_speed_ships,
    nav_planet.next_battle,
    nav_planet.scientists,
    nav_planet.scientists_capacity,
    nav_planet.soldiers,
    nav_planet.soldiers_capacity,
    nav_planet.radar_strength,
    nav_planet.radar_jamming,
    nav_planet.colonization_datetime,
    nav_planet.orbit_ore,
    nav_planet.orbit_hydrocarbon,
    nav_planet.score,
    nav_planet.last_catastrophe,
    nav_planet.next_training_datetime,
    nav_planet.production_frozen,
    nav_planet.mood,
    nav_planet.workers_for_maintenance,
    nav_planet.soldiers_for_security,
    nav_planet.recruit_workers,
    nav_planet.buildings_dilapidation,
    nav_planet.previous_buildings_dilapidation,
    nav_planet.production_percent,
    nav_planet.energy_receive_antennas,
    nav_planet.energy_send_antennas,
    nav_planet.energy_receive_links,
    nav_planet.energy_send_links,
    nav_planet.upkeep,
    int4(GREATEST((static.const_planet_market_stock_min())::double precision, LEAST((static.const_planet_market_stock_max())::double precision, ((nav_planet.planet_stock_ore)::double precision - (((nav_planet.planet_need_ore)::double precision * date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone))) / (3600.0)::double precision))))) AS planet_stock_ore,
    int4(GREATEST((static.const_planet_market_stock_min())::double precision, LEAST((static.const_planet_market_stock_max())::double precision, ((nav_planet.planet_stock_hydrocarbon)::double precision - (((nav_planet.planet_need_hydrocarbon)::double precision * date_part('epoch'::text, (now() - (nav_planet.production_lastupdate)::timestamp with time zone))) / (3600.0)::double precision))))) AS planet_stock_hydrocarbon,
    nav_planet.buy_ore,
    nav_planet.buy_hydrocarbon,
    nav_planet.credits_production,
    nav_planet.credits_random_production,
    nav_planet.production_prestige
   FROM exile_s03.nav_planet;


ALTER TABLE exile_s03.vw_planets OWNER TO exileng;

--
-- Name: VIEW vw_planets; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON VIEW exile_s03.vw_planets IS 'Return planet info with virtual resources data : resources it should have

note: the workers production is limited to a maximum of 1500 hours to prevent overflow with the power() function

';


--
-- Name: vw_planets_bonus; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_planets_bonus AS
 SELECT nav_planet.id,
    nav_planet.ownerid,
    users.planets,
    (random() * (users.planets)::double precision) AS bonus_probability
   FROM (exile_s03.nav_planet
     JOIN exile_s03.users ON ((users.id = nav_planet.ownerid)))
  WHERE ((nav_planet.ownerid IS NOT NULL) AND (users.planets > 0))
 OFFSET 0;


ALTER TABLE exile_s03.vw_planets_bonus OWNER TO exileng;

--
-- Name: vw_players; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_players AS
 SELECT users.id,
    users.privilege,
    users.login,
    users.password,
    users.lastlogin,
    users.regdate,
    users.email,
    users.credits,
    users.credits_bankruptcy,
    users.lcid,
    users.description,
    users.notes,
    users.avatar_url,
    users.lastplanetid,
    users.deletion_date,
    users.score,
    users.score_prestige,
    users.score_buildings,
    users.score_research,
    users.score_ships,
    users.alliance_id,
    users.alliance_rank,
    users.alliance_joined,
    users.alliance_left,
    users.alliance_taxes_paid,
    users.alliance_credits_given,
    users.alliance_credits_taken,
    users.alliance_score_combat,
    users.newpassword,
    users.lastactivity,
    users.planets,
    users.noplanets_since,
    users.last_catastrophe,
    users.last_holidays,
    users.previous_score,
    users.timers_enabled,
    users.ban_datetime,
    users.ban_expire,
    users.ban_reason,
    users.ban_reason_public,
    users.ban_adminuserid,
    users.scientists,
    users.soldiers,
    users.dev_lasterror,
    users.dev_lastnotice,
    users.protection_enabled,
    users.protection_colonies_to_unprotect,
    users.protection_datetime,
    users.max_colonizable_planets,
    users.remaining_colonizations,
    users.upkeep_last_cost,
    users.upkeep_commanders,
    users.upkeep_planets,
    users.upkeep_scientists,
    users.upkeep_soldiers,
    users.upkeep_ships,
    users.upkeep_ships_in_position,
    users.upkeep_ships_parked,
    users.wallet_display,
    users.resets,
    users.commanders_loyalty,
    users.orientation,
    users.admin_notes,
    users.paid_until,
    users.autosignature,
    users.game_started,
    users.requests,
    users.score_next_update,
    users.display_alliance_planet_name,
    users.score_visibility
   FROM exile_s03.users
  WHERE (((users.privilege = 0) OR (users.privilege = '-2'::integer)) AND (users.orientation > 0) AND (users.planets > 0) AND (users.credits_bankruptcy > 0));


ALTER TABLE exile_s03.vw_players OWNER TO exileng;

--
-- Name: vw_players_upkeep; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_players_upkeep AS
 SELECT users.id AS userid,
    int4(( SELECT count(*) AS count
           FROM exile_s03.commanders
          WHERE ((commanders.ownerid = users.id) AND (commanders.recruited <= now())))) AS commanders,
    int4(( SELECT COALESCE(sum(commanders.salary), (0)::bigint) AS sum
           FROM exile_s03.commanders
          WHERE ((commanders.ownerid = users.id) AND (commanders.recruited <= now())))) AS commanders_salary,
    int4((( SELECT COALESCE(sum(nav_planet.scientists), (0)::bigint) AS "coalesce"
           FROM exile_s03.nav_planet
          WHERE (nav_planet.ownerid = users.id)) + ( SELECT COALESCE(sum(fleets.cargo_scientists), (0)::bigint) AS "coalesce"
           FROM exile_s03.fleets
          WHERE (fleets.ownerid = users.id)))) AS scientists,
    int4((( SELECT COALESCE(sum(nav_planet.soldiers), (0)::bigint) AS "coalesce"
           FROM exile_s03.nav_planet
          WHERE (nav_planet.ownerid = users.id)) + ( SELECT COALESCE(sum(fleets.cargo_soldiers), (0)::bigint) AS "coalesce"
           FROM exile_s03.fleets
          WHERE (fleets.ownerid = users.id)))) AS soldiers,
    int4(( SELECT count(*) AS count
           FROM exile_s03.nav_planet
          WHERE ((nav_planet.planet_floor > 0) AND (nav_planet.planet_space > 0) AND (nav_planet.ownerid = users.id)))) AS planets,
    int4(( SELECT COALESCE(sum(fleets.upkeep), (0)::bigint) AS "coalesce"
           FROM (exile_s03.fleets
             LEFT JOIN exile_s03.nav_planet ON (((nav_planet.id = fleets.planetid) AND (fleets.dest_planetid IS NULL))))
          WHERE ((fleets.ownerid = users.id) AND ((nav_planet.ownerid IS NULL) OR ((nav_planet.planet_floor = 0) AND (nav_planet.planet_space = 0)) OR (nav_planet.ownerid = users.id) OR (EXISTS ( SELECT 1
                   FROM exile_s03.vw_friends
                  WHERE ((vw_friends.userid = users.id) AND (vw_friends.friend = nav_planet.ownerid)))))))) AS ships_signature,
    int4(( SELECT COALESCE(sum(fleets.upkeep), (0)::bigint) AS "coalesce"
           FROM (exile_s03.fleets
             LEFT JOIN exile_s03.nav_planet ON (((nav_planet.id = fleets.planetid) AND (fleets.dest_planetid IS NULL))))
          WHERE ((fleets.ownerid = users.id) AND (nav_planet.ownerid IS NOT NULL) AND (nav_planet.planet_floor > 0) AND (nav_planet.planet_space > 0) AND (nav_planet.ownerid <> users.id) AND (NOT (EXISTS ( SELECT 1
                   FROM exile_s03.vw_friends
                  WHERE ((vw_friends.userid = users.id) AND (vw_friends.friend = nav_planet.ownerid)))))))) AS ships_in_position_signature,
    int4(( SELECT COALESCE(sum((db_ships.upkeep * planet_ships.quantity)), (0)::bigint) AS "coalesce"
           FROM ((exile_s03.planet_ships
             JOIN exile_s03.nav_planet ON ((nav_planet.id = planet_ships.planetid)))
             JOIN static.db_ships ON ((db_ships.id = planet_ships.shipid)))
          WHERE (nav_planet.ownerid = users.id))) AS ships_parked_signature,
    (static.const_upkeep_commanders() * users.mod_upkeep_commanders_cost) AS cost_commanders,
    (static.const_upkeep_planets(( SELECT int4(count(*)) AS int4
           FROM exile_s03.nav_planet
          WHERE ((nav_planet.planet_floor > 0) AND (nav_planet.planet_space > 0) AND (nav_planet.ownerid = users.id)))) * users.mod_upkeep_planets_cost) AS cost_planets,
    (static.const_upkeep_scientists() * users.mod_upkeep_scientists_cost) AS cost_scientists,
    (static.const_upkeep_soldiers() * users.mod_upkeep_soldiers_cost) AS cost_soldiers,
    (static.const_upkeep_ships() * users.mod_upkeep_ships_cost) AS cost_ships,
    (static.const_upkeep_ships_in_position() * users.mod_upkeep_ships_cost) AS cost_ships_in_position,
    (static.const_upkeep_ships_parked() * users.mod_upkeep_ships_cost) AS cost_ships_parked,
    users.upkeep_commanders,
    users.upkeep_scientists,
    users.upkeep_soldiers,
    users.upkeep_ships,
    users.upkeep_ships_in_position,
    users.upkeep_ships_parked,
    users.upkeep_planets,
    users.upkeep_last_cost,
    float4(((( SELECT sum(nav_planet.upkeep) AS sum
           FROM exile_s03.nav_planet
          WHERE ((nav_planet.planet_floor > 0) AND (nav_planet.planet_space > 0) AND (nav_planet.ownerid = users.id))))::double precision * users.mod_upkeep_planets_cost)) AS cost_planets2
   FROM exile_s03.users;


ALTER TABLE exile_s03.vw_players_upkeep OWNER TO exileng;

--
-- Name: vw_relations; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_relations AS
 SELECT u1.id AS user1,
    u2.id AS user2,
        CASE
            WHEN (u1.id = u2.id) THEN int2(2)
            WHEN (u1.alliance_id = u2.alliance_id) THEN int2(1)
            WHEN ((u1.privilege = '-50'::integer) OR (u2.privilege = '-50'::integer)) THEN int2(0)
            WHEN (EXISTS ( SELECT 1
               FROM exile_s03.alliances_naps
              WHERE ((alliances_naps.allianceid1 = u1.alliance_id) AND (alliances_naps.allianceid2 = u2.alliance_id)))) THEN int2(0)
            ELSE int2('-1'::integer)
        END AS relation
   FROM exile_s03.users u1,
    exile_s03.users u2;


ALTER TABLE exile_s03.vw_relations OWNER TO exileng;

--
-- Name: vw_reports; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_reports AS
 SELECT r.ownerid,
    r.type,
    r.datetime,
    r.battleid,
    r.fleetid,
    r.fleet_name,
    r.planetid,
    r.planet_name,
    r.planet_relation,
    r.planet_ownername,
    nav_planet.galaxy,
    nav_planet.sector,
    nav_planet.planet,
    r.researchid,
    r.read_date,
    r.ore,
    r.hydrocarbon,
    r.credits,
    r.subtype,
    r.scientists,
    r.soldiers,
    r.workers,
    users.login AS username,
    alliances.tag AS alliance_tag,
    alliances.name AS alliance_name,
    r.invasionid,
    r.spyid,
    spy.key AS spy_key,
    r.commanderid,
    c.name,
    r.description,
    r.buildingid,
    r.upkeep_commanders,
    r.upkeep_planets,
    r.upkeep_scientists,
    r.upkeep_ships,
    r.upkeep_ships_in_position,
    r.upkeep_ships_parked,
    r.upkeep_soldiers
   FROM (((((exile_s03.reports r
     LEFT JOIN exile_s03.nav_planet ON ((nav_planet.id = r.planetid)))
     LEFT JOIN exile_s03.users ON ((users.id = r.userid)))
     LEFT JOIN exile_s03.alliances ON ((alliances.id = r.allianceid)))
     LEFT JOIN exile_s03.spy ON ((spy.id = r.spyid)))
     LEFT JOIN exile_s03.commanders c ON ((c.id = r.commanderid)))
  WHERE ((r.datetime <= now()) AND ((r.read_date IS NULL) OR (r.read_date > (now() - '7 days'::interval))));


ALTER TABLE exile_s03.vw_reports OWNER TO exileng;

--
-- Name: vw_researches; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_researches AS
 SELECT users.id AS userid,
    db_research.id,
    db_research.category,
    db_research.name,
    db_research.label,
    db_research.description,
    db_research.rank,
    db_research.cost_credits,
    db_research.levels,
    COALESCE(( SELECT researches.level
           FROM exile_s03.researches
          WHERE ((researches.researchid = db_research.id) AND (researches.userid = users.id))), int2(0)) AS level,
    ( SELECT int4(date_part('epoch'::text, ((researches_pending.end_time)::timestamp with time zone - now()))) AS int4
           FROM exile_s03.researches_pending
          WHERE ((researches_pending.researchid = db_research.id) AND (researches_pending.userid = users.id))) AS status,
    exile_s03.sp_get_research_time(users.id, db_research.rank, (db_research.levels)::integer, COALESCE((( SELECT researches.level
           FROM exile_s03.researches
          WHERE ((researches.researchid = db_research.id) AND (researches.userid = users.id))))::integer, 0)) AS total_time,
    exile_s03.sp_get_research_cost(users.id, db_research.id) AS total_cost,
    (NOT (EXISTS ( SELECT 1
           FROM static.db_research_req_research
          WHERE ((db_research_req_research.researchid = db_research.id) AND (NOT (db_research_req_research.required_researchid IN ( SELECT researches.researchid
                   FROM exile_s03.researches
                  WHERE ((researches.userid = users.id) AND (researches.level >= db_research_req_research.required_researchlevel))))))))) AS researchable,
    (NOT (EXISTS ( SELECT 1
           FROM static.db_research_req_building
          WHERE ((db_research_req_building.researchid = db_research.id) AND (NOT (db_research_req_building.required_buildingid IN ( SELECT planet_buildings.buildingid
                   FROM (exile_s03.nav_planet
                     LEFT JOIN exile_s03.planet_buildings ON ((nav_planet.id = planet_buildings.planetid)))
                  WHERE (nav_planet.ownerid = users.id)
                  GROUP BY planet_buildings.buildingid
                 HAVING (sum(planet_buildings.quantity) >= db_research_req_building.required_buildingcount)))))))) AS buildings_requirements_met,
    (NOT (EXISTS ( SELECT 1
           FROM static.db_research_req_building
          WHERE ((db_research_req_building.researchid = db_research.id) AND (( SELECT db_buildings.is_planet_element
                   FROM static.db_buildings
                  WHERE (db_buildings.id = db_research_req_building.required_buildingid)) = true) AND (NOT (db_research_req_building.required_buildingid IN ( SELECT planet_buildings.buildingid
                   FROM (exile_s03.nav_planet
                     LEFT JOIN exile_s03.planet_buildings ON ((nav_planet.id = planet_buildings.planetid)))
                  WHERE (nav_planet.ownerid = users.id)
                  GROUP BY planet_buildings.buildingid
                 HAVING (sum(planet_buildings.quantity) >= db_research_req_building.required_buildingcount)))))))) AS planet_elements_requirements_met
   FROM exile_s03.users,
    static.db_research
  WHERE (db_research.rank > 0)
  ORDER BY db_research.category, db_research.id;


ALTER TABLE exile_s03.vw_researches OWNER TO exileng;

--
-- Name: vw_ships; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_ships AS
 SELECT p.id AS planetid,
    p.ownerid AS planet_ownerid,
    db_ships.id,
    db_ships.category,
    db_ships.name,
    db_ships.label,
    db_ships.description,
    db_ships.cost_ore,
    db_ships.cost_hydrocarbon,
    db_ships.cost_energy,
    db_ships.cost_credits,
    db_ships.cost_prestige,
    db_ships.upkeep,
    db_ships.workers,
    db_ships.crew,
    db_ships.capacity,
    int4((((db_ships.construction_time)::numeric * 100.0) / (p.mod_construction_speed_ships)::numeric)) AS construction_time,
    COALESCE(s2.hull, db_ships.hull) AS hull,
    COALESCE(s2.shield, db_ships.shield) AS shield,
    COALESCE((((s2.weapon_dmg_em + s2.weapon_dmg_explosive) + s2.weapon_dmg_kinetic) + s2.weapon_dmg_thermal), (((db_ships.weapon_dmg_em + db_ships.weapon_dmg_explosive) + db_ships.weapon_dmg_kinetic) + db_ships.weapon_dmg_thermal)) AS weapon_power,
    COALESCE(s2.weapon_ammo, db_ships.weapon_ammo) AS weapon_ammo,
    COALESCE(s2.weapon_tracking_speed, db_ships.weapon_tracking_speed) AS weapon_tracking_speed,
    COALESCE(s2.weapon_turrets, db_ships.weapon_turrets) AS weapon_turrets,
    COALESCE(s2.signature, db_ships.signature) AS signature,
    COALESCE(s2.speed, db_ships.speed) AS speed,
    COALESCE(s2.handling, db_ships.handling) AS handling,
    db_ships.buildingid,
    COALESCE(s2.recycler_output, db_ships.recycler_output) AS recycler_output,
    COALESCE(s2.droppods, db_ships.droppods) AS droppods,
    COALESCE(s2.long_distance_capacity, db_ships.long_distance_capacity) AS long_distance_capacity,
    COALESCE(planet_ships.quantity, (int2(0))::integer) AS quantity,
    db_ships.required_shipid,
    db_ships.new_shipid,
    COALESCE(( SELECT planet_ships_1.quantity
           FROM exile_s03.planet_ships planet_ships_1
          WHERE ((planet_ships_1.planetid = p.id) AND (planet_ships_1.shipid = db_ships.required_shipid))), 0) AS required_ship_count,
    (NOT (EXISTS ( SELECT db_ships_req_building.required_buildingid
           FROM static.db_ships_req_building
          WHERE ((db_ships_req_building.shipid = COALESCE(db_ships.new_shipid, db_ships.id)) AND (NOT (db_ships_req_building.required_buildingid IN ( SELECT planet_buildings.buildingid
                   FROM exile_s03.planet_buildings
                  WHERE (planet_buildings.planetid = p.id)))))))) AS buildings_requirements_met,
    (db_ships.buildable AND (NOT (EXISTS ( SELECT 1
           FROM static.db_ships_req_research
          WHERE ((db_ships_req_research.shipid = COALESCE(db_ships.new_shipid, db_ships.id)) AND (NOT (db_ships_req_research.required_researchid IN ( SELECT researches.researchid
                   FROM exile_s03.researches
                  WHERE ((researches.userid = p.ownerid) AND (researches.level >= db_ships_req_research.required_researchlevel)))))))))) AS research_requirements_met,
    db_ships.built_per_batch,
    db_ships.required_vortex_strength,
    db_ships.leadership AS mod_leadership
   FROM (((exile_s03.nav_planet p
     CROSS JOIN static.db_ships)
     LEFT JOIN exile_s03.planet_ships ON (((planet_ships.planetid = p.id) AND (planet_ships.shipid = db_ships.id))))
     LEFT JOIN static.db_ships s2 ON ((s2.id = db_ships.new_shipid)))
  ORDER BY db_ships.category, db_ships.id;


ALTER TABLE exile_s03.vw_ships OWNER TO exileng;

--
-- Name: VIEW vw_ships; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON VIEW exile_s03.vw_ships IS 'list all ships that can be built on a planet. A ship can be built if it meet the requirement :

if it depends on other buildings, these buildings must be built on the planet

if it depends on researches, these researches must be done';


--
-- Name: vw_ships_under_construction; Type: VIEW; Schema: exile_s03; Owner: exileng
--

CREATE VIEW exile_s03.vw_ships_under_construction AS
 SELECT planet_ships_pending.id,
    p.id AS planetid,
    p.name AS planetname,
    p.ownerid,
    p.galaxy,
    p.sector,
    p.planet,
    COALESCE(db_ships.new_shipid, planet_ships_pending.shipid) AS shipid,
    planet_ships_pending.start_time,
    planet_ships_pending.end_time,
    (int8(planet_ships_pending.quantity) * COALESCE(int4(date_part('epoch'::text, ((planet_ships_pending.end_time)::timestamp with time zone - now()))), int4(((
        CASE
            WHEN planet_ships_pending.recycle THEN static.const_ship_recycling_multiplier()
            ELSE (1)::real
        END * (((db_ships.construction_time * 100))::numeric)::double precision) / ((p.mod_construction_speed_ships)::numeric)::double precision)))) AS remaining_time,
    planet_ships_pending.quantity,
    planet_ships_pending.recycle,
    db_ships.required_shipid,
    db_ships.cost_ore,
    db_ships.cost_hydrocarbon,
    db_ships.cost_credits,
    db_ships.crew,
    db_ships.cost_energy,
    db_ships.workers
   FROM ((exile_s03.nav_planet p
     JOIN exile_s03.planet_ships_pending ON ((planet_ships_pending.planetid = p.id)))
     LEFT JOIN static.db_ships ON ((planet_ships_pending.shipid = db_ships.id)))
  ORDER BY p.id, (upper((db_ships.label)::text));


ALTER TABLE exile_s03.vw_ships_under_construction OWNER TO exileng;

--
-- Name: chat_channels id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_channels ALTER COLUMN id SET DEFAULT nextval('exile_s03.chat_channels_id_seq'::regclass);


--
-- Name: impersonate_impersonationlog id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.impersonate_impersonationlog ALTER COLUMN id SET DEFAULT nextval('exile_s03.impersonate_impersonationlog_id_seq'::regclass);


--
-- Name: precise_bbcode_bbcodetag id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_bbcodetag ALTER COLUMN id SET DEFAULT nextval('exile_s03.precise_bbcode_bbcodetag_id_seq'::regclass);


--
-- Name: precise_bbcode_smileytag id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_smileytag ALTER COLUMN id SET DEFAULT nextval('exile_s03.precise_bbcode_smileytag_id_seq'::regclass);


--
-- Name: sessions_notifications id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sessions_notifications ALTER COLUMN id SET DEFAULT nextval('exile_s03.sessions_notifications_id_seq'::regclass);


--
-- Name: users_options_history id; Type: DEFAULT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_options_history ALTER COLUMN id SET DEFAULT nextval('exile_s03.users_options_history_id_seq'::regclass);


--
-- Data for Name: ai_planets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: ai_rogue_planets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: ai_rogue_targets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: ai_watched_planets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_invitations; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_naps; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_naps_offers; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_ranks; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_reports; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_tributes; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_wallet_journal; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_wallet_requests; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: alliances_wars; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_buildings; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_fleets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_fleets_ships; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_fleets_ships_kills; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_relations; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: battles_ships; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: chat; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.chat VALUES (2, 'Exile', '', '', true);
INSERT INTO exile_s03.chat VALUES (1, 'Nouveaux joueurs', '', '', true);


--
-- Data for Name: chat_channels; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: chat_lines; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: chat_onlineusers; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: chat_users; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: commanders; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: fleets; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: fleets_items; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: fleets_ships; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: impersonate_impersonationlog; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: invasions; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_admin_actions; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_http_errors; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_jobs; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.log_jobs VALUES ('exile-events.vbs', '2019-03-30 13:46:59.404076', 'sp_execute_events(), took : 0s', 1700);
INSERT INTO exile_s03.log_jobs VALUES ('exile-update.vbs', '2019-03-30 13:46:58.99762', 'sp_execute_processes(), took : 3,90625E-03s', 4968);
INSERT INTO exile_s03.log_jobs VALUES ('exile-battles.vbs', '2019-03-30 13:46:57.699585', 'No battles found', 1300);


--
-- Data for Name: log_multi_account_warnings; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_multi_simultaneous_warnings; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_notices; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_pages; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_referers; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_referers_users; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: log_sys_errors; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: market_history; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: market_purchases; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: market_sales; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: messages; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: messages_addressee_history; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: messages_ignore_list; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: messages_money_transfers; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: nav_galaxies; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: nav_planet; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_buildings; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_buildings_pending; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_energy_transfer; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_owners; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_ships; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_ships_pending; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: planet_training_pending; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: precise_bbcode_bbcodetag; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: precise_bbcode_smileytag; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: reports; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: researches; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: researches_pending; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: routes; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: routes_waypoints; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: sessions_notifications; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: spy; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: spy_building; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: spy_fleet; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: spy_planet; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: spy_research; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: sys_daily_updates; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.sys_daily_updates VALUES ('sp_daily_credits_production()', false, '2007-02-06 04:10:22.4907', '22:00:00', NULL, '{00:00:01.675299,00:00:00.447144,00:00:01.357681,00:00:00.577626,00:00:01.028507,00:00:00.193653,00:00:02.033776,00:00:00.201612,00:00:01.079752,00:00:01.914209}');
INSERT INTO exile_s03.sys_daily_updates VALUES ('sp_daily_update_scores()', false, '2006-11-20 00:00:00', '22:00:00', NULL, '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}');
INSERT INTO exile_s03.sys_daily_updates VALUES ('sp_daily_cleaning()', true, '2008-01-30 04:09:50.279533', '22:00:00', NULL, '{00:00:13.869816,00:00:08.827096,00:00:12.374063,00:00:09.327597,00:00:08.78746,00:00:09.458528,00:00:16.454975,00:00:12.765035,00:00:12.074814,00:00:12.369658}');


--
-- Data for Name: sys_events; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.sys_events VALUES ('sp_event_fleet_delayed()', false, '2008-09-24 13:52:44.233', '00:10:30', NULL, '{00:00:00.016,00:00:00.015,00:00:00,00:00:00,00:00:00.016,00:00:00,00:00:00.016,00:00:00,00:00:00,00:00:00.015}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_spawn_new_resource_points()', false, '2008-07-24 15:24:11.004', '00:19:10', NULL, '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_spawn_orbit_resources()', true, '2008-11-03 13:43:38.781', '00:01:00', NULL, '{00:00:00,00:00:00,00:00:00,00:00:00,00:00:00,00:00:00.016,00:00:00,00:00:00.016,00:00:00.016,00:00:00.016}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_annihilation_fleets()', false, '2019-03-28 22:23:15.281233', '00:30:00', NULL, '{00:00:02.363637,00:00:02.49736,00:00:00.049482,00:00:00.049954,00:00:00.049901,00:00:08.135784,00:00:02.225658,00:00:00.935741,00:00:01.75,00:00:02.125}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_merchants_contract()', true, '2020-09-09 18:37:48.554622', '24:00:00', NULL, '{00:00:00.013764,00:00:00.002839,00:00:00.002246,00:00:00.001681,00:00:00.001819,00:00:00.00186,00:00:00.010767,00:00:00.007715,00:00:00.001035,00:00:00.000896}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_lottery()', true, '2020-09-06 18:34:47.887603', '168:00:00', NULL, '{00:00:00.010829,00:00:00.004089,00:00:00.089142,00:00:00.003773,00:00:00.101392,00:00:03.625,00:00:00.938,00:00:00.781,00:00:01.031,00:00:04.203}');
INSERT INTO exile_s03.sys_events VALUES ('sp_daily_cleaning()', true, '2020-09-09 18:37:48.554622', '24:00:00', NULL, '{00:00:00.034056,00:00:00.040125,00:00:00.032311,00:00:00.034862,00:00:00.033231,00:00:00.026335,00:00:00.023199,00:00:00.019599,00:00:00.025142,00:00:00.022588}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_riots()', true, '2020-09-10 12:43:38.081482', '00:10:50', NULL, '{00:00:00.002134,00:00:00.002266,00:00:00.004531,00:00:00.005939,00:00:00.002095,00:00:00.002307,00:00:00.001463,00:00:00.001195,00:00:00.006364,00:00:00.005597}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_rogue_fleets_patrol()', true, '2020-09-10 11:27:46.500595', '01:30:00', NULL, '{00:00:00.002591,00:00:00.007417,00:00:00.009682,00:00:00.007987,00:00:00.009318,00:00:00.00837,00:00:00.008106,00:00:00.007294,00:00:00.03403,00:00:00.006827}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_commanders_promotions()', true, '2020-09-10 12:27:46.919184', '00:30:00', NULL, '{00:00:00.002799,00:00:00.001448,00:00:00.000485,00:00:00.00147,00:00:00.001721,00:00:00.001647,00:00:00.001341,00:00:00.001246,00:00:00.001248,00:00:00.001645}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_lost_nations_abandon()', true, '2020-09-10 12:45:47.018908', '00:11:00', NULL, '{00:00:00.004053,00:00:00.002489,00:00:00.002518,00:00:00.003105,00:00:00.002655,00:00:00.004197,00:00:00.002434,00:00:00.000374,00:00:00.003662,00:00:00.002457}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_planet_bonus()', true, '2020-09-10 12:37:48.084671', '00:10:00', NULL, '{00:00:00.004053,00:00:00.004412,00:00:00.004921,00:00:00.004532,00:00:00.005446,00:00:00.003884,00:00:00.004165,00:00:00.001473,00:00:00.004265,00:00:00.004304}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_robberies()', true, '2020-09-10 12:38:58.89094', '00:10:10', NULL, '{00:00:00.004312,00:00:00.008309,00:00:00.001908,00:00:00.002102,00:00:00.002169,00:00:00.002388,00:00:00.001979,00:00:00.001587,00:00:00.002864,00:00:00.002615}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_laboratory_accident()', true, '2020-09-10 12:40:08.400608', '00:10:20', NULL, '{00:00:00.004202,00:00:00.004227,00:00:00.003442,00:00:00.003826,00:00:00.005053,00:00:00.001292,00:00:00.000967,00:00:00.001897,00:00:00.004072,00:00:00.004552}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_rogue_fleets_rush_resources()', true, '2020-09-10 12:42:46.92233', '01:15:00', NULL, '{00:00:00.002609,00:00:00.002989,00:00:00.001325,00:00:00.000765,00:00:00.033123,00:00:00.00155,00:00:00.002498,00:00:00.001128,00:00:00.004483,00:00:00.001258}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_long()', true, '2020-09-10 12:43:26.544712', '00:10:40', NULL, '{00:00:00.001374,00:00:00.003457,00:00:00.003917,00:00:00.005572,00:00:00.003241,00:00:00.00357,00:00:00.000931,00:00:00.001459,00:00:00.000989,00:00:00.003432}');
INSERT INTO exile_s03.sys_events VALUES ('sp_event_sandworm()', true, '2020-09-10 12:46:06.572772', '00:11:10', NULL, '{00:00:00.002357,00:00:00.002254,00:00:00.002829,00:00:00.002264,00:00:00.002626,00:00:00.002231,00:00:00.002218,00:00:00.001324,00:00:00.004023,00:00:00.004078}');


--
-- Data for Name: sys_processes; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.sys_processes VALUES ('sp_process_market_price()', true, '2020-09-10 12:28:42.356864', '01:00:00', NULL, '{00:00:00.004626,00:00:00.006103,00:00:00.004638,00:00:00.003627,00:00:00.003688,00:00:00.003939,00:00:00.006734,00:00:00.003795,00:00:00.003886,00:00:00.005855}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_clean_waiting_fleets()', true, '2020-09-10 12:38:42.878269', '00:10:00', NULL, '{00:00:00.000768,00:00:00.000854,00:00:00.00075,00:00:00.000705,00:00:00.000449,00:00:00.000592,00:00:00.00048,00:00:00.001052,00:00:00.003096,00:00:00.001882}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_clean_routes()', true, '2020-09-10 12:43:43.382825', '00:05:00', NULL, '{00:00:00.000816,00:00:00.001336,00:00:00.003024,00:00:00.000628,00:00:00.001527,00:00:00.001373,00:00:00.001031,00:00:00.001412,00:00:00.001811,00:00:00.000752}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_clean_alliances()', true, '2020-09-10 12:45:42.536249', '00:01:00', NULL, '{00:00:00.002406,00:00:00.0036,00:00:00.002186,00:00:00.003399,00:00:00.000717,00:00:00.000917,00:00:00.001037,00:00:00.00259,00:00:00.002135,00:00:00.000804}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_market(''0:00:05'', 50)', true, '2020-09-10 12:46:19.349942', '00:00:05', NULL, '{00:00:00.000146,00:00:00.00015,00:00:00.000501,00:00:00.000551,00:00:00.000494,00:00:00.000548,00:00:00.000511,00:00:00.000932,00:00:00.000091,00:00:00.000078}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_merchant_planets()', true, '2020-09-10 12:46:19.349942', '00:00:05', NULL, '{00:00:00.00009,00:00:00.00016,00:00:00.000096,00:00:00.000105,00:00:00.000088,00:00:00.000092,00:00:00.000083,00:00:00.001014,00:00:00.000077,00:00:00.00013}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_market_purchases()', true, '2020-09-10 12:46:19.349942', '00:00:05', NULL, '{00:00:00.000071,00:00:00.00021,00:00:00.000133,00:00:00.000144,00:00:00.000131,00:00:00.000077,00:00:00.000066,00:00:00.000711,00:00:00.000065,00:00:00.000079}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_holidays()', true, '2020-09-10 12:46:19.349942', '00:00:05', NULL, '{00:00:00.000071,00:00:00.000151,00:00:00.000074,00:00:00.000077,00:00:00.000073,00:00:00.00006,00:00:00.000056,00:00:00.00046,00:00:00.000056,00:00:00.000064}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_bounties(10)', true, '2020-09-10 12:46:19.349942', '00:00:05', NULL, '{00:00:00.000054,00:00:00.000103,00:00:00.000082,00:00:00.000083,00:00:00.000085,00:00:00.000165,00:00:00.000129,00:00:00.000353,00:00:00.000107,00:00:00.000059}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_destroy_buildings(''0:00:01'', 10)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000478,00:00:00.000369,00:00:00.000293,00:00:00.000291,00:00:00.000274,00:00:00.000341,00:00:00.00027,00:00:00.000276,00:00:00.000283,00:00:00.000326}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_accounts_deletion()', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000207,00:00:00.000136,00:00:00.000116,00:00:00.000122,00:00:00.000119,00:00:00.000158,00:00:00.000106,00:00:00.000116,00:00:00.000115,00:00:00.000119}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_leave_alliance(10)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000178,00:00:00.000087,00:00:00.000071,00:00:00.000069,00:00:00.000069,00:00:00.000098,00:00:00.000067,00:00:00.000072,00:00:00.000071,00:00:00.000074}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_score(''0:00:00'', 50)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000119,00:00:00.000092,00:00:00.000071,00:00:00.000071,00:00:00.000072,00:00:00.000124,00:00:00.000066,00:00:00.000068,00:00:00.000069,00:00:00.000062}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_sessions_timeout()', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000091,00:00:00.000057,00:00:00.000054,00:00:00.000051,00:00:00.000052,00:00:00.000078,00:00:00.000052,00:00:00.000054,00:00:00.000054,00:00:00.000049}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_naps(10)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000193,00:00:00.000103,00:00:00.0001,00:00:00.000098,00:00:00.000102,00:00:00.000142,00:00:00.00009,00:00:00.000094,00:00:00.000094,00:00:00.000088}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_wars(10)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000211,00:00:00.000123,00:00:00.000117,00:00:00.000127,00:00:00.000117,00:00:00.000182,00:00:00.000146,00:00:00.000146,00:00:00.00013,00:00:00.000138}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_update_planets(''0:00:00'', 25)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.00012,00:00:00.000089,00:00:00.000064,00:00:00.000065,00:00:00.00006,00:00:00.000087,00:00:00.000061,00:00:00.000064,00:00:00.000061,00:00:00.000061}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_buildings()', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000134,00:00:00.00011,00:00:00.000072,00:00:00.000067,00:00:00.00006,00:00:00.000092,00:00:00.000082,00:00:00.000063,00:00:00.000061,00:00:00.000063}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_tributes(25)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000146,00:00:00.000119,00:00:00.000079,00:00:00.000107,00:00:00.000078,00:00:00.000112,00:00:00.000074,00:00:00.000073,00:00:00.000072,00:00:00.000073}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_training(''0:00:01'', 10)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.00051,00:00:00.000313,00:00:00.000266,00:00:00.000271,00:00:00.000296,00:00:00.000362,00:00:00.000315,00:00:00.000301,00:00:00.000285,00:00:00.000295}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_fleets_waiting()', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000114,00:00:00.000073,00:00:00.000069,00:00:00.000072,00:00:00.000072,00:00:00.000093,00:00:00.000067,00:00:00.000072,00:00:00.000073,00:00:00.00007}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_credits_production(''0:00:00'', 50)', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000122,00:00:00.000086,00:00:00.000073,00:00:00.000071,00:00:00.000072,00:00:00.000096,00:00:00.00008,00:00:00.000092,00:00:00.000089,00:00:00.000072}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_researches()', true, '2020-09-10 12:46:21.867974', '00:00:01', NULL, '{00:00:00.000163,00:00:00.000174,00:00:00.000086,00:00:00.000094,00:00:00.000084,00:00:00.000119,00:00:00.000083,00:00:00.000083,00:00:00.000079,00:00:00.000082}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_continue_shipyard(''0:00:01'', 20)', true, '2020-09-10 12:46:22.374671', '00:00:00.5', NULL, '{00:00:00.000119,00:00:00.000129,00:00:00.000065,00:00:00.000071,00:00:00.000067,00:00:00.000061,00:00:00.000078,00:00:00.000069,00:00:00.000121,00:00:00.00006}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_ships(''0:00:01'', 20)', true, '2020-09-10 12:46:22.374671', '00:00:00.5', NULL, '{00:00:00.000105,00:00:00.000136,00:00:00.000092,00:00:00.000087,00:00:00.000098,00:00:00.000083,00:00:00.000087,00:00:00.000077,00:00:00.000092,00:00:00.00008}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_fleets_recycling(''0:00:01'', 25)', true, '2020-09-10 12:46:22.374671', '00:00:00.5', NULL, '{00:00:00.000107,00:00:00.00018,00:00:00.000208,00:00:00.000151,00:00:00.000144,00:00:00.000096,00:00:00.000124,00:00:00.000083,00:00:00.000093,00:00:00.00009}');
INSERT INTO exile_s03.sys_processes VALUES ('sp_process_fleets_movements(''0:00:01'', 25)', true, '2020-09-10 12:46:22.374671', '00:00:00.5', NULL, '{00:00:00.000096,00:00:00.000154,00:00:00.0001,00:00:00.000143,00:00:00.000113,00:00:00.000088,00:00:00.000104,00:00:00.000115,00:00:00.000082,00:00:00.000113}');


--
-- Data for Name: users; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.users VALUES (4, -100, 'Nation rebelle', 'A', '2006-09-01 00:00:00', '2006-09-01 00:00:00', 'nr@exile', 1000000, 168, 1036, '', NULL, '', NULL, NULL, 0, 103843, 0, 0, 0, NULL, 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, 0, NULL, '2006-09-05 11:57:09.571683', NULL, 0, true, NULL, '2009-01-01 17:00:00', NULL, NULL, NULL, 0, 0, NULL, NULL, false, 5, '2006-09-19 11:57:09.571683', 50000, 100000, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 100, 2, '', NULL, NULL, '2006-09-01 00:00:00', 1, 1, 0, '2007-02-23 10:53:36.184266', false, 0, 103843, 1, 0, 0, NULL, '0.0.0.0', NULL, 1, NULL, true, true, NULL, 0, '2008-07-27 14:38:06.042', 0, 1, 1, 1, 400, 3, 0);
INSERT INTO exile_s03.users VALUES (2, -100, 'Nation oubliée', 'A', '2006-09-01 00:00:00', '2006-09-01 00:00:00', 'no@exile', 1000000, 168, 1036, '', NULL, '', NULL, NULL, 0, 4469810, 140617750, 0, 36455650, NULL, 100, '2019-03-29 18:16:08.73905', '2019-03-30 02:16:08.73905', 0, 0, 0, 0, NULL, NULL, 3, NULL, '2006-09-05 11:54:34.148706', NULL, 0, true, NULL, '2009-01-01 17:00:00', NULL, NULL, NULL, 0, 0, NULL, NULL, false, 5, '2006-09-19 11:54:34.148706', 50000, 100000, 7095, 0, 375, 3255, 1693, 0, 0, 0, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 100, 2, '', NULL, NULL, '2006-09-01 00:00:00', 1, 1, 0, '2007-02-23 10:53:36.184266', false, 0, 4471262, 1, 0, 0, NULL, '0.0.0.0', NULL, 1, NULL, true, true, NULL, 62100, '2008-07-27 14:38:06.042', 2908212204, 1, 1, 1, 400, 3, 3);
INSERT INTO exile_s03.users VALUES (5, 500, 'Duke', 'nocheat', '2019-03-29 16:14:24.626639', '2009-01-01 21:22:34.04', NULL, 1000000, 168, 1036, '', NULL, '', NULL, NULL, 283, 0, 0, 0, 0, NULL, 0, NULL, NULL, 0, 0, 0, 0, NULL, '2019-03-29 16:14:24.626639', 0, NULL, '2009-01-01 21:22:34.04', NULL, 283, true, NULL, '2009-01-01 17:00:00', NULL, NULL, NULL, 0, 0, 637, 99880, false, 5, '2009-01-15 21:22:34.04', 50000, 100000, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 85, 0, '', NULL, '', '2009-01-01 21:22:34.04', 1, 1, 0, '2020-09-11 00:00:00', false, 0, 0, 1, 0, 0, NULL, '82.246.212.174', NULL, 1, 's_default', false, false, NULL, 0, '2008-12-31 21:22:34.04', 0, 1, 1, 1, 400, 3, 0);
INSERT INTO exile_s03.users VALUES (1, -100, 'Les fossoyeurs', 'A', '2006-09-01 00:00:00', '2006-09-01 00:00:00', 'fos@exile', 1000000, 168, 1036, '', NULL, '', NULL, NULL, 0, 14868700, 0, 0, 0, NULL, 100, '2019-03-30 13:49:00.351465', '2019-03-30 21:49:00.351465', 0, 0, 0, 0, NULL, NULL, 0, NULL, '2006-09-05 11:56:46.664541', NULL, 0, false, NULL, '2009-01-01 17:00:00', NULL, NULL, NULL, 0, 0, NULL, NULL, false, 5, '2006-09-19 11:56:46.664541', 50000, 99999, 0, 0, 0, 0, 0, 535430.8, 0, 0, NULL, 1, 1.8522, 1.8522, 1.21, 1, 1.9845, 2.3625, 1.2, 1.575, 1.625, 1.5, 1.45, 1, 1, 1, 0.9, 1.1, 1.25, 1, 0.95, 0.8, 0.9, 1, 0.8, 0.95, 1, 5, 20, 85, 2, '', NULL, NULL, '2006-09-01 00:00:00', 1, 1, 0, '2007-02-23 10:53:36.184266', false, 0, 14905392, 1.1, 0, 0, NULL, '0.0.0.0', NULL, 1, NULL, true, true, NULL, 0, '2008-07-27 14:38:06.042', 0, 1, 1, 1, 400, 3, 0);
INSERT INTO exile_s03.users VALUES (3, -50, 'Guilde marchande', 'A', '2006-09-01 00:00:00', '2006-09-01 00:00:00', 'gm@exile', 1000000, 168, 1036, '', NULL, '', NULL, NULL, 0, 0, 0, 0, 0, NULL, 100, '2019-03-30 13:49:00.351465', '2019-03-30 21:49:00.351465', 0, 0, 0, 0, NULL, NULL, 1021, NULL, '2106-09-05 11:54:00.464825', NULL, 0, false, NULL, '2009-01-01 17:00:00', NULL, NULL, NULL, 0, 0, NULL, NULL, false, 5, '2005-09-19 11:54:00.464825', 50000, 100000, 46389, 0, 375, 0, 0, 1026.6666, 0, 0, NULL, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 85, 1, '', NULL, NULL, '2006-09-01 00:00:00', 1, 1, 0, '2007-02-23 10:53:36.184266', true, 0, 0, 1, 0, 0, NULL, '0.0.0.0', NULL, 1, NULL, true, true, NULL, 0, '2008-07-27 14:38:06.042', 0, 1, 1, 1, 400, 3, 0);


--
-- Data for Name: users_alliance_history; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_bounty; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_channels; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_chats; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_connections; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--

INSERT INTO exile_s03.users_connections VALUES (905475, 350, '2020-09-10 11:29:54.512186', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', 2964195738, 5334197, NULL);


--
-- Data for Name: users_expenses; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_favorite_locations; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_fleets_categories; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_holidays; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_newemails; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_options_history; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_registration_address; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_reports; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Data for Name: users_ships_kills; Type: TABLE DATA; Schema: exile_s03; Owner: exileng
--



--
-- Name: alliances_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.alliances_id_seq', 440, true);


--
-- Name: alliances_reports_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.alliances_reports_id_seq', 310249, true);


--
-- Name: alliances_wallet_journal_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.alliances_wallet_journal_id_seq', 497256, true);


--
-- Name: alliances_wallet_requests_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.alliances_wallet_requests_id_seq', 5128, true);


--
-- Name: battles_fleets_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.battles_fleets_id_seq', 479634, true);


--
-- Name: battles_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.battles_id_seq', 110642, true);


--
-- Name: chat_channels_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.chat_channels_id_seq', 1, false);


--
-- Name: chat_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.chat_id_seq', 12541, true);


--
-- Name: chat_lines_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.chat_lines_id_seq', 2266734, true);


--
-- Name: commanders_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.commanders_id_seq', 50938, true);


--
-- Name: fleets_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.fleets_id_seq', 724266, true);


--
-- Name: impersonate_impersonationlog_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.impersonate_impersonationlog_id_seq', 24, true);


--
-- Name: invasions_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.invasions_id_seq', 21963, true);


--
-- Name: last_colonisation_planet_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.last_colonisation_planet_seq', 1, false);


--
-- Name: log_failed_logins_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_failed_logins_id_seq', 1, false);


--
-- Name: log_http_errors_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_http_errors_id_seq', 637, true);


--
-- Name: log_notices_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_notices_id_seq', 144809, true);


--
-- Name: log_pages_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_pages_id_seq', 1, false);


--
-- Name: log_referers_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_referers_id_seq', 358, true);


--
-- Name: log_sys_errors_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.log_sys_errors_id_seq', 697543, true);


--
-- Name: market_history_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.market_history_id_seq', 316590, true);


--
-- Name: messages_addressee_history_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.messages_addressee_history_id_seq', 214540, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.messages_id_seq', 467894, true);


--
-- Name: nav_planet_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.nav_planet_id_seq', 1, false);


--
-- Name: nav_planet_location; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.nav_planet_location', 1, false);


--
-- Name: npc_fleet_uid_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.npc_fleet_uid_seq', 217505, true);


--
-- Name: planet_buildings_pending_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.planet_buildings_pending_id_seq', 1354293, true);


--
-- Name: planet_owners_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.planet_owners_id_seq', 157116, true);


--
-- Name: planet_ships_pending_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.planet_ships_pending_id_seq', 45390804, true);


--
-- Name: planet_training_pending_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.planet_training_pending_id_seq', 1996304, true);


--
-- Name: precise_bbcode_bbcodetag_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.precise_bbcode_bbcodetag_id_seq', 1, false);


--
-- Name: precise_bbcode_smileytag_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.precise_bbcode_smileytag_id_seq', 1, false);


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.reports_id_seq', 5705589, true);


--
-- Name: researches_pending_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.researches_pending_id_seq', 165397, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.routes_id_seq', 560137, true);


--
-- Name: routes_waypoints_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.routes_waypoints_id_seq', 1133077, true);


--
-- Name: sessions_notifications_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.sessions_notifications_id_seq', 1, false);


--
-- Name: spy_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.spy_id_seq', 7880, true);


--
-- Name: stats_requests; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.stats_requests', 5334199, true);


--
-- Name: users_connections_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.users_connections_id_seq', 905475, true);


--
-- Name: users_options_history_id_seq; Type: SEQUENCE SET; Schema: exile_s03; Owner: exileng
--

SELECT pg_catalog.setval('exile_s03.users_options_history_id_seq', 1, false);


--
-- Name: ai_planets ai_planets_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.ai_planets
    ADD CONSTRAINT ai_planets_pkey PRIMARY KEY (planetid);


--
-- Name: ai_rogue_planets ai_rogue_planets_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.ai_rogue_planets
    ADD CONSTRAINT ai_rogue_planets_pkey PRIMARY KEY (planetid);


--
-- Name: ai_rogue_targets ai_rogue_targets_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.ai_rogue_targets
    ADD CONSTRAINT ai_rogue_targets_pkey PRIMARY KEY (planetid);


--
-- Name: alliances_invitations alliances_invitations_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_invitations
    ADD CONSTRAINT alliances_invitations_pkey PRIMARY KEY (allianceid, userid);


--
-- Name: alliances_naps_offers alliances_naps_invitations_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps_offers
    ADD CONSTRAINT alliances_naps_invitations_pkey PRIMARY KEY (allianceid, targetallianceid);


--
-- Name: alliances_naps alliances_naps_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps
    ADD CONSTRAINT alliances_naps_pkey PRIMARY KEY (allianceid1, allianceid2);


--
-- Name: alliances alliances_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances
    ADD CONSTRAINT alliances_pkey PRIMARY KEY (id);


--
-- Name: alliances_ranks alliances_ranks_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_ranks
    ADD CONSTRAINT alliances_ranks_pkey PRIMARY KEY (allianceid, rankid);


--
-- Name: alliances_reports alliances_reports_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_pkey PRIMARY KEY (id);


--
-- Name: alliances_tributes alliances_tributes_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_tributes
    ADD CONSTRAINT alliances_tributes_pkey PRIMARY KEY (allianceid, target_allianceid);


--
-- Name: alliances_wallet_journal alliances_wallet_journal_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wallet_journal
    ADD CONSTRAINT alliances_wallet_journal_pkey PRIMARY KEY (id);


--
-- Name: alliances_wallet_requests alliances_wallet_requests_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wallet_requests
    ADD CONSTRAINT alliances_wallet_requests_pkey PRIMARY KEY (id);


--
-- Name: alliances_wars alliances_wars_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wars
    ADD CONSTRAINT alliances_wars_pkey PRIMARY KEY (allianceid1, allianceid2);


--
-- Name: battles_fleets battles_fleets_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets
    ADD CONSTRAINT battles_fleets_pkey PRIMARY KEY (id);


--
-- Name: battles battles_key_key; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles
    ADD CONSTRAINT battles_key_key UNIQUE (key);


--
-- Name: battles battles_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles
    ADD CONSTRAINT battles_pkey PRIMARY KEY (id);


--
-- Name: battles_relations battles_relations_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_relations
    ADD CONSTRAINT battles_relations_pkey PRIMARY KEY (battleid, user1, user2);


--
-- Name: chat_channels chat_channels_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_channels
    ADD CONSTRAINT chat_channels_pkey PRIMARY KEY (id);


--
-- Name: chat_lines chat_lines_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_lines
    ADD CONSTRAINT chat_lines_pkey PRIMARY KEY (id);


--
-- Name: chat_onlineusers chat_onlineusers_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_onlineusers
    ADD CONSTRAINT chat_onlineusers_pkey PRIMARY KEY (chatid, userid);


--
-- Name: chat chat_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (id);


--
-- Name: chat_users chat_users_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_users
    ADD CONSTRAINT chat_users_pkey PRIMARY KEY (channelid, userid);


--
-- Name: commanders commanders_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.commanders
    ADD CONSTRAINT commanders_pkey PRIMARY KEY (id);


--
-- Name: sys_events events_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sys_events
    ADD CONSTRAINT events_pkey PRIMARY KEY (procedure);


--
-- Name: fleets_items fleets_items_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets_items
    ADD CONSTRAINT fleets_items_pkey PRIMARY KEY (fleetid, resourceid);


--
-- Name: fleets fleets_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_pkey PRIMARY KEY (id);


--
-- Name: fleets_ships fleets_ships_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets_ships
    ADD CONSTRAINT fleets_ships_pkey PRIMARY KEY (fleetid, shipid);


--
-- Name: impersonate_impersonationlog impersonate_impersonationlog_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.impersonate_impersonationlog
    ADD CONSTRAINT impersonate_impersonationlog_pkey PRIMARY KEY (id);


--
-- Name: invasions invasions_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.invasions
    ADD CONSTRAINT invasions_pkey PRIMARY KEY (id);


--
-- Name: log_http_errors log_http_errors_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_http_errors
    ADD CONSTRAINT log_http_errors_pkey PRIMARY KEY (id);


--
-- Name: log_jobs log_jobs_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_jobs
    ADD CONSTRAINT log_jobs_pkey PRIMARY KEY (task);


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_multi_simultaneous_warnings
    ADD CONSTRAINT log_multi_simultaneous_warnings_pkey PRIMARY KEY (datetime, userid1, userid2);


--
-- Name: log_notices log_notices_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_notices
    ADD CONSTRAINT log_notices_pkey PRIMARY KEY (id);


--
-- Name: log_pages log_pages_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_pages
    ADD CONSTRAINT log_pages_pkey PRIMARY KEY (id);


--
-- Name: log_referers log_referers_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_referers
    ADD CONSTRAINT log_referers_pkey PRIMARY KEY (id);


--
-- Name: log_sys_errors log_sys_errors_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_sys_errors
    ADD CONSTRAINT log_sys_errors_pkey PRIMARY KEY (id);


--
-- Name: market_history market_history_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.market_history
    ADD CONSTRAINT market_history_pkey PRIMARY KEY (id);


--
-- Name: market_sales market_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.market_sales
    ADD CONSTRAINT market_pkey PRIMARY KEY (planetid);


--
-- Name: market_purchases market_purchases_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.market_purchases
    ADD CONSTRAINT market_purchases_pkey PRIMARY KEY (planetid);


--
-- Name: messages_addressee_history messages_history_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_addressee_history
    ADD CONSTRAINT messages_history_pkey PRIMARY KEY (id);


--
-- Name: messages_ignore_list messages_ignore_list_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_ignore_list
    ADD CONSTRAINT messages_ignore_list_pkey PRIMARY KEY (userid, ignored_userid);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: nav_galaxies nav_galaxies_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_galaxies
    ADD CONSTRAINT nav_galaxies_pkey PRIMARY KEY (id);


--
-- Name: nav_planet nav_planet_location_unique; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_planet
    ADD CONSTRAINT nav_planet_location_unique UNIQUE (galaxy, sector, planet);


--
-- Name: nav_planet nav_planet_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_planet
    ADD CONSTRAINT nav_planet_pkey PRIMARY KEY (id);


--
-- Name: planet_buildings_pending planet_buildings_pending_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings_pending
    ADD CONSTRAINT planet_buildings_pending_pkey PRIMARY KEY (id);


--
-- Name: planet_buildings_pending planet_buildings_pending_unique; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings_pending
    ADD CONSTRAINT planet_buildings_pending_unique UNIQUE (planetid, buildingid);


--
-- Name: planet_buildings planet_buildings_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings
    ADD CONSTRAINT planet_buildings_pkey PRIMARY KEY (planetid, buildingid);


--
-- Name: planet_owners planet_owners_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_owners
    ADD CONSTRAINT planet_owners_pkey PRIMARY KEY (id);


--
-- Name: planet_energy_transfer planet_sending_energy_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_energy_transfer
    ADD CONSTRAINT planet_sending_energy_pkey PRIMARY KEY (planetid, target_planetid);


--
-- Name: planet_ships_pending planet_ships_pending_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships_pending
    ADD CONSTRAINT planet_ships_pending_pkey PRIMARY KEY (id);


--
-- Name: planet_ships planet_ships_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships
    ADD CONSTRAINT planet_ships_pkey PRIMARY KEY (planetid, shipid);


--
-- Name: planet_training_pending planet_training_pending_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_training_pending
    ADD CONSTRAINT planet_training_pending_pkey PRIMARY KEY (id);


--
-- Name: precise_bbcode_bbcodetag precise_bbcode_bbcodetag_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_bbcodetag
    ADD CONSTRAINT precise_bbcode_bbcodetag_pkey PRIMARY KEY (id);


--
-- Name: precise_bbcode_bbcodetag precise_bbcode_bbcodetag_tag_name_key; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_bbcodetag
    ADD CONSTRAINT precise_bbcode_bbcodetag_tag_name_key UNIQUE (tag_name);


--
-- Name: precise_bbcode_smileytag precise_bbcode_smileytag_code_key; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_smileytag
    ADD CONSTRAINT precise_bbcode_smileytag_code_key UNIQUE (code);


--
-- Name: precise_bbcode_smileytag precise_bbcode_smileytag_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.precise_bbcode_smileytag
    ADD CONSTRAINT precise_bbcode_smileytag_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: researches_pending researches_pending_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches_pending
    ADD CONSTRAINT researches_pending_pkey PRIMARY KEY (id);


--
-- Name: researches researches_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches
    ADD CONSTRAINT researches_pkey PRIMARY KEY (userid, researchid);


--
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (id);


--
-- Name: routes_waypoints routes_waypoints_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.routes_waypoints
    ADD CONSTRAINT routes_waypoints_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (userid);


--
-- Name: spy_building spy_building_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_building
    ADD CONSTRAINT spy_building_pkey PRIMARY KEY (spy_id, planet_id, building_id);


--
-- Name: spy_fleet spy_fleet_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_fleet
    ADD CONSTRAINT spy_fleet_pkey PRIMARY KEY (spy_id, fleet_id);


--
-- Name: spy spy_key_key; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy
    ADD CONSTRAINT spy_key_key UNIQUE (key);


--
-- Name: spy spy_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy
    ADD CONSTRAINT spy_pkey PRIMARY KEY (id);


--
-- Name: spy_planet spy_planet_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_planet
    ADD CONSTRAINT spy_planet_pkey PRIMARY KEY (spy_id, planet_id);


--
-- Name: spy_research spy_research_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_research
    ADD CONSTRAINT spy_research_pkey PRIMARY KEY (spy_id, research_id);


--
-- Name: sys_daily_updates sys_daily_updates_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sys_daily_updates
    ADD CONSTRAINT sys_daily_updates_pkey PRIMARY KEY (procedure);


--
-- Name: sys_processes sys_processes_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sys_processes
    ADD CONSTRAINT sys_processes_pkey PRIMARY KEY (procedure);


--
-- Name: users_channels users_channels_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_channels
    ADD CONSTRAINT users_channels_pkey PRIMARY KEY (userid, channelid);


--
-- Name: users_chats users_chats_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_chats
    ADD CONSTRAINT users_chats_pkey PRIMARY KEY (userid, chatid);


--
-- Name: users_fleets_categories users_fleets_category_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_fleets_categories
    ADD CONSTRAINT users_fleets_category_pkey PRIMARY KEY (userid, category);


--
-- Name: users_holidays users_holidays_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_holidays
    ADD CONSTRAINT users_holidays_pkey PRIMARY KEY (userid);


--
-- Name: users_newemails users_newemails_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_newemails
    ADD CONSTRAINT users_newemails_pkey PRIMARY KEY (userid);


--
-- Name: users_options_history users_options_history_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_options_history
    ADD CONSTRAINT users_options_history_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_connections users_remote_address_history_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_connections
    ADD CONSTRAINT users_remote_address_history_pkey PRIMARY KEY (id);


--
-- Name: users_reports users_reports_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_reports
    ADD CONSTRAINT users_reports_pkey PRIMARY KEY (userid, type, subtype);


--
-- Name: users_ships_kills users_stats_pkey; Type: CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_ships_kills
    ADD CONSTRAINT users_stats_pkey PRIMARY KEY (userid, shipid);


--
-- Name: ai_planets_nextupdate_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX ai_planets_nextupdate_idx ON exile_s03.ai_planets USING btree (nextupdate);


--
-- Name: ai_rogue_planets_nextupdate_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX ai_rogue_planets_nextupdate_idx ON exile_s03.ai_planets USING btree (nextupdate);


--
-- Name: alliances_invitations_replied_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_invitations_replied_idx ON exile_s03.alliances_invitations USING btree (replied);


--
-- Name: alliances_name_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX alliances_name_unique ON exile_s03.alliances USING btree (upper((name)::text));


--
-- Name: alliances_naps_offers_replied; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_naps_offers_replied ON exile_s03.alliances_naps_offers USING btree (replied);


--
-- Name: alliances_ranks_label_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX alliances_ranks_label_unique ON exile_s03.alliances_ranks USING btree (allianceid, upper((label)::text));


--
-- Name: alliances_reports_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_reports_datetime_idx ON exile_s03.alliances_reports USING btree (datetime);


--
-- Name: alliances_reports_ownerid_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_reports_ownerid_datetime_idx ON exile_s03.alliances_reports USING btree (ownerid, datetime);


--
-- Name: alliances_reports_type_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_reports_type_idx ON exile_s03.alliances_reports USING btree (type);


--
-- Name: alliances_tag_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX alliances_tag_unique ON exile_s03.alliances USING btree (upper((tag)::text));


--
-- Name: alliances_wallet_journal_allianceid_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX alliances_wallet_journal_allianceid_datetime_idx ON exile_s03.alliances_wallet_journal USING btree (allianceid, datetime);


--
-- Name: battles_fleets_battleid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX battles_fleets_battleid_idx ON exile_s03.battles_fleets USING btree (battleid);


--
-- Name: battles_time_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX battles_time_idx ON exile_s03.battles USING btree ("time");


--
-- Name: chat_channels_name_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX chat_channels_name_idx ON exile_s03.chat_channels USING btree (lower((name)::text)) WHERE (name IS NOT NULL);


--
-- Name: chat_lines_chatid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX chat_lines_chatid_idx ON exile_s03.chat_lines USING btree (chatid);


--
-- Name: chat_name_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX chat_name_idx ON exile_s03.chat USING btree (upper((name)::text)) WHERE (name IS NOT NULL);


--
-- Name: fki_alliances_invitations_recruiterid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_invitations_recruiterid_fkey ON exile_s03.alliances_invitations USING btree (recruiterid);


--
-- Name: fki_alliances_invitations_userid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_invitations_userid_fkey ON exile_s03.alliances_invitations USING btree (userid);


--
-- Name: fki_alliances_naps_allianceid2_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_naps_allianceid2_fkey ON exile_s03.alliances_naps USING btree (allianceid2);


--
-- Name: fki_alliances_naps_invitations_recruterid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_naps_invitations_recruterid_fkey ON exile_s03.alliances_naps_offers USING btree (recruiterid);


--
-- Name: fki_alliances_wallet_requests_allianceid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_wallet_requests_allianceid ON exile_s03.alliances_wallet_requests USING btree (allianceid);


--
-- Name: fki_alliances_wallet_requests_userid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_alliances_wallet_requests_userid ON exile_s03.alliances_wallet_requests USING btree (userid);


--
-- Name: fki_battles_fleets_ships_fleetid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_fleets_ships_fleetid ON exile_s03.battles_fleets_ships USING btree (fleetid);


--
-- Name: fki_battles_fleets_ships_kills_destroyed_shipid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_fleets_ships_kills_destroyed_shipid ON exile_s03.battles_fleets_ships_kills USING btree (destroyed_shipid);


--
-- Name: fki_battles_fleets_ships_kills_fleetid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_fleets_ships_kills_fleetid ON exile_s03.battles_fleets_ships_kills USING btree (fleetid);


--
-- Name: fki_battles_fleets_ships_kills_shipid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_fleets_ships_kills_shipid ON exile_s03.battles_fleets_ships_kills USING btree (shipid);


--
-- Name: fki_battles_fleets_ships_shipid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_fleets_ships_shipid ON exile_s03.battles_fleets_ships USING btree (shipid);


--
-- Name: fki_battles_ships_battleid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_ships_battleid ON exile_s03.battles_ships USING btree (battleid);


--
-- Name: fki_battles_ships_owner_id; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_ships_owner_id ON exile_s03.battles_ships USING btree (owner_id);


--
-- Name: fki_battles_ships_shipid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_battles_ships_shipid ON exile_s03.battles_ships USING btree (shipid);


--
-- Name: fki_commanders_ownerid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_commanders_ownerid_fk ON exile_s03.commanders USING btree (ownerid);


--
-- Name: fki_fleets_dest_planetid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_fleets_dest_planetid_fkey ON exile_s03.fleets USING btree (dest_planetid) WHERE (dest_planetid IS NOT NULL);


--
-- Name: fki_log_multi_simultaneous_warnings_userid1_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_log_multi_simultaneous_warnings_userid1_fkey ON exile_s03.log_multi_simultaneous_warnings USING btree (userid1);


--
-- Name: fki_log_multi_simultaneous_warnings_userid2_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_log_multi_simultaneous_warnings_userid2_fkey ON exile_s03.log_multi_simultaneous_warnings USING btree (userid2);


--
-- Name: fki_market_planetid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_market_planetid_fk ON exile_s03.market_sales USING btree (planetid);


--
-- Name: fki_messages_addressee_history_addresseeid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_messages_addressee_history_addresseeid_fk ON exile_s03.messages_addressee_history USING btree (addresseeid);


--
-- Name: fki_messages_addressee_history_ownerid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_messages_addressee_history_ownerid_fk ON exile_s03.messages_addressee_history USING btree (ownerid);


--
-- Name: fki_messages_ownerid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_messages_ownerid_fk ON exile_s03.messages USING btree (ownerid) WHERE (ownerid IS NOT NULL);


--
-- Name: fki_messages_senderid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_messages_senderid_fk ON exile_s03.messages USING btree (senderid) WHERE (senderid IS NOT NULL);


--
-- Name: fki_nav_planet_commanderid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_nav_planet_commanderid_fkey ON exile_s03.nav_planet USING btree (commanderid) WHERE (commanderid IS NOT NULL);


--
-- Name: fki_planet_buildings_pending_buildingid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_planet_buildings_pending_buildingid_fk ON exile_s03.planet_buildings_pending USING btree (buildingid);


--
-- Name: fki_planet_buildings_pending_planetid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_planet_buildings_pending_planetid_fk ON exile_s03.planet_buildings_pending USING btree (planetid);


--
-- Name: fki_planet_ships_pending_planetid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_planet_ships_pending_planetid_fkey ON exile_s03.planet_ships_pending USING btree (planetid);


--
-- Name: fki_planet_ships_pending_shipid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_planet_ships_pending_shipid_fkey ON exile_s03.planet_ships_pending USING btree (shipid);


--
-- Name: fki_planet_ships_shipid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_planet_ships_shipid_fkey ON exile_s03.planet_ships USING btree (shipid);


--
-- Name: fki_researches_researchid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_researches_researchid_fk ON exile_s03.researches USING btree (researchid);


--
-- Name: fki_researches_userid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_researches_userid_fk ON exile_s03.researches USING btree (userid);


--
-- Name: fki_routes_waypoints_routeid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_routes_waypoints_routeid_fkey ON exile_s03.routes_waypoints USING btree (routeid);


--
-- Name: fki_spy_building_spyid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_spy_building_spyid_fkey ON exile_s03.spy_building USING btree (spy_id);


--
-- Name: fki_spy_fleet_spyid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_spy_fleet_spyid_fkey ON exile_s03.spy_fleet USING btree (spy_id);


--
-- Name: fki_spy_planet_spyid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_spy_planet_spyid_fkey ON exile_s03.spy_planet USING btree (spy_id);


--
-- Name: fki_spy_research_spyid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_spy_research_spyid_fkey ON exile_s03.spy_research USING btree (spy_id);


--
-- Name: fki_users_alliance_id_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_users_alliance_id_fkey ON exile_s03.users USING btree (alliance_id) WHERE (alliance_id IS NOT NULL);


--
-- Name: fki_users_multi_account_warnings_id_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_users_multi_account_warnings_id_fkey ON exile_s03.log_multi_account_warnings USING btree (id);


--
-- Name: fki_users_multi_account_warnings_withid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_users_multi_account_warnings_withid_fkey ON exile_s03.log_multi_account_warnings USING btree (withid);


--
-- Name: fki_users_remote_address_history_userid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_users_remote_address_history_userid ON exile_s03.users_connections USING btree (userid);


--
-- Name: fki_users_reports_userid_fkey; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fki_users_reports_userid_fkey ON exile_s03.users_reports USING btree (userid);


--
-- Name: fleets_action_end_time_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_action_end_time_idx ON exile_s03.fleets USING btree (action_end_time) WHERE (action_end_time IS NOT NULL);


--
-- Name: fleets_action_moving_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_action_moving_idx ON exile_s03.fleets USING btree (action) WHERE ((action = '-1'::integer) OR (action = 1));


--
-- Name: fleets_action_recycling_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_action_recycling_idx ON exile_s03.fleets USING btree (action) WHERE (action = 2);


--
-- Name: fleets_action_waiting_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_action_waiting_idx ON exile_s03.fleets USING btree (action) WHERE (action = 4);


--
-- Name: fleets_commanderid_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX fleets_commanderid_unique ON exile_s03.fleets USING btree (commanderid) WHERE (commanderid IS NOT NULL);


--
-- Name: fleets_engaged_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_engaged_idx ON exile_s03.fleets USING btree (engaged) WHERE engaged;


--
-- Name: fleets_next_waypointid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_next_waypointid_idx ON exile_s03.fleets USING btree (next_waypointid) WHERE (next_waypointid IS NOT NULL);


--
-- Name: fleets_ownerid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_ownerid_idx ON exile_s03.fleets USING btree (ownerid);


--
-- Name: fleets_planetid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX fleets_planetid_idx ON exile_s03.fleets USING btree (planetid) WHERE (planetid IS NOT NULL);


--
-- Name: impersonate_impersonationlog_impersonating_id_afd114fc; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX impersonate_impersonationlog_impersonating_id_afd114fc ON exile_s03.impersonate_impersonationlog USING btree (impersonating_id);


--
-- Name: impersonate_impersonationlog_impersonator_id_1ecfe8ce; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX impersonate_impersonationlog_impersonator_id_1ecfe8ce ON exile_s03.impersonate_impersonationlog USING btree (impersonator_id);


--
-- Name: invasions_time_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX invasions_time_idx ON exile_s03.invasions USING btree ("time");


--
-- Name: log_notices_timestamp_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX log_notices_timestamp_idx ON exile_s03.log_notices USING btree (datetime);


--
-- Name: market_sale_time_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX market_sale_time_idx ON exile_s03.market_sales USING btree (sale_time);


--
-- Name: messages_money_transfers_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX messages_money_transfers_idx ON exile_s03.messages_money_transfers USING btree (senderid, toid);


--
-- Name: nav_planet_credits_next_update; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_credits_next_update ON exile_s03.nav_planet USING btree (credits_next_update) WHERE ((credits_next_update IS NOT NULL) AND ((credits_production > 0) OR (credits_random_production > 0)));


--
-- Name: nav_planet_galaxy_owner_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_galaxy_owner_idx ON exile_s03.nav_planet USING btree (galaxy, ownerid) WHERE (ownerid IS NOT NULL);


--
-- Name: nav_planet_galaxy_sector_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_galaxy_sector_idx ON exile_s03.nav_planet USING btree (galaxy, sector) WHERE (ownerid IS NOT NULL);


--
-- Name: nav_planet_galaxy_sector_ownerid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_galaxy_sector_ownerid_idx ON exile_s03.nav_planet USING btree (galaxy, sector, ownerid) WHERE (ownerid IS NOT NULL);


--
-- Name: nav_planet_mood_lt_80_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_mood_lt_80_idx ON exile_s03.nav_planet USING btree (mood) WHERE (mood < 80);


--
-- Name: nav_planet_next_battle; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_next_battle ON exile_s03.nav_planet USING btree (next_battle) WHERE (next_battle IS NOT NULL);


--
-- Name: nav_planet_next_planet_update_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_next_planet_update_idx ON exile_s03.nav_planet USING btree (next_planet_update) WHERE (next_planet_update IS NOT NULL);


--
-- Name: nav_planet_ownerid_notnull_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_ownerid_notnull_idx ON exile_s03.nav_planet USING btree (ownerid) WHERE (ownerid IS NOT NULL);


--
-- Name: nav_planet_seism_sandworm_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_seism_sandworm_idx ON exile_s03.nav_planet USING btree (sandworm_activity, seismic_activity) WHERE ((sandworm_activity > 0) OR (seismic_activity > 0));


--
-- Name: nav_planet_shipyard_next_continue_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_shipyard_next_continue_idx ON exile_s03.nav_planet USING btree (shipyard_next_continue) WHERE ((shipyard_next_continue IS NOT NULL) AND (NOT production_frozen));


--
-- Name: nav_planet_spawn_planet_id; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX nav_planet_spawn_planet_id ON exile_s03.nav_planet USING btree (id) WHERE ((spawn_ore > 0) OR (spawn_hydrocarbon > 0));


--
-- Name: planet_buildings_destroy_datetime; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_buildings_destroy_datetime ON exile_s03.planet_buildings USING btree (destroy_datetime) WHERE (destroy_datetime IS NOT NULL);


--
-- Name: planet_buildings_pending_end_time; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_buildings_pending_end_time ON exile_s03.planet_buildings_pending USING btree (end_time) WHERE (end_time IS NOT NULL);


--
-- Name: planet_owners_newownerid; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_owners_newownerid ON exile_s03.planet_owners USING btree (newownerid);


--
-- Name: planet_ships_pending_end_time; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_ships_pending_end_time ON exile_s03.planet_ships_pending USING btree (end_time) WHERE (end_time IS NOT NULL);


--
-- Name: planet_training_pending_end_time_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_training_pending_end_time_idx ON exile_s03.planet_training_pending USING btree (end_time) WHERE (end_time IS NOT NULL);


--
-- Name: planet_training_pending_planetid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX planet_training_pending_planetid_idx ON exile_s03.planet_training_pending USING btree (planetid);


--
-- Name: precise_bbcode_bbcodetag_tag_name_22d3966e_like; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX precise_bbcode_bbcodetag_tag_name_22d3966e_like ON exile_s03.precise_bbcode_bbcodetag USING btree (tag_name varchar_pattern_ops);


--
-- Name: precise_bbcode_smileytag_code_ea9deb44_like; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX precise_bbcode_smileytag_code_ea9deb44_like ON exile_s03.precise_bbcode_smileytag USING btree (code varchar_pattern_ops);


--
-- Name: reports_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX reports_datetime_idx ON exile_s03.reports USING btree (datetime);


--
-- Name: reports_fleetid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX reports_fleetid_idx ON exile_s03.reports USING btree (fleetid) WHERE (fleetid IS NOT NULL);


--
-- Name: reports_merchants_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX reports_merchants_idx ON exile_s03.reports USING btree (ownerid, type, subtype, read_date) WHERE ((ownerid = 3) AND (type = 5) AND (subtype = 1) AND (read_date IS NULL));


--
-- Name: reports_ownerid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX reports_ownerid_idx ON exile_s03.reports USING btree (ownerid);


--
-- Name: reports_type_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX reports_type_idx ON exile_s03.reports USING btree (type);


--
-- Name: researches_pending_end_time; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX researches_pending_end_time ON exile_s03.researches_pending USING btree (end_time);


--
-- Name: researches_pending_researchid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX researches_pending_researchid_fk ON exile_s03.researches_pending USING btree (researchid);


--
-- Name: researches_pending_userid_fk; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX researches_pending_userid_fk ON exile_s03.researches_pending USING btree (userid);


--
-- Name: routes_name_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX routes_name_unique ON exile_s03.routes USING btree (ownerid, upper((name)::text)) WHERE (ownerid IS NOT NULL);


--
-- Name: spy_userid_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX spy_userid_idx ON exile_s03.spy USING btree (userid);


--
-- Name: users_credits_use_userid_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_credits_use_userid_datetime_idx ON exile_s03.users_expenses USING btree (userid, datetime);


--
-- Name: users_deletion_date_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_deletion_date_idx ON exile_s03.users USING btree (deletion_date) WHERE (deletion_date IS NOT NULL);


--
-- Name: users_email_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX users_email_unique ON exile_s03.users USING btree (upper((email)::text)) WHERE (email IS NOT NULL);


--
-- Name: users_isplayer_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_isplayer_idx ON exile_s03.users USING btree (lastlogin) WHERE ((privilege = 0) AND (orientation > 0) AND (planets > 0) AND (credits_bankruptcy > 0));


--
-- Name: users_leave_alliance_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_leave_alliance_datetime_idx ON exile_s03.users USING btree (leave_alliance_datetime) WHERE (leave_alliance_datetime IS NOT NULL);


--
-- Name: users_login_unique; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE UNIQUE INDEX users_login_unique ON exile_s03.users USING btree (upper((login)::text)) WHERE (login IS NOT NULL);


--
-- Name: users_orientation; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_orientation ON exile_s03.users USING btree (orientation);


--
-- Name: users_privilege; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_privilege ON exile_s03.users USING btree (privilege);


--
-- Name: users_regdate; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_regdate ON exile_s03.users USING btree (regdate);


--
-- Name: users_remote_address_history_address_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_remote_address_history_address_idx ON exile_s03.users_connections USING btree (address);


--
-- Name: users_remote_address_history_datetime_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_remote_address_history_datetime_idx ON exile_s03.users_connections USING btree (datetime);


--
-- Name: users_score_next_update_idx; Type: INDEX; Schema: exile_s03; Owner: exileng
--

CREATE INDEX users_score_next_update_idx ON exile_s03.users USING btree (score_next_update) WHERE ((privilege = '-2'::integer) OR (privilege = 0));


--
-- Name: fleets after_fleets_insert_update_check_battle; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_fleets_insert_update_check_battle AFTER INSERT OR DELETE OR UPDATE ON exile_s03.fleets FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_fleets_check_battle();


--
-- Name: fleets_ships after_fleets_ships_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_fleets_ships_changes AFTER INSERT OR DELETE OR UPDATE ON exile_s03.fleets_ships FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_fleets_ships_afterchanges();


--
-- Name: messages after_messages_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_messages_changes AFTER UPDATE ON exile_s03.messages FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_messages_afterchanges();


--
-- Name: nav_planet after_nav_planet_update; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_nav_planet_update AFTER UPDATE ON exile_s03.nav_planet FOR EACH ROW EXECUTE FUNCTION static.sp_nav_planet_afterupdate();


--
-- Name: TRIGGER after_nav_planet_update ON nav_planet; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TRIGGER after_nav_planet_update ON exile_s03.nav_planet IS 'Update planet info, a commander affected on a planet changes the planet production bonus, also check to update research speed if number of scientists changes.';


--
-- Name: planet_buildings after_planet_buildings_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_planet_buildings_changes AFTER INSERT OR DELETE OR UPDATE ON exile_s03.planet_buildings FOR EACH ROW EXECUTE FUNCTION static.sp_planet_buildings_afterchanges();


--
-- Name: TRIGGER after_planet_buildings_changes ON planet_buildings; Type: COMMENT; Schema: exile_s03; Owner: exileng
--

COMMENT ON TRIGGER after_planet_buildings_changes ON exile_s03.planet_buildings IS 'Called after a building has been built or destroyed to update the planet info';


--
-- Name: planet_energy_transfer after_planet_energy_transfer_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_planet_energy_transfer_changes AFTER INSERT OR DELETE OR UPDATE ON exile_s03.planet_energy_transfer FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_energy_transfer_after_changes();


--
-- Name: planet_ships after_planet_ships_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_planet_ships_changes AFTER UPDATE ON exile_s03.planet_ships FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_ships_afterchanges();


--
-- Name: planet_ships_pending after_planet_ships_pending_delete; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_planet_ships_pending_delete AFTER DELETE ON exile_s03.planet_ships_pending FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_ships_pending_afterdelete();


--
-- Name: planet_training_pending after_planet_training_pending_delete; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_planet_training_pending_delete AFTER DELETE ON exile_s03.planet_training_pending FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_training_pending_afterdelete();


--
-- Name: reports after_reports_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_reports_insert AFTER INSERT ON exile_s03.reports FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_reports_after_insert();


--
-- Name: routes_waypoints after_routes_waypoints_append; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_routes_waypoints_append AFTER INSERT ON exile_s03.routes_waypoints FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_routes_waypoints_after_insert();


--
-- Name: users after_user_leave_alliance; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER after_user_leave_alliance AFTER DELETE OR UPDATE ON exile_s03.users FOR EACH ROW EXECUTE FUNCTION static.sp_users_after_leave_alliance();


--
-- Name: alliances_wallet_journal before_alliance_wallet_journal_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_alliance_wallet_journal_insert BEFORE INSERT ON exile_s03.alliances_wallet_journal FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_alliances_wallet_journal_before_insert();


--
-- Name: chat_lines before_chat_lines_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_chat_lines_insert BEFORE INSERT ON exile_s03.chat_lines FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_chat_lines_before_insert();


--
-- Name: fleets_ships before_fleets_ships_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_fleets_ships_insert BEFORE INSERT ON exile_s03.fleets_ships FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_fleets_ships_beforeinsert();


--
-- Name: log_notices before_log_notice_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_log_notice_insert BEFORE INSERT ON exile_s03.log_notices FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_log_notice_before_insert();


--
-- Name: messages_addressee_history before_messages_addressee_history_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_messages_addressee_history_insert BEFORE INSERT ON exile_s03.messages_addressee_history FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_messages_addressee_history_beforeinsert();


--
-- Name: nav_planet before_nav_planet_update; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_nav_planet_update BEFORE UPDATE ON exile_s03.nav_planet FOR EACH ROW EXECUTE FUNCTION static.sp_nav_planet_beforechanges();


--
-- Name: planet_buildings before_planet_buildings_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_planet_buildings_insert BEFORE INSERT ON exile_s03.planet_buildings FOR EACH ROW EXECUTE FUNCTION static.sp_planet_buildings_beforeinsert();


--
-- Name: planet_buildings_pending before_planet_buildings_pending_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_planet_buildings_pending_insert BEFORE INSERT ON exile_s03.planet_buildings_pending FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_buildings_pending_beforeinsert();


--
-- Name: planet_energy_transfer before_planet_energy_transfer_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_planet_energy_transfer_changes BEFORE INSERT OR DELETE OR UPDATE ON exile_s03.planet_energy_transfer FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_energy_transfer_before_changes();


--
-- Name: planet_ships before_planet_ships_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_planet_ships_insert BEFORE INSERT ON exile_s03.planet_ships FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_ships_beforeinsert();


--
-- Name: planet_ships_pending before_planet_ships_pending_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_planet_ships_pending_insert BEFORE INSERT ON exile_s03.planet_ships_pending FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_planet_ships_pending_beforeinsert();


--
-- Name: reports before_reports_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_reports_insert BEFORE INSERT ON exile_s03.reports FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_reports_before_insert();


--
-- Name: researches before_researches_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_researches_insert BEFORE INSERT ON exile_s03.researches FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_researches_beforeinsert();


--
-- Name: researches_pending before_researches_pending_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_researches_pending_insert BEFORE INSERT ON exile_s03.researches_pending FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_researches_pending_beforeinsert();


--
-- Name: users before_user_changes; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_user_changes BEFORE UPDATE ON exile_s03.users FOR EACH ROW EXECUTE FUNCTION static.sp_users_before_changes();


--
-- Name: users before_user_deletion; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_user_deletion BEFORE DELETE ON exile_s03.users FOR EACH ROW EXECUTE FUNCTION static.sp_users_before_deletion();


--
-- Name: users_ships_kills before_users_ships_kills_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER before_users_ships_kills_insert BEFORE INSERT ON exile_s03.users_ships_kills FOR EACH ROW EXECUTE FUNCTION static.sp_users_ships_kills_beforeinsert();


--
-- Name: chat_onlineusers chat_onlineusers_beforeinsert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER chat_onlineusers_beforeinsert BEFORE INSERT ON exile_s03.chat_onlineusers FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_chat_onlineusers_before_insert();


--
-- Name: chat_users chat_users_notifications; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER chat_users_notifications AFTER INSERT OR DELETE ON exile_s03.chat_users FOR EACH ROW EXECUTE FUNCTION exile_s03.notifications_chat_users();


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_before_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER log_multi_simultaneous_warnings_before_insert BEFORE INSERT ON exile_s03.log_multi_simultaneous_warnings FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_log_multi_simultaneous_warnings_before_insert();


--
-- Name: messages messages_notifications; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER messages_notifications AFTER INSERT ON exile_s03.messages FOR EACH ROW EXECUTE FUNCTION exile_s03.notifications_messages();


--
-- Name: reports reports_notifications; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER reports_notifications AFTER INSERT ON exile_s03.reports FOR EACH ROW EXECUTE FUNCTION exile_s03.notifications_reports();


--
-- Name: users_bounty users_bounty_before_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER users_bounty_before_insert BEFORE INSERT ON exile_s03.users_bounty FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_users_bounty_before_insert();


--
-- Name: users_expenses users_expenses_before_insert; Type: TRIGGER; Schema: exile_s03; Owner: exileng
--

CREATE TRIGGER users_expenses_before_insert BEFORE INSERT ON exile_s03.users_expenses FOR EACH ROW EXECUTE FUNCTION exile_s03.sp_users_expenses_before_insert();


--
-- Name: alliances alliances_chatid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances
    ADD CONSTRAINT alliances_chatid_fkey FOREIGN KEY (chatid) REFERENCES exile_s03.chat(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: alliances_invitations alliances_invitations_alliances_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_invitations
    ADD CONSTRAINT alliances_invitations_alliances_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_invitations alliances_invitations_recruiterid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_invitations
    ADD CONSTRAINT alliances_invitations_recruiterid_fkey FOREIGN KEY (recruiterid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: alliances_invitations alliances_invitations_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_invitations
    ADD CONSTRAINT alliances_invitations_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_naps alliances_naps_allianceid1_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps
    ADD CONSTRAINT alliances_naps_allianceid1_fkey FOREIGN KEY (allianceid1) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_naps alliances_naps_allianceid2_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps
    ADD CONSTRAINT alliances_naps_allianceid2_fkey FOREIGN KEY (allianceid2) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_naps_offers alliances_naps_invitations_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps_offers
    ADD CONSTRAINT alliances_naps_invitations_allianceid_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_naps_offers alliances_naps_invitations_recruterid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps_offers
    ADD CONSTRAINT alliances_naps_invitations_recruterid_fkey FOREIGN KEY (recruiterid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: alliances_naps_offers alliances_naps_invitations_targetallianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_naps_offers
    ADD CONSTRAINT alliances_naps_invitations_targetallianceid_fkey FOREIGN KEY (targetallianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_ranks alliances_rank_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_ranks
    ADD CONSTRAINT alliances_rank_allianceid_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_allianceid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_allianceid_fk FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_buildingid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_commanderid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_commanderid_fkey FOREIGN KEY (commanderid) REFERENCES exile_s03.commanders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: alliances_reports alliances_reports_fleetid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_fleetid FOREIGN KEY (fleetid) REFERENCES exile_s03.fleets(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: alliances_reports alliances_reports_invasionid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_invasionid_fk FOREIGN KEY (invasionid) REFERENCES exile_s03.invasions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_ownerallianceid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_ownerallianceid_fk FOREIGN KEY (ownerallianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_researchid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_spyid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_spyid_fk FOREIGN KEY (spyid) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_reports alliances_reports_userid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_reports
    ADD CONSTRAINT alliances_reports_userid_fk FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: alliances_tributes alliances_tributes_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_tributes
    ADD CONSTRAINT alliances_tributes_allianceid_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_tributes alliances_tributes_target_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_tributes
    ADD CONSTRAINT alliances_tributes_target_allianceid_fkey FOREIGN KEY (target_allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_wallet_journal alliances_wallet_journal_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wallet_journal
    ADD CONSTRAINT alliances_wallet_journal_allianceid_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_wallet_requests alliances_wallet_requests_allianceid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wallet_requests
    ADD CONSTRAINT alliances_wallet_requests_allianceid_fkey FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_wallet_requests alliances_wallet_requests_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wallet_requests
    ADD CONSTRAINT alliances_wallet_requests_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_wars alliances_wars_allianceid1_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wars
    ADD CONSTRAINT alliances_wars_allianceid1_fkey FOREIGN KEY (allianceid1) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: alliances_wars alliances_wars_allianceid2_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.alliances_wars
    ADD CONSTRAINT alliances_wars_allianceid2_fkey FOREIGN KEY (allianceid2) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_fleets battles_fleets_battleid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets
    ADD CONSTRAINT battles_fleets_battleid FOREIGN KEY (battleid) REFERENCES exile_s03.battles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_fleets_ships battles_fleets_ships_fleetid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets_ships
    ADD CONSTRAINT battles_fleets_ships_fleetid FOREIGN KEY (fleetid) REFERENCES exile_s03.battles_fleets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_fleets_ships_kills battles_fleets_ships_kills_destroyed_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets_ships_kills
    ADD CONSTRAINT battles_fleets_ships_kills_destroyed_shipid_fk FOREIGN KEY (destroyed_shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: battles_fleets_ships_kills battles_fleets_ships_kills_fleetid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets_ships_kills
    ADD CONSTRAINT battles_fleets_ships_kills_fleetid FOREIGN KEY (fleetid) REFERENCES exile_s03.battles_fleets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_fleets_ships_kills battles_fleets_ships_kills_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets_ships_kills
    ADD CONSTRAINT battles_fleets_ships_kills_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: battles_fleets_ships battles_fleets_ships_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_fleets_ships
    ADD CONSTRAINT battles_fleets_ships_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: battles_relations battles_relations_battleid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_relations
    ADD CONSTRAINT battles_relations_battleid FOREIGN KEY (battleid) REFERENCES exile_s03.battles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_ships battles_ships_battleid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_ships
    ADD CONSTRAINT battles_ships_battleid FOREIGN KEY (battleid) REFERENCES exile_s03.battles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: battles_ships battles_ships_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.battles_ships
    ADD CONSTRAINT battles_ships_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: planet_buildings building_buildingid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings
    ADD CONSTRAINT building_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_lines chat_lines_chatid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_lines
    ADD CONSTRAINT chat_lines_chatid_fkey FOREIGN KEY (chatid) REFERENCES exile_s03.chat(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_onlineusers chat_onlineusers_chatid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_onlineusers
    ADD CONSTRAINT chat_onlineusers_chatid_fkey FOREIGN KEY (chatid) REFERENCES exile_s03.chat(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_onlineusers chat_onlineusers_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_onlineusers
    ADD CONSTRAINT chat_onlineusers_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_users chat_users_channelid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_users
    ADD CONSTRAINT chat_users_channelid_fkey FOREIGN KEY (channelid) REFERENCES exile_s03.chat_channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: chat_users chat_users_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.chat_users
    ADD CONSTRAINT chat_users_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commanders commanders_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.commanders
    ADD CONSTRAINT commanders_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fleets fleets_commanderid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_commanderid_fkey FOREIGN KEY (commanderid) REFERENCES exile_s03.commanders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fleets fleets_dest_planetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_dest_planetid_fkey FOREIGN KEY (dest_planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fleets fleets_next_waypointid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_next_waypointid_fkey FOREIGN KEY (next_waypointid) REFERENCES exile_s03.routes_waypoints(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: fleets fleets_ownerid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_ownerid_fkey FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fleets fleets_planetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets
    ADD CONSTRAINT fleets_planetid_fkey FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: fleets_ships fleets_ships_fleetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.fleets_ships
    ADD CONSTRAINT fleets_ships_fleetid_fkey FOREIGN KEY (fleetid) REFERENCES exile_s03.fleets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: impersonate_impersonationlog impersonate_imperson_impersonating_id_afd114fc_fk_auth_user; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.impersonate_impersonationlog
    ADD CONSTRAINT impersonate_imperson_impersonating_id_afd114fc_fk_auth_user FOREIGN KEY (impersonating_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: impersonate_impersonationlog impersonate_imperson_impersonator_id_1ecfe8ce_fk_auth_user; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.impersonate_impersonationlog
    ADD CONSTRAINT impersonate_imperson_impersonator_id_1ecfe8ce_fk_auth_user FOREIGN KEY (impersonator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_userid1_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_multi_simultaneous_warnings
    ADD CONSTRAINT log_multi_simultaneous_warnings_userid1_fkey FOREIGN KEY (userid1) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_multi_simultaneous_warnings log_multi_simultaneous_warnings_userid2_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_multi_simultaneous_warnings
    ADD CONSTRAINT log_multi_simultaneous_warnings_userid2_fkey FOREIGN KEY (userid2) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_referers_users log_referers_users_refererid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_referers_users
    ADD CONSTRAINT log_referers_users_refererid FOREIGN KEY (refererid) REFERENCES exile_s03.log_referers(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: market_sales market_planetid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.market_sales
    ADD CONSTRAINT market_planetid_fk FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: market_purchases market_purchases_planetid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.market_purchases
    ADD CONSTRAINT market_purchases_planetid_fk FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_addressee_history messages_addressee_history_addresseeid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_addressee_history
    ADD CONSTRAINT messages_addressee_history_addresseeid_fk FOREIGN KEY (addresseeid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_addressee_history messages_addressee_history_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_addressee_history
    ADD CONSTRAINT messages_addressee_history_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_ignore_list messages_ignore_list_ignored_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_ignore_list
    ADD CONSTRAINT messages_ignore_list_ignored_userid_fkey FOREIGN KEY (ignored_userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_ignore_list messages_ignore_list_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages_ignore_list
    ADD CONSTRAINT messages_ignore_list_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages messages_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages
    ADD CONSTRAINT messages_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: messages messages_senderid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.messages
    ADD CONSTRAINT messages_senderid_fk FOREIGN KEY (senderid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: nav_planet nav_planet_commanderid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_planet
    ADD CONSTRAINT nav_planet_commanderid_fkey FOREIGN KEY (commanderid) REFERENCES exile_s03.commanders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: nav_planet nav_planet_galaxy_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_planet
    ADD CONSTRAINT nav_planet_galaxy_fkey FOREIGN KEY (galaxy) REFERENCES exile_s03.nav_galaxies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nav_planet nav_planet_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.nav_planet
    ADD CONSTRAINT nav_planet_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED;


--
-- Name: planet_buildings_pending planet_buildings_pending_buildingid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings_pending
    ADD CONSTRAINT planet_buildings_pending_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_buildings_pending planet_buildings_pending_planetid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings_pending
    ADD CONSTRAINT planet_buildings_pending_planetid_fk FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_ships_pending planet_ships_pending_planetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships_pending
    ADD CONSTRAINT planet_ships_pending_planetid_fkey FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_ships_pending planet_ships_pending_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships_pending
    ADD CONSTRAINT planet_ships_pending_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_ships planet_ships_planetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships
    ADD CONSTRAINT planet_ships_planetid_fkey FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_ships planet_ships_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_ships
    ADD CONSTRAINT planet_ships_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_training_pending planet_training_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_training_pending
    ADD CONSTRAINT planet_training_fkey FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: planet_buildings planetid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.planet_buildings
    ADD CONSTRAINT planetid_fk FOREIGN KEY (planetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_allianceid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_allianceid_fk FOREIGN KEY (allianceid) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_buildingid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_buildingid_fk FOREIGN KEY (buildingid) REFERENCES static.db_buildings(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_commanderid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_commanderid_fkey FOREIGN KEY (commanderid) REFERENCES exile_s03.commanders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reports reports_fleetid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_fleetid FOREIGN KEY (fleetid) REFERENCES exile_s03.fleets(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: reports reports_invasionid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_invasionid_fk FOREIGN KEY (invasionid) REFERENCES exile_s03.invasions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_ownerid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_ownerid_fk FOREIGN KEY (ownerid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_researchid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_spyid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_spyid_fk FOREIGN KEY (spyid) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reports reports_userid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.reports
    ADD CONSTRAINT reports_userid_fk FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: researches_pending researches_pending_researchid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches_pending
    ADD CONSTRAINT researches_pending_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: researches_pending researches_pending_userid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches_pending
    ADD CONSTRAINT researches_pending_userid_fk FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: researches researches_researchid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches
    ADD CONSTRAINT researches_researchid_fk FOREIGN KEY (researchid) REFERENCES static.db_research(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: researches researches_userid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.researches
    ADD CONSTRAINT researches_userid_fk FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: routes_waypoints routes_waypoints_routeid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.routes_waypoints
    ADD CONSTRAINT routes_waypoints_routeid_fkey FOREIGN KEY (routeid) REFERENCES exile_s03.routes(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sessions sessions_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.sessions
    ADD CONSTRAINT sessions_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spy_building spy_building_spy_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_building
    ADD CONSTRAINT spy_building_spy_id_fkey FOREIGN KEY (spy_id) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spy_fleet spy_fleet_spy_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_fleet
    ADD CONSTRAINT spy_fleet_spy_id_fkey FOREIGN KEY (spy_id) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spy_planet spy_planet_spy_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_planet
    ADD CONSTRAINT spy_planet_spy_id_fkey FOREIGN KEY (spy_id) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spy_research spy_research_spy_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy_research
    ADD CONSTRAINT spy_research_spy_id_fkey FOREIGN KEY (spy_id) REFERENCES exile_s03.spy(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: spy spy_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.spy
    ADD CONSTRAINT spy_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_alliance_history users_alliance_history_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_alliance_history
    ADD CONSTRAINT users_alliance_history_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_alliance_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users
    ADD CONSTRAINT users_alliance_id_fkey FOREIGN KEY (alliance_id) REFERENCES exile_s03.alliances(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: users users_alliance_rank_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users
    ADD CONSTRAINT users_alliance_rank_fkey FOREIGN KEY (alliance_id, alliance_rank) REFERENCES exile_s03.alliances_ranks(allianceid, rankid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_bounty users_bounty_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_bounty
    ADD CONSTRAINT users_bounty_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_channels users_channels_channelid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_channels
    ADD CONSTRAINT users_channels_channelid_fkey FOREIGN KEY (channelid) REFERENCES exile_s03.chat_channels(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_channels users_channels_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_channels
    ADD CONSTRAINT users_channels_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_chats users_chats_chatid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_chats
    ADD CONSTRAINT users_chats_chatid_fkey FOREIGN KEY (chatid) REFERENCES exile_s03.chat(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_chats users_chats_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_chats
    ADD CONSTRAINT users_chats_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_expenses users_credits_use_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_expenses
    ADD CONSTRAINT users_credits_use_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_favorite_locations users_favorite_locations_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_favorite_locations
    ADD CONSTRAINT users_favorite_locations_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_holidays users_holidays_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_holidays
    ADD CONSTRAINT users_holidays_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users users_lastplanetid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users
    ADD CONSTRAINT users_lastplanetid_fkey FOREIGN KEY (lastplanetid) REFERENCES exile_s03.nav_planet(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: log_multi_account_warnings users_multi_account_warnings_id_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_multi_account_warnings
    ADD CONSTRAINT users_multi_account_warnings_id_fkey FOREIGN KEY (id) REFERENCES exile_s03.users_connections(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log_multi_account_warnings users_multi_account_warnings_withid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.log_multi_account_warnings
    ADD CONSTRAINT users_multi_account_warnings_withid_fkey FOREIGN KEY (withid) REFERENCES exile_s03.users_connections(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_newemails users_newemails_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_newemails
    ADD CONSTRAINT users_newemails_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_options_history users_options_history_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_options_history
    ADD CONSTRAINT users_options_history_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_connections users_remote_address_history_userid; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_connections
    ADD CONSTRAINT users_remote_address_history_userid FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_reports users_reports_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_reports
    ADD CONSTRAINT users_reports_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_ships_kills users_stats_shipid_fk; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_ships_kills
    ADD CONSTRAINT users_stats_shipid_fk FOREIGN KEY (shipid) REFERENCES static.db_ships(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_ships_kills users_stats_userid_fkey; Type: FK CONSTRAINT; Schema: exile_s03; Owner: exileng
--

ALTER TABLE ONLY exile_s03.users_ships_kills
    ADD CONSTRAINT users_stats_userid_fkey FOREIGN KEY (userid) REFERENCES exile_s03.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
