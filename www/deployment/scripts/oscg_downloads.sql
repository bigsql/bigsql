--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: oscg_downloads; Type: TABLE; Schema: public; Owner: bigsql; Tablespace:
--

CREATE TABLE oscg_downloads (
    download_id integer NOT NULL,
    file_name character varying(128) NOT NULL,
    ip_address character varying(256) NOT NULL,
    download_time timestamp without time zone NOT NULL,
    user_name character varying(64),
    reverse_dns character varying(256),
    update_time timestamp without time zone,
    country_code character varying(2),
    state_region character varying(2),
    city character varying(75)
);


ALTER TABLE oscg_downloads OWNER TO bigsql;

--
-- Name: oscg_downloads_download_id_seq; Type: SEQUENCE; Schema: public; Owner: bigsql
--

CREATE SEQUENCE oscg_downloads_download_id_seq
    START WITH 465202
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oscg_downloads_download_id_seq OWNER TO bigsql;

--
-- Name: oscg_downloads_download_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: bigsql
--

ALTER SEQUENCE oscg_downloads_download_id_seq OWNED BY oscg_downloads.download_id;


--
-- Name: download_id; Type: DEFAULT; Schema: public; Owner: bigsql
--

ALTER TABLE ONLY oscg_downloads ALTER COLUMN download_id SET DEFAULT nextval('oscg_downloads_download_id_seq'::regclass);


--
-- Name: oscg_downloads_pkey; Type: CONSTRAINT; Schema: public; Owner: bigsql; Tablespace:
--

ALTER TABLE ONLY oscg_downloads
    ADD CONSTRAINT oscg_downloads_pkey PRIMARY KEY (download_id);


--
-- PostgreSQL database dump complete
--
