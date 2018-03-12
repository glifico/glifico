--
-- PostgreSQL database dump
--

-- Dumped from database version 10.2 (Ubuntu 10.2-1.pgdg14.04+1)
-- Dumped by pg_dump version 10.3

-- Started on 2018-03-12 11:47:39 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 13809)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 1791116)
-- Name: agenzia; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agenzia (
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
-- TOC entry 197 (class 1259 OID 1791123)
-- Name: agenzia_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agenzia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 197
-- Name: agenzia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agenzia_id_seq OWNED BY public.agenzia.id;


--
-- TOC entry 198 (class 1259 OID 1791125)
-- Name: currencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currencies (
    id integer NOT NULL,
    currency character varying(3),
    conversion numeric,
    description character varying(40)
);


--
-- TOC entry 199 (class 1259 OID 1791131)
-- Name: currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.currencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 199
-- Name: currencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.currencies_id_seq OWNED BY public.currencies.id;


--
-- TOC entry 200 (class 1259 OID 1791133)
-- Name: language_pair; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language_pair (
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
-- TOC entry 201 (class 1259 OID 1791139)
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    username character varying(50),
    language text,
    datatest timestamp without time zone,
    tottest integer,
    idlanguageto character varying(2),
    skilltest integer
);


--
-- TOC entry 202 (class 1259 OID 1791145)
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
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
-- TOC entry 203 (class 1259 OID 1791152)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 203
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 208 (class 1259 OID 9001213)
-- Name: ratingtest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ratingtest (
    id integer,
    language character varying(255),
    text_to_translate character varying(2048),
    topic character varying(255)
);


--
-- TOC entry 204 (class 1259 OID 1791154)
-- Name: skilltest; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skilltest (
    id integer NOT NULL,
    language character varying(255) NOT NULL,
    question character varying(2000) NOT NULL,
    answer1 character varying(255) NOT NULL,
    answer2 character varying(255) NOT NULL,
    answer3 character varying(255) NOT NULL,
    scelta integer NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 1791160)
-- Name: skilltest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skilltest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 205
-- Name: skilltest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skilltest_id_seq OWNED BY public.skilltest.id;


--
-- TOC entry 206 (class 1259 OID 1791162)
-- Name: traduttore; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.traduttore (
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
-- TOC entry 207 (class 1259 OID 1791173)
-- Name: traduttore_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.traduttore_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 207
-- Name: traduttore_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.traduttore_id_seq OWNED BY public.traduttore.id;


--
-- TOC entry 3599 (class 2604 OID 1791175)
-- Name: agenzia id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenzia ALTER COLUMN id SET DEFAULT nextval('public.agenzia_id_seq'::regclass);


--
-- TOC entry 3600 (class 2604 OID 1791176)
-- Name: currencies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currencies ALTER COLUMN id SET DEFAULT nextval('public.currencies_id_seq'::regclass);


--
-- TOC entry 3601 (class 2604 OID 1791177)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 3603 (class 2604 OID 1791178)
-- Name: skilltest id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skilltest ALTER COLUMN id SET DEFAULT nextval('public.skilltest_id_seq'::regclass);


--
-- TOC entry 3609 (class 2604 OID 1791179)
-- Name: traduttore id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.traduttore ALTER COLUMN id SET DEFAULT nextval('public.traduttore_id_seq'::regclass);


--
-- TOC entry 3748 (class 0 OID 1791116)
-- Dependencies: 196
-- Data for Name: agenzia; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agenzia (id, nome, vat, username, password, email, street, number, citta, provincia, cap, stato, banca, pagamento, iban) FROM stdin;
1	agenzia		agenzia	cbf921b6eb12815a33f74360d66dfef435f1bbbc9e5a5e1f13196db757f8ae57	filippovalle@aim.com	roma	314	Torino	TO	12309	Italy	\N	\N	\N
\.


--
-- TOC entry 3750 (class 0 OID 1791125)
-- Dependencies: 198
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.currencies (id, currency, conversion, description) FROM stdin;
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
-- TOC entry 3752 (class 0 OID 1791133)
-- Dependencies: 200
-- Data for Name: language_pair; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.language_pair (username, from_l, to_l, price, field, currency, price_euro, service) FROM stdin;
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Italian	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Italian	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Italian	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Italian	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	French	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	French	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	French	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Portuguese	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Portuguese	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	Portuguese	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
clrm2018	English	Spanish	0.008	translation	USD - US Dollar	0.01	
Adi Saputra	English	Indonesian	0.06	translation	USD - US Dollar	0.05	
\.


--
-- TOC entry 3753 (class 0 OID 1791139)
-- Dependencies: 201
-- Data for Name: languages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.languages (username, language, datatest, tottest, idlanguageto, skilltest) FROM stdin;
clrm2018	English	\N	\N	\N	\N
clrm2018	Italian	\N	\N	\N	\N
clrm2018	French	\N	\N	\N	\N
clrm2018	Portuguese	\N	\N	\N	\N
clrm2018	Spanish	2018-02-27 01:18:27	\N	\N	4
Adi Saputra	English	\N	\N	\N	\N
Adi Saputra	Indonesian	\N	\N	\N	\N
\.


--
-- TOC entry 3754 (class 0 OID 1791145)
-- Dependencies: 202
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments (id, job, price, currency, status, description, username, translated, translator, secondtranslator, document, preview, secondstatus, deadline) FROM stdin;
\.


--
-- TOC entry 3760 (class 0 OID 9001213)
-- Dependencies: 208
-- Data for Name: ratingtest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ratingtest (id, language, text_to_translate, topic) FROM stdin;
75	Turkish	Kale Endüstri Holding Yönetim Kurulu Üyesi Mehmet Çevik, birkaç gün önce işten çıkarılan bir kişinin silahlı saldırısı sonucu ağır yaralandı. Hastaneye kaldırılan 47 yaşındaki Mehmet Çevik yoğun bakım ünitesinde tedavi altına alındı. \\n\\nOlay, saat 16.00 sıralarında Güngören Atatürk Caddesi, Başaklı Skak'tabulunan Kale Endüstri Holding binasında meydana geldi. İddiaya göre, birkaç gün önce işten çıkarıldığı öğrenilen saldırgan, Mehmet Çevik ile konuşmak üzere holding binasına geldi. Aralarında yaşanan kısa süreli tartışmanın ardından silahını çeken saldırgan, Mehmet Çevik'e ateş etti. Zanlı, daha sonra olay yerinden kaçtı. \\n	Social and Political Matters
76	Turkish	Silvan'daki Hain Saldırı Teröristler, Askerlerin Başında Beklemiş\\n\\nDiyarbakır'da biri astsubay iki askerin şehit olduğu saldırının detayları netleşiyor. Teröristler askerlerin öldüğünden emin olmak için başında beklemiş.\\n\\nDiyarbakır'ın Silvan ilçesinde bugün sabah saat 07.30'da biri astsubay iki askerin şehit olduğu saldırının detayları ortaya çıkmaya başladı. Aynı apartmanda kapı komşu oldukları belirlenen şehitlerin bindikleri aracın otoparktan çıktığı sırada çapraz ateşe tutulduğu ve teröristlerin uzmanların öldüğünden emin olduktan sonra olay yerinden kaçtığı öğrenildi.\\n	\\nSocial and Political Matters
77	Turkish	POLİS TÜPÇÜ GİBİ EVE GİRDİ\\n\\nAsayiş Şube Müdürlüğü'nün Aranan Şahıslar Büro Amirliği ekipleri, Leyla Yıldırım'ın merkez Yüreğir İlçesi'nin Kışla Mahallesi'nde bir evde oturduğunu tespit etti. Yıldırım'ın kaçmaması için özel bir plan hazırlayan ekipler, keşif için genç kadının evine gitti. Tüpçü görünümde evin ziline basan polis, kapıyı açan Leyla Yıldırım'ı teşhis etti. Şüphelinin evde olduğunun anlaşılması üzerine sokağa giren ekipler, "Dolandırıcı arıyoruz, bu sokağa girmiş" diyerek ev sahiplerinden yardım istedi. Leyla Yıldırım'ın evine de aynı yöntemle giren polis, 3 yıldan beri kaçmayı başaran Leyla Yıldırım'ı yakaladı.\\n	Social and Political Matters
78	Turkish	Genel Sağlık Sigortası kapsamında yaptırılması gereken gelir testinde, son gün kaosu yaşandı. Yeni işe giren ve geçmişe ait borç çıkarılan gençler "İlk maaşımız devlete gitti" diyor.\\n\\nGenel Sağlık Sigortası (GSS) kapsamında, özellikle işsiz gençlerin 306 lira aylık prim ödememek için girdiği gelir testinde, dün son gündü. Bu nedenle Sosyal Yardımlaşma ve Dayanışma vakıflarında tam anlamıyla kaos yaşandı. İşte o gençlerin feyratları:\\n\\nHEM İŞSİZ HEM BORÇLU\\n\\nBora Yanık: 4 yıldır iş bulamıyorum. Bana 6 bin 700 lira borç çıkartıldı. Üstelik borç için tebligat da almadım. Sigortasız olduğum için borç çıkmasın diye hastanenin kapısından geçmiyorum.\\n	Health and Sport
79	Turkish	Bir ilde daha sandıklar taşınacak\\n\\nBatman'da 15 mahalledeki 26 okulda güvenlik gerekçesiyle sandık kurulmayacağı açıklandı.\\nBatman'da Merkez İlçe Seçim Kurulu, 15 mahalledeki 26 okulda güvenlik gerekçesiyle sandık kurulmayacağına, bu nedenle seçmenlerin farklı bölgelerdeki sandıklarda oy kullanmasına karar verdi.\\nMerkez İlçe Seçim Kurulu  Başkanlığı, 1 Kasım'da yapılacak seçimde, İl Emniyet Müdürlüğünün son dönemlerde artan terör olayları nedeniyle kent merkezindeki bazı mahallelerde güvenlik gerekçesiyle, sandıkların güvenlik sorunu olmayan okullara taşınmasına yönelik talebini değerlendirdi.\\n	Social and Political Matters
80	Hungarian	A piackutató cég felmérése 19 különböző reklámforma iránti bizalmat vizsgálta 60 ország 30 ezer internethasználója körében. \\n\\nAz MTI-vel hétfőn közölt összegzés szerint, amennyiben reklámokról van szó, a magyarok 80 százaléka ismerőseit vagy családtagjait tekinti hiteles információforrásnak, ami 3 százalékkal alacsonyabb mint a globális átlag. A magyar vásárlók 68 százaléka a vállalatok, márkák saját weboldalaiban bízik, 62 százalékuk más fogyasztók online posztjaira támaszkodik, valamint 56 százalék azok aránya, akik valamely médiumban olvasott vagy hallott szerkesztőségi véleményt tartanak hitelesnek.\\n	Social and Political Matters
81	Hungarian	Minél komplexebb egy vállalat struktúrája, annál inkább osztályokon átívelővé válnak a tevékenységek, a szervezet egyre nagyobb hálózatot alkot. A folyamatosan rövidülő fejlesztési időszakok, a növekvő követelmények és a gyorsan változó piaci körülmények nehezítik a kitűzött stratégiai és pénzügyi célok elérését. A decentralizáltabb, lapos struktúrájú szervezetekben ily módon nem csak a vezető, hanem az egyes munkatársak felelőssége is egyre nő, és ez fokozhatja a szervezeten belüli feszültségeket. Az ilyen típusú munkakörnyezetben a munkatársak elkötelezettsége egyébként is erős a közös célok felé, de a növekvő leterheltség frusztráltabbá teheti őket egymás iránt.	Business and Managment
82	Hungarian	A halgazdálkodási vállalat is igyekszik népszerűsíteni a horgászatot a gyerekek körében. Az éves bérlet nekik csak 1500 forintba kerül. Míg tavaly 5000, addig idén már 6500 gyerekbérletet értékesítettek. „Sajnos országos tendencia az, hogy a gyerekhorgászok létszáma csökkenőben van. Itt a Balatonon most sikerült nekünk ezt megfordítani azzal, hogy az idei évtől egy kedvezményes árú, valamint eléggé bő lehetőségű jegyet adtunk számukra. Korábban csak úszóval, úszós módszerrel lehetett horgászni a gyerekeknek, de az idei évtől bármilyen módszerrel horgászhatnak” – fogalmazott Nagy Gábor horgászati ágazatvezető.	Health and Sport
83	Hungarian	Kutatás-fejlesztési projekthez nyújtott támogatás keretében alapkutatás, ipari kutatás, kísérleti fejlesztés támogatható, míg a csekély összegű támogatás keretében projektelőkészítés, projektmenedzsment, a projekt szakmai megvalósításához kapcsolódó szolgáltatások igénybevétele.\\n\\nKutatási infrastruktúrához nyújtott beruházási támogatás keretében technológiai fejlesztést eredményező új eszközök beszerzése, a kutatási infrastruktúrához feltétlenül szükséges épület építése, korszerűsítése és a szükséges alap infrastrukturális fejlesztések, immateriális javak beszerzése lehetséges.\\n	Business and Managment
84	Hungarian	Ma már kevesebbet gondolunk az akkor bemutatott, megrázó képekre, és a bírósági tárgyalásokról érkező híreken kívül nem sok szó esik a katasztrófáról. Pedig a tragédia környezeti, anyagi és morális hatásai egy darabig még kísérni fogják Magyarországot, így szomorú aktualitása van Kollányi Péter csütörtökön nyíló fotókiállításának is. A fotográfus az élettelen devecseri kistérséget fotózta egy éven át, mielőtt a szerencsétlenül járt házakat lebontották volna. A fotók többsége a tragédiát követő első fél évben készült. A sorozat Marks of a Catastrophe (Egy katasztrófa nyomai) címmel 2010-ben a rangos Pictures of the Year (Az év képei) nemzetközi fotópályázaton második helyezést ért el.	Culture
85	Uzbek	Ўзбекистон билан беш йўналишда ҳамкорлик қилишга тайёрмиз\\r\\n\\r\\nШанхай маъмурияти Ўзбекистон билан беш йўналишда ҳамкорлик муносабатларини йўлга қўйиш ва ривожлантиришга тайёр. Шанхай шаҳар ҳокимияти Ташқи ишлар бошқармаси раҳбари ўринбосари Фу Цзихуннинг “Ватандош” мухбирига айтишича, қадимий Буюк ипак йўлини қуруқлик ва денгизда тиклаш бўйича халқаро лойиҳа ўзаро робиталарни янада кучайтиришга хизмат қилади.\\r\\nСавдо-иқтисодий муносабатлар ҳамкорликнинг биринчи йўналиши саналади. Жаноб Фуга кўра, сармоядор ва ишбилармонлар фаоллигини ошириш учун савдо-иқтисодий жабҳада ахборот алмашувини жонлантириш лозим.\\r\\n	topic to define
86	Uzbek	O'qituvchilik – mas'uliyatli va mashaqqatli kasb. Insoniyat kamoloti uchun butun bilimi, iqtidori va hayotini baxsh etgan ustozlarning xizmatlarini hamma zamonlarda ham kishilar hurmatlab, o'zlarini esa e'zozlab kelishgan. Mustaqillik va ezgulik – mana shu ikki buyuk qadriyat zamirida xalqimizning asriy intilishlari, ezgu orzu – umidlari, bu majmuaning siyosiy va insoniy ma'nosi mujassamdir. Muhtaram ustozlarimizga o'z hurmatimiz va e'tiborimizni 1997 yildan beri respublikamizda keng nishonlanib kelayotgan 1 oktyabr – Ustoz va murabbiylar kunida yana bir bor izhor qilishimiz mumkin.	topic to define
87	Uzbek	O'zbekiston Badiiy Akademiyasi Ikuo Xirayama Xalqaro madaniyat karvon saroyida Nizomiy nomidagi Toshkent Davlat Pedagogika universitetining "Tasviriy san'at" fakulteti o'qituvchilarining "Mo'yqalam sehri" nomli ko'rgazmasining ochilishi bo'lib o'tdi.\\r\\nNizomiy nomidagi Toshkent Davlat Pedagogika universiteti 1935 yilda tashkil etilgan bo'lib, o'tgan yillar davomida respublikamiz ta'lim muassasalariga turli yo'nalishdagi pedagog kadrlarni tayyorlab keladi. Avval institut, hozirda esa universitet maqomini olgan ushbu bilim maskani bu yil 80 yillik yubileyini nishonlamoqda. 	topic to define
88	Uzbek	Xitoy Xalq Respublikasi raisi Si Tsinpinning Amerika Qo'shma Shtatlariga rasmiy tashrifi ikki davlat o'rtasidagi hamkorlik va birgalikdagi harakatlarni rivojlantirishga xizmat qiladi. Bu haqda AQShning Xitoydagi elchisi Maks Bokus ma'lum qildi. Uning ta'kidlashicha, Xitoy davlati rahbarining tashrifi Qo'shma Shtatlar eng orziqib kutgan muhim voqealardan biridir.\\r\\nAmerika elchisi o'z intervyusida Si Szinpinning tashrifi ikki mamlakatga ekologiya, iqtisodiyot, siyosat kabi turli sohalarda o'zaro hamkorlikni kengaytirish imkonini berishini ta'kidladi.  	topic to define
89	Uzbek	Тошкентлик шахмат устаси Дмитрий Қаюмов (2389) 9 имкониятдан 8 очко (7 та ғалаба, 2 та дуранг) тўплаб, 6th KLK Tan Sri Lee Loy Seng Seniors Open 2015 ветеранлар мусобақасида биринчи ўринни эгаллади ва россиялик Александр Фоминихдан (2439, иккинчи ўрин) 0,5 очко, индонезиялик Ронни Гунавандан (2371, учинчи ўрин) 1 очко ўзиб кетди.\\r\\nСамарқандлик Жаҳонгир Воҳидов(2532) 18 та мамлакатдан 141 нафар шахматчи иштирок этган 12th IGB Dato' Arthur Tan Malaysian Open 2015 турнирида ғолиб бўлди. Турнирнинг 6 нафар иштирокчиси 9 имкониятдан 7 тадан очко жамғаришди, лекин Жаҳонгир қўшимча кўрсаткич бўйича биринчи ўринга лойиқ топилди.\\r\\n	topic to define
90	English	When you drive the new expressway to the airport in the Chinese city of Luliang, you are as likely to come across a stray dog as another vehicle. When I recently drove it, a farmer was riding in a 3-wheel flatbed truck and heading in the wrong direction. But it didn't matter. There was no oncoming traffic.\\nThat's because the city's $160 million airport, which opened in 2014, gets at most five flights a day and as few as three. Officials began building the airport when this coal town was still booming. Since then, though, global commodity prices have plunged as China's old industrial economy has sputtered. The airport has become a white elephant.\\n	Social and Political Matters
91	English	College students can't miss the warnings these days about the risk of campus sexual assault, but increasingly, some students are also taking note of what they perceive as a different danger.\\n"Once you are accused, you're guilty," says Parker Oaks, one of several Boston University students stopped by NPR between classes. "We're living in a society where you're guilty before innocent now."\\nXavier Adsera, another BU student, sounds a similar theme. "We used to not be fair to women on this issue," he says. "Now we're on the other extreme, not being fair to guys."\\n	Social and Political Matters
92	English	In every book, you have to find a character that you love. This is true for authors as well as readers — we both need something to hang onto when the going gets rough, someone to root for, someone in whom we find small fragments of ourselves.\\nThis is doubly-true in this epoch of the multiply-narrated novel and the omniscient voice. Triply-true when authors get to door-stopping and their books creep upwards of five, six and seven hundred pages. When you're talking about that kind of commitment, you want to do your time with someone you like.\\n	Culture
93	English	Dave Gahan has sung about a soul that needs saving since his earliest murmurings as the frontman of Depeche Mode. Now, he's recorded his second collection of collaborative songs with Soulsavers since teaming up with the U.K. production enterprise in 2012. The first release was solely a Soulsavers project by virtue of its billing, with Gahan presented as a contributor of vocals to all songs that weren't instrumentals. But Angels & Ghosts puts Gahan's name — and his searching, dependably anguished cry — out front for all to behold.\\nAngels & Ghosts is nothing like a Depeche Mode album in terms of atmosphere, with a dusty, sparse desert-rock sound that couldn't be less electronic. \\n	Culture
94	English	If you're the parent of a young teen with intense mood swings, researchers have good news. Those emotions are probably normal and should calm down as your child moves through adolescence.\\n\\nBut if stormy emotional seas don't subside as teens move toward young adulthood, it may be a warning to parents of larger problems.\\n\\nResearchers in the Netherlands followed 474 middle- to high-income Dutch adolescents from ages 13 to 18. Forty percent of the teens were considered high risk for aggressive or delinquent behavior at age 12. At various times over five years, the teens rated their daily moods with regard to happiness, anger, sadness and anxiety.	Social and Political Matters
95	French	Dans son discours sur l’état de l’Union, le président américain a cherché à combattre le pessimisme qui domine la campagne pour les primaires. Avec une cible implicite : le candidat à l’investiture républicaine Donald Trump.\\r\\n“L’opposant d’Obama en 2016 : Donald Trump”, titre Politico au lendemain du dernier discours sur l’état de l’Union du président américain, mardi 12 janvier, devant le Congrès. “Sans même prononcer son nom”, Barack Obama s’est engagé dans une réfutation en règle “du trumpisme et de l’attitude pessimiste qu’il incarne”, estime le site.\\r\\n	Social and Political Matters
97	French	Le gouvernement de droite a trouvé un accord avec le principal parti d’opposition sur le projet de loi qui permettra à la police de confisquer les biens des réfugiés à leur arrivée au Danemark. Ils ne pourront garder que les objets ayant une valeur affective.\\r\\nC’est ce mercredi que le Parlement danois se penche sur la nouvelle version de ce projet de loi polémique, note le quotidien Jyllands-Posten. Le texte en question stipule que, quand les réfugiés arriveront au Danemark, leurs valises seront désormais fouillées par la police afin de voir s’ils ont de l’argent ou des objets de valeur. Le cas échéant, les forces de l’ordre saisiront les biens.\\r\\n	Social and Political Matters
98	French	Impressionnantes, puissantes, nées dans l'après-guerre sur les décombres de l'histoire, les oeuvres de l'artiste allemand Anselm Kiefer percutent et émeuvent. Le Centre Pompidou en présente une magistrale rétrospective.\\r\\nCertaines oeuvres claquent comme une gifle. On s'en approche. On recule. Puis on revient sur ses pas, partagé entre stupéfaction et trouble. Anselm Kiefer nous a saisis ! Ici, un livre ouvert arbore ses pages calcinées comme autant de cicatrices. Figé tel un témoin-fossile, il dira, mieux qu'une complexe allégorie, tous les attentats et autodafés dont l'homme a parfois meurtri sa mémoire. Le voyage a commencé. Ses paysages vont habiter des toiles monumentales. Leurs champs de labours enneigés traceront à l'infini des sillons désolés. Ses tournesols, géants au coeur sombre, se pencheront en silence sur un être allongé.\\r\\n	Culture
99	German	Im Süden Chiles sind mehr als 330 Wale gestrandet - eine der größten Strandungen dieser Art, die jemals registriert wurden. "Es erschien uns wie ein apokalyptisches Bild. Noch nie hatte ich so etwas gesehen", berichtete die Direktorin des Wissenschaftszentrums Huinay, Vreni Häussermann. Sie hatte an der Expedition teilgenommen, die die toten Wale zählte.\\r\\nMehr als 20 Sei-Wale mit einer Länge von etwa zehn Metern waren im vergangenen April als tot gemeldet worden, nachdem sie im Norden des Golfs von Penas in Patagonien fast 2000 Kilometer südlich der chilenischen Hauptstadt Santiago gestrandet waren. Wissenschaftler, darunter Häussermann, überflogen dann im Juni das schwer zugängliche Gebiet.\\r\\n	Nature
100	German	Das Mindesthaltbarkeitsdatum ist abgelaufen - aber wegwerfen muss man Lebensmittel deshalb noch lange nicht. Vieles hält sich deutlich länger, und beim Check darf man sich ruhig auf die eigenen Sinne verlassen.\\r\\nWir alle werfen Lebensmittelweg, jeden Tag. Das Bundesministerium fürErnährung undLandwirtschaft hat 2012 in einer Studie ermitteln lassen, dass jedes achte Lebensmittel, das wir einkaufen, in der Mülltonne landet - die meisten noch in Originalverpackung. Pro Kopf und Jahr sind das etwa zwei volle Einkaufswagen mit Lebensmitteln im Wert von 235 Euro, die wir wegwerfen.\\r\\n	Health and Sport
101	German	Was geschieht nach dem Ende des siebten und letzten Buchs der Harry-Potter-Serie? Ein Theaterstück erzählt die berühmte Geschichte weiter - nun stehen die drei Hauptdarsteller dazu fest.\\r\\nHarry Potter als Ehemann, Vater von drei schulpflichtigen Kindern und Mitarbeiter im Ministerium für Magie: Im Sommer kommenden Jahres geht die Geschichte um den berühmtesten Zauberlehrling weiter - allerdings nicht auf Buchseiten, sondern als Theaterstück. Nun ist auch klar, wer die Hauptrollen darin übernehmen wird: Jamie Parker wird den erwachsenen Harry spielen, Noma Dumezweni bekam die Rolle der Hermine und Paul Thornley wird als Ron Weasley zu sehen sein.\\r\\n	Culture
102	Spanish	El pomelo no es un alimento milagro pero, si lo que queremos es perder peso de forma saludable, este cítrico nos ayudará a darnos un poco de impulso en nuestro objeto. Un estudio del Centro de Investigación Scripps (EE.UU.) monitorizó peso y características metabólicas de 91 participantes, tanto masculinos como femeninos, durante 12 semanas. Cada participante fue asignado al azar en distintos grupos. Un grupo recibió cápsulas de placebo junto con zumo de manzana; el segundo grupo, cápsulas de pomelo con zumo de manzana; el tercer grupo, zumo de pomelo y una cápsula de placebo; el último grupo, la mitad de un pomelo fresco y un placebo, tres veces al día antes de cada comida. Los resultados revelaron que el grupo que había tomado pomelo fresco, además de una reducción significativa de los niveles de glucosa, también presentó una mayor pérdida de peso con respecto a los demás participantes.	Health and Sport
103	Spanish	Un equipo de investigadores de distintas instituciones internacionales ha descubierto que la mayoría de las estrellas alberga en su interior un intenso campo magnético. De hecho, este es hasta diez millones de veces más potente que el de la Tierra en aquellas que son solo un poco más masivas que el Sol. Para determinarlo, estos astrónomos han analizado una muestra de 3.600 gigantes rojas, unos objetos fríos y muy grandes, con una masa de hasta nueve veces la del astro rey, que ya han agotado el hidrógeno en su núcleo. Este podría ser, precisamente, el destino del Sol dentro de 5.000 o 6.000 millones de años.	Science
104	Spanish	A lo largo de la Historia, siempre surgieron plagas mortíferas como si fuesen un enemigo invisible que se empeñase, periódicamente, en aniquilar a los seres humanos.\\r\\nEn el siglo XIV, no se produjo la primera manifestación de la peste negra, la infección más letal que se conoce. Ya había aparecido antes en el año 542, en Constantinopla y se conoció como Plaga de Justiniano, después se fue reproduciendo en cliclos de ocho o doce años hasta desaparecer por completo en el año 700. Según cifras estimativas, la peste de la Antigüedad se llevó a un total de más de 200 millones de personas.\\r\\n	History 
105	Russian	Тем туристам, кто не намерен ограничиваться знакомством только с историческим центром Стокгольма, предложат аренду велосипедов. В этом случае туристические возможности расширяются несказанно. Можно не только посмотреть практически весь город, но и заглянуть на рынки и в музей.\\r\\nПопулярность в Стокгольме пользуется и водный транспорт. Экскурсии на катере позволяют не только полюбоваться городскими набережными, но и побывать в окрестностях шведской столицы – Ваксхольме, где нашли пристанище любители парусного спорта, и в Фьедерхольмарне, где можно посетить музей виски и заглянуть к стеклодувам.\\r\\n	Culture
106	Russian	Письма и документы немецких лингвистов и писателей-сказочников Якоба и Вильгельма Гримм стали доступны для свободного просмотра в Интернете. Об этом сообщили представители Университета Касселя. Именно они проделали колоссальную работу над архивом семейства Гримм и выложили в сеть отсканированные копии старинных документов. \\r\\nВ виртуальный архив попали письма не только самих братьев, но и их родственников. Датируется коллекция документов 1698-1949 годами. Оригиналы писем и документов хранятся в Государственном земельном архиве Гессена в Марбурге. Переданы документы семейства общественности были Марко Плоком - правнуком Вильгельма Гримма.\\r\\n	Culture
107	Russian	К химическим явлениям относят такие явления, при которых одни вещества превращаются в другие. Химические явления называют иначе химическими реакциями. \\r\\nТо, из чего состоят физические тела, то есть окружающие нас предметы, называется веществом. Простое вещество состоит из атомов только одного вида или из молекул, построенных из атомов одного вида. Сложное вещество состоит из молекул, построенных из атомов разных видов.\\r\\nСмесью называется вещество, состоящее из молекул (или атомов) двух или нескольких веществ. Вещества, составляющие смесь, могут быть простыми и сложными.\\r\\n	Science
108	Russian	Финансовые аналитики предрекают резкое и серьезное укрепление доллара в 2016 году. Впрочем, как говорится в материале агентства Bloomberg, перед американским долларом смогут устоять канадский доллар, британский фунт стерлингов и норвежская крона. А вот новозеландский и австралийский доллары, а также швейцарский франк сдадут свои позиции.  Специалисты ожидают, что доллар будет укрепляться не менее двух лет.\\r\\nЧто касается рубля, то специалисты агентства предрекают ему дальнейший обвал - до 20% и падение экономики России на полпроцента. Если эти прогнозы верны, то нас может ожидать курс доллара в 87 рублей.\\r\\n	Economy
109	Ukranian	Львівська бізнес-школа та Видавництво Старого Лева запрошують на презентацію перекладу книги Сунь-дзи «Мистецтво війни» у м. Івано-Франківську. Вперше з давнокитайської на українську мову книгу переклав Сергій Лесняк, викладач з міжнародного бізнесу, історик філософії Сходу. Перекладач, переконаний, що філософськостратегічний твір давньокитайського воєначальника та викладені в ньому ідеї і поради стосуються не лише стратегії бою і завоювання, але й усієї діяльності людини, зокрема й бізнесу.\\r\\nВ оформленні книжки використано оригінальні каліграфічні написи, надані Сергієм Лесняком.\\r\\n	Culture
110	Ukranian	Літературний фестиваль в Пулі ошелешив мене величезним вибором книжок. Тобто багато зарубіжних письменників були представлені не так, як у нас двома-трьома книжками, а десятками книжок, включаючи й томи їхнього листування чи щоденники. І хоча на львівському Форумі видавців значно менший асортимент книжок, ніж на ярмарку в Пулі, але зате в нас яблуку ніде впасти. Натомість у Пулі відвідувачів було небагато. При цьому треба сказати, що як і в колишній Югославії, так і в Хорватії, книжки дуже дорогі. Подекуди дорожчі навіть за австрійські чи німецькі, не кажучи про польські та чеські.	Culture
111	Ukranian	Фізика — природнича наука. В її основі лежить експериментальне дослідження явищ природи, а її задача — формулювання законів, якими пояснюються ці явища. Фізика зосереджується на вивченні найфундаментальніших та найпростіших явищ і на відповідях на найпростіші запитання: з чого складається матерія, яким чином частинки матерії взаємодіють між собою, за якими правилами й законами здійснюється рух частинок, тощо. В основі фізичних досліджень лежать спостереження. Узагальнення спостережень дозволяє фізикам формулювати гіпотези щодо спільних загальних рис тих явищ, за якими велися спостереження. 	Science
112	Ukranian	В Ірані повідомили про остаточне скасування санкцій, що забороняли європейцям купувати продукцію іранських нафтохімічних підприємств. Про це повідомляє Європейська правда з посиланням на іранське агентство IRNA.\\r\\nІранські нафтохіміки вперше за п'ять років отримали гроші за свій товар через зареєстрований в ЄС банк. За словами директора нафтохімічної торгової компанії Мехді Шаріф Нікнафса, його компанія отримала перший платіж на рахунок в одному з банків Іспанії.\\r\\nЦе перше постачання іранської нафти в ЄС після скасування санкцій, які тривали п'ять років, уточнив він.\\r\\n	Economy
113	Portoguese	Mais de 10 mil crianças imigrantes podem ter desaparecido depois de chegar na Europa apenas nos últimos dois anos, segundo a unidade de inteligência da polícia da União Europeia.\\r\\nA Europol disse que as milhares de crianças desapareceram depois de serem registradas por autoridades.\\r\\nA polícia do bloco europeu ainda alertou que crianças e jovens podem estar sendo explorados sexualmente e usados em trabalho escravo por gangues de criminosos.\\r\\nEsta foi a primeira vez que a Europol forneceu uma estimativa de quantas crianças imigrantes podem estar desaparecidas em todo o bloco europeu.\\r\\n	Social and Political Matters
114	Portuguese	Polvos podem ter mais interações sociais do que se acreditava anteriormente, afirma um novo estudo.\\r\\nBiólogos estudaram um grupo de polvos na Costa Leste da Austrália e observaram uma variedade de comportamentos que podem indicar uma complexa capacidade de comunicação.\\r\\nPolvos que ficam "de pé", escuros e com os tentáculos espalhados estão provavelmente com temperamento agressivo.\\r\\nPor outro lado, os polvos podem assumir cores mais claras depois de perder uma briga ou para sinalizar que não querem brigar.\\r\\n	Science
115	Portuguese	Os casos de zika e microcefalia no Brasil aumentaram a preocupação com a picada do mosquito Aedes aegypti, que já era temido por causa da dengue.\\r\\nDesde outubro, foram notificados 4.180 casos suspeitos de microcefalia no país - 270 já foram confirmados, 462 descartados e os outros seguem em investigação.\\r\\nComo não existe vacina ou tratamento para a zika, o conselho, principalmente para as grávidas, é tomar medidas para se proteger da picada do mosquito.\\r\\nMas por que mosquitos picam algumas pessoas mais do que outras? Segundo um estudo, publicado no ano passado no periódico PLOS ONE, isso pode estar ligado aos genes que controlam o odor corporal.\\r\\n	Science
116	Portuguese	Barreiras às exportações equatorianas de camarão, peixe e banana para o Brasil e a necessidade de um acordo para facilitar investimentos estão entre as questões que Brasília e Quito prometem resolver em um encontro marcado para março, conforme anunciado na terça-feira pela presidente do Brasil, Dilma Rousseff, e o do Equador, Rafael Correa.\\r\\n"Um dos três maiores deficits comerciais do Equador hoje é precisamente com o Brasil, no qual temos tido dificuldade de entrar com nossas principais exportações não petroleiras – basicamente banana, camarão e peixe, especialmente o atum", disse Correa.\\r\\n	Economy
117	Portuguese	Os investidores da Apple estão assustados: embora 2015 tenha sido um ano vigoroso, algo peculiar aconteceu neste mês: o preço da ação da Apple caiu para menos de US$ 100 (R$ 410) pela primeira vez desde outubro de 2014.\\r\\nHá muitos rumores no ar, mas é nesta terça-feira que realmente saberemos se 2016 será um ano difícil para a gigante da tecnologia - é nesta terça que devem ser divulgados dados de seu desempenho recente e expectativas para os próximos meses.\\r\\nÉ nesse momento que a companhia apresenta suas preocupações, os problemas que mantêm seus executivos acordados à noite (ou ao menos estressados nas salas de reuniões).\\r\\n	Economy
118	Italian	RENZI IN NIGERIA: "DISTRUGGEREMO I TERRORISTI"\\r\\nMassimo impegno dell'Italia alla lotta al terrorismo. Lo ha garantito il Presidente del Consiglio Matteo Renzi ad Abuja, in Nigeria, dove ha incontrato il presidente della Repubblica federale, Muhammadu Buhari nel palazzo presidenziale. "I terroristi sanno benissimo che la comunità internazionale è impegnata a distruggerli - prosegue - e noi li distruggeremo, con determinazione, perchè i nostri valori, le nostre idee, i nostri ideali sono troppo grandi per essere bloccati\\r\\n	Social and Political Matters
119	Italian	L'atleta che ha riportato la storica vittoria è Kotoshogiku (il vero nome è Kazuhiro Kikutsugi) che è un "ozeki", che significa che ha un titolo solo di un livello inferiore allo "yokozuna", il campione assoluto. Kotoshigiku ha battuto Goeido, diventando così il primo sumotori giapponese a vincere il titolo dopo Tochiazuma nel 2006. Nella classifica ha superato di un incontro Hakuho, il grande campione di origine mongola, che con l'altro mongolo Asashoryu ha di fatto dominato il mondo del sumo negli ultimi anni insieme ai due europei Kaido Hoovelson (che combatte come Baruto Kaito), estone e campione 2012 soprannominato  'sumotori' dagli occhi azzuri, e il bulgaro Kotooshu (Kaloyan Mahlyanov Stefanov, il vero nome), primo europeo a conquistare in assoluto il trofeo nel 2008. 	Sport and Health
120	Italian	Per la prima volta nel Regno Unito un gruppo di scienziati del Francis Crick Institute di Londra è stato autorizzato a gestire embrioni umani per fini di ricerca. Lo ha annunciato l'autorita' britannica per la fertilizzazione e l'embriologia (Hfea). L'autorizzazione prevede l'utilizzo del metodo Crispr-Cas9, che permette di bersagliare e neutralizzare i geni inadempienti nel Dna in modo più preciso. Si cerca in pratica di studiare i geni coinvolti nello sviluppo di cellule che formano la placenta per cercare di spiegare gli aborti spontanei. Si tratta di una delle prime autorizzazioni di manipolazione di embrioni umani, dopo un primo tentativo cinese all'inizio del 2015. 	Science
121	Italian	L’arte messicana nella città di Partenope: è in corso nell’Instituto Cervantes di Napoli la mostra “Cuore lontano, cuore messicano. 6 artisti in Italia”. L’esposizione, organizzata dall’Ambasciata del Messico in collaborazione con l’Instituto Cervantes, arriva per la prima volta in Italia e comprende 39 opere di diversa dimensione, realizzate tra il 2000 e il 2015 da Ana María Serna, David Beuchot, Jehsel Lau, Karla Guajardo Ro, Ricardo Macías e Santos Badillo. Sei tra i più interessanti artisti messicani residenti in Italia. 	Culture
122	Italian	Sotto la 'Madunina' fa festa il Milan che affonda 3-0 l'Inter in crisi sempre più palese. Per i nerazzurri ci sono solo 5 punti nelle ultime 6 gare, corredate da tre sconfitte. E' pur vero che i rossoneri arrotondano il risultato solo nel finale, dopo aver rischiato il pari sul rigore fallito da Icardi. Ma i gol incassati sotto questo aspetto fanno ancora più male. E il nervosismo di Mancini, espulso per proteste a inizio ripresa e che mostra il dito medio ai tifosi del Milan, testimonia una situazione complicata nella quale è difficile capire dove mettere mano. 	Sport and Health
\.


--
-- TOC entry 3756 (class 0 OID 1791154)
-- Dependencies: 204
-- Data for Name: skilltest; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.skilltest (id, language, question, answer1, answer2, answer3, scelta) FROM stdin;
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
-- TOC entry 3758 (class 0 OID 1791162)
-- Dependencies: 206
-- Data for Name: traduttore; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.traduttore (id, nome, cognome, data_nascita, madrelingua, password, has_new_message, username, email, vat, citta, cap, provincia, idstato, madrelinguaid, stato) FROM stdin;
82	Claudia	Ramirez	\N	\N	3e1b7adeca0162d68bd908ddccbf83dcb89376af6e4bf23f9992a29efbe1e1f0	N	clrm2018	claudiaramirez.m@gmail.com	N/A	\N	\N	\N	\N	\N	\N
83	Akiko	Numata	\N	\N	54b053cca36c971a2807d001744d5bff3650b482f8fc776cd3f71bd5f6e932d3	N	Akikomemceroktaty	numataakiko@hotmail.com	undefined	\N	\N	\N	\N	\N	\N
84	Adi	Saputra	\N	\N	557afe58fb4ac32832e7384b564a56fd799bdbb106a38864d725159a2be15d70	N	Adi Saputra	adisaputra_9@yahoo.com	undefined	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 197
-- Name: agenzia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.agenzia_id_seq', 2, true);


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 199
-- Name: currencies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.currencies_id_seq', 196, true);


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 203
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_id_seq', 17, true);


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 205
-- Name: skilltest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.skilltest_id_seq', 1, false);


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 207
-- Name: traduttore_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.traduttore_id_seq', 84, true);


--
-- TOC entry 3611 (class 2606 OID 1791181)
-- Name: agenzia agenzia_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenzia
    ADD CONSTRAINT agenzia_pkey PRIMARY KEY (username);


--
-- TOC entry 3613 (class 2606 OID 1791183)
-- Name: agenzia agenzia_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenzia
    ADD CONSTRAINT agenzia_username_key UNIQUE (username);


--
-- TOC entry 3615 (class 2606 OID 1791185)
-- Name: payments payments_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_id_key UNIQUE (id);


--
-- TOC entry 3621 (class 2606 OID 9001220)
-- Name: ratingtest ratingtest_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ratingtest
    ADD CONSTRAINT ratingtest_id_key UNIQUE (id);


--
-- TOC entry 3617 (class 2606 OID 1791187)
-- Name: traduttore traduttore_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.traduttore
    ADD CONSTRAINT traduttore_pkey PRIMARY KEY (username);


--
-- TOC entry 3619 (class 2606 OID 1791189)
-- Name: traduttore traduttore_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.traduttore
    ADD CONSTRAINT traduttore_username_key UNIQUE (username);


--
-- TOC entry 3622 (class 2606 OID 1791190)
-- Name: language_pair language_pair_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language_pair
    ADD CONSTRAINT language_pair_username_fkey FOREIGN KEY (username) REFERENCES public.traduttore(username);


--
-- TOC entry 3624 (class 2606 OID 1791195)
-- Name: payments payments_secondtranslator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_secondtranslator_fkey FOREIGN KEY (secondtranslator) REFERENCES public.traduttore(username);


--
-- TOC entry 3625 (class 2606 OID 1791200)
-- Name: payments payments_translator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_translator_fkey FOREIGN KEY (translator) REFERENCES public.traduttore(username);


--
-- TOC entry 3626 (class 2606 OID 1791205)
-- Name: payments payments_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_username_fkey FOREIGN KEY (username) REFERENCES public.agenzia(username);


--
-- TOC entry 3623 (class 2606 OID 1791210)
-- Name: languages test_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT test_username_fkey FOREIGN KEY (username) REFERENCES public.traduttore(username);


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO rrvkxtiqcmdwhu;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 633
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON LANGUAGE plpgsql TO rrvkxtiqcmdwhu;


-- Completed on 2018-03-12 11:48:13 CET

--
-- PostgreSQL database dump complete
--

