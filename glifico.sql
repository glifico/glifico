--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 10.2

-- Started on 2018-02-15 07:48:59 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 13277)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 188 (class 1259 OID 2850707)
-- Name: agenzia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE agenzia (
    id integer NOT NULL,
    nome character varying(50),
    vat character varying(15) DEFAULT NULL::character varying,
    username character varying(15) NOT NULL,
    password character varying(64),
    email character varying(30),
    street character varying(100),
    number character varying(5),
    citta character varying(50),
    provincia character varying(50),
    cap character varying(5),
    stato character varying(30),
    banca character varying(30),
    pagamento character varying(30),
    iban character varying(34)
);


--
-- TOC entry 187 (class 1259 OID 2850705)
-- Name: agenzia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE agenzia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 187
-- Name: agenzia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE agenzia_id_seq OWNED BY agenzia.id;


--
-- TOC entry 196 (class 1259 OID 3857799)
-- Name: currencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE currencies (
    id integer NOT NULL,
    currency character varying(3),
    conversion numeric,
    description character varying(40)
);


--
-- TOC entry 195 (class 1259 OID 3857797)
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 195
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE currencies_id_seq OWNED BY currencies.id;


--
-- TOC entry 194 (class 1259 OID 3770600)
-- Name: language_pair; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE language_pair (
    username character varying(40),
    from_l character varying(30),
    to_l character varying(30),
    price numeric,
    field character varying(50),
    currency character varying(50),
    price_euro numeric,
    service character varying(30)
);


--
-- TOC entry 191 (class 1259 OID 3065281)
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE languages (
    username character varying(50),
    language text,
    datatest timestamp without time zone,
    tottest integer,
    idlanguageto character varying(2),
    skilltest integer
);


--
-- TOC entry 193 (class 1259 OID 3419737)
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payments (
    id integer NOT NULL,
    job character varying(200),
    price numeric,
    currency character varying(50),
    status character varying(15),
    description character varying(500),
    username character varying(20),
    translated character varying(200),
    translator character varying(200),
    secondtranslator character varying(20),
    document character varying(200),
    preview character varying(200),
    secondstatus character varying(20),
    deadline date,
    CONSTRAINT payments_check CHECK (((translator)::text <> (secondtranslator)::text))
);


--
-- TOC entry 192 (class 1259 OID 3419735)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 192
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- TOC entry 190 (class 1259 OID 2995904)
-- Name: skilltest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skilltest (
    id integer NOT NULL,
    language character varying(255) NOT NULL,
    question character varying(2000) NOT NULL,
    answer1 character varying(255) NOT NULL,
    answer2 character varying(255) NOT NULL,
    answer3 character varying(255) NOT NULL,
    scelta integer NOT NULL
);


--
-- TOC entry 189 (class 1259 OID 2995902)
-- Name: skilltest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE skilltest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 189
-- Name: skilltest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE skilltest_id_seq OWNED BY skilltest.id;


--
-- TOC entry 186 (class 1259 OID 2794053)
-- Name: traduttore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE traduttore (
    id integer NOT NULL,
    nome character varying(100) DEFAULT NULL::character varying,
    cognome character varying(100) DEFAULT NULL::character varying,
    data_nascita date,
    madrelingua character varying(100) DEFAULT NULL::character varying,
    password character varying(64) DEFAULT NULL::character varying,
    has_new_message character varying(1) DEFAULT 'N'::character varying NOT NULL,
    username character varying(30) NOT NULL,
    email character varying(50),
    vat character varying(15),
    citta character varying(30),
    cap character varying(5),
    provincia character varying(30),
    idstato character varying(2),
    madrelinguaid character varying(2),
    stato character varying(30)
);


--
-- TOC entry 185 (class 1259 OID 2794051)
-- Name: traduttore_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE traduttore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 185
-- Name: traduttore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE traduttore_id_seq OWNED BY traduttore.id;


--
-- TOC entry 2934 (class 2604 OID 2850710)
-- Name: agenzia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY agenzia ALTER COLUMN id SET DEFAULT nextval('agenzia_id_seq'::regclass);


--
-- TOC entry 2939 (class 2604 OID 3857802)
-- Name: currencies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY currencies ALTER COLUMN id SET DEFAULT nextval('currencies_id_seq'::regclass);


--
-- TOC entry 2937 (class 2604 OID 3419740)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- TOC entry 2936 (class 2604 OID 2995907)
-- Name: skilltest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY skilltest ALTER COLUMN id SET DEFAULT nextval('skilltest_id_seq'::regclass);


--
-- TOC entry 2928 (class 2604 OID 2794056)
-- Name: traduttore id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY traduttore ALTER COLUMN id SET DEFAULT nextval('traduttore_id_seq'::regclass);


--
-- TOC entry 3075 (class 0 OID 2850707)
-- Dependencies: 188
-- Data for Name: agenzia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY agenzia (id, nome, vat, username, password, email, street, number, citta, provincia, cap, stato, banca, pagamento, iban) FROM stdin;
1	agenzia		agenzia	cbf921b6eb12815a33f74360d66dfef435f1bbbc9e5a5e1f13196db757f8ae57	filippovalle@aim.com	roma	314	Torino	TO	12309	Italy	\N	\N	\N
\.


--
-- TOC entry 3083 (class 0 OID 3857799)
-- Dependencies: 196
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY currencies (id, currency, conversion, description) FROM stdin;
107	BDT	96.48141675	BDT - Bangladeshi Taka
108	BGN	1.95705537	BGN - Bulgarian Lev
109	BHD	0.43889083	BHD - Bahraini Dinar
110	BRL	3.81580489	BRL - Brazilian Real
115	CHF	1.16154512	CHF - Swiss Franc
116	CLP	740.47535827	CLP - Chilean Peso
117	CNY	7.7235862	CNY - Yuan Renminbi
118	COP	3542.93358965	COP - Colombian Peso
119	CZK	25.66627441	CZK - Czech Koruna
120	DKK	7.44231398	DKK - Danish Krone
121	DOP	55.80799254	DOP - Dominican Peso
122	EEK	15.63053861	EEK - Kroon
123	EGP	20.51730164	EGP - Egyptian Pound
167	PKR	122.50961202	PKR - Pakistan Rupee
168	PLN	4.2426867	PLN - Zloty
169	PYG	6558.07969242	PYG - Guarani
170	QAR	4.39892811	QAR - Qatari Rial
171	RON	4.60159648	RON - Romanian New Leu
172	RSD	119.07782827	RSD - Serbian Dinar
173	RUB	67.87130136	RUB - Russian Ruble
174	SAR	4.36754133	SAR - Saudi Riyal
175	SCR	15.54235116	SCR - Seychelles Rupee
176	SEK	9.74918486	SEK - Swedish Krona
177	SGD	1.58708777	SGD - Singapore Dollar
178	THB	38.66638973	THB - Baht
179	TJS	10.25061167	TJS - Somoni
113	BYN	2.00128027	BYN
189	VEF	11.62122801	VEF
191	XAF	655.43516253	XAF
196	ZMW	11.6509379	ZMW
139	JMD	147.08144006	JMD - Jamaican Dollar
140	JOD	0.82430386	JOD - Jordanian Dinar
141	JPY	132.21325513	JPY - Japanese yen
142	KES	120.64546196	KES - Kenyan Shilling
190	VND	26424.40562638	VND - Vietnamese
100	AED	4.27845742	AED - United Arab Emirates dirham
101	AMD	562.00629151	AMD - Armenian Dram
102	ANG	2.07386695	ANG - Netherlands Antillian Guilder
103	AOA	192.35348946	AOA - Kwanza
104	ARS	20.5825469	ARS - Argentine Peso
105	AUD	1.52135983	AUD - Australian Dollar
106	BBD	2.33018758	BBD - Barbados Dollar
111	BSD	1.16509379	BSD - Bahamian Dollar
112	BWP	12.23255272	BWP - Pula
114	CAD	1.5018664	CAD - Canadian Dollar
124	ETB	31.45753233	ETB - Ethiopian Birr
99	EUR	1	EUR - Euro
125	FJD	2.41698707	FJD - Fiji Dollar
126	GBP	0.878327	GBP - Pound Sterling
127	GHS	5.1130141	GHS - Cedi
128	GTQ	8.5552837	GTQ - Quetzal
129	HKD	9.08318686	HKD - Hong Kong Dollar
130	HNL	27.29698241	HNL - Lempira
131	HRK	7.51986604	HRK - Croatian Kuna
132	HUF	311.43857451	HUF - Forint
133	IDR	15802.21051237	IDR - Rupiah
134	ILS	4.09891249	ILS - New Israeli Shekel
135	INR	75.39681513	INR - Indian Rupee
136	IQD	1358.4993592	IQD - Iraqi Dinar
137	IRR	40724.68833741	IRR - Iranian Rial
138	ISK	122.68437609	ISK - Iceland Krona
143	KHR	4698.82325527	KHR - Riel
144	KRW	1301.7408783	KRW - South Korean Won
145	KWD	0.35244087	KWD - Kuwaiti Dinar
146	KZT	390.09670278	KZT - Tenge
147	LAK	9670.27845742	LAK - Kip
148	LBP	1760.45671677	LBP - Lebanese Pound
149	LKR	178.90015146	LKR - Sri Lanka Rupee
150	LTL	3.37993348	LTL - Lithuanian Litas
151	LVL	0.68791574	LVL - Latvian Lats
152	MAD	11.05732261	MAD - Moroccan Dirham
153	MKD	61.24898054	MKD - Denar
154	MMK	1588.02283584	MMK - Kyat
155	MUR	39.78795293	MUR - Mauritius Rupee
156	MXN	22.29595618	MXN - Mexican Peso
157	MYR	4.92790108	MYR - Malaysian Ringgit
158	NAD	16.47093091	NAD - Namibian Dollar
159	NGN	415.93848305	NGN - Naira
160	NOK	9.525421	NOK - Norwegian Krone
161	NZD	1.70176193	NZD - New Zealand Dollar
162	OMR	0.44634743	OMR - Rial Omani
163	PAB	1.16509379	PAB - Balboa
164	PEN	3.78069268	PEN - Nuevo Sol
165	PGK	3.77606897	PGK - Kina
166	PHP	60.10555274	PHP - Philippine Peso
180	TND	2.90551089	TND - Tunisian Dinar
181	TRY	4.41906665	TRY - New Turkish Lira
182	TTD	7.83490621	TTD - Trinidad and Tobago Dollar
183	TWD	35.10814325	TWD - New Taiwan Dollar
184	TZS	2607.47990213	TZS - Tanzanian Shilling
185	UAH	31.30607014	UAH - Hryvnia
186	USD	1.16443258	USD - US Dollar
187	UYU	34.02073867	UYU - Peso Uruguayo
188	UZS	9390.6559478	UZS - Uzbekistan Som
192	XCD	3.14575323	XCD - East Caribbean Dollar
193	XOF	656.00605849	XOF - CFA Franc BCEAO
194	XPF	118.99102878	XPF - CFP franc
195	ZAR	16.44795532	ZAR - South African Rand
\.


--
-- TOC entry 3081 (class 0 OID 3770600)
-- Dependencies: 194
-- Data for Name: language_pair; Type: TABLE DATA; Schema: public; Owner: -
--

COPY language_pair (username, from_l, to_l, price, field, currency, price_euro, service) FROM stdin;
Claudia	Spanish	Italian	0	translation	USD - US Dollar	0	translations
Claudia	Italian	Spanish	0	translation	USD - US Dollar	0	translations
Claudia	Spanish	Portuguese	0	translation	USD - US Dollar	0	translations
Claudia	Portuguese	Spanish	0	translation	USD - US Dollar	0	translations
annabaccenetti	English	Italian	80	translation	EUR - Euro	80	translations
d.fasano5	Russian	Italian	0.1	translation	EUR - Euro	0.1	translations
d.fasano5	English	Italian	0.1	translation	EUR - Euro	0.1	translations
savu.florin@gmail.com	Dutch	Romanian	8	translation	EUR - Euro	8	translations
mmakrai@yahoo.com	English	German	0.08	translation	EUR - Euro	0.08	translations
mariarosaria_leggieri@yahoo.it	English	Italian	0	translation	EUR - Euro	0	translations
Christi	English	Greek	0.07	translation	EUR - Euro	0.07	translations
test	Italian	English	0.001	translation	EUR - Euro	0	
test	French	English	0.004	translation	EUR - Euro	0	
luca	Nepali	Italian	0	translation	EUR - Euro	0	
test	English	Italian	0.001	translation	EUR - Euro	0	
cristina_1987ro	French	Romanian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Portuguese	Romanian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Portuguese	Italian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Portuguese	Spanish	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Portuguese	English	0.1	translation	EUR - Euro	0.1	translations
giuliapiaser	Spanish	Italian	0.06	translation	EUR - Euro	0.06	translations
giuliapiaser	English	Italian	0.06	translation	EUR - Euro	0.06	translations
ValentinaO	English	Italian	0.03	translation	EUR - Euro	0.03	translations
ValentinaO	Spanish	Italian	0.03	translation	EUR - Euro	0.03	translations
ValentinaO	French	Italian	0.03	translation	EUR - Euro	0.03	translations
VL11939	French	Italian	0	translation	EUR - Euro	0	translations
simkovich0811@gmail.com	Hungarian	English	1000	translation	HUF - Forint	3.21	translations
AngleRei	English	Italian	20	translation	EUR - Euro	20	translations
Tony1964	Italian	Spanish	13	translation	EUR - Euro	13	translations
Tony1964	Italian	English	13	translation	EUR - Euro	13	translations
Tony1964	Spanish	Italian	13	translation	EUR - Euro	13	translations
Tony1964	English	Italian	13	translation	EUR - Euro	13	translations
Tony1964	English	Spanish	13	translation	EUR - Euro	13	translations
Tony1964	French	Italian	13	translation	EUR - Euro	13	translations
cristina_1987ro	Catalan	Spanish	0.1	translation	EUR - Euro	0.1	translations
_valentina	English	Italian	12	translation	EUR - Euro	12	translations
luca	English	Italian	2	translation	EUR - Euro	2	
mariarosaria_leggieri@yahoo.it	French	Italian	0	translation	EUR - Euro	0	translations
cristina_1987ro	Catalan	English	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Catalan	Italian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	French	Spanish	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	French	English	0.1	translation	EUR - Euro	0.1	translations
Christi	French	Greek	0.07	translation	EUR - Euro	0.07	translations
Claudia	French	Spanish	0	translation	USD - US Dollar	0	translations
_valentina	Spanish	Italian	12	translation	EUR - Euro	12	translations
juanantcastan@gmail.com	French	Spanish	0.07	translation	EUR - Euro	0.07	translations
sarahtankr@gmail.com	English	Italian	20	translation	EUR - Euro	20	translations
sarahtankr@gmail.com	French	Italian	20	translation	EUR - Euro	20	translations
translatorsitalian	English	Italian	0.07	translation	EUR - Euro	0.07	translations
translatorsitalian	French	Italian	0.07	translation	EUR - Euro	0.07	translations
cristina_1987ro	English	Italian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Romanian	Spanish	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Romanian	Italian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Spanish	Romanian	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Catalan	Romanian	0.1	translation	EUR - Euro	0.1	translations
Christi	Turkish	Greek	0.07	translation	EUR - Euro	0.07	translations
Christi	Italian	Greek	0.07	translation	EUR - Euro	0.07	translations
mmakrai@yahoo.com	English	Croation	0.055	translation	EUR - Euro	0.06	translations
BibianaSalazar	Spanish	English	0	translation	COP - Colombian Peso	0	translations
BekirDiri	Turkish	English	0.07	translation	EUR - Euro	0.07	translations
BibianaSalazar	English	Spanish	0	translation	COP - Colombian Peso	0	translations
jaredfirth	Russian	English	0.12	translation	USD - US Dollar	0.1	translations
TheSirion	English	Portuguese	0.07	translation	USD - US Dollar	0.06	translations
idalconte	English	Italian	500	translation	EUR - Euro	500	translations
idalconte	Italian	English	500	translation	EUR - Euro	500	translations
petersenizza	English	Slovenian	0	translation	EUR - Euro	0	translations
petersenizza	English	Slovenian	0	translation	EUR - Euro	0	translations
Claudia	French	Italian	0	translation	USD - US Dollar	0	translations
petersenizza	English	Italian	0	translation	EUR - Euro	0	translations
petersenizza	Italian	English	0	translation	EUR - Euro	0	translations
gloria_732000@yahoo.it	English	Italian	1	translation	EUR - Euro	1	translations
BekirDiri	English	Turkish	0.06	translation	EUR - Euro	0.06	translations
idalconte	Italian	Russian	500	translation	EUR - Euro	500	translations
bertolinolucrezia@gmail.com	English	Italian	0.01	translation	USD - US Dollar	0.01	translations
juanantcastan@gmail.com	English	Spanish	0.07	translation	EUR - Euro	0.07	translations
cristina_1987ro	Romanian	English	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Spanish	English	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	Spanish	Italian	0.1	translation	EUR - Euro	0.1	translations
Viktorija	Croation	Italian	15	translation	EUR - Euro	15	translations
Viktorija	Italian	Croation	15	translation	EUR - Euro	15	translations
simkovich0811@gmail.com	Hungarian	Ukranian	1000	translation	HUF - Forint	3.21	translations
Claudia	English	Spanish	0	translation	USD - US Dollar	0	translations
Claudia	Portuguese	Italian	0	translation	USD - US Dollar	0	translations
Claudia	Portuguese	French	0	translation	USD - US Dollar	0	translations
savu.florin@gmail.com	Romanian	English	8	translation	EUR - Euro	8	translations
savu.florin@gmail.com	Romanian	English	8	translation	EUR - Euro	8	translations
Claudia	French	Portuguese	0	translation	USD - US Dollar	0	translations
santaseta@hotmail.com	Italian	Turkish	100	translation	TRY - New Turkish Lira	22.63	translations
oljafiore@gmail.com	Italian	Serbian	20	translation	EUR - Euro	20	translations
oljafiore@gmail.com	Portuguese	Serbian	20	translation	EUR - Euro	20	translations
simona	English	Italian	10	translation	EUR - Euro	10	translations
simona	German	Italian	10	translation	EUR - Euro	10	translations
simona	French	Italian	10	translation	EUR - Euro	10	translations
sebastianvargas92@gmail.com	English	Spanish	0.07	translation	USD - US Dollar	0.06	translations
sebastianvargas92@gmail.com	Spanish	English	0.07	translation	USD - US Dollar	0.06	translations
Viktorija	Macedonian	Italian	15	translation	EUR - Euro	15	translations
eespol@yahoo.com	Nepali	English	15	translation	EUR - Euro	15	translations
camilla.musso@gmail.com	English	Italian	0.02	translation	EUR - Euro	0.02	translations
camilla.musso@gmail.com	French	Italian	0.02	translation	EUR - Euro	0.02	translations
camilla.musso@gmail.com	Spanish	Italian	0.02	translation	EUR - Euro	0.02	translations
quistis25@gmail.com	English	Italian	0.06	translation	EUR - Euro	0.06	translations
quistis25@gmail.com	Spanish	Italian	0.05	translation	EUR - Euro	0.05	translations
oljafiore@gmail.com	Serbian	Italian	20	translation	EUR - Euro	20	translations
mchiarasbragaglia@hotmail.it	English	Italian	0.008	translation	EUR - Euro	0.01	translations
AdrianaB	French	Italian	0.05	translation	EUR - Euro	0.05	translations
AdrianaB	English	Italian	0.05	translation	EUR - Euro	0.05	translations
AdrianaB	Spanish	Italian	0.05	translation	EUR - Euro	0.05	translations
Claudia	Spanish	English	0	translation	USD - US Dollar	0	translations
Zsofia Kraus	Hungarian	Turkish	8500	translation	HUF - Forint	27.29	translations
Claudia	English	Italian	0	translation	USD - US Dollar	0	translations
Claudia	Italian	English	0	translation	USD - US Dollar	0	translations
simona	German	English	10	translation	EUR - Euro	10	translations
Viktorija	Italian	Macedonian	15	translation	EUR - Euro	15	translations
Viktorija	Italian	Serbian	15	translation	EUR - Euro	15	translations
Viktorija	Serbian	Italian	15	translation	EUR - Euro	15	translations
Serena	Italian	English	6	translation	EUR - Euro	6	translations
Serena	Italian	French	6	translation	EUR - Euro	6	translations
mchiarasbragaglia@hotmail.it	Spanish	Italian	0.008	translation	EUR - Euro	0.01	translations
Claudia	Italian	Portuguese	0	translation	USD - US Dollar	0	translations
idalconte	Russian	Italian	500	translation	EUR - Euro	500	translations
cristina_1987ro	English	Spanish	0.1	translation	EUR - Euro	0.1	translations
cristina_1987ro	French	Italian	0.1	translation	EUR - Euro	0.1	translations
VL11939	English	Italian	0	translation	EUR - Euro	0	translations
annabaccenetti	French	Italian	80	translation	EUR - Euro	80	translations
Claudia	English	French	0	translation	USD - US Dollar	0	translations
Claudia	French	English	0	translation	USD - US Dollar	0	translations
Claudia	Spanish	French	0	translation	USD - US Dollar	0	translations
Claudia	English	Portuguese	0	translation	USD - US Dollar	0	translations
Viktorija	Italian	Bulgarian	15	translation	EUR - Euro	15	translations
Viktorija	Bulgarian	Italian	15	translation	EUR - Euro	15	translations
sonia.giardini@gmail.com	Japanese	Italian	30	translation	EUR - Euro	30	translations
giorgio	English	Italian	0.01	translation	EUR - EURO	0.01	translations
simkovich0811@gmail.com	Ukranian	Hungarian	1000	translation	HUF - Forint	3.21	translations
simkovich0811@gmail.com	English	Hungarian	1000	translation	HUF - Forint	3.21	translations
Claudia	Portuguese	English	0	translation	USD - US Dollar	0	translations
helga83	English	Hungarian	1	translation	HUF - Forint	0	translations
\.


--
-- TOC entry 3078 (class 0 OID 3065281)
-- Dependencies: 191
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY languages (username, language, datatest, tottest, idlanguageto, skilltest) FROM stdin;
giorgio	Italian	2017-10-12 09:58:17	0	it	0
GiorgioTraduttore	Italian	2017-10-12 09:58:17	0	it	0
luca	English	2017-10-12 09:58:17	0	en	0
GiorgioTraduttore	English	2017-10-12 09:58:17	0	en	0
GiorgioTraduttore	Spanish	2017-10-12 09:58:17	0	es	0
giorgio	English	2017-10-29 16:39:51	1	en	1
luca	Italian	2017-11-04 17:01:41	2	it	2
test	Japanese	2017-10-12 09:58:17	2	jp	2
test	English	2017-10-29 16:38:37	2	en	2
test	French	2017-11-30 06:43:59	\N	\N	2
luca	Nepali	\N	\N	\N	\N
test	Italian	\N	\N	\N	\N
\.


--
-- TOC entry 3080 (class 0 OID 3419737)
-- Dependencies: 193
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY payments (id, job, price, currency, status, description, username, translated, translator, secondtranslator, document, preview, secondstatus, deadline) FROM stdin;
17		1	EUR - EURO	Paid		agenzia	https://cdn.filestackcontent.com/EG5mBCV1QfCetXSI6LPl	luca	\N	https://cdn.filestackcontent.com/S5TtYIMaSPy1SeiuHbMk	https://cdn.filestackcontent.com/tGUSfggTnGW0xVmN7CYX	\N	2018-02-13
15	engl->ital	1	EUR - EURO	Paid	pagato da filippo	agenzia	https://cdn.filestackcontent.com/TYrGb9QlS0KuavfQ2sDt	luca	\N	https://cdn.filestackcontent.com/kYFKpaOHS3mVGoMCk4lv	https://cdn.filestackcontent.com/VV0V49ZARKSYUIhIq5bw	\N	2018-02-12
\.


--
-- TOC entry 3077 (class 0 OID 2995904)
-- Dependencies: 190
-- Data for Name: skilltest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY skilltest (id, language, question, answer1, answer2, answer3, scelta) FROM stdin;
89	English	The Internet giant, Amazon, has put a warning on some of the 'Tom and Jerry' cartoons it offers to its customers. Visitors who want to buy or download the series 'Tom and Jerry: The Complete Second Volume' get a warning that the cartoons contain scenes that are racist. The warning says: "Tom and Jerry shorts may show some ethnic and racial prejudices that were once commonplace in American society." It added that the scenes were wrong when the cartoons were made 70 years ago, and are still wrong today. People say the character of the black maid in the cartoon series is racist. Some of the cartoons were edited in the 1960s because of worries about racism. Tom and Jerry were created in 1940 by cartoonists William Hanna and Joseph Barbera. The cartoons won the Oscar for the best Animated Short Film seven times. The shows have become one of the most popular cartoons in animation history. Many people posted on Twitter to say it was "madness" for Amazon to put a warning on the cartoons.	Based on the text information, Tom and Jerry shows were created to criticize racism	According to the warning of Amazon, the racist scenes are wrong nowadays; however, in the past they were acceptable.	According to the warning of Amazon, racism is no longer a common behavior in America	3
89	English	The Internet giant, Amazon, has put a warning on some of the 'Tom and Jerry' cartoons it offers to its customers. Visitors who want to buy or download the series 'Tom and Jerry: The Complete Second Volume' get a warning that the cartoons contain scenes that are racist. The warning says: "Tom and Jerry shorts may show some ethnic and racial prejudices that were once commonplace in American society." It added that the scenes were wrong when the cartoons were made 70 years ago, and are still wrong today. People say the character of the black maid in the cartoon series is racist. Some of the cartoons were edited in the 1960s because of worries about racism. Tom and Jerry were created in 1940 by cartoonists William Hanna and Joseph Barbera. The cartoons won the Oscar for the best Animated Short Film seven times. The shows have become one of the most popular cartoons in animation history. Many people posted on Twitter to say it was "madness" for Amazon to put a warning on the cartoons.	Based on the text information, Tom and Jerry shows were created to criticize racism	According to the warning of Amazon, the racist scenes are wrong nowadays; however, in the past they were acceptable.	According to the warning of Amazon, racism is no longer a common behavior in America	3
90	English	Dear Sheila, In your last letter, you asked me to tell you about all the things I did during my summer vacation. We went to Vancouver (1) I have some old friends (2) I haven't seen for about three years. My friend Tim, (3) mother I wrote about in my last letter to you, came with me and we had a great time. We flew into Vancouver on Monday 24th, (4) was also my birthday. The first thing we did was to visit the wonderful aquarium in the city center (5) there are three killer whales and a whole crowd of seals, penguins and dolphins. We arrived in the late afternoon (6) all the animals are fed so it was wonderful to see the dolphins leaping out of the water to get the fish (7) they love to eat so much. The following day, (8) was cloudy and rainy unfortunately, we went to a museum (9) they have some dinosaur skeletons (10) local people have found in the area. The horrible weather never improved all day so we visited a superb seafood restaurant later in the afternoon and had an early dinner. The waiters, (11) were all dressed in traditional fishermen's clothes, were very friendly and told us about the history of the restaurant (12) name was The Jolly Whaler. The restaurant, (13) has been open since 1888, was once visited by the American President J.F. Kennedy and his wife Jackie. The skies were blue on Thursday and we spent some time out on the sea in a large boat (14) we hired. I caught a big fish (15) the captain said was the biggest he'd seen this year. I felt very proud! We left on Thursday evening after a mini-vacation (16) helped me to relax a lot and now I have returned to work. The next time (17) you write to me, you must tell me about YOUR last vacation. Bye for now Sheila, Ben.	Numbers 2, 7, 14, 15, 17 don’t need a relative pronoun	Numbers 4, 8, 10, 13, 16, can be completed with the relative pronoun ‘that’.	Numbers 5, 6, 9 can be completed with the relative pronoun ‘where’	1
91	English	The Internet giant, Amazon, has put a warning on some of the 'Tom and Jerry' cartoons it offers to its customers. Visitors who want to buy or download the series 'Tom and Jerry: The Complete Second Volume' get a warning that the cartoons contain scenes that are racist. The warning says: "Tom and Jerry shorts may show some ethnic and racial prejudices that were once commonplace in American society." It added that the scenes were wrong when the cartoons were made 70 years ago, and are still wrong today. People say the character of the black maid in the cartoon series is racist. Some of the cartoons were edited in the 1960s because of worries about racism. Tom and Jerry were created in 1940 by cartoonists William Hanna and Joseph Barbera. The cartoons won the Oscar for the best Animated Short Film seven times. The shows have become one of the most popular cartoons in animation history. Many people posted on Twitter to say it was "madness" for Amazon to put a warning on the cartoons.	Visitors can only download the series “Tom and Jerry” from Amazon	In the sixties the cartoons were revised due to racism issues	Tom and Jerry were created over 20 years before some cartoons were edited due to worries about racism.	2
92	English	Are you looking for a holiday home in Italy? Why not buy a home in the picturesque town of Gangi for one Euro? This offer may seem too good to be true, but there’s a catch: you have to promise to renovate the property within three years and this could cost you €20,000. Gangi’s mayor came up with the idea to put some life back into the Sicilian town. Poverty caused many inhabitants to leave after World War II. The idea is attracting interest from all over the world. Would you buy one of these homes?  These words from the text: picturesque, too good to be true, catch, came up, poverty could be replaced with no change in their meanings for the following words respectively.	pictorial, fabulous, cash, occur, power	pretty, unbelievable, a slight problem, thought of, poor economic conditions.	picture, amazing, drawback, arise, indigence	2
93	English	This year’s edition of the Taxation Trends in the European Union appears at a time of upheaval. The effects of the global economic and fi nancial crisis have hit the European Union (EU) with increasing force from the second half of 2008. Given that the last year for which detailed data are available is 2007, this year´s report cannot yet analyze the consequences of the recession on tax revenues. Nevertheless, the report takes stock of the tax policy measures taken by EU governments in response to the crisis up to spring 2009.	the global economic and financial crisis has impacted on the EU.	the global economic and financial crisis may still hit the European Union	the global economic and financial crisis could have affected the EU	1
94	English	The high EU overall tax ratio is not new, dating back essentially to the last third of the 20th century. In those years, the role of the public sector became more extensive, leading to a strong upward trend in the tax ratio in the 1970s, and to a lesser extent also in the 1980s and early 1990s.	the role played by the public sector lessened	the role played by the public sector diminished	the role played by the public sector widened.	3
95	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Temperatures could be 5°C warmer by the end of the current century	Sea levels are not likely to be higher than today by the end of the century.	50% of the scientists believed humans were the cause of climate change in 1995.	1
96	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Himalayan glaciers will certainly disappear by 2035 because of global warming	The IPCC can now be sure of how climate change will impact different locations	The IPCC made a wrong prediction about the Himalayas in the 2007 report	3
97	English	“In some cultures team members will be highly selfmotivated to carry out their responsibilities without the need for a manager or colleagues to motivate them. In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them.” (Source: DIGNEN, Bob; CHAMBERLAIN, James. Fifty ways to improve your intercultural skills. London: Summertown Publishing, 2009. p. 121)   In the sentence “In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them”, the modal verb ‘may’ indicates:	possibility.	prohibition.	lack of need.	1
99	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless	Type O blood people must eat a lot of meat and avoid milk, yogurt and cheese, for example	Type O blood appeared before the other blood types	Type B diet, which is rich in yogurt, milk, cheese and meat, can cause diabetes	1
101	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless.	He is a Belgium scientist specialized in the area of nutrition.	He wrote a book, has a website and sells diet supplements based on his blood type diet.	e published the findings of his research on blood type diets after an eight-year long trial.	2
10000000	Turkish	Onunla konuşurken sizin tek yapabileceğiniz şey, ona bir uzmana danışması önermenizdir.  Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	konuşurken	danışması	önermenizdir	2
10000180	Spanish	Les daré el dinero ................... vengan; si no, hay dinero que valga.	si	siempre que	salvo si	2
10000001	Turkish	Gazetenin haberinde, Hamaney'in kendisi internet sayfasındaki fetvada, bekar kadın ile erkek arasındaki sohbetin, 'ahlaksızlık' olduğunu gerekçe göstererek, sohbetin derhal yasaklanacağını ifade ettiğine yer verildi.   Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	kendisi	yasaklanacağını	yer verildi	1
10000002	Turkish	Şirket onlarca yıllardır bu sektörde ......	faaliyet gösterir.	faaliyet göstermektedir.	faaliyet halindedir.	2
10000003	Turkish	Mektubu sonlandırırken: Dünya çapında tanınan önemli markalar yaratan ve moda sektöründe dinamizmi ile öne çıkan kuruluşunuzda kariyerime devam etmek istiyor, konu ile ilgili ………………….	haber istiyorum	cevap istiyorum	cevabınızı bekliyorum	3
10000004	Turkish	İnsanda çok keramet vardır; ama düşünce gücü kısıtlanmış, düşüncelerini etrafına iletme fırsatı bulamamış, bu fırsatı elinden alınmış insanda değil.  Bu cümleye anlamca en yakın cümle, aşağı­dakilerden hangisidir?	İnsan fikrine saygı, bilimselliğin en önemli ilkelerindendir	İnsanın yetenek ve yaratıcılığı düşünce özgürlüğü ile ortaya çıkar	İnsanı diğer canlılardan ayıran özelliği düşünme yeteneğidir	2
10000005	Turkish	Aşağıdaki cümlelerin hangisinde anlatım bozukluğu yoktur?	Tırnakları büyüyenler hemen kessinler	Çöllenmeye karşı bir milyon meşe fidanı ekilecekmiş	Ailesinin geçimini sağlamak için çalışıyordu	3
10000006	Turkish	“Konuşur gibi yazanları severim, ötekileri bazen okurum; hoşlandığım da olur.” cümlesindeki anlatım bozukluğu, aşağıdakilerden hangisiyle giderilebilir?	“hoşlandığım” sözcüğünden önce “onlardan” sözcüğü getirilerek	“ötekileri” sözcüğü cümleden çıkarılarak	“severim” sözcüğünden sonra “ama" kelimesi getirilerek	1
10000007	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Hiç kimse beni dilemiyor, herkes başka işlerle meşgul oluyor	Engelli vatandaşlara hem maaş hem de fatura indirimi yapılacak	Adam bizi hiç değilse yola kadar götürebilirdi	2
10000008	Turkish	Bütün insanları dostun bil, kardeşin bil kızım Sevincin ürünüdür insan, nefretin değil kızım Zulmün önünde dimdik tut onurunu Sevginin önünde eğil kızım. Ataol BEHRAMOĞLU  Bu dörtlükte aşağıdakilerden hangisi öğütlenmemektedir?	Fedakârlık yapma	Kardeşlik duygusu	Onurlu davranma	1
10000009	Turkish	Yüksek fiyatlar nedeniyle teklifi……………	inkar ettik	geri çevirdik	attık	2
10000010	Turkish	“Başka ülkelerde de hakemlere saldırılıyor, soyunma odasına kadar kovalanıyor.” cümlesindeki bozukluk aşağıdakilerden hangisi ile giderilebilir?	de” bağlacı cümleden atılarak	İkinci cümleye özne getirilerek	“saldırılıyor” sözü “saldırıyorlar” yapılarak	2
10000011	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Sahildeki çay bahçesine epey zamandır gitmiyormuş	Günümüzde sanat dergileri pek okunmuyor.	Kapıya gelen çocuğun boyu uzun, elbiseleri de düzenli değildi	3
10000012	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	İyi bir şair olabilmek için sürekli şiir yazmak gerektiğini biliyordu	Ülkemizin önde gelen yazarlarıyla dostluğumu sürdürmekteyim	Memduh Şevket de, Sait Faik de ben de insancıl çizgide öyküler yazdım	3
10000013	Turkish	Yoksa bana mı darıldın?” cümlesindeki altı çizili sözcüğün yerine aşağıdakilerden hangisi getirilemez?	küsmek	kırılmak	üzülmek	3
10000014	Turkish	Aşağıdaki cümlelerin hangisindeki ikileme "en faz­la" anlamına gelecek şekilde kullanılmıştır?	Bu cihaz çok çok yüz lira eder	Pazardan ucuz ucuz şeyleri alıp gelmişti	Kendini güzel mi güzel bir kıza kaptırmıştı	1
10000015	Turkish	Projeyi son teslim tarihine…………………… için fazla mesai yapmalıyız	ulaştırmak	yetiştirmek	götürmek	2
10000016	Turkish	Aşağıdaki altı çizili sözcüklerden hangisinin yanlış anlamda kullanılması anlatım bozukluğuna yol açmıştır?	Sigara, kansere yakalanma şansını büyük ölçüde artırır	Hava kirliliğinin bir nedeni de araçlardır	Doğalgaz kullanımı, hava kirliliğini büyük oranda azaltmaktadır	1
10000017	Turkish	‘Üzülerek söylüyoruz ki………..’	teklifinizi kabul edebiliriz	maliyetleri düşüremiyoruz	önerdiğiniz fuara katılacağız	2
10000018	Turkish	………………………………. takdirde, maalesef yasal yollara başvurmamız gerekecek.	Ürünlerin ödemesini yapmadığınız	Ürünleri gönderdiğiniz	Faturayı gönderdiğiniz	1
10000019	Turkish	Sanatın temel konusu insandır, insanla ilgili her şeyi sanatta bulabiliriz. Sanat, toplumun aynası olduğu için, toplumdaki değişmeleri sanatın yansıtması doğaldır. Sanatçıların da toplumla birlikte yaşayışı, duyuşu, düşünüşü de değişir. Bu toplumsal değişim sanatın değişmesine de yol açar.  Bu paragraftan aşağıdaki yargılardan hangisi çıkarılamaz?	Sanat toplumu yansıtır	Sanatçı toplumdan etkilenir	Sanatçı toplumu yönlendirir	3
10000020	Turkish	Toplumsal değerlerin sese bürünmüş şeklidir türküler. Türküler sesimiz, yürek sızılarımızdır. Dilimizin rengi, güzelliği; sözümüzün özüdür. Türküler sinelere hapsedilen aşkların dilidir.  Yukarıdaki parçada türkülerin hangi niteliğine değinilmemiştir?	Sadece ozanlarca bestelendiğine	Dilin güzelliklerini gösterdiğine	Duyguları ifade ettiğine	1
10000021	Turkish	Kırmızı renk, her yere farklı anlamlar yükler. Manavda domates, Adana’da kan kırmızı karpuz, Ereğli’de mis kokulu çilek... Hastanede ameliyathaneye son anda yetiştirilen kan...  Bu parça aşağıdakilerden hangisini anlatmaktadır?	Kırmızı rengin çok sevilmesi	Kırmızı rengin kişilere çağrıştırdıkları	Kırmızı rengin kullanıldığı yerl	2
10000022	Turkish	Anlamsız bir çocukluk ve tatsız bir gençlik, insanı olgunluk çağına erken hazırlar.  Aşağıdakilerden hangisi bu cümlede anlatılanı bütünüyle kapsar?	Olgunluk çağı, çocukluk ve gençlik yıllarının bitimiyle başlar	Tecrübeler, insanı iyi bir biçimde olgunlaştırır	Çocukluk ve gençlik yılları gerektiği gibi yaşanmazsa kişi yaşıtlarından önce olgunlaşır	3
10000023	Turkish	Bir şiirin değeri, söyleyişi ile biçiminin mükem­melliğine bağlıdır.  Aşağıdakilerden hangisi bu cümle ile aynı anlamdadır?	Değerli şiirler, hem biçim hem de söyleyiş bakımından kusursuzdur	Biçimi güzel olan şiirler mükemmeldir	Şiirde zirveyi yakalayabilmek için etkileyi­ci bir söyleyiş oluşturmak gerekir	1
10000024	Turkish	Daha hızlı çalışmalıyız,	programın gerisinde olabiliriz	halbuki programın gerisinde olabiliriz	sonuç olarak programın gerisinde olmalıyız	1
10000025	Turkish	Derin düşünmeyen insan, hiçbir şeyi değişti­remez; hiçbir şeyi değiştirmeden de uygarlık olmaz.  Bu cümleden aşağıdaki yargılardan hangisi çıkarılabilir?	Uygarlık, derin düşünmesini bilen insanlar­la doğmuştur.	Uygarlık, insanların ortak çabalarının ürü­nüdür.	Değişim, insanın doğasında vardır.	1
10000026	Turkish	"İnsanların yükselmesi, gelişme ve medeniyet, yemekle başlamış, yemekle aynı derecede ileri gitmiştir." sözüne hak vermemek mümkün mü?  Yukarıdaki cümlenin konusu nedir?	Yemek kültürünün medeniyetle ilişkisi	Medeniyetin yemek kültürünü etkilemesi	Yemek kültürünün tarihî gelişimi	1
10000027	Turkish	"Akıl tamamlandığında söz noksanlaşır." cümlesinde aşağıdakilerden hangisi anlatılmaktadır?	Akıllı kişiler, az ve öz konuşur	Çok konuşanlar, olgunlaşmamış kişilerdir.	Öz konuşmak, çok okumayı gerektirir.	1
10000028	Turkish	Bir kişi ile sohbet ederken hep .............. söz eder, kendi düşüncelerimizi öne sürersek karşımızdakinin susmasına ve bir süre sonra sohbetin kesilmesine .............."  Bu cümlede boş bırakılan yerlere aşağıdakilerden hangisi getirilirse, cümlenin anlamında bir bozulma olmaz?	kişiliğimizden - katkı sağlarız	başkalarından - neden oluruz	kendimizden - yol açarız	3
10000029	Hungarian	Azóta, ... megismertem, mindig rá gondolok	minthogy	mint	hogy	3
10000030	Hungarian	... fogadjunk, hogy az Internazionale nyeri a mai meccset?	Mihez	Miről	Mibe	3
10000031	Hungarian	. .. ideje, hogy hazamenjünk	Legfőbb	Nagy	Fő	1
10000032	Hungarian	... jössz, szívesen látlak!	Bár	Valaha	Amikor csak	3
10000033	Hungarian	"Jelölje a helyes megoldást! " Szegény, mint ... .	a templom egere	a ma született bárány	aki kettőig sem tud számolni	1
10000034	Hungarian	Nem igazi barát az, aki, ha baj van, ... hagyja a társát.	vajban	cserben	pechben	2
10000035	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Kérem, biztosítsanak nekem lehetőséget arra, hogyan egy személyes találkozás alkalmával mutatkozhassak be Önöknek.	biztosítsanak	hogyan	személyes	3
10000036	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Tárgyalóképes angolnyelv-tudással rendelkezem, írásban és szóban egyaránt, mert a külföldi partnerekkel való kapcsolattartás sem jelent számomra problémát.	angolnyelv-tudással	egyaránt	mert	2
10000037	Hungarian	Az alábbi mondatban melyik szó  helytelen?   A megszerzett tudásomat szívesen kamatoztatnám a JKL Kft.-nél, mert számomra kiemelten fontos az egészséges életmód, ennek megfelelően táplálkozom és az Önök termékeit is rendszeres fogyasztója vagyok.	egészséges	ennek	termékeit	3
10000038	Hungarian	mondattal nem fejezne be egy hivatalos levelet?	Kérem, biztosítsanak nekem lehetőséget arra, hogy egy személyes találkozás alkalmával mutatkozhassak be Önöknek	Bízom benne, hogy lehetőségem nyílik egy személyes találkozás keretében is bemutatkozni Önöknek	Tudom, hogy lehetőségem nyílik majd egy személyes beszélgetésen is meggyőzni Önöket az alkalmasságomról	3
10000039	Hungarian	Az alábbi mondatban melyik szó  helytelen?  Büszke vagyok például arra, hogy az ismert márka a segítséggel lett ismét meghatározó nemcsak a magyar piacon, hanem a környező országok piacán is.	segítséggel	nemcsak	piacán	1
10000040	Hungarian	Mit jelent a megadott szó? \\nESZMÉL\\n	öntudatra ébred	elmélkedik, gondolkodik	eszmerendszerekben gondolkodik	1
10000041	Hungarian	Mit jelent a megadott szó? FATTYÚ	ebadta rossz kölyök	házasságon kívül született gyerek	levágott, megcsonkolt	2
10000042	Hungarian	Mit jelent a megadott szó?   INGÁZIK	bizonytalankodik, ide-oda áll az egymással szemben álló táborokban	munkahelye és lakóhelye között rendszeresen és hosszabb távon utazik	megingat, elbizonytalanít	2
10000043	Hungarian	Mit jelent a megadott szó?   KÖZHASZNÚ	a legtöbb ember által általánosan fogyasztott, vásárolt	a közösség hasznára levő, a társadalom céljait segítő	a nagyközönség által igénybe vett	2
10000044	English	Greater in number or size or amount	major	similar	specific	1
10000045	English	Lower or bend (the head or upper body), as in a nod or bow	conceive	persist	incline	3
10000046	English	Summon into action or bring into existence, often as if by magic	invoke	encounter	pose	1
10000047	English	The loose soft material that makes up a large part of the land surface	port	earth	forest	2
10000048	English	To: All staff From: HR Department  Please remember that your manager must agree any holiday dates before you complete a form.  Why is the HR department sending this email?	to ask staff for some information	to explain how something is done	to tell managers about a problem	2
10000049	English	FINEFOODS  Agent required for nationwide distribution. Some experience in food retail an advantage. Refrigerated van provided.  Finefoods requires an agent to:	own a suitable vehicle for delivery	be a specialist in food distribution.	deliver goods all over the country.	3
10000050	English	"Phone Neil Smith at our showroom for a free quotation, or to arrange a visit from our representative." Contact Neil Smith if you want to	obtain information about the company’s prices.	arrange a visit to the showroom.	speak to a representative about special offers.	1
10000051	English	OFC Co-operative is a supplier of industrial chemicals and, in terms of job applications, it is currently one of the most popular employers in Aveburn. Unlike a number of its competitors, which are currently.................................  at a loss, OFC has reported its most successful year ever, mainly due to a major new contract early in the year	managing	conducting	running	3
10000052	English	The company has plans to expand its core business in the coming year. A key factor in the company’s success has been its wish to create a highly skilled and motivated workforce, as highlighted in its mission..........................	statement	announcement	promise	1
10000053	English	One of Stewart Green’s first actions on becoming the new Managing Director last year was to...........................his employees’ training needs.	assess	value	figure	1
10000054	English	We attribute our success to the dedication and expertise of our workforce, which .........................from six apprentices to permanent employees who are highly qualified and experienced.	ranges	spreads	expands	1
10000055	English	This company actively ......................employees to progress through the company, and many of the current surveyors and site managers launched their careers on the Reid workshop floor.	encourages	supports	promotes	1
10000056	English	At present, our company is.......................... in the refurbishment of a major concert hall in London, with particular responsibility for the stage and acoustic panels.	concerned	involved	committed	2
10000061	Russian	Определите значение иностранного слова: Несессер	чемоданчик для хранения разных мелких вещей	набор принадлежностей для маникюра, шитья в специальном футляре	женская сумочка	1
10000062	Russian	Определите родовую принадлежность существительного: Инкогнито	полный	полная	полное	3
10000063	Russian	Определите родовую принадлежность существительного: Пенальти	точный	точное	точная	2
10000064	Russian	Выберите правильный вариант: Кондуктор Анна вежливо … нас оплатить проезд	попросил	попросила	спросила	2
10000065	Russian	Выберите правильный вариант: Студент решил около … задач.	полтора десятков	полутора десятков	полуторых десятков	2
10000066	Russian	Выберите верный ответ: Орфоэпические нормы –	это правила произношения отдельных звуков, сочетаний звуков, грамматических форм;	это определенные правила образования слов в русском языке	это нормы и правила написания слов и словосочетаний в русском языке	1
10000067	Russian	Определите значение слова: Цельный	состоящий, сделанный из одного куска	неповрежденный, неразрушенный	новый, нетронутый	1
10000068	Russian	12.Выберите верный вариант для дополнения предложения:  Из-за нарушения договоренностей мы вынуждены ...	освободиться от констракта	расторгнуть контракт	закончить контракт	2
10000069	Russian	Выберите верный вариант для дополнения предложения: ... из всех вышеперечисленных пунктов, фирма не согласилась подписать договор.	выходя	исходя	проходя	2
10000070	Russian	Вставьте в предложение подходящее по смыслу слово:  Мы живем в одном доме, но на … этажах.	различных	других	разных	3
10000071	Russian	Вставьте в предложение подходящее по смыслу слово: В лифт 8-этажного дома на первом этаже  ...  5 человек.	вошли	зашли	вошло	1
10000072	Russian	Определите значение иностранного слова: Дефолт	отказ от выполнения финансовых обязательств	ликвидация промышленного предприятия	банкрот	1
10000073	Russian	Укажите правильный вариант: Нам не хватает ... для покупки этого товара.	шестиста рублей	шестьсот рублей	шестисот рублей	3
10000074	Russian	Выберите правильный вариант: Страна находится ... реформ.	в преддверии	в преддверьи	в преддверие	1
10000075	Russian	Расставьте запятые в предложении: Если человек видит смысл жизни в зарабатывании денег (1) ему бывает довольно затруднительно поверить в то (2) что можно (3) действительно (4) быть счастливым (5) занимаясь (6) творчеством (7) даже (8) если ты не получаешь за это ни рубля.	1, 2, 3, 5, 7, 8	1, 2, 3, 4, 5, 7	1, 2, 5, 6, 7, 8	3
10000076	Russian	Расставьте запятые в предложении: Крупнейшие банки имеют значительный вес в своих странах (1) составляя стержень экономической и политической силы великих наций (2) и (3) простирая свои производственные и сервисные сети по всему миру (4)приобретают транснациональный характер.	1, 2, 3, 4	1, 4	2, 3, 4	2
10000077	Russian	Выберите правильный вариант: ... – это дерево или кустарник из семейства кипарисовых	мозжевельник	можевельник	можжевельник	3
10000078	Russian	Выберите правильный вариант: Самая ... актриса Линдси Лохан.	веснусчатая	веснушчатая	веснушчетая	2
10000079	Russian	Выберите правильный вариант: Бабушка ... с ветчиной.	потчевала винигретом	потчевала винегретом	подчевала винигретом	2
10000080	Russian	Выберите правильный вариант: Приятно петь под ... фортепьяно.	аккомпанимент	аккомпанемент	акомпанемент	2
10000081	Russian	Выберите правильный вариант: Существует миф, что «те, кто умеют играть на пианино, с лёгкостью научатся играть на ...»	аккардеоне	акордеоне	аккордеоне	3
10000082	Russian	В каком варианте ответа выделенное слово употреблено неверно?	Используя специальные термометры, океанологи производят измерения на различных глубинах океана по всей его ВОДЯНОЙ поверхности.	Для возвышенностей с твёрдыми, нерастворимыми породами типична БОЛОТИСТАЯ местность.	Наполеон проявил ОСОБОЕ уважение к Сперанскому, подарив ему табакерку с собственным портретом.	1
10000083	Russian	Укажите предложение, в котором есть страдательное причастие прошедшего времени. (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	5	2	3	3
10000003	Turkish	Mektubu sonlandırırken: Dünya çapında tanınan önemli markalar yaratan ve moda sektöründe dinamizmi ile öne çıkan kuruluşunuzda kariyerime devam etmek istiyor, konu ile ilgili ………………….	haber istiyorum	cevap istiyorum	cevabınızı bekliyorum	3
10000084	Russian	В каком предложении НЕ со словом пишется раздельно?	(Не)сколькими годами позже в Петербург переехал Виссарион Белинский.	Теперь он пришел к убеждению, что изящная словесность должна (не)посредственно способствовать улучшению жизни.	Критик призывал изображать повседневное существование (не)романтических влюбленных, а обычных людей.	3
10000085	Russian	Какое из приведённых ниже слов (сочетаний слов) должно быть на месте пропуска в шестом предложении?  (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	Поэтому	Впрочем	Например	1
10000086	Russian	Укажите предложение, в котором нужно поставить одну запятую. (Знаки препинания не расставлены)	Он жил одиноко и замкнуто и тосковал днем и ночью.	Гости выпили еще по стакану встали из-за стола и простились с Пугачевым.	Гром уже грохотал и впереди и справа и слева.	2
10000087	Russian	Выберите верный вариант для дополнения предложения: Точное время мероприятия требует ...	уточнения	уточнить	для уточнения	1
10000088	Russian	Определите значение слова: Рекламация – это	объявление, служащее средством привлечения внимания покупателей	официальная  претензия к качеству товара	маркетинговая стратегия	2
10000089	Russian	Укажите, к какому стилю относится текст: Ветер – это движение воздушных масс над поверхностью Земли. Движение воздуха от Земли называется восходящим потоком, а движение вниз – нисходящим. Ветер – это один из важнейших элементов природы. Его название зависит от стороны света. Например, ветер, дующий с юга на север, называется южным, а с северо-запада на юго-восток – северо-западный ветер.	научный	публицистический	официально-деловой	1
10000090	Russian	Выберите верный вариант для дополнения предложения: Вопиющая безграмотность вчерашних школьников заставила задуматься не только филологов, но и тех, … родной язык.	кто любит	что любят	кто любят	1
10000091	Ukranian	Апостроф треба писати на місці обох пропусків у рядку:	досвідчений різьб..яр, високий бур..ян	велике сузір..я, роз..ятрена рана	очікувана прем..єра, духм..яна страва	2
10000092	Ukranian	Немає лексичної помилки в рядку	погляди співпадають	багаточисельні дзвінки	наступного разу	3
10000093	Ukranian	Неправильно вжито прийменник у словосполученні	вишивати по шовку	зустрітися по обіді	зайти по неуважності	3
10000094	Ukranian	Потрібно поставити у на місці всіх пропусків у рядку	гуляв ... лісі, улюблений ..читель, блиск ... очах	було ... Києві, лежала ... шухляді, плавала ... воді	бути ... формі, осінь ... Каневі, допоможе ..війти	3
10000095	Ukranian	Правильно написано всі слова в рядку	тріснути, тиждневик, контрастний	рідкісний, ненависний, захистний	форпостний, пісний, кількісний	3
10000096	Ukranian	НЕПРАВИЛЬНО оформлено пряму мову в рядку	«Митець не може відвернутися від своєї сучасності, – говорив Альбер Камю і далі пояснював: «Якби він відвернувся від неї, то промовляв би в порожнечу».	Український письменник В. Винниченко якось сказав: «Як нудно, сіро проходить життя людей неталановитих, так нудно й нецікаво живуть без любові навіть талановиті».	«Слово – найтонше доторкання до серця, – був переконаний В. Сухомлинський, – воно може стати і запашною квіткою, і живою водою, і розжареним залізом».	1
10000097	Ukranian	Синонімічним до простого речення «У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне для досягнення особистістю успіху» є складнопідрядне речення	У сучасному світі вивчати мови міжнародного спілкування вкрай потрібно, тому що так особистість може досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне, щоб особистість могла досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне через те, що так особистість може досягти успіху.	2
10000001	Turkish	Gazetenin haberinde, Hamaney'in kendisi internet sayfasındaki fetvada, bekar kadın ile erkek arasındaki sohbetin, 'ahlaksızlık' olduğunu gerekçe göstererek, sohbetin derhal yasaklanacağını ifade ettiğine yer verildi.   Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	kendisi	yasaklanacağını	yer verildi	1
10000098	Ukranian	Кому (коми) треба ставити в реченні (розділові знаки пропущено)	А тим часом місяць пливе оглядать небо й зорі та землю й море.	У моїй душі бриніли людські голоси і ні вдень ні вночі не давали спокою.	Жовтороте ластів’ятко силилося вилетіти з гнізда та ще не змогло.	3
10000099	Ukranian	Двокрапку треба поставити, якщо до частини «Люблю теплу весняну пору…» додати фрагмент рядка	... коли з-під снігу виглядають перші блакитні проліски.	... кидаю всі невідкладні справи та йду в поля далекі.	... у цей час народжуються нові потаємні мрії та сподівання.	3
10000100	Ukranian	В якому реченні допущено пунктуаційну помилку?  (1) Холодні осінні тумани клубочаться вгорі і спускають на землю мокрі коси. (2) Пливе в сірі безвісті нудьга, пливе відчай, і стиха хлипає сум. (3) Плачуть голі дерева, плачуть солом’яні стріхи, умивається сльозами вбога земля і не знає, коли усміхнеться. (4) Міріади дрібних крапель спадають додолу, і пливуть, змішані з землею, брудними потоками.	другому	третьому	четвертому	3
10000101	Ukranian	Антонімічну пару вжито в прислів’ї:	Рідня до півдня, а як сонце зайде – ніхто не знайде.	Діти – як квіти: поливай, то ростимуть.	Малі діти – малий клопіт, а підростуть – буде великий.	3
90	English	Dear Sheila, In your last letter, you asked me to tell you about all the things I did during my summer vacation. We went to Vancouver (1) I have some old friends (2) I haven't seen for about three years. My friend Tim, (3) mother I wrote about in my last letter to you, came with me and we had a great time. We flew into Vancouver on Monday 24th, (4) was also my birthday. The first thing we did was to visit the wonderful aquarium in the city center (5) there are three killer whales and a whole crowd of seals, penguins and dolphins. We arrived in the late afternoon (6) all the animals are fed so it was wonderful to see the dolphins leaping out of the water to get the fish (7) they love to eat so much. The following day, (8) was cloudy and rainy unfortunately, we went to a museum (9) they have some dinosaur skeletons (10) local people have found in the area. The horrible weather never improved all day so we visited a superb seafood restaurant later in the afternoon and had an early dinner. The waiters, (11) were all dressed in traditional fishermen's clothes, were very friendly and told us about the history of the restaurant (12) name was The Jolly Whaler. The restaurant, (13) has been open since 1888, was once visited by the American President J.F. Kennedy and his wife Jackie. The skies were blue on Thursday and we spent some time out on the sea in a large boat (14) we hired. I caught a big fish (15) the captain said was the biggest he'd seen this year. I felt very proud! We left on Thursday evening after a mini-vacation (16) helped me to relax a lot and now I have returned to work. The next time (17) you write to me, you must tell me about YOUR last vacation. Bye for now Sheila, Ben.	Numbers 2, 7, 14, 15, 17 don’t need a relative pronoun	Numbers 4, 8, 10, 13, 16, can be completed with the relative pronoun ‘that’.	Numbers 5, 6, 9 can be completed with the relative pronoun ‘where’	1
91	English	The Internet giant, Amazon, has put a warning on some of the 'Tom and Jerry' cartoons it offers to its customers. Visitors who want to buy or download the series 'Tom and Jerry: The Complete Second Volume' get a warning that the cartoons contain scenes that are racist. The warning says: "Tom and Jerry shorts may show some ethnic and racial prejudices that were once commonplace in American society." It added that the scenes were wrong when the cartoons were made 70 years ago, and are still wrong today. People say the character of the black maid in the cartoon series is racist. Some of the cartoons were edited in the 1960s because of worries about racism. Tom and Jerry were created in 1940 by cartoonists William Hanna and Joseph Barbera. The cartoons won the Oscar for the best Animated Short Film seven times. The shows have become one of the most popular cartoons in animation history. Many people posted on Twitter to say it was "madness" for Amazon to put a warning on the cartoons.	Visitors can only download the series “Tom and Jerry” from Amazon	In the sixties the cartoons were revised due to racism issues	Tom and Jerry were created over 20 years before some cartoons were edited due to worries about racism.	2
92	English	Are you looking for a holiday home in Italy? Why not buy a home in the picturesque town of Gangi for one Euro? This offer may seem too good to be true, but there’s a catch: you have to promise to renovate the property within three years and this could cost you €20,000. Gangi’s mayor came up with the idea to put some life back into the Sicilian town. Poverty caused many inhabitants to leave after World War II. The idea is attracting interest from all over the world. Would you buy one of these homes?  These words from the text: picturesque, too good to be true, catch, came up, poverty could be replaced with no change in their meanings for the following words respectively.	pictorial, fabulous, cash, occur, power	pretty, unbelievable, a slight problem, thought of, poor economic conditions.	picture, amazing, drawback, arise, indigence	2
93	English	This year’s edition of the Taxation Trends in the European Union appears at a time of upheaval. The effects of the global economic and fi nancial crisis have hit the European Union (EU) with increasing force from the second half of 2008. Given that the last year for which detailed data are available is 2007, this year´s report cannot yet analyze the consequences of the recession on tax revenues. Nevertheless, the report takes stock of the tax policy measures taken by EU governments in response to the crisis up to spring 2009.	the global economic and financial crisis has impacted on the EU.	the global economic and financial crisis may still hit the European Union	the global economic and financial crisis could have affected the EU	1
94	English	The high EU overall tax ratio is not new, dating back essentially to the last third of the 20th century. In those years, the role of the public sector became more extensive, leading to a strong upward trend in the tax ratio in the 1970s, and to a lesser extent also in the 1980s and early 1990s.	the role played by the public sector lessened	the role played by the public sector diminished	the role played by the public sector widened.	3
10000002	Turkish	Şirket onlarca yıllardır bu sektörde ......	faaliyet gösterir.	faaliyet göstermektedir.	faaliyet halindedir.	2
10000065	Russian	Выберите правильный вариант: Студент решил около … задач.	полтора десятков	полутора десятков	полуторых десятков	2
95	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Temperatures could be 5°C warmer by the end of the current century	Sea levels are not likely to be higher than today by the end of the century.	50% of the scientists believed humans were the cause of climate change in 1995.	1
96	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Himalayan glaciers will certainly disappear by 2035 because of global warming	The IPCC can now be sure of how climate change will impact different locations	The IPCC made a wrong prediction about the Himalayas in the 2007 report	3
97	English	“In some cultures team members will be highly selfmotivated to carry out their responsibilities without the need for a manager or colleagues to motivate them. In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them.” (Source: DIGNEN, Bob; CHAMBERLAIN, James. Fifty ways to improve your intercultural skills. London: Summertown Publishing, 2009. p. 121)   In the sentence “In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them”, the modal verb ‘may’ indicates:	possibility.	prohibition.	lack of need.	1
99	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless	Type O blood people must eat a lot of meat and avoid milk, yogurt and cheese, for example	Type O blood appeared before the other blood types	Type B diet, which is rich in yogurt, milk, cheese and meat, can cause diabetes	1
101	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless.	He is a Belgium scientist specialized in the area of nutrition.	He wrote a book, has a website and sells diet supplements based on his blood type diet.	e published the findings of his research on blood type diets after an eight-year long trial.	2
10000000	Turkish	Onunla konuşurken sizin tek yapabileceğiniz şey, ona bir uzmana danışması önermenizdir.  Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	konuşurken	danışması	önermenizdir	2
10000234	Italian	Mentre eravamo in spiaggia ...........  è scoppiato un temporale.	infine	già	all'improvviso	3
10000004	Turkish	İnsanda çok keramet vardır; ama düşünce gücü kısıtlanmış, düşüncelerini etrafına iletme fırsatı bulamamış, bu fırsatı elinden alınmış insanda değil.  Bu cümleye anlamca en yakın cümle, aşağı­dakilerden hangisidir?	İnsan fikrine saygı, bilimselliğin en önemli ilkelerindendir	İnsanın yetenek ve yaratıcılığı düşünce özgürlüğü ile ortaya çıkar	İnsanı diğer canlılardan ayıran özelliği düşünme yeteneğidir	2
10000005	Turkish	Aşağıdaki cümlelerin hangisinde anlatım bozukluğu yoktur?	Tırnakları büyüyenler hemen kessinler	Çöllenmeye karşı bir milyon meşe fidanı ekilecekmiş	Ailesinin geçimini sağlamak için çalışıyordu	3
10000006	Turkish	“Konuşur gibi yazanları severim, ötekileri bazen okurum; hoşlandığım da olur.” cümlesindeki anlatım bozukluğu, aşağıdakilerden hangisiyle giderilebilir?	“hoşlandığım” sözcüğünden önce “onlardan” sözcüğü getirilerek	“ötekileri” sözcüğü cümleden çıkarılarak	“severim” sözcüğünden sonra “ama" kelimesi getirilerek	1
10000007	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Hiç kimse beni dilemiyor, herkes başka işlerle meşgul oluyor	Engelli vatandaşlara hem maaş hem de fatura indirimi yapılacak	Adam bizi hiç değilse yola kadar götürebilirdi	2
10000008	Turkish	Bütün insanları dostun bil, kardeşin bil kızım Sevincin ürünüdür insan, nefretin değil kızım Zulmün önünde dimdik tut onurunu Sevginin önünde eğil kızım. Ataol BEHRAMOĞLU  Bu dörtlükte aşağıdakilerden hangisi öğütlenmemektedir?	Fedakârlık yapma	Kardeşlik duygusu	Onurlu davranma	1
10000009	Turkish	Yüksek fiyatlar nedeniyle teklifi……………	inkar ettik	geri çevirdik	attık	2
10000010	Turkish	“Başka ülkelerde de hakemlere saldırılıyor, soyunma odasına kadar kovalanıyor.” cümlesindeki bozukluk aşağıdakilerden hangisi ile giderilebilir?	de” bağlacı cümleden atılarak	İkinci cümleye özne getirilerek	“saldırılıyor” sözü “saldırıyorlar” yapılarak	2
10000011	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Sahildeki çay bahçesine epey zamandır gitmiyormuş	Günümüzde sanat dergileri pek okunmuyor.	Kapıya gelen çocuğun boyu uzun, elbiseleri de düzenli değildi	3
10000012	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	İyi bir şair olabilmek için sürekli şiir yazmak gerektiğini biliyordu	Ülkemizin önde gelen yazarlarıyla dostluğumu sürdürmekteyim	Memduh Şevket de, Sait Faik de ben de insancıl çizgide öyküler yazdım	3
10000013	Turkish	Yoksa bana mı darıldın?” cümlesindeki altı çizili sözcüğün yerine aşağıdakilerden hangisi getirilemez?	küsmek	kırılmak	üzülmek	3
10000014	Turkish	Aşağıdaki cümlelerin hangisindeki ikileme "en faz­la" anlamına gelecek şekilde kullanılmıştır?	Bu cihaz çok çok yüz lira eder	Pazardan ucuz ucuz şeyleri alıp gelmişti	Kendini güzel mi güzel bir kıza kaptırmıştı	1
10000015	Turkish	Projeyi son teslim tarihine…………………… için fazla mesai yapmalıyız	ulaştırmak	yetiştirmek	götürmek	2
10000016	Turkish	Aşağıdaki altı çizili sözcüklerden hangisinin yanlış anlamda kullanılması anlatım bozukluğuna yol açmıştır?	Sigara, kansere yakalanma şansını büyük ölçüde artırır	Hava kirliliğinin bir nedeni de araçlardır	Doğalgaz kullanımı, hava kirliliğini büyük oranda azaltmaktadır	1
10000017	Turkish	‘Üzülerek söylüyoruz ki………..’	teklifinizi kabul edebiliriz	maliyetleri düşüremiyoruz	önerdiğiniz fuara katılacağız	2
10000018	Turkish	………………………………. takdirde, maalesef yasal yollara başvurmamız gerekecek.	Ürünlerin ödemesini yapmadığınız	Ürünleri gönderdiğiniz	Faturayı gönderdiğiniz	1
10000019	Turkish	Sanatın temel konusu insandır, insanla ilgili her şeyi sanatta bulabiliriz. Sanat, toplumun aynası olduğu için, toplumdaki değişmeleri sanatın yansıtması doğaldır. Sanatçıların da toplumla birlikte yaşayışı, duyuşu, düşünüşü de değişir. Bu toplumsal değişim sanatın değişmesine de yol açar.  Bu paragraftan aşağıdaki yargılardan hangisi çıkarılamaz?	Sanat toplumu yansıtır	Sanatçı toplumdan etkilenir	Sanatçı toplumu yönlendirir	3
10000020	Turkish	Toplumsal değerlerin sese bürünmüş şeklidir türküler. Türküler sesimiz, yürek sızılarımızdır. Dilimizin rengi, güzelliği; sözümüzün özüdür. Türküler sinelere hapsedilen aşkların dilidir.  Yukarıdaki parçada türkülerin hangi niteliğine değinilmemiştir?	Sadece ozanlarca bestelendiğine	Dilin güzelliklerini gösterdiğine	Duyguları ifade ettiğine	1
10000021	Turkish	Kırmızı renk, her yere farklı anlamlar yükler. Manavda domates, Adana’da kan kırmızı karpuz, Ereğli’de mis kokulu çilek... Hastanede ameliyathaneye son anda yetiştirilen kan...  Bu parça aşağıdakilerden hangisini anlatmaktadır?	Kırmızı rengin çok sevilmesi	Kırmızı rengin kişilere çağrıştırdıkları	Kırmızı rengin kullanıldığı yerl	2
10000022	Turkish	Anlamsız bir çocukluk ve tatsız bir gençlik, insanı olgunluk çağına erken hazırlar.  Aşağıdakilerden hangisi bu cümlede anlatılanı bütünüyle kapsar?	Olgunluk çağı, çocukluk ve gençlik yıllarının bitimiyle başlar	Tecrübeler, insanı iyi bir biçimde olgunlaştırır	Çocukluk ve gençlik yılları gerektiği gibi yaşanmazsa kişi yaşıtlarından önce olgunlaşır	3
10000023	Turkish	Bir şiirin değeri, söyleyişi ile biçiminin mükem­melliğine bağlıdır.  Aşağıdakilerden hangisi bu cümle ile aynı anlamdadır?	Değerli şiirler, hem biçim hem de söyleyiş bakımından kusursuzdur	Biçimi güzel olan şiirler mükemmeldir	Şiirde zirveyi yakalayabilmek için etkileyi­ci bir söyleyiş oluşturmak gerekir	1
10000024	Turkish	Daha hızlı çalışmalıyız,	programın gerisinde olabiliriz	halbuki programın gerisinde olabiliriz	sonuç olarak programın gerisinde olmalıyız	1
10000025	Turkish	Derin düşünmeyen insan, hiçbir şeyi değişti­remez; hiçbir şeyi değiştirmeden de uygarlık olmaz.  Bu cümleden aşağıdaki yargılardan hangisi çıkarılabilir?	Uygarlık, derin düşünmesini bilen insanlar­la doğmuştur.	Uygarlık, insanların ortak çabalarının ürü­nüdür.	Değişim, insanın doğasında vardır.	1
10000026	Turkish	"İnsanların yükselmesi, gelişme ve medeniyet, yemekle başlamış, yemekle aynı derecede ileri gitmiştir." sözüne hak vermemek mümkün mü?  Yukarıdaki cümlenin konusu nedir?	Yemek kültürünün medeniyetle ilişkisi	Medeniyetin yemek kültürünü etkilemesi	Yemek kültürünün tarihî gelişimi	1
10000027	Turkish	"Akıl tamamlandığında söz noksanlaşır." cümlesinde aşağıdakilerden hangisi anlatılmaktadır?	Akıllı kişiler, az ve öz konuşur	Çok konuşanlar, olgunlaşmamış kişilerdir.	Öz konuşmak, çok okumayı gerektirir.	1
10000005	Turkish	Aşağıdaki cümlelerin hangisinde anlatım bozukluğu yoktur?	Tırnakları büyüyenler hemen kessinler	Çöllenmeye karşı bir milyon meşe fidanı ekilecekmiş	Ailesinin geçimini sağlamak için çalışıyordu	3
10000028	Turkish	Bir kişi ile sohbet ederken hep .............. söz eder, kendi düşüncelerimizi öne sürersek karşımızdakinin susmasına ve bir süre sonra sohbetin kesilmesine .............."  Bu cümlede boş bırakılan yerlere aşağıdakilerden hangisi getirilirse, cümlenin anlamında bir bozulma olmaz?	kişiliğimizden - katkı sağlarız	başkalarından - neden oluruz	kendimizden - yol açarız	3
10000029	Hungarian	Azóta, ... megismertem, mindig rá gondolok	minthogy	mint	hogy	3
10000030	Hungarian	... fogadjunk, hogy az Internazionale nyeri a mai meccset?	Mihez	Miről	Mibe	3
10000031	Hungarian	. .. ideje, hogy hazamenjünk	Legfőbb	Nagy	Fő	1
10000032	Hungarian	... jössz, szívesen látlak!	Bár	Valaha	Amikor csak	3
10000033	Hungarian	"Jelölje a helyes megoldást! " Szegény, mint ... .	a templom egere	a ma született bárány	aki kettőig sem tud számolni	1
10000034	Hungarian	Nem igazi barát az, aki, ha baj van, ... hagyja a társát.	vajban	cserben	pechben	2
10000035	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Kérem, biztosítsanak nekem lehetőséget arra, hogyan egy személyes találkozás alkalmával mutatkozhassak be Önöknek.	biztosítsanak	hogyan	személyes	3
10000036	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Tárgyalóképes angolnyelv-tudással rendelkezem, írásban és szóban egyaránt, mert a külföldi partnerekkel való kapcsolattartás sem jelent számomra problémát.	angolnyelv-tudással	egyaránt	mert	2
10000037	Hungarian	Az alábbi mondatban melyik szó  helytelen?   A megszerzett tudásomat szívesen kamatoztatnám a JKL Kft.-nél, mert számomra kiemelten fontos az egészséges életmód, ennek megfelelően táplálkozom és az Önök termékeit is rendszeres fogyasztója vagyok.	egészséges	ennek	termékeit	3
10000038	Hungarian	mondattal nem fejezne be egy hivatalos levelet?	Kérem, biztosítsanak nekem lehetőséget arra, hogy egy személyes találkozás alkalmával mutatkozhassak be Önöknek	Bízom benne, hogy lehetőségem nyílik egy személyes találkozás keretében is bemutatkozni Önöknek	Tudom, hogy lehetőségem nyílik majd egy személyes beszélgetésen is meggyőzni Önöket az alkalmasságomról	3
10000039	Hungarian	Az alábbi mondatban melyik szó  helytelen?  Büszke vagyok például arra, hogy az ismert márka a segítséggel lett ismét meghatározó nemcsak a magyar piacon, hanem a környező országok piacán is.	segítséggel	nemcsak	piacán	1
10000040	Hungarian	Mit jelent a megadott szó? \\nESZMÉL\\n	öntudatra ébred	elmélkedik, gondolkodik	eszmerendszerekben gondolkodik	1
10000041	Hungarian	Mit jelent a megadott szó? FATTYÚ	ebadta rossz kölyök	házasságon kívül született gyerek	levágott, megcsonkolt	2
10000042	Hungarian	Mit jelent a megadott szó?   INGÁZIK	bizonytalankodik, ide-oda áll az egymással szemben álló táborokban	munkahelye és lakóhelye között rendszeresen és hosszabb távon utazik	megingat, elbizonytalanít	2
10000043	Hungarian	Mit jelent a megadott szó?   KÖZHASZNÚ	a legtöbb ember által általánosan fogyasztott, vásárolt	a közösség hasznára levő, a társadalom céljait segítő	a nagyközönség által igénybe vett	2
10000044	English	Greater in number or size or amount	major	similar	specific	1
10000045	English	Lower or bend (the head or upper body), as in a nod or bow	conceive	persist	incline	3
10000046	English	Summon into action or bring into existence, often as if by magic	invoke	encounter	pose	1
10000047	English	The loose soft material that makes up a large part of the land surface	port	earth	forest	2
10000048	English	To: All staff From: HR Department  Please remember that your manager must agree any holiday dates before you complete a form.  Why is the HR department sending this email?	to ask staff for some information	to explain how something is done	to tell managers about a problem	2
10000049	English	FINEFOODS  Agent required for nationwide distribution. Some experience in food retail an advantage. Refrigerated van provided.  Finefoods requires an agent to:	own a suitable vehicle for delivery	be a specialist in food distribution.	deliver goods all over the country.	3
10000050	English	"Phone Neil Smith at our showroom for a free quotation, or to arrange a visit from our representative." Contact Neil Smith if you want to	obtain information about the company’s prices.	arrange a visit to the showroom.	speak to a representative about special offers.	1
10000051	English	OFC Co-operative is a supplier of industrial chemicals and, in terms of job applications, it is currently one of the most popular employers in Aveburn. Unlike a number of its competitors, which are currently.................................  at a loss, OFC has reported its most successful year ever, mainly due to a major new contract early in the year	managing	conducting	running	3
10000052	English	The company has plans to expand its core business in the coming year. A key factor in the company’s success has been its wish to create a highly skilled and motivated workforce, as highlighted in its mission..........................	statement	announcement	promise	1
10000053	English	One of Stewart Green’s first actions on becoming the new Managing Director last year was to...........................his employees’ training needs.	assess	value	figure	1
10000054	English	We attribute our success to the dedication and expertise of our workforce, which .........................from six apprentices to permanent employees who are highly qualified and experienced.	ranges	spreads	expands	1
10000055	English	This company actively ......................employees to progress through the company, and many of the current surveyors and site managers launched their careers on the Reid workshop floor.	encourages	supports	promotes	1
10000056	English	At present, our company is.......................... in the refurbishment of a major concert hall in London, with particular responsibility for the stage and acoustic panels.	concerned	involved	committed	2
10000061	Russian	Определите значение иностранного слова: Несессер	чемоданчик для хранения разных мелких вещей	набор принадлежностей для маникюра, шитья в специальном футляре	женская сумочка	1
10000062	Russian	Определите родовую принадлежность существительного: Инкогнито	полный	полная	полное	3
10000063	Russian	Определите родовую принадлежность существительного: Пенальти	точный	точное	точная	2
10000064	Russian	Выберите правильный вариант: Кондуктор Анна вежливо … нас оплатить проезд	попросил	попросила	спросила	2
10000034	Hungarian	Nem igazi barát az, aki, ha baj van, ... hagyja a társát.	vajban	cserben	pechben	2
10000066	Russian	Выберите верный ответ: Орфоэпические нормы –	это правила произношения отдельных звуков, сочетаний звуков, грамматических форм;	это определенные правила образования слов в русском языке	это нормы и правила написания слов и словосочетаний в русском языке	1
10000067	Russian	Определите значение слова: Цельный	состоящий, сделанный из одного куска	неповрежденный, неразрушенный	новый, нетронутый	1
10000068	Russian	12.Выберите верный вариант для дополнения предложения:  Из-за нарушения договоренностей мы вынуждены ...	освободиться от констракта	расторгнуть контракт	закончить контракт	2
10000069	Russian	Выберите верный вариант для дополнения предложения: ... из всех вышеперечисленных пунктов, фирма не согласилась подписать договор.	выходя	исходя	проходя	2
10000070	Russian	Вставьте в предложение подходящее по смыслу слово:  Мы живем в одном доме, но на … этажах.	различных	других	разных	3
10000071	Russian	Вставьте в предложение подходящее по смыслу слово: В лифт 8-этажного дома на первом этаже  ...  5 человек.	вошли	зашли	вошло	1
10000072	Russian	Определите значение иностранного слова: Дефолт	отказ от выполнения финансовых обязательств	ликвидация промышленного предприятия	банкрот	1
10000073	Russian	Укажите правильный вариант: Нам не хватает ... для покупки этого товара.	шестиста рублей	шестьсот рублей	шестисот рублей	3
10000074	Russian	Выберите правильный вариант: Страна находится ... реформ.	в преддверии	в преддверьи	в преддверие	1
10000075	Russian	Расставьте запятые в предложении: Если человек видит смысл жизни в зарабатывании денег (1) ему бывает довольно затруднительно поверить в то (2) что можно (3) действительно (4) быть счастливым (5) занимаясь (6) творчеством (7) даже (8) если ты не получаешь за это ни рубля.	1, 2, 3, 5, 7, 8	1, 2, 3, 4, 5, 7	1, 2, 5, 6, 7, 8	3
10000076	Russian	Расставьте запятые в предложении: Крупнейшие банки имеют значительный вес в своих странах (1) составляя стержень экономической и политической силы великих наций (2) и (3) простирая свои производственные и сервисные сети по всему миру (4)приобретают транснациональный характер.	1, 2, 3, 4	1, 4	2, 3, 4	2
10000077	Russian	Выберите правильный вариант: ... – это дерево или кустарник из семейства кипарисовых	мозжевельник	можевельник	можжевельник	3
10000078	Russian	Выберите правильный вариант: Самая ... актриса Линдси Лохан.	веснусчатая	веснушчатая	веснушчетая	2
10000079	Russian	Выберите правильный вариант: Бабушка ... с ветчиной.	потчевала винигретом	потчевала винегретом	подчевала винигретом	2
10000080	Russian	Выберите правильный вариант: Приятно петь под ... фортепьяно.	аккомпанимент	аккомпанемент	акомпанемент	2
10000081	Russian	Выберите правильный вариант: Существует миф, что «те, кто умеют играть на пианино, с лёгкостью научатся играть на ...»	аккардеоне	акордеоне	аккордеоне	3
10000082	Russian	В каком варианте ответа выделенное слово употреблено неверно?	Используя специальные термометры, океанологи производят измерения на различных глубинах океана по всей его ВОДЯНОЙ поверхности.	Для возвышенностей с твёрдыми, нерастворимыми породами типична БОЛОТИСТАЯ местность.	Наполеон проявил ОСОБОЕ уважение к Сперанскому, подарив ему табакерку с собственным портретом.	1
10000083	Russian	Укажите предложение, в котором есть страдательное причастие прошедшего времени. (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	5	2	3	3
10000084	Russian	В каком предложении НЕ со словом пишется раздельно?	(Не)сколькими годами позже в Петербург переехал Виссарион Белинский.	Теперь он пришел к убеждению, что изящная словесность должна (не)посредственно способствовать улучшению жизни.	Критик призывал изображать повседневное существование (не)романтических влюбленных, а обычных людей.	3
10000035	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Kérem, biztosítsanak nekem lehetőséget arra, hogyan egy személyes találkozás alkalmával mutatkozhassak be Önöknek.	biztosítsanak	hogyan	személyes	3
10000235	Italian	Benché ......... tardi, vengo ugualmente.	sia	fosse	è	1
10000085	Russian	Какое из приведённых ниже слов (сочетаний слов) должно быть на месте пропуска в шестом предложении?  (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	Поэтому	Впрочем	Например	1
10000086	Russian	Укажите предложение, в котором нужно поставить одну запятую. (Знаки препинания не расставлены)	Он жил одиноко и замкнуто и тосковал днем и ночью.	Гости выпили еще по стакану встали из-за стола и простились с Пугачевым.	Гром уже грохотал и впереди и справа и слева.	2
10000087	Russian	Выберите верный вариант для дополнения предложения: Точное время мероприятия требует ...	уточнения	уточнить	для уточнения	1
10000088	Russian	Определите значение слова: Рекламация – это	объявление, служащее средством привлечения внимания покупателей	официальная  претензия к качеству товара	маркетинговая стратегия	2
10000089	Russian	Укажите, к какому стилю относится текст: Ветер – это движение воздушных масс над поверхностью Земли. Движение воздуха от Земли называется восходящим потоком, а движение вниз – нисходящим. Ветер – это один из важнейших элементов природы. Его название зависит от стороны света. Например, ветер, дующий с юга на север, называется южным, а с северо-запада на юго-восток – северо-западный ветер.	научный	публицистический	официально-деловой	1
10000090	Russian	Выберите верный вариант для дополнения предложения: Вопиющая безграмотность вчерашних школьников заставила задуматься не только филологов, но и тех, … родной язык.	кто любит	что любят	кто любят	1
10000091	Ukranian	Апостроф треба писати на місці обох пропусків у рядку:	досвідчений різьб..яр, високий бур..ян	велике сузір..я, роз..ятрена рана	очікувана прем..єра, духм..яна страва	2
10000092	Ukranian	Немає лексичної помилки в рядку	погляди співпадають	багаточисельні дзвінки	наступного разу	3
10000093	Ukranian	Неправильно вжито прийменник у словосполученні	вишивати по шовку	зустрітися по обіді	зайти по неуважності	3
10000094	Ukranian	Потрібно поставити у на місці всіх пропусків у рядку	гуляв ... лісі, улюблений ..читель, блиск ... очах	було ... Києві, лежала ... шухляді, плавала ... воді	бути ... формі, осінь ... Каневі, допоможе ..війти	3
10000095	Ukranian	Правильно написано всі слова в рядку	тріснути, тиждневик, контрастний	рідкісний, ненависний, захистний	форпостний, пісний, кількісний	3
10000096	Ukranian	НЕПРАВИЛЬНО оформлено пряму мову в рядку	«Митець не може відвернутися від своєї сучасності, – говорив Альбер Камю і далі пояснював: «Якби він відвернувся від неї, то промовляв би в порожнечу».	Український письменник В. Винниченко якось сказав: «Як нудно, сіро проходить життя людей неталановитих, так нудно й нецікаво живуть без любові навіть талановиті».	«Слово – найтонше доторкання до серця, – був переконаний В. Сухомлинський, – воно може стати і запашною квіткою, і живою водою, і розжареним залізом».	1
10000097	Ukranian	Синонімічним до простого речення «У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне для досягнення особистістю успіху» є складнопідрядне речення	У сучасному світі вивчати мови міжнародного спілкування вкрай потрібно, тому що так особистість може досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне, щоб особистість могла досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне через те, що так особистість може досягти успіху.	2
10000098	Ukranian	Кому (коми) треба ставити в реченні (розділові знаки пропущено)	А тим часом місяць пливе оглядать небо й зорі та землю й море.	У моїй душі бриніли людські голоси і ні вдень ні вночі не давали спокою.	Жовтороте ластів’ятко силилося вилетіти з гнізда та ще не змогло.	3
10000099	Ukranian	Двокрапку треба поставити, якщо до частини «Люблю теплу весняну пору…» додати фрагмент рядка	... коли з-під снігу виглядають перші блакитні проліски.	... кидаю всі невідкладні справи та йду в поля далекі.	... у цей час народжуються нові потаємні мрії та сподівання.	3
10000100	Ukranian	В якому реченні допущено пунктуаційну помилку?  (1) Холодні осінні тумани клубочаться вгорі і спускають на землю мокрі коси. (2) Пливе в сірі безвісті нудьга, пливе відчай, і стиха хлипає сум. (3) Плачуть голі дерева, плачуть солом’яні стріхи, умивається сльозами вбога земля і не знає, коли усміхнеться. (4) Міріади дрібних крапель спадають додолу, і пливуть, змішані з землею, брудними потоками.	другому	третьому	четвертому	3
10000101	Ukranian	Антонімічну пару вжито в прислів’ї:	Рідня до півдня, а як сонце зайде – ніхто не знайде.	Діти – як квіти: поливай, то ростимуть.	Малі діти – малий клопіт, а підростуть – буде великий.	3
90	English	Dear Sheila, In your last letter, you asked me to tell you about all the things I did during my summer vacation. We went to Vancouver (1) I have some old friends (2) I haven't seen for about three years. My friend Tim, (3) mother I wrote about in my last letter to you, came with me and we had a great time. We flew into Vancouver on Monday 24th, (4) was also my birthday. The first thing we did was to visit the wonderful aquarium in the city center (5) there are three killer whales and a whole crowd of seals, penguins and dolphins. We arrived in the late afternoon (6) all the animals are fed so it was wonderful to see the dolphins leaping out of the water to get the fish (7) they love to eat so much. The following day, (8) was cloudy and rainy unfortunately, we went to a museum (9) they have some dinosaur skeletons (10) local people have found in the area. The horrible weather never improved all day so we visited a superb seafood restaurant later in the afternoon and had an early dinner. The waiters, (11) were all dressed in traditional fishermen's clothes, were very friendly and told us about the history of the restaurant (12) name was The Jolly Whaler. The restaurant, (13) has been open since 1888, was once visited by the American President J.F. Kennedy and his wife Jackie. The skies were blue on Thursday and we spent some time out on the sea in a large boat (14) we hired. I caught a big fish (15) the captain said was the biggest he'd seen this year. I felt very proud! We left on Thursday evening after a mini-vacation (16) helped me to relax a lot and now I have returned to work. The next time (17) you write to me, you must tell me about YOUR last vacation. Bye for now Sheila, Ben.	Numbers 2, 7, 14, 15, 17 don’t need a relative pronoun	Numbers 4, 8, 10, 13, 16, can be completed with the relative pronoun ‘that’.	Numbers 5, 6, 9 can be completed with the relative pronoun ‘where’	1
91	English	The Internet giant, Amazon, has put a warning on some of the 'Tom and Jerry' cartoons it offers to its customers. Visitors who want to buy or download the series 'Tom and Jerry: The Complete Second Volume' get a warning that the cartoons contain scenes that are racist. The warning says: "Tom and Jerry shorts may show some ethnic and racial prejudices that were once commonplace in American society." It added that the scenes were wrong when the cartoons were made 70 years ago, and are still wrong today. People say the character of the black maid in the cartoon series is racist. Some of the cartoons were edited in the 1960s because of worries about racism. Tom and Jerry were created in 1940 by cartoonists William Hanna and Joseph Barbera. The cartoons won the Oscar for the best Animated Short Film seven times. The shows have become one of the most popular cartoons in animation history. Many people posted on Twitter to say it was "madness" for Amazon to put a warning on the cartoons.	Visitors can only download the series “Tom and Jerry” from Amazon	In the sixties the cartoons were revised due to racism issues	Tom and Jerry were created over 20 years before some cartoons were edited due to worries about racism.	2
92	English	Are you looking for a holiday home in Italy? Why not buy a home in the picturesque town of Gangi for one Euro? This offer may seem too good to be true, but there’s a catch: you have to promise to renovate the property within three years and this could cost you €20,000. Gangi’s mayor came up with the idea to put some life back into the Sicilian town. Poverty caused many inhabitants to leave after World War II. The idea is attracting interest from all over the world. Would you buy one of these homes?  These words from the text: picturesque, too good to be true, catch, came up, poverty could be replaced with no change in their meanings for the following words respectively.	pictorial, fabulous, cash, occur, power	pretty, unbelievable, a slight problem, thought of, poor economic conditions.	picture, amazing, drawback, arise, indigence	2
93	English	This year’s edition of the Taxation Trends in the European Union appears at a time of upheaval. The effects of the global economic and fi nancial crisis have hit the European Union (EU) with increasing force from the second half of 2008. Given that the last year for which detailed data are available is 2007, this year´s report cannot yet analyze the consequences of the recession on tax revenues. Nevertheless, the report takes stock of the tax policy measures taken by EU governments in response to the crisis up to spring 2009.	the global economic and financial crisis has impacted on the EU.	the global economic and financial crisis may still hit the European Union	the global economic and financial crisis could have affected the EU	1
94	English	The high EU overall tax ratio is not new, dating back essentially to the last third of the 20th century. In those years, the role of the public sector became more extensive, leading to a strong upward trend in the tax ratio in the 1970s, and to a lesser extent also in the 1980s and early 1990s.	the role played by the public sector lessened	the role played by the public sector diminished	the role played by the public sector widened.	3
10000001	Turkish	Gazetenin haberinde, Hamaney'in kendisi internet sayfasındaki fetvada, bekar kadın ile erkek arasındaki sohbetin, 'ahlaksızlık' olduğunu gerekçe göstererek, sohbetin derhal yasaklanacağını ifade ettiğine yer verildi.   Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	kendisi	yasaklanacağını	yer verildi	1
10000002	Turkish	Şirket onlarca yıllardır bu sektörde ......	faaliyet gösterir.	faaliyet göstermektedir.	faaliyet halindedir.	2
10000003	Turkish	Mektubu sonlandırırken: Dünya çapında tanınan önemli markalar yaratan ve moda sektöründe dinamizmi ile öne çıkan kuruluşunuzda kariyerime devam etmek istiyor, konu ile ilgili ………………….	haber istiyorum	cevap istiyorum	cevabınızı bekliyorum	3
10000004	Turkish	İnsanda çok keramet vardır; ama düşünce gücü kısıtlanmış, düşüncelerini etrafına iletme fırsatı bulamamış, bu fırsatı elinden alınmış insanda değil.  Bu cümleye anlamca en yakın cümle, aşağı­dakilerden hangisidir?	İnsan fikrine saygı, bilimselliğin en önemli ilkelerindendir	İnsanın yetenek ve yaratıcılığı düşünce özgürlüğü ile ortaya çıkar	İnsanı diğer canlılardan ayıran özelliği düşünme yeteneğidir	2
10000238	Italian	Vi ........ di guardare la partita a casa nostra?	andrebbe	andate	andreste	1
95	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Temperatures could be 5°C warmer by the end of the current century	Sea levels are not likely to be higher than today by the end of the century.	50% of the scientists believed humans were the cause of climate change in 1995.	1
96	English	Climate scientists have concluded that temperatures could jump by up to 5°C and sea levels could rise by up to 82 cm by the end of the century, according to a leaked draft of a United Nations (UN) report. The UN Intergovernmental Panel on Climate Change (IPCC) also said there was a 95 per cent likelihood that global warming is caused by human activities. That was the highest assessment so far from the IPCC, which put the figure at 90 per cent in a previous report in 2007, 66 per cent in 2001, and just over 50 per cent in 1995. Reto Knutti, a professor at the Swiss Federal Institute of Technology in Zurich, said: “We have got quite a bit more certain that climate change is largely man-made. We’re less certain than many would hope about the local impacts.” The IPCC report, the first of three in 2013 and 2014, will face intense scrutiny particularly after errors in the 2007 study, which wrongly predicted that all Himalayan glaciers could melt by 2035. Almost 200 governments have agreed to try to limit global warming to below 2°C above pre-industrial times, which is seen as a threshold for dangerous changes including more droughts, extinctions, floods and rising seas that could swamp coastal regions and island nations. Temperatures have already risen by 0.8°C since the Industrial Revolution. The report will say there is a high risk global temperatures will rise by more than 2°C this century. They could rise anywhere from about 0.6°C to almost 5°C a wider range at both ends of the scale than predicted in the 2007 report. It will also say evidence of rising sea levels is “unequivocal”. The report projects seas will rise by between 30 cm and 82 cm by the late 21st century. In 2007 the estimated rise was between 18 cm and 58 cm, but that did not fully account for changes in Antarctica and Greenland. Scientists say it is harder to predict local impacts. Drew Shindell, a Nasa scientist, said: “I talk to people in regional power planning. They ask, 'What’s the temperature goin	Himalayan glaciers will certainly disappear by 2035 because of global warming	The IPCC can now be sure of how climate change will impact different locations	The IPCC made a wrong prediction about the Himalayas in the 2007 report	3
97	English	“In some cultures team members will be highly selfmotivated to carry out their responsibilities without the need for a manager or colleagues to motivate them. In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them.” (Source: DIGNEN, Bob; CHAMBERLAIN, James. Fifty ways to improve your intercultural skills. London: Summertown Publishing, 2009. p. 121)   In the sentence “In other cultures, team leaders may need to coach performance from team members and use positive feedback to motivate them”, the modal verb ‘may’ indicates:	possibility.	prohibition.	lack of need.	1
99	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless	Type O blood people must eat a lot of meat and avoid milk, yogurt and cheese, for example	Type O blood appeared before the other blood types	Type B diet, which is rich in yogurt, milk, cheese and meat, can cause diabetes	1
101	English	In 1996 a naturopath named Peter D’Adamo published a book called Eat Right 4 Your Type. D’Adamo argued that we must eat according to our blood type, in order to harmonise with our evolutionary heritage. Blood types, he claimed, “appear to have arrived at critical junctures of human development.” According to D’Adamo, type O blood arose in our hunter-gatherer ancestors in Africa, type A at the dawn of agriculture, and type B developed between 10,000 and 15,000 years ago in the Himalayan highlands. Type AB, he argued, is a modern blending of A and B. From these suppositions, D’Adamo then claimed that our blood type determines what food we should eat. With my agriculturebased type A blood, for example, I should be a vegetarian. People with the ancient hunter type O should have a meat-rich diet and avoid grains and dairy. According to the book, foods that are not suited to our blood type contain antigens that can cause all sorts of illness. D’Adamo recommended his diet as a way to reduce infections, lose weight, fight cancer and diabetes, and slow the ageing process. D’Adamo’s book has sold seven million copies and has been translated into 60 languages. It has been followed by a string of other blood type diet books; D’Adamo also sells a line of blood-type-tailored diet supplements on his website. As a result, doctors often get asked by their patients if blood type diets actually work. The best way to answer that question is to run an experiment. In Eat Right 4 Your Type D’Adamo wrote that he was in the eighth year of a decade-long trial of blood type diets on women with cancer. Eighteen years later, however, the data from this trial have not yet been published. Recently, researchers at the Red Cross in Belgium decided to see if there was any other evidence in the diet’s favor. They hunted through the scientific literature for experiments that measured the benefits of diets based on blood types. Although they examined over 1,000 studies, their efforts were fruitless.	He is a Belgium scientist specialized in the area of nutrition.	He wrote a book, has a website and sells diet supplements based on his blood type diet.	e published the findings of his research on blood type diets after an eight-year long trial.	2
10000000	Turkish	Onunla konuşurken sizin tek yapabileceğiniz şey, ona bir uzmana danışması önermenizdir.  Yukarıdaki tümceyi alt çizili sözcüklerden hangisi bozmaktadır?	konuşurken	danışması	önermenizdir	2
10000236	Italian	Che tu ............ sul serio la tua malattia, è un consiglio che ti danno tutti.	prendi	prenda	prendessi	2
10000006	Turkish	“Konuşur gibi yazanları severim, ötekileri bazen okurum; hoşlandığım da olur.” cümlesindeki anlatım bozukluğu, aşağıdakilerden hangisiyle giderilebilir?	“hoşlandığım” sözcüğünden önce “onlardan” sözcüğü getirilerek	“ötekileri” sözcüğü cümleden çıkarılarak	“severim” sözcüğünden sonra “ama" kelimesi getirilerek	1
10000007	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Hiç kimse beni dilemiyor, herkes başka işlerle meşgul oluyor	Engelli vatandaşlara hem maaş hem de fatura indirimi yapılacak	Adam bizi hiç değilse yola kadar götürebilirdi	2
10000008	Turkish	Bütün insanları dostun bil, kardeşin bil kızım Sevincin ürünüdür insan, nefretin değil kızım Zulmün önünde dimdik tut onurunu Sevginin önünde eğil kızım. Ataol BEHRAMOĞLU  Bu dörtlükte aşağıdakilerden hangisi öğütlenmemektedir?	Fedakârlık yapma	Kardeşlik duygusu	Onurlu davranma	1
10000009	Turkish	Yüksek fiyatlar nedeniyle teklifi……………	inkar ettik	geri çevirdik	attık	2
10000010	Turkish	“Başka ülkelerde de hakemlere saldırılıyor, soyunma odasına kadar kovalanıyor.” cümlesindeki bozukluk aşağıdakilerden hangisi ile giderilebilir?	de” bağlacı cümleden atılarak	İkinci cümleye özne getirilerek	“saldırılıyor” sözü “saldırıyorlar” yapılarak	2
10000011	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	Sahildeki çay bahçesine epey zamandır gitmiyormuş	Günümüzde sanat dergileri pek okunmuyor.	Kapıya gelen çocuğun boyu uzun, elbiseleri de düzenli değildi	3
10000012	Turkish	Aşağıdaki cümlelerin hangisinde bir anlatım bozukluğu vardır?	İyi bir şair olabilmek için sürekli şiir yazmak gerektiğini biliyordu	Ülkemizin önde gelen yazarlarıyla dostluğumu sürdürmekteyim	Memduh Şevket de, Sait Faik de ben de insancıl çizgide öyküler yazdım	3
10000013	Turkish	Yoksa bana mı darıldın?” cümlesindeki altı çizili sözcüğün yerine aşağıdakilerden hangisi getirilemez?	küsmek	kırılmak	üzülmek	3
10000014	Turkish	Aşağıdaki cümlelerin hangisindeki ikileme "en faz­la" anlamına gelecek şekilde kullanılmıştır?	Bu cihaz çok çok yüz lira eder	Pazardan ucuz ucuz şeyleri alıp gelmişti	Kendini güzel mi güzel bir kıza kaptırmıştı	1
10000015	Turkish	Projeyi son teslim tarihine…………………… için fazla mesai yapmalıyız	ulaştırmak	yetiştirmek	götürmek	2
10000016	Turkish	Aşağıdaki altı çizili sözcüklerden hangisinin yanlış anlamda kullanılması anlatım bozukluğuna yol açmıştır?	Sigara, kansere yakalanma şansını büyük ölçüde artırır	Hava kirliliğinin bir nedeni de araçlardır	Doğalgaz kullanımı, hava kirliliğini büyük oranda azaltmaktadır	1
10000017	Turkish	‘Üzülerek söylüyoruz ki………..’	teklifinizi kabul edebiliriz	maliyetleri düşüremiyoruz	önerdiğiniz fuara katılacağız	2
10000018	Turkish	………………………………. takdirde, maalesef yasal yollara başvurmamız gerekecek.	Ürünlerin ödemesini yapmadığınız	Ürünleri gönderdiğiniz	Faturayı gönderdiğiniz	1
10000019	Turkish	Sanatın temel konusu insandır, insanla ilgili her şeyi sanatta bulabiliriz. Sanat, toplumun aynası olduğu için, toplumdaki değişmeleri sanatın yansıtması doğaldır. Sanatçıların da toplumla birlikte yaşayışı, duyuşu, düşünüşü de değişir. Bu toplumsal değişim sanatın değişmesine de yol açar.  Bu paragraftan aşağıdaki yargılardan hangisi çıkarılamaz?	Sanat toplumu yansıtır	Sanatçı toplumdan etkilenir	Sanatçı toplumu yönlendirir	3
10000020	Turkish	Toplumsal değerlerin sese bürünmüş şeklidir türküler. Türküler sesimiz, yürek sızılarımızdır. Dilimizin rengi, güzelliği; sözümüzün özüdür. Türküler sinelere hapsedilen aşkların dilidir.  Yukarıdaki parçada türkülerin hangi niteliğine değinilmemiştir?	Sadece ozanlarca bestelendiğine	Dilin güzelliklerini gösterdiğine	Duyguları ifade ettiğine	1
10000021	Turkish	Kırmızı renk, her yere farklı anlamlar yükler. Manavda domates, Adana’da kan kırmızı karpuz, Ereğli’de mis kokulu çilek... Hastanede ameliyathaneye son anda yetiştirilen kan...  Bu parça aşağıdakilerden hangisini anlatmaktadır?	Kırmızı rengin çok sevilmesi	Kırmızı rengin kişilere çağrıştırdıkları	Kırmızı rengin kullanıldığı yerl	2
10000022	Turkish	Anlamsız bir çocukluk ve tatsız bir gençlik, insanı olgunluk çağına erken hazırlar.  Aşağıdakilerden hangisi bu cümlede anlatılanı bütünüyle kapsar?	Olgunluk çağı, çocukluk ve gençlik yıllarının bitimiyle başlar	Tecrübeler, insanı iyi bir biçimde olgunlaştırır	Çocukluk ve gençlik yılları gerektiği gibi yaşanmazsa kişi yaşıtlarından önce olgunlaşır	3
10000023	Turkish	Bir şiirin değeri, söyleyişi ile biçiminin mükem­melliğine bağlıdır.  Aşağıdakilerden hangisi bu cümle ile aynı anlamdadır?	Değerli şiirler, hem biçim hem de söyleyiş bakımından kusursuzdur	Biçimi güzel olan şiirler mükemmeldir	Şiirde zirveyi yakalayabilmek için etkileyi­ci bir söyleyiş oluşturmak gerekir	1
10000024	Turkish	Daha hızlı çalışmalıyız,	programın gerisinde olabiliriz	halbuki programın gerisinde olabiliriz	sonuç olarak programın gerisinde olmalıyız	1
10000025	Turkish	Derin düşünmeyen insan, hiçbir şeyi değişti­remez; hiçbir şeyi değiştirmeden de uygarlık olmaz.  Bu cümleden aşağıdaki yargılardan hangisi çıkarılabilir?	Uygarlık, derin düşünmesini bilen insanlar­la doğmuştur.	Uygarlık, insanların ortak çabalarının ürü­nüdür.	Değişim, insanın doğasında vardır.	1
10000026	Turkish	"İnsanların yükselmesi, gelişme ve medeniyet, yemekle başlamış, yemekle aynı derecede ileri gitmiştir." sözüne hak vermemek mümkün mü?  Yukarıdaki cümlenin konusu nedir?	Yemek kültürünün medeniyetle ilişkisi	Medeniyetin yemek kültürünü etkilemesi	Yemek kültürünün tarihî gelişimi	1
10000027	Turkish	"Akıl tamamlandığında söz noksanlaşır." cümlesinde aşağıdakilerden hangisi anlatılmaktadır?	Akıllı kişiler, az ve öz konuşur	Çok konuşanlar, olgunlaşmamış kişilerdir.	Öz konuşmak, çok okumayı gerektirir.	1
10000028	Turkish	Bir kişi ile sohbet ederken hep .............. söz eder, kendi düşüncelerimizi öne sürersek karşımızdakinin susmasına ve bir süre sonra sohbetin kesilmesine .............."  Bu cümlede boş bırakılan yerlere aşağıdakilerden hangisi getirilirse, cümlenin anlamında bir bozulma olmaz?	kişiliğimizden - katkı sağlarız	başkalarından - neden oluruz	kendimizden - yol açarız	3
10000029	Hungarian	Azóta, ... megismertem, mindig rá gondolok	minthogy	mint	hogy	3
10000030	Hungarian	... fogadjunk, hogy az Internazionale nyeri a mai meccset?	Mihez	Miről	Mibe	3
10000031	Hungarian	. .. ideje, hogy hazamenjünk	Legfőbb	Nagy	Fő	1
10000032	Hungarian	... jössz, szívesen látlak!	Bár	Valaha	Amikor csak	3
10000033	Hungarian	"Jelölje a helyes megoldást! " Szegény, mint ... .	a templom egere	a ma született bárány	aki kettőig sem tud számolni	1
10000036	Hungarian	Az alábbi mondatban melyik szó  helytelen?   Tárgyalóképes angolnyelv-tudással rendelkezem, írásban és szóban egyaránt, mert a külföldi partnerekkel való kapcsolattartás sem jelent számomra problémát.	angolnyelv-tudással	egyaránt	mert	2
10000037	Hungarian	Az alábbi mondatban melyik szó  helytelen?   A megszerzett tudásomat szívesen kamatoztatnám a JKL Kft.-nél, mert számomra kiemelten fontos az egészséges életmód, ennek megfelelően táplálkozom és az Önök termékeit is rendszeres fogyasztója vagyok.	egészséges	ennek	termékeit	3
10000038	Hungarian	mondattal nem fejezne be egy hivatalos levelet?	Kérem, biztosítsanak nekem lehetőséget arra, hogy egy személyes találkozás alkalmával mutatkozhassak be Önöknek	Bízom benne, hogy lehetőségem nyílik egy személyes találkozás keretében is bemutatkozni Önöknek	Tudom, hogy lehetőségem nyílik majd egy személyes beszélgetésen is meggyőzni Önöket az alkalmasságomról	3
10000039	Hungarian	Az alábbi mondatban melyik szó  helytelen?  Büszke vagyok például arra, hogy az ismert márka a segítséggel lett ismét meghatározó nemcsak a magyar piacon, hanem a környező országok piacán is.	segítséggel	nemcsak	piacán	1
10000040	Hungarian	Mit jelent a megadott szó? \\nESZMÉL\\n	öntudatra ébred	elmélkedik, gondolkodik	eszmerendszerekben gondolkodik	1
10000041	Hungarian	Mit jelent a megadott szó? FATTYÚ	ebadta rossz kölyök	házasságon kívül született gyerek	levágott, megcsonkolt	2
10000042	Hungarian	Mit jelent a megadott szó?   INGÁZIK	bizonytalankodik, ide-oda áll az egymással szemben álló táborokban	munkahelye és lakóhelye között rendszeresen és hosszabb távon utazik	megingat, elbizonytalanít	2
10000043	Hungarian	Mit jelent a megadott szó?   KÖZHASZNÚ	a legtöbb ember által általánosan fogyasztott, vásárolt	a közösség hasznára levő, a társadalom céljait segítő	a nagyközönség által igénybe vett	2
10000044	English	Greater in number or size or amount	major	similar	specific	1
10000045	English	Lower or bend (the head or upper body), as in a nod or bow	conceive	persist	incline	3
10000046	English	Summon into action or bring into existence, often as if by magic	invoke	encounter	pose	1
10000047	English	The loose soft material that makes up a large part of the land surface	port	earth	forest	2
10000048	English	To: All staff From: HR Department  Please remember that your manager must agree any holiday dates before you complete a form.  Why is the HR department sending this email?	to ask staff for some information	to explain how something is done	to tell managers about a problem	2
10000049	English	FINEFOODS  Agent required for nationwide distribution. Some experience in food retail an advantage. Refrigerated van provided.  Finefoods requires an agent to:	own a suitable vehicle for delivery	be a specialist in food distribution.	deliver goods all over the country.	3
10000050	English	"Phone Neil Smith at our showroom for a free quotation, or to arrange a visit from our representative." Contact Neil Smith if you want to	obtain information about the company’s prices.	arrange a visit to the showroom.	speak to a representative about special offers.	1
10000051	English	OFC Co-operative is a supplier of industrial chemicals and, in terms of job applications, it is currently one of the most popular employers in Aveburn. Unlike a number of its competitors, which are currently.................................  at a loss, OFC has reported its most successful year ever, mainly due to a major new contract early in the year	managing	conducting	running	3
10000052	English	The company has plans to expand its core business in the coming year. A key factor in the company’s success has been its wish to create a highly skilled and motivated workforce, as highlighted in its mission..........................	statement	announcement	promise	1
10000053	English	One of Stewart Green’s first actions on becoming the new Managing Director last year was to...........................his employees’ training needs.	assess	value	figure	1
10000054	English	We attribute our success to the dedication and expertise of our workforce, which .........................from six apprentices to permanent employees who are highly qualified and experienced.	ranges	spreads	expands	1
10000055	English	This company actively ......................employees to progress through the company, and many of the current surveyors and site managers launched their careers on the Reid workshop floor.	encourages	supports	promotes	1
10000056	English	At present, our company is.......................... in the refurbishment of a major concert hall in London, with particular responsibility for the stage and acoustic panels.	concerned	involved	committed	2
10000061	Russian	Определите значение иностранного слова: Несессер	чемоданчик для хранения разных мелких вещей	набор принадлежностей для маникюра, шитья в специальном футляре	женская сумочка	1
10000062	Russian	Определите родовую принадлежность существительного: Инкогнито	полный	полная	полное	3
10000063	Russian	Определите родовую принадлежность существительного: Пенальти	точный	точное	точная	2
10000064	Russian	Выберите правильный вариант: Кондуктор Анна вежливо … нас оплатить проезд	попросил	попросила	спросила	2
10000065	Russian	Выберите правильный вариант: Студент решил около … задач.	полтора десятков	полутора десятков	полуторых десятков	2
10000066	Russian	Выберите верный ответ: Орфоэпические нормы –	это правила произношения отдельных звуков, сочетаний звуков, грамматических форм;	это определенные правила образования слов в русском языке	это нормы и правила написания слов и словосочетаний в русском языке	1
10000067	Russian	Определите значение слова: Цельный	состоящий, сделанный из одного куска	неповрежденный, неразрушенный	новый, нетронутый	1
10000068	Russian	12.Выберите верный вариант для дополнения предложения:  Из-за нарушения договоренностей мы вынуждены ...	освободиться от констракта	расторгнуть контракт	закончить контракт	2
10000130	Portuguese	O que é a elipse entre as figuras de sintaxe da língua portuguesa?	A alteração do sentido de uma palavra	O emprego de uma palavra por outra	A omissão de um termo que o contexto permite omitir	3
10000069	Russian	Выберите верный вариант для дополнения предложения: ... из всех вышеперечисленных пунктов, фирма не согласилась подписать договор.	выходя	исходя	проходя	2
10000070	Russian	Вставьте в предложение подходящее по смыслу слово:  Мы живем в одном доме, но на … этажах.	различных	других	разных	3
10000071	Russian	Вставьте в предложение подходящее по смыслу слово: В лифт 8-этажного дома на первом этаже  ...  5 человек.	вошли	зашли	вошло	1
10000072	Russian	Определите значение иностранного слова: Дефолт	отказ от выполнения финансовых обязательств	ликвидация промышленного предприятия	банкрот	1
10000073	Russian	Укажите правильный вариант: Нам не хватает ... для покупки этого товара.	шестиста рублей	шестьсот рублей	шестисот рублей	3
10000074	Russian	Выберите правильный вариант: Страна находится ... реформ.	в преддверии	в преддверьи	в преддверие	1
10000075	Russian	Расставьте запятые в предложении: Если человек видит смысл жизни в зарабатывании денег (1) ему бывает довольно затруднительно поверить в то (2) что можно (3) действительно (4) быть счастливым (5) занимаясь (6) творчеством (7) даже (8) если ты не получаешь за это ни рубля.	1, 2, 3, 5, 7, 8	1, 2, 3, 4, 5, 7	1, 2, 5, 6, 7, 8	3
10000076	Russian	Расставьте запятые в предложении: Крупнейшие банки имеют значительный вес в своих странах (1) составляя стержень экономической и политической силы великих наций (2) и (3) простирая свои производственные и сервисные сети по всему миру (4)приобретают транснациональный характер.	1, 2, 3, 4	1, 4	2, 3, 4	2
10000077	Russian	Выберите правильный вариант: ... – это дерево или кустарник из семейства кипарисовых	мозжевельник	можевельник	можжевельник	3
10000078	Russian	Выберите правильный вариант: Самая ... актриса Линдси Лохан.	веснусчатая	веснушчатая	веснушчетая	2
10000079	Russian	Выберите правильный вариант: Бабушка ... с ветчиной.	потчевала винигретом	потчевала винегретом	подчевала винигретом	2
10000080	Russian	Выберите правильный вариант: Приятно петь под ... фортепьяно.	аккомпанимент	аккомпанемент	акомпанемент	2
10000081	Russian	Выберите правильный вариант: Существует миф, что «те, кто умеют играть на пианино, с лёгкостью научатся играть на ...»	аккардеоне	акордеоне	аккордеоне	3
10000082	Russian	В каком варианте ответа выделенное слово употреблено неверно?	Используя специальные термометры, океанологи производят измерения на различных глубинах океана по всей его ВОДЯНОЙ поверхности.	Для возвышенностей с твёрдыми, нерастворимыми породами типична БОЛОТИСТАЯ местность.	Наполеон проявил ОСОБОЕ уважение к Сперанскому, подарив ему табакерку с собственным портретом.	1
10000083	Russian	Укажите предложение, в котором есть страдательное причастие прошедшего времени. (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	5	2	3	3
10000084	Russian	В каком предложении НЕ со словом пишется раздельно?	(Не)сколькими годами позже в Петербург переехал Виссарион Белинский.	Теперь он пришел к убеждению, что изящная словесность должна (не)посредственно способствовать улучшению жизни.	Критик призывал изображать повседневное существование (не)романтических влюбленных, а обычных людей.	3
10000085	Russian	Какое из приведённых ниже слов (сочетаний слов) должно быть на месте пропуска в шестом предложении?  (1)... (2)Тогда почти двумя третями Франции и всей Англией владела династия Плантагенетов. (3) Языком английского королевского двора оказался старофранцузский, на нем и были созданы первые рыцарские романы. (4)Вначале их писали в стихах и хранили в виде богато иллюстрированных манускриптов. (5)Рукописи эти читали вслух в покоях замков: там всегда находился какой-нибудь книжник – как правило, священнослужитель. (6) ... и сами хозяева, а особенно хозяйки замков нередко были грамотными.	Поэтому	Впрочем	Например	1
10000173	Spanish	¿No comes? ¿Quieres adelgazar?      No, algo me sentó mal ayer y estoy ................ dieta.	a	en	con	1
10000174	Spanish	Faltan los platos .............. postre.	con	a	de	3
10000086	Russian	Укажите предложение, в котором нужно поставить одну запятую. (Знаки препинания не расставлены)	Он жил одиноко и замкнуто и тосковал днем и ночью.	Гости выпили еще по стакану встали из-за стола и простились с Пугачевым.	Гром уже грохотал и впереди и справа и слева.	2
10000087	Russian	Выберите верный вариант для дополнения предложения: Точное время мероприятия требует ...	уточнения	уточнить	для уточнения	1
10000088	Russian	Определите значение слова: Рекламация – это	объявление, служащее средством привлечения внимания покупателей	официальная  претензия к качеству товара	маркетинговая стратегия	2
10000089	Russian	Укажите, к какому стилю относится текст: Ветер – это движение воздушных масс над поверхностью Земли. Движение воздуха от Земли называется восходящим потоком, а движение вниз – нисходящим. Ветер – это один из важнейших элементов природы. Его название зависит от стороны света. Например, ветер, дующий с юга на север, называется южным, а с северо-запада на юго-восток – северо-западный ветер.	научный	публицистический	официально-деловой	1
10000090	Russian	Выберите верный вариант для дополнения предложения: Вопиющая безграмотность вчерашних школьников заставила задуматься не только филологов, но и тех, … родной язык.	кто любит	что любят	кто любят	1
10000091	Ukranian	Апостроф треба писати на місці обох пропусків у рядку:	досвідчений різьб..яр, високий бур..ян	велике сузір..я, роз..ятрена рана	очікувана прем..єра, духм..яна страва	2
10000092	Ukranian	Немає лексичної помилки в рядку	погляди співпадають	багаточисельні дзвінки	наступного разу	3
10000093	Ukranian	Неправильно вжито прийменник у словосполученні	вишивати по шовку	зустрітися по обіді	зайти по неуважності	3
10000094	Ukranian	Потрібно поставити у на місці всіх пропусків у рядку	гуляв ... лісі, улюблений ..читель, блиск ... очах	було ... Києві, лежала ... шухляді, плавала ... воді	бути ... формі, осінь ... Каневі, допоможе ..війти	3
10000095	Ukranian	Правильно написано всі слова в рядку	тріснути, тиждневик, контрастний	рідкісний, ненависний, захистний	форпостний, пісний, кількісний	3
10000096	Ukranian	НЕПРАВИЛЬНО оформлено пряму мову в рядку	«Митець не може відвернутися від своєї сучасності, – говорив Альбер Камю і далі пояснював: «Якби він відвернувся від неї, то промовляв би в порожнечу».	Український письменник В. Винниченко якось сказав: «Як нудно, сіро проходить життя людей неталановитих, так нудно й нецікаво живуть без любові навіть талановиті».	«Слово – найтонше доторкання до серця, – був переконаний В. Сухомлинський, – воно може стати і запашною квіткою, і живою водою, і розжареним залізом».	1
10000097	Ukranian	Синонімічним до простого речення «У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне для досягнення особистістю успіху» є складнопідрядне речення	У сучасному світі вивчати мови міжнародного спілкування вкрай потрібно, тому що так особистість може досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне, щоб особистість могла досягти успіху.	У сучасному світі вивчення мов міжнародного спілкування вкрай потрібне через те, що так особистість може досягти успіху.	2
10000098	Ukranian	Кому (коми) треба ставити в реченні (розділові знаки пропущено)	А тим часом місяць пливе оглядать небо й зорі та землю й море.	У моїй душі бриніли людські голоси і ні вдень ні вночі не давали спокою.	Жовтороте ластів’ятко силилося вилетіти з гнізда та ще не змогло.	3
10000099	Ukranian	Двокрапку треба поставити, якщо до частини «Люблю теплу весняну пору…» додати фрагмент рядка	... коли з-під снігу виглядають перші блакитні проліски.	... кидаю всі невідкладні справи та йду в поля далекі.	... у цей час народжуються нові потаємні мрії та сподівання.	3
10000100	Ukranian	В якому реченні допущено пунктуаційну помилку?  (1) Холодні осінні тумани клубочаться вгорі і спускають на землю мокрі коси. (2) Пливе в сірі безвісті нудьга, пливе відчай, і стиха хлипає сум. (3) Плачуть голі дерева, плачуть солом’яні стріхи, умивається сльозами вбога земля і не знає, коли усміхнеться. (4) Міріади дрібних крапель спадають додолу, і пливуть, змішані з землею, брудними потоками.	другому	третьому	четвертому	3
10000175	Spanish	¿Le has dicho que no puede venir?      No, todavía no. No sé cómo ....................	decírselo	decírtela	decírtelo	1
10000237	Italian	Vorrei cambiare abitudini:  ........ farò ginnastica per mezz'ora tutte le mattine.	d'ora in poi	finora	presto	1
10000101	Ukranian	Антонімічну пару вжито в прислів’ї:	Рідня до півдня, а як сонце зайде – ніхто не знайде.	Діти – як квіти: поливай, то ростимуть.	Малі діти – малий клопіт, а підростуть – буде великий.	3
10000102	Ukranian	Граматичну помилку допущено в реченні:	Край дороги, якою їхали вершники, густо цвіли ромашки.	Степ розлігся перед мандрівником, який переливався барвами весняного цвіту.	Мліла під блакитним небом земля, яка напоєна була життєдайним теплом весняного сонця.	2
10000103	Ukranian	Помилку в написанні слова допущено в рядку:	кипарис, азимут, косінус	партитура, афоризм, акціонер	аквамарин, сюїта, шифон	1
10000104	Ukranian	Порушено норму відмінювання числівника в рядку:	Швидкість бігу гепарда – від сто двадцяти до сто сорока кідометрів за годину.	Прийшовши на спортмайданчик, він зустрів там сімох однокласників.	Запорізька чайка вміщала від п’ятдесяти до сімдесяти козаків.	1
10000105	Ukranian	Немає помилок у дієслівних формах в рядку:	мовчимо, відповіси, клеїмо	біжать, стелишся, їсиш	дуєте,стовбичать, кришуть	1
10000106	Ukranian	Літеру и на місці пропуску треба писати в усіх словах рядка	пр..буток, пр..крашений, пр..своїти	пр..бічник, пр..славний, пр..леглий	пр..подобний, пр..бій, пр..ваба	1
10000107	Ukranian	Помилково вжито слово в рядку	відхилити пропозицію	давно знати друг друга	довгостроковий проект	2
10000108	Ukranian	Неправильно утворено форму слова у варіанті	їздити по понеділкам	виголосить промову	задля спільної вигоди	1
10000109	Ukranian	Неправильно побудовано речення	Князь Святослав був мудрим і хоробрим полководцем.	Авторами стрілецьких пісень часто є невідомі поети й композитори.	У полон узяли двох генералів й один документ.	3
10000110	Ukranian	Подвоєні літери треба писати в усіх словах рядка	радіст..ю, нездолaн..ий, зіл..я	зван..я, жовч..ю, розрізан..ий	завдан..я, велич..ю, старан..о	3
10000111	Ukranian	Правильно утворено всі імена по батькові в рядку	Юрійович, Петрівна, Валерієвич	В’ячеславівна, Євгенович, Кузьмич	Святославович, Матвійович, Ігоревна	2
10000112	Ukranian	Форми ступенів порівняння можна утворити від усіх прикметників рядка	кругленький, смачний, щирий	скромний, малий, солодкий	здоровенний, вигідний, злий	2
10000113	Ukranian	Граматично правильна відповідь на запитання «Котра година?»	половина дев’ятої	десять хвилин першої	за п’ять одинадцята	3
10000114	Ukranian	Неправильно вжито прийменник у реченні	Пожежа спалахнула через недотримання елементарних норм безпеки.	Один з енергоблоків електростанції зупинили на вимогу екологів.	Школярі знову мають вимушені канікули із-за лютих морозів.	3
10000115	Ukranian	Помилково вжито слово в рядку	запросив до вітальні	розповів про відрядження	приїхав вісім років назад	3
10000116	Ukranian	Неправильно утворено форму слова у варіанті	самий головний	сімома голосами	віддаси потім	1
10000117	Ukranian	Неправильно побудовано речення	Побачивши в магазині нову енциклопедію, я захотів її переглянути.	Ще не ходячи до школи, мама читала мені вірші Марійки Підгірянки.	Створюючи виставу, режисер суттєво осучаснив текст класичної п’єси.	2
10000118	Ukranian	Усі слова написано правильно в рядку	карпатський, дорожчати, робітництво	криворізький, об’їжджати, французський	інтелігентський, сонячний, надхнення	1
10000119	Ukranian	Прийменник у на місці пропуску слід уживати в усіх словах рядка	перебував … Ватикані, експонат … музеї, наймиліше … світі	поїхати … відрядження, птах … небі, купити … аптеці	побувати … Львові, квітник … саду, покласти … узголів’я	1
10000120	Ukranian	Правильно вжито прийменник у варіанті	вишивати по шовку	проживати по адресі	їхати по виклику	1
10000121	Portuguese	Assinale a alternativa que estabeleça o mesmo tipo de relação existente na oração destacada no parágrafo abaixo.  Visto que estavam enfraquecidos pela contraofensiva aliada, austríacos e turcos se renderam em outubro de 1918.	À medida que se aproximavam do rio, mais mosquitos apareciam.	Medidas urgentes precisam ser tomadas a fim de que a falência da empresa possa ser evitada.	Naquela manhã, estava muito dispersivo porque dormira pouco.	3
10000176	Spanish	. Yo creo que es mejor comer en casa, así podemos hacer la sobremesa que queramos sin que nos interrumpa nadie.    Sí, yo también pienso lo mismo, y ....................... he dicho a ellos.	te lo	se lo	se los	2
10000177	Spanish	Laura falta mucho a clase.     Por mí, como si no ......................	aprobara	apruebe	aprueba	3
10000178	Spanish	..................... vas a biblioteca, ¿puedes llevar estos libros?	Cuando	Porque	Ya que	3
10000179	Spanish	. ¿Qué le dijiste a la profesora?      Le dije que estaba empezando a ..................... las películas en español.	comprende	comprendido	comprender	3
10000122	Portuguese	Leia o fragmento de texto a seguir e responda à questão.  A retirada impunha-se. Pela madrugada, tornou-se urgentíssima. Falecera o coronel Moreira César. Era o último empuxo no desânimo geral. Os aprestos da partida fizeram-se, então, no atropelo de um tumulto indescritível. De modo que, quando ao primeiro bruxulear da manhã uma força constituída por praças de todos os corpos abalou, fazendo a vanguarda, encalçada pelas ambulâncias, fardos, feridos e padiolas, entre as quais a que levava o corpo do comandante malogrado, nada indicava naquele momento a séria operação de guerra que ia realizar-se. A retirada era a fuga. (...)  (CUNHA, Euclides da. Os sertões. Rio de Janeiro: Tecnoprint Gráfica, 1878, p. 307)  Os vocábulos empuxo (4ª linha), aprestos (5ª linha), bruxulear (7ª linha), encalçada (9ª linha) e malogrado (12ª linha), podem ser substituídos, sem perda de sentido, respectivamente, por:	puxão, preparativos, despontar, protegida, morto.	abalo, preparativos, despontar, seguida, malsucedido.	puxão, avisos, raiar, protegida, morto.	2
10000123	Portuguese	A questão que segue tem como base uma nota jornalística intitulada Máscara antifumo:  A fim de largar o vício em tabaco, o turco Ibrahim Yücel, 42 anos, resolveu fechar a cara, literalmente. O cara criou um tipo de gaiola, que usa como capacete para não repetir o hábito, que já dura 26 anos, de fumar dois maços de cigarro por dia. A cada manhã, antes de sair para trabalhar, Yücel veste o “capacete da vergonha” e o tranca, deixando uma chave com a mulher e a outra com a filha. A engenhoca, confeccionada em um mês com 40 m de fio de cobre, tem várias aberturas bem estreitas que barram o cigarro, mas permitem enxergar, comer biscoitos que passam pela grade – única refeição feita fora de casa – e tomar líquidos usando canudos mais finos que cigarros. A principal motivação para tomar medida tão radical foi a morte do pai, há alguns anos, causada por câncer de pulmão. Fonte: Revista Mundo Estranho, set. 2013, ed.143, p. 74.  Com base no texto lido, analise as afirmações: I. As expressões “um tipo de gaiola”, “capacete da vergonha”, “engenhoca”, têm um mesmo referente: o instrumento criado pelo turco Yücel para fazê-lo parar de fumar. II. Os travessões utilizados no texto podem ser substituídos por vírgula ou parênteses.  III. A passagem “fechar a cara, literalmente” significa que o turco Ibrahim Yücel, frustrado por não conseguir parar de fumar, sentiu-se zangado, enraivecido. IV. Às vezes, textos publicados na imprensa apresentam alguma impropriedade gramatical, como a que acontece no texto: a expressão “a fim de” está grafada de maneira inadequada, o correto é “afim de”.  Está(ão) CORRETA(S) a(s) afirmação(ões):	Somente em II e IV.	Somente em III e IV.	Somente em I e II.	3
10000124	Portuguese	Assinale a opção que preenche de forma gramaticalmente correta as lacunas do texto.  Para os emergentes, a recomendação, por enquanto, é ____ adiante os esforços de consolidação fi scal e de reformas para elevar o potencial de crescimento e garantir uma expansão segura nos próximos anos. Os governos devem adotar políticas para tornar ____ economias menos vulneráveis ____ mudanças no mercado fi nanceiro - um risco associado, ____ curto prazo, ____ esperado aperto da política monetária americana. Menos crédito disponível e juros consequentemente mais altos compõem o cenário previsto.	levar, às, a, à, no	de levar, as, às, a, ao	levar-se, as, as, à, ao	3
10000125	Portuguese	Assinale a opção que apresenta substituição correta para o termo grifado no texto abaixo.  Nunca na história da humanidade, uma virada de ano teve tantos registros em imagens e textos como esta de 2013 para 2014. Jamais as pessoas tiveram tanto poder nas mãos para fotografar, descrever e repassar instantaneamente para qualquer parte do mundo tudo o que lhes parece interessante. Os smartphones e as redes sociais consolidaram-se como instrumentos da comunicação instantânea, reduzindo distâncias, aproximando pessoas, possibilitando o compartilhamento de informações e até mesmo de intimidades.	consolidou-se	foi se consolidando	foram consolidados	3
10000126	Portuguese	Para preservar a coerência e a correção gramatical do texto, assinale a opção que corresponde ao termo a que se refere o elemento coesivo constituído pelo pronome “-la”   A reciprocidade de tratamento é tradicional princípio da liturgia diplomática. Esse pressuposto consagrado na relação entre as nações − econômicas e migratórias, entre outras − é determinante para estimular o equilíbrio e afastar a tensão na convivência entre os países, colaborando para mantê-la em desejável harmonia. É hipocrisia, por exemplo, cobrar de uma parceria obediência a normas de bom trato (ou de acolhimento) se o outro lado da fronteira não é contemplado com o respeito ao protocolo da civilidade.	“convivência”	“liturgia”	“reciprocidade”	1
10000127	Portuguese	Assinale a opção que, na sequência, preenche corretamente as lacunas do texto.  Quando a crise fi nanceira eclodiu em 2008, uma das ameaças mais temidas foi ____ ela trouxesse consigo o protecionismo generalizado. A crise ainda não acabou, as perspectivas pessimistas ____ comércio mundial não se concretizaram, e ____ Brasil tenta agora é obter sinal verde para fechar por um tempo sua economia, abrindo caminhos ____ outros países em situação semelhante façam o mesmo. A Organização Mundial do Comércio − OMC daria então aval a esse protecionismo, supondo que ela fosse capaz de estabelecer ____ deveria ser a taxa de câmbio de equilíbrio de seus membros, e o período pelo qual uma taxa desalinhada poderia voltar ao seu nível “normal”, que é o que o Brasil parece supor ao pedir proteção temporária. A proteção, se concedida ao Brasil, provavelmente elevaria seus substanciais saldos comerciais, valorizando mais sua moeda, ____esse é apenas um dos problemas da proposta.	o de que, com o, aquilo que o, para, onde, porém	a de que, a respeito do, o que o, para que, qual, mas	que, do, o, de que, que, todavia	2
10000128	Portuguese	Ao anunciar que o Hotel Copacabana Palace passou por uma grande reforma para a Copa do Mundo, a revista TAM nas Nuvens (abril 2014) veiculou o seguinte texto:  O Copacabana Palace é daqueles hotéis – dá para contar nos dedos pelo mundo – que são ao mesmo tempo substantivo e adjetivo. Você já deve ter lido “um Copacabana Palace de Buenos Aires” ou algo assim. Mas a verdade é que apenas recentemente, às vésperas de essa grande senhora de Copacabana – sim, porque tudo me faz crer que “o” Copa é um substantivo feminino – completar 90 anos, passei por aquela porta giratória como hóspede. Porém, longe de encontrar uma old lady.  Sobre o texto, considere as seguintes afirmações: 1. Ao dizer que o Copacabana Palace é “ao mesmo tempo substantivo e adjetivo”, mencionam-se as propriedades de nomear o local e, paralelamente, de designar qualidade quando a expressão é aplicada a outro local. 2. A publicidade argumenta que existem poucos hotéis no mundo comparáveis ao Copacabana Palace. 3. O texto mostra a expansão da rede do “Copa”, exemplificada pela filial em funcionamento na capital argentina. 4. A ideia central do informe é defender que, apesar de sua tradição, o Copacabana Palace responde às exigências da modernidade.  Assinale a alternativa correta.	Somente a afirmativa 1 é verdadeira.	Somente as afirmativas 3 e 4 são verdadeiras.	Somente as afirmativas 1, 2 e 4 são verdadeiras.	3
10000129	Portuguese	Pleonasmo é sinônimo de ______ de palavras para expressar uma ideia.	Excesso	Ausência	Transferência	1
10000131	Portuguese	Poética  Estou farto do lirismo comedido Do lirismo bem comportado Do lirismo funcionário público com livro de ponto expediente protocolo e [manifestações de apreço ao Sr. diretor. Estou farto do lirismo que pára e vai averiguar no dicionário o [cunho vernáculo de um vocábulo Abaixo os puristas […] Quero antes o lirismo dos loucos O lirismo dos bêbedos O lirismo difícil e pungente dos bêbedos O lirismo dos clowns de Shakespeare — Não quero mais saber do lirismo que não é libertação. (BANDEIRA, Manuel. Poesia Completa e Prosa. Rio de Janeiro: Aguilar, 1974)  Com base na leitura do poema, podemos afirmar corretamente que o poeta:	critica o lirismo louco do movimento modernista.	propõe o retorno ao lirismo do movimento clássico.	propõe a criação de um novo lirismo.	3
10000132	Portuguese	Na expressão distância a pé não se emprega o acento de crase no “a”. Isso acontece, pelo mesmo motivo, na alternativa:	É preciso comparecer a festas.	Gostava de andar a cavalo.	Vai pagar a perder de vista.	2
10000133	Portuguese	Em que frase a vírgula foi usada de maneira CORRETA?	A interferência do presidente, no entender do líder estudantil, demonstra imaturidade política	Quem entra naquela casa seja brasileiro ou estrangeiro é recebido, com muita simpatia	Até Pelé, do alto dos seus 60 anos colocou-se como alternativa	1
10000134	Portuguese	Assinale a alternativa em que a vírgula NÃO foi usada corretamente:	Corre, senão o cachorro te pega, gritou a menina	Não tenho dúvida de que a maioria aceita o pedágio, ponderou	O noivado e o casamento vêm logo, afirmou constrangido	1
10000135	Portuguese	Aponte a situação em que a vírgula foi usada CORRETAMENTE:	Com o seu cartão, você acessa os serviços do banco as 24 horas do dia. Quer dizer resolve toda a sua vida bancária	Com o seu cartão você acessa os serviços do banco, as 24 horas do dia. Quer dizer resolve toda a sua vida bancária	Com o seu cartão você acessa os serviços do banco as 24 horas do dia. Quer dizer, resolve toda a sua vida bancária	3
10000136	Portuguese	Em que frase a vírgula foi usada de maneira CORRETA?	O novo mensageiro é lento, mas eficiente	Saiu da reunião dizendo que havia chamado o sujeito de incompetente e não, de autoritário	Compro livros editados ou não no Brasil, mas quero que tenham o país como tema	3
10000137	German	Nach der Produktion ................. sich die Fachkräfte um die fachgerechte Lagerung.	bereiten	kümmern	hindern	2
10000138	German	Über die Übertragung habe ich lange .......................	nachgedacht	gedacht	gedankt	1
10000140	German	In Deutschland dürfen Jugendliche unter achtzehn Jahren keine Kreditkarten bekommen, ............... das kommt einer Kreditgewährung gleich.	zwar	denn	da	2
10000141	German	Wir leben jeden Tag, .................... es der letzte wäre.	wenn	zumal	als ob	3
10000142	German	In Dubai entsteht ein........ d....... größt........ Finanzplätze der Welt.	-es / -er / -en	-er / -en / -en	-er / -er / -en	3
10000143	German	Wir nehmen diese unterschiedlichen Positionen bewusst ....................	in  Absicht	in Kauf	in Antrag	2
10000144	German	Was lernt man, wenn man anthropologische Studien ...................... will	antreiben	vertreiben	betreiben	3
10000145	German	Alle leisten im Moment sehr gute .................	Job	Arbeit	Beruf	2
10000146	German	Mehrkindfamilien müssen unter .................. gegriffen werden.	den Schulter	die Arme	die Achselhöhle	2
10000147	German	Vom Gehalts- oder Lohnteil, der über dieser Grenze liegt, brauchen keine Beiträge entrichtet ........................	zu werden	zu haben	worden	2
10000148	German	Die Verwaltungsreform ist landesweit ......................	umgesetzt	abgesetzt	versetzt	1
10000149	German	Zahlreiche Renovierungen waren in der Winterpause erledigt ..................	werden	wurden	worden	3
10000150	German	Woran kann der Wurmbefall eines Systems ................. werden?	gekannt	bekannt	erkannt	3
10000151	German	Peter .................. schon seit drei Monaten an einem neuen Projekt.	anfertigt	arbeitet	beschäftigt	2
10000152	German	Die Zahlung ist auf maximal 10 Euro ................	verbessert	begrenzt	bestimmt	2
10000153	German	Die Seminarteilnehmerzahl .................. sich auf max. 12 Personen.	ausmacht	läuft	beläuft	3
10000154	German	Wenn er kein Geld .............., ................... er zu Fuß nach Hause gehen.	hat / soll	hätte / müsste	hätte / wäre	2
10000155	German	Ich weiß nicht, was wir .............. erwarten können.	vor ihm	von ihr	durch ihn	2
10000156	German	................. ich den neuen Wagen bekomme, fahre ich nach Berlin.	So wie	Solange	Sobald	3
10000157	German	............. diese Maßnahmen notwendig waren, daran zweifelt keiner.	Dass	Ob	Damit	1
10000158	Spanish	Por qué te enfadaste tanto?     Porque mi novio no quiso llevarnos. Nos dijo que ....................... en un taxi.	íbamos	vayamos	fuéramos	3
10000159	Spanish	Ayer, en la sobremesa, Pepe actuó como si .................... el jefe.	fuera	sería	era	1
10000160	Spanish	No ........................ tantas especias a la salsa, que va a estar muy fuerte.	pongas	pon	pondrás	1
10000161	Spanish	Creo que viene Ander a la fiesta. Pues como ........................., voy a ponerme a dar saltos de alegría.	viene	vendrá	venga	3
10000162	Spanish	Me parece que nos ........................ bebida.     Si hay mucha, y seremos solo unos quince.	vaya a faltar	faltara	va a faltar	3
10000163	Spanish	Me parece bien que ...................... la carne poco hecha.     Sí, yo creo que es lo mejor. Si alguien quiere, de le da una vuelta.	vas a preparar	prepararás	preparas	2
10000164	Spanish	¿Vais a encargar, al final, la paella para el sábado?     Sí, ...................... hable con Luis, llamaré.	antes de que	después de	en cuanto	3
10000165	Spanish	Pedro es un poco antipático, ¿no? No, ........................ es muy tímido.	lo que pasa	porque	lo que pasa es que	3
10000166	Spanish	¿Vas a preparar algún plato de cuchara?    Quizás, ..................... venga Silvia, porque a ella le gustan mucho los quisos.	en caso de que	a no ser que	como	1
10000167	Spanish	¿Todavía no ha llegado Juan?      No, ......................... ha tardado mucho el autobús en llegar.	es possible que	puede que	a lo mejor que	3
10000168	Spanish	No queda tila ni poelo, ................ voy a bajar a comprar infusiones.      Vale, compra también manzanilla, que ya queda poca.	porque	de ahí que	así que	3
10000169	Spanish	Coge ............. quieras, yo no los necesito.	el que	los que	las que	2
10000170	Spanish	¿Preparo el pescado al horno o a la plancha?       Haz ................ quieras.	los que	lo que	que	2
10000171	Spanish	Estoy .................. comprar la vajilla, me gusta mucho.	para	de	por	3
10000172	Spanish	¿Qué es un cazo?       Es un recipiente ........................ el que calientas agua, leche...	por	en	a	2
10000181	Spanish	No sé si comentarle lo de mi ascenso.       Yo que tú, ....................... pasar unos días.	dejaré	dejara	dejaría	3
10000182	Spanish	¿Por qué te negaste .................... hablar con él?	de	para	a	3
10000183	Spanish	¿Por qoé has llegado tan tarde a la reunión con el jefe?     Lo siento, es que he venido .................. la autopista y había atasco.	en	por	hacia	2
10000184	Spanish	No me parece que esa .................... la mejor solución para el futuro de la empresa.	será	sea	sería	2
10000185	Spanish	¿Vais a quedaros a trabajar?     Sí, .................... paguen las horas extra.	por si	excepto si	siempre que	3
10000186	French	.................... Claude n'avait pas payé ses notes de téléphone, les Telecom lui ont coupé la ligne.	Jusqu'à ce que	Avant que	Étant donné que	3
10000187	French	............. que je lui propose d'aller au cinéma, il me répond qu'il est trop occupé.	Chaque fois	Maintes fois	Les fois	1
10000188	French	Allez-y! Je vous rejoins tout de suite, on se retrouve ......... la voiture.	dedans	prés	à	3
10000189	French	C'est bien ce .......... j'avais pensé! Il a oublié de prendre sa clé et ce soir il ne pourra pas rentrer.	dont	de quoi	que	3
10000190	French	Cétait une chance ............. personne n'avait osé croire.	à laquelle	à quoi	que	1
10000191	French	J'adore les gâteaux au chocolat et ........ tu nous as fait dimanche était vraiment délicieux.	celui que	ceux que	ce que	1
10000192	French	Ça y est, j'ai trouvé! C'est ici ....... nous avions caché notre trésor.	pour que	que	dans lequel	3
10000193	French	Ne vous en faites pas, ce n'est que ........... de repos que cet enfant a besoin.	trop peu	peu	-	3
10000194	French	Ce texte est beaucoup trop long, comment veux-tu avoir .......... temps de mémoriser le nom des personnages!	du	de	le	3
10000195	French	Dans ce petit village la vie est ........... trois fois plus dure que dans celui d'à côté.	les	à	-	3
10000196	French	Le paquet ........... par mes parents n'est toujours pas arrivé.	à envoyer	envoyé	envoyant	2
10000197	French	Regardez ces gros champignons que nous ............ dans la forêt.	avons cueillis	cueillions	avions cueilli	1
10000198	French	Elle .......... avoir une vie paisible près de cet homme déjà bien installé, mais elle a préféré partir avec ce danseur en Afrique.	aurait pu	a pu	avait pu	1
10000199	French	Il a encore ............... quantité de dossiers à classer qu'il ne pourra pas rentrer déjeuner chez lui.	tellement de	une telle	tant	2
10000200	French	Il a enfin compris le danger .............. il y avait de partir en montagne par ce temps.	qu'	ce qu'	duquel	1
10000201	French	Il est dommage que vous ................ l'heure à laquelle il arrivait.	ne comprenez pas	n'ayez pas compris	n'avez pas compris	2
10000202	French	Il n'a pas vu qu'il lui faisait beaucoup de peine avec de telles réflexions. Il ne /n'/ ........... vraiment pas rendu compte.	a	y est	s'en est	3
10000203	French	Elle n'est ................ satisfaite de ces résultats.	nulle	aucune sorte	pas du tout	3
10000204	French	Nous n'aurions pas cru qu'elle ............ capable d'une telle méchanceté.	sera	soit	aura été	2
10000205	French	L'enfant ne comprend pas pourquoi on le gronde car il n'a rien fait ........... mal.	de	du	pour	1
10000206	French	Tu parles .............. tu étais encore le chef. Pourtant ce n'est plus le cas.	comme si	alors que	même si	1
10000207	French	Je ne suis pas certaine que mon enfant soit vraiment guéri, je veux pourtant être sûre qu'il ............ est.	-	l'	y	2
10000208	French	Malgré la concurrence, cette entreprise fait un bénéfice de trois ............. francs dans une année.	milliards de	millard	millard de	1
10000209	French	........... impréve, le président devrait arriver jeudi soir à Moscou.	Sinon	Sauf	S'il n'est d'	2
10000210	French	La mère de Jeanne est .......... ingénieur de formation, mais elle travaille comme manager depuis deux ans.	une	bonne	-	3
10000211	French	Cette année, la poupée Barbi s'est vendu .......... que d'habitude.	le moins	même	autant	3
10000212	French	Pierre s'est jeté sur son verre de coca comme s'il ne /n'/ ........... depuis trois jours.	boit pas	boirait pas	avait pas bu	3
10000213	French	L'affiche de ce film ............ critiquée par de nombreuses personnalités du monde du cinéma.	s'est	s'est fait	a été	3
10000214	French	Le père furieux lui a demandé: "Qui ....... donc épousé?"	t'es-tu	as-tu	es-tu	2
10000215	French	Le voleur ........... sauvé en voyant la frontière, mais les gendarmes l'attendaient derrière un buisson.	s'est voulu	a cru se	s'est cru	3
10000216	German	............. diese Maßnahmen notwendig waren, daran zweifelt keiner.	Dass	Ob	Damit	1
10000217	German	Wir möchten einige Tage .................. Hamburg verbringen.	in schönen	in schöner	im schönen	3
10000218	German	Diese Entscheidung war wichtig ............... Zukunft.	auf die	für die	bei der	2
10000219	German	Männer haben es besser. Frauen werden bei ................... Arbeit oft schlechter bezahlt.	gleicher	gleichen	gleiche	1
10000220	German	Die Frau ist sehr müde, .................. sie arbeitet weiter.	aber	obwohl	so	1
10000221	German	Bei euch in Holland ist ................. billiger als bei uns.	vieler	vieles	viel	2
10000222	German	Der Taxifahrer ist bei Rot ............... Kreutzung gefahren.	vor die	vor der	über die	3
10000223	German	Ich weiß, dass er ................ jedem Opfer bereit wäre.	auf	zu	für	2
10000224	German	Die letzte Bemerkung war sehr typisch ...................	auf ihn	bei ihr	für ihn	3
10000225	German	Das Kind .............. noch im Bett ..................., wenn es Fieber hätte.	müsste / bleiben sollen	musste / geblieben	müsste / bleiben	3
10000226	German	Man wollte jeden dritten ............... sofort entlassen.	Angestellte	Angestellten	Angestellter	2
10000227	Italian	Domani andremo a trovare un amico .................... conosci bene.	che	quale	chi	1
10000228	Italian	La situazione è più complessa ............. difficile.	che	del	quanto	1
10000229	Italian	E' certo che nemmeno Maria ............. domani.	venirà	venga	verrà	3
10000230	Italian	Se il mal di testa non è intenso non ......... le compresse, te lo ha detto anche il medico.	prendi	prendere	prende	2
10000231	Italian	L'estate prossima vorresti andare in vacanza ........... Canarie?	sulle	nelle	alle	3
10000232	Italian	Da giovane ............ un mondo quando andavo al cinema.	mi sono divertito	mi divertii	mi divertivo	3
10000233	Italian	Questo è il terreno ........... costruirò la mia casa.	sul quale	sul cui	su quale	1
10000239	Italian	Ieri i ragazzi ........ a calcio tutto il pomeriggio.	giocavano	sono giocati	hanno giocato	3
10000240	Italian	Oggi è la festa della mamma: ....... regalo dei fiori.	la	mi	le	3
10000241	Italian	La classe si divide ....... due gruppi: uno va al museo di storia, l'altro va al museo di scienze.	per	da	in	3
10000242	Italian	Conosco una scuola di lingua ....... corsi sono adatti anche a te.	che	i cui	cui	2
10000243	Italian	Ognuno ......  noi sa che correre fa bene alla linea.	di	da	tra	1
10000244	Italian	Non sopporto ....... fa la spia.	con	chi	che	2
10000246	Italian	Aspettava che ....... a trovarlo noi.	andavamo	andiamo	andassimo	3
10000247	Italian	Ehi! Sta' attento ....... dove vai!	da	di	a	3
10000248	Italian	Ho fatto il budino,  ........ vuoi un po'?	lo	ne	ci	2
10000249	Italian	Paolo credeva che Giulia ....... già letto quel libro.	ebbe	avesse	avrebbe	2
10000250	Italian	Non eravamo contenti che ....... senza avvertirci.	se ne fossero andati	se ne furono andati	se ne sarebbero andati	1
10000251	Italian	Era in ritardo di un'ora e tutti avevano paura che gli ...... qualcosa.	fu successo	avesse successo	fosse successo	3
10000252	Italian	Bisognava che tu ..... prima!	ti fossi svegliato	ti avessi svegliato	ti fosti svegliato	1
10000253	Italian	......... non ho la patente, non ho nemmeno la macchina.	neanche	siccome	siccome	2
10000254	Italian	Ho capito che voleva parlarmi, ........ l'ho aspettato.	quindi	poiché	perché	1
\.


--
-- TOC entry 3073 (class 0 OID 2794053)
-- Dependencies: 186
-- Data for Name: traduttore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY traduttore (id, nome, cognome, data_nascita, madrelingua, password, has_new_message, username, email, vat, citta, cap, provincia, idstato, madrelinguaid, stato) FROM stdin;
26	Roufina Safiullina	ditta Adamantis	\N	Italian	\N	N	roufina@adamantis.eu	roufina@adamantis.eu	\N	Bologna Area	\N	\N	\N	\N	Italy
37	Irene Isabel	Dal Conte	\N	Italian	\N	N	idalconte	ire.dalconte@gmail.com	\N	Turin	\N	\N	\N	\N	Italy
38	Lucrezia	Bertolino	\N	Italian	\N	N	bertolinolucrezia@gmail.com	bertolinolucrezia@gmail.com	\N	Trapani	\N	\N	\N	\N	Italy
40	Sara	Tancredi	\N	Italian	\N	N	sarahtankr@gmail.com	sarahtankr@gmail.com	\N	Cosenza Area	\N	\N	\N	\N	Italy
42	Simona	Leggero	\N	Italian	\N	N	translatorsitalian	translatorsitalian@gmail.com	\N	Genoa	\N	\N	\N	\N	Italy
43	cristina	calin	\N	Italian	\N	N	cristina_1987ro	cristina_1987ro@yahoo.com	\N	Pisa	\N	\N	\N	\N	Italy
44	Giulia	Piaser	\N	Italian	\N	N	giuliapiaser	giulia.piaser@gmail.com	\N	Treviso	\N	\N	\N	\N	Italy
45	Maria Chiara	Sbragaglia	\N	Italian	\N	N	mchiarasbragaglia@hotmail.it	mchiarasbragaglia@hotmail.it	\N	Civitavecchia	\N	\N	\N	\N	Italy
46	Valentina	Ottomano	\N	Italian	\N	N	ValentinaO	valentina.ottomano@gmail.com	\N	Milan	\N	\N	\N	\N	Italy
47	Valentina	Lambrugo	\N	Italian	\N	N	VL11939	valentina.lambrugo@gmail.com	\N	Giussano	\N	\N	\N	\N	Italy
49	Anna	Baccenetti	\N	Italian	\N	N	annabaccenetti	anna.baccenetti@gmail.com	\N	Milan	\N	\N	\N	\N	Italy
12	Luca	Sapone	2017-10-12	Italian	4c3eeb5ba4109d98b0c309f9b13a333e622dd592bc8f5fc0a5a71ebf40b741aa	N	luca	luca.sapone86@gmail.com	\N	Torino	\N	TO	IT	it	\N
13	Giorgio	Valle	1965-07-08	Italian	9f2c3e310418393bac624106a65cfc1f617af21963dd821bdfe5c6639baec339	N	giorgio	giorgio.valle@hotmail.it	\N	Rivara			IT	it	\N
53	Delia	Fasano	\N	Italian	\N	N	d.fasano5	fasano.delia@gmail.com	\N	Cava deTirreni	\N	\N	\N	\N	Italy
56	Edoardo	Fattizzo	\N	Italian	\N	N	AngleRei	anglereikun@msn.com	\N	Firenze	\N	\N	\N	\N	Italy
25	Rafael	Belomo	\N		\N	N	rbelomo@gmail.com	rbelomo@gmail.com	\N		\N	\N	\N	\N	
27	Okszána	Szimkovics	\N		\N	N	simkovich0811@gmail.com	simkovich0811@gmail.com	\N		\N	\N	\N	\N	
28	Zsuzsanna	Kiliti	\N	Hungarian	\N	N	porcica7953@gmail.com	porcica7953@gmail.com	\N	Kiskunhalas	\N	\N	\N	\N	Hungary
29	Zsofia	Kraus	\N	Hungarian	\N	N	Zsofia Kraus	kraus.harimau@gmail.com	\N	Budapest	\N	\N	\N	\N	Hungary
30	Claudia	Ramirez	\N	Spanish	\N	N	Claudia	claudiaramirez.m@gmail.com	\N	San Salvador	\N	\N	\N	\N	El Salvador
31	Jared	Firth	\N	English	\N	N	jaredfirth	translations@jaredfirth.com	\N	Abington	\N	\N	\N	\N	United States
32	Matheus	Ribeiro	\N	Portuguese	\N	N	TheSirion	matheus_ribeiro@hotmail.com	\N	Niterói	\N	\N	\N	\N	Brazil
33	Helga	Halász	\N	Hungarian	\N	N	helga83	helga.halasz@gmail.com	\N	Szeged	\N	\N	\N	\N	Hungary
34	Bibiana	Salazar	\N	Spanish	\N	N	BibianaSalazar	traductorescolombia@gmail.com	\N	Medellín	\N	\N	\N	\N	Colombia
35	Bekir	Diri	\N	Turkish	\N	N	BekirDiri	diribekir@gmail.com	\N	Fatsa	\N	\N	\N	\N	Turkey
36	Nadia	Kozin	\N		\N	N	nadia.kozin@c7c.org	nadia.kozin@c7c.org	\N	Istanbul	\N	\N	\N	\N	Turkey
39	Juan Antonio	Castán Abán	\N	Spanish	\N	N	juanantcastan@gmail.com	juanantcastan@gmail.com	\N	Zaragoza Area	\N	\N	\N	\N	Spain
41	Gulsah	Tamer Sergio	\N		\N	N	gulsah_tamer@hotmail.com	gulsah_tamer@hotmail.com	\N		\N	\N	\N	\N	
48	Christina	Argyropoulou	\N	Greek	\N	N	Christi	argyropoulou-ch@hotmail.com	\N	Salonicco	\N	\N	\N	\N	Greece
50	Mohamed Walid	Romdhane	\N	French	\N	N	walid.romdhane	romdhane.oualid@gmail.com	\N	MSAKEN	\N	\N	\N	\N	Tunisia
51	Monica	Pasin	\N	Italian	\N	N	MonicaPas	monica.pasin@outlook.com	\N	Leeds	\N	\N	\N	\N	Great Britain
52	Dalila	Minelli	\N		\N	N	lilyblack90@hotmail.it	lilyblack90@hotmail.it	\N		\N	\N	\N	\N	
54	Florin	Savu	\N	Romanian	\N	N	savu.florin@gmail.com	savu.florin@gmail.com	\N	Constanta	\N	\N	\N	\N	Romania
55	mariann	makrai	\N	Hungarian	\N	N	mmakrai@yahoo.com	mmakrai@yahoo.com	\N	Croatia	\N	\N	\N	\N	
57	Eng. Ipek	Budak	\N		\N	N	santaseta@hotmail.com	santaseta@hotmail.com	\N	Istanbul	\N	\N	\N	\N	Turkey
62	Seba	Vargas	\N		\N	N	seba.v_sk8@hotmail.com	seba.v_sk8@hotmail.com	\N		\N	\N	\N	\N	
58	Antonella	Donaggio	\N	Italian	\N	N	Tony1964	elledi.edi@gmail.com	\N	Vigliano Biellese (BI)	\N	\N	\N	\N	Italy
59	valentina	pandolfi	\N	Italian	\N	N	_valentina	valentina.pando@gmail.com	\N	Pesaro	\N	\N	\N	\N	Italy
60	Maria Rosaria	Leggieri	\N	Italian	\N	N	mariarosaria_leggieri@yahoo.it	mariarosaria_leggieri@yahoo.it	\N	Foggia Area	\N	\N	\N	\N	Italy
61	Angelica	Albergo	\N	Italian	\N	N	angelique23@hotmail.it	angelique23@hotmail.it	\N	Bari	\N	\N	\N	\N	Italy
10	Test	tester	2017-11-22	Italian	1dc90894c15d296867ea77a7cfcc30a96643c23b5d0887a2d05ebbd1540eaefa	N	test	fvalle.glifico@outlook.com	\N	Rivara	10080	TO	IT	it	\N
11	Gio	Val	1965-07-08	Italian	bda34b1b4ab8051f454ca1f61f91829e6eb872678284e100e6d549efca0d506d	N	GiorgioTraduttore	giorgio.valle@hotmail.it	\N	\N	\N	\N	IT	it	\N
63	Sebastián	Vargas	\N	Spanish	\N	N	sebastianvargas92@gmail.com	sebastianvargas92@gmail.com	\N	Mendoza	\N	\N	\N	\N	Argentina
65	Alla	Kolesnikova	\N	Russian	\N	N	alla.kolesnikova.95@mail.ru	alla.kolesnikova.95@mail.ru	\N	Pyatigorsk	\N	\N	\N	\N	Russian Federation
67	Rubru	Shrestha	\N	Nepali	\N	N	eespol@yahoo.com	eespol@yahoo.com	\N	Madrid	\N	\N	\N	\N	Spain
70	Olgica	Andric	\N	Serbian	\N	N	oljafiore@gmail.com	oljafiore@gmail.com	\N	Serbia	\N	\N	\N	\N	Yugoslavia
76	Peter	Senizza	\N	Slovenian	\N	N	petersenizza	info@petersenizza.eu	\N	Sezana	\N	\N	\N	\N	Slovenia
64	Viktorija	Simonovik	\N	Italian	\N	N	Viktorija	viki4kaitaly@yahoo.it	\N	Vicenza	\N	\N	\N	\N	Italy
66	Sonia	Giardini	\N	Italian	\N	N	sonia.giardini@gmail.com	sonia.giardini@gmail.com	\N	Italy	\N	\N	\N	\N	Italy
68	Camilla	Musso	\N	Italian	\N	N	camilla.musso@gmail.com	camilla.musso@gmail.com	\N	Milano	\N	\N	\N	\N	Italy
69	Alessandra	Gramignano	\N	Italian	\N	N	quistis25@gmail.com	alessandra.gramignano@gmail.com	\N	Trapani	\N	\N	\N	\N	Italy
71	simona	caiazzo	\N	Italian	\N	N	simona	scaiazzo@alice.it	\N	civitavecchia	\N	\N	\N	\N	Italy
72	Beatrice	De Bonis	\N	Italian	\N	N	bdebonis92	bdebonis@hotmail.it	\N	Rome	\N	\N	\N	\N	Italy
73	Maria Mihaela	Barbieru	\N	Italian	\N	N	mbarbieru@hotmail.com	mbarbieru@hotmail.com	\N	Milan Area	\N	\N	\N	\N	Italy
74	Gloria	Nobili	\N	Italian	\N	N	gloria_732000@yahoo.it	mglorianobili@gmail.com	\N	Monza and Brianza Area	\N	\N	\N	\N	Italy
75	Luca	Colangelo	\N	Italian	\N	N	luca.colangelo2287@gmail.com	luca.colangelo2287@gmail.com	\N	Milan Area	\N	\N	\N	\N	Italy
77	Serena	Genovese	\N	Italian	\N	N	Serena	genovese.serena@gmail.com	\N	Torino	\N	\N	\N	\N	Italy
78	Adriana Beatriz	Carriero	\N	Italian	\N	N	AdrianaB	adriana.carriero@gmail.com	\N	Montoro	\N	\N	\N	\N	Italy
79	Rita	Sanfilippo	\N	Italian	\N	N	rita11	rita.sanf91@gmail.com	\N	Palermo	\N	\N	\N	\N	Italy
80	Patrizia	Dal Zotto	\N	Italian	\N	N	patriziadz@teletu.it	patriziadz@teletu.it	\N	Padova Area	\N	\N	\N	\N	Italy
\.


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 187
-- Name: agenzia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('agenzia_id_seq', 2, true);


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 195
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('currencies_id_seq', 196, true);


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 192
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('payments_id_seq', 17, true);


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 189
-- Name: skilltest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('skilltest_id_seq', 1, false);


--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 185
-- Name: traduttore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('traduttore_id_seq', 80, true);


--
-- TOC entry 2945 (class 2606 OID 2967884)
-- Name: agenzia agenzia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agenzia
    ADD CONSTRAINT agenzia_pkey PRIMARY KEY (username);


--
-- TOC entry 2947 (class 2606 OID 2850712)
-- Name: agenzia agenzia_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY agenzia
    ADD CONSTRAINT agenzia_username_key UNIQUE (username);


--
-- TOC entry 2949 (class 2606 OID 3419745)
-- Name: payments payments_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_id_key UNIQUE (id);


--
-- TOC entry 2941 (class 2606 OID 3751374)
-- Name: traduttore traduttore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY traduttore
    ADD CONSTRAINT traduttore_pkey PRIMARY KEY (username);


--
-- TOC entry 2943 (class 2606 OID 3751376)
-- Name: traduttore traduttore_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY traduttore
    ADD CONSTRAINT traduttore_username_key UNIQUE (username);


--
-- TOC entry 2954 (class 2606 OID 3770603)
-- Name: language_pair language_pair_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY language_pair
    ADD CONSTRAINT language_pair_username_fkey FOREIGN KEY (username) REFERENCES traduttore(username);


--
-- TOC entry 2953 (class 2606 OID 3751387)
-- Name: payments payments_secondtranslator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_secondtranslator_fkey FOREIGN KEY (secondtranslator) REFERENCES traduttore(username);


--
-- TOC entry 2952 (class 2606 OID 3751382)
-- Name: payments payments_translator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_translator_fkey FOREIGN KEY (translator) REFERENCES traduttore(username);


--
-- TOC entry 2951 (class 2606 OID 3419820)
-- Name: payments payments_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_username_fkey FOREIGN KEY (username) REFERENCES agenzia(username);


--
-- TOC entry 2950 (class 2606 OID 3751377)
-- Name: languages test_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT test_username_fkey FOREIGN KEY (username) REFERENCES traduttore(username);


--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO rxalpunoeboees;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 601
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON LANGUAGE plpgsql TO rxalpunoeboees;


-- Completed on 2018-02-15 07:49:27 CET

--
-- PostgreSQL database dump complete
--

