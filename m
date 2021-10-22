Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30B9437F5B
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhJVUeb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 16:34:31 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:54753
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232411AbhJVUea (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 16:34:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHIRKaXkZ55pC9ze9492TBH2Fn95sahC3Sy5AxI24w5skFca5GgNrbl+9+A32cAOsLaKGf6U1euILkjY4uk6QrZska2aJiINSPdX/BkM+JQTEpK/MNPCXTxZYPjzBzIvsPoMZVV/vJbK5oz5XDFpXGC4Ksi6Dwfx3OWdDKtr1MZMn1e4r2yuHyTUH8ReK2QQ3hZV87Ii1EpGranQ7XBDx9qnp2B5lMG4FQyDhmhzH9M/kvV9FI1EL3zFtXlA3BiDRt9ZSptZzFaZjeZt+lkJ+D27J/tIZjWdoo5mCopEZggomi+Vx6MG6bEADA7yc9uWa2Egnr9QdXz3IgullKiLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uk7XeJcR3nb35+Z2XY+gphHBcS/B6TMyhEn66C/x12s=;
 b=AU4SoweC2USbJV3n4FIobLrVqbpkpoZrw6OeWTrYuGzgZhgvNFwVAjXHCOgH8IELEiNHM3m26NfWxO29fgqKFJmvNIe5pOPM5Wj+fTgWHIBkdLBC1wdtkCG2/vpFPJadBUrb3Ta/0mqJtzkWJB/Q49OVlfEdepk9nzrQY0VjW5iKRTXzp+V/F8IxK0qrVubwXpA1bM2Zj41ygAoXm8RgdDlv8NxeiFNfJ1SrE0g+e6X6VQPqRdTLTTKKbuL7iuknZ/D/oX5yRHQAg6B1qz0un7QGjG8Tud8EhbjfFsYcOQS3/Qu4Kpk06KN9gZMJneAimE7uAdRdpDpCDdZzf8SCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk7XeJcR3nb35+Z2XY+gphHBcS/B6TMyhEn66C/x12s=;
 b=PSv0fMXRPGPsf6F5SmwKuklvVpOMA/K3GG92rVqcz3m1q3JTzWehhTQNaSoojXyAOaHfc/hYb4sJtHclJ1DOfSKMRJWgFm4ECwT3Tpx1yV0Ya7hLIVVzSBUZ/zbIyHP9CEEKlJcPiE+fCzJchl2dTNARLcKGOL41cbBK0H9NBMA=
Received: from DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 20:32:10 +0000
Received: from DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::65:3406:3d73:adbc]) by DM6PR12MB4499.namprd12.prod.outlook.com
 ([fe80::65:3406:3d73:adbc%8]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 20:32:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] ACPI: Add stubs for wakeup handler functions
Thread-Topic: [PATCH v3 1/2] ACPI: Add stubs for wakeup handler functions
Thread-Index: AQHXxQL4+yUIBCnkd0qfhIyNlvs+8Kve/d0AgAB/wlA=
Date:   Fri, 22 Oct 2021 20:32:10 +0000
Message-ID: <DM6PR12MB44995E8EAFF6A029F3E320AAE2809@DM6PR12MB4499.namprd12.prod.outlook.com>
References: <20211019160401.8296-1-mario.limonciello@amd.com>
 <2615562.mvXUDI8C0e@kreacher>
In-Reply-To: <2615562.mvXUDI8C0e@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T20:32:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5ba35d6e-f23f-4244-b81f-3cce671b6e3b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa613686-03cd-4d13-4118-08d9959b0651
x-ms-traffictypediagnostic: DM6PR12MB4620:
x-microsoft-antispam-prvs: <DM6PR12MB4620B10CD596F76D88E3EBD1E2809@DM6PR12MB4620.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3fvND6wAFeUuRKGIU9EBGl9E2TFD/801ONoOZJlykbnjetsHApynhKH22116wqo6z5zKgqAfZqqpW1kiilcsZvnR9+OvDRLcyDWPKQslvEzU53PNVagAeWIEiEtL+RiVdiWWTWsTos7dkxus3hoB7GoZ9l5Z4ronE4U95wQeILJ/t4WrXQI7leSBudsV4X7YKKIPUb7dR3i69iLTWdVtxPQ7rhNtq4XLTb8pWKx1PyS+wVIB3uQLLn6g2MMVTRY9fpxUCXmUlWrbr14VJoFNvjg9TLnDrHlqbWKQNpoI90nLZ/HnytAAg9lUnJ2toTEIW+xYJz3Elly4avQCWHq9WXCLZjlgwMWujKuvYCa0TEe0n0zyNS5/S0x/Q5kNU0Uv4U29xF6CD9G2r22KD5+DPTKSjnMPlqAPDup5nFGn5N4MdVVUHS7iM4N8MbJ2Jusv9TqPsbligwJ07J53YJs3f5u0lIniJ3bZN7xOoC5FroLldxfW4jEChZOnpQdgFW8h54/FCMpnK659Mr4gl4qmI3+Z2/IF0dQ7rA+F6JGe4pFWjguYNOn9CzEeeMsaTKRoeApEP/F99ui4SgpeQJhg3jx7A48ZvyxE7Wo64vK+6xH/yP9MzPJZ7Yt5RI6setyn0Qz+k7STw9Oh6Wa2bnHAUmrjHadFGXicfxZni6SI0pqhCOjjiVy6fV3aaPiOgTMbEIcC8TMDY4TlfahCftXDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4499.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(7696005)(9686003)(5660300002)(316002)(53546011)(6916009)(66556008)(52536014)(6506007)(86362001)(66946007)(76116006)(38100700002)(66476007)(122000001)(64756008)(66446008)(8676002)(33656002)(71200400001)(4326008)(55016002)(2906002)(8936002)(83380400001)(54906003)(508600001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFB0Q1BJRk9jVkV2MitGSDdsb1hqRVBnVit5NkhPNWZmQkVBR0ZmanowNFNl?=
 =?utf-8?B?RHVDRXNUaGppNCtHQmpPQmdVaExvWVMyNkFWQ2xGY00zSmZRdzV1RmZuelVC?=
 =?utf-8?B?aXpVa2pKcDdSa1pHazQzQUhDMldGZjhBbHJuNnFXZi9LYy9odkZEZnp3bkpF?=
 =?utf-8?B?ZEFGQ0lPQm1xb3I4Q3Q1LzJ6Z3hlaFZuM0FGZEhDRW5rczNXekUyTklhckVi?=
 =?utf-8?B?VXNVeG4ycXBHaFZXQlV6RFlMeGpWbWpsTVdOelp3S1ljdUZPdHJEV3QvTk9W?=
 =?utf-8?B?THZSVDZxQTRXYXlSUFhrSXIvdllnTndpaHNJRnpUdmJacEl1MVhoc01hWmV4?=
 =?utf-8?B?THNVR0YvNWlsazM4UCtyYm5YZENZdElDODFNc2FzdFdsbjlOS0ZhTVdqbk5E?=
 =?utf-8?B?OTE5eTZvMGVBTGJPYUtTSEliTml2aVB2cDNveHNOZisxREkrZEF3eVVhTG9I?=
 =?utf-8?B?eSt4ZFBIVXdQU1dlUEFGVlNBdHBZRFE5NEtOcUV5dlVsd3o5eUExVlZJaFpw?=
 =?utf-8?B?eUp5K0FTcTR3azA5Y0dHSHMwcEo5RWxrTGh2bGFFYVhydEtFbEx2ME95MWY1?=
 =?utf-8?B?RUVDSUlxQTArdnQ5QjFnWU5td1hrMzFCdjdIMDRWSXo4Sm54S2cvanhnZXJS?=
 =?utf-8?B?Zm1DeXpaWDkxcFRqT3RGMUxYSlhrLzIwa0JVZGZKUnJsN0w5MWFPbUZaRld6?=
 =?utf-8?B?NDcwMWN4TzlHVVZOSXVYR1gzU2UrbFUvV3MxUFc2eXRJNnRqeG1UWnhLMDBu?=
 =?utf-8?B?Nk9GUVJReTFBRXhJa28yQXNhakVzVnViYVpmd2dDTE1ETERXakFBU2VPTGNV?=
 =?utf-8?B?dDdJWXNIVEVSUGhIdTdSa0pBTERzVzgvWGtLTmtlZXF1b0xSR29MTzhwaXdv?=
 =?utf-8?B?R2dnQWZsb3FBeUdqcC84bUU0cDhlb21DMFAvY0VrK3YyS3dSbHRSeHNTaEFa?=
 =?utf-8?B?R1k3aE1Yd1VaVXF0QlJjMnhHc1FzeVE1UVNwN0ZGTHhLenVoTXpTMkNJVVkr?=
 =?utf-8?B?bXRtRG5UVkRlRDExUHNkVUROVEw1RGNlU0pFdE53NHBiazJxdXptSUVSQ0VB?=
 =?utf-8?B?eTZLZ21nTjgvdkhxbHRwd2M5RXZpd0pGWmtHcFMxMzR4a1g2QUNVSitBQUhh?=
 =?utf-8?B?OXB4eTBWbzUyMkhURVRScE10ZVlxTS9tTHNteVpRZkM4ZUpha0VSUUZHYWd0?=
 =?utf-8?B?S3ZwU25vSDVMQzFCNkZ0TXlaT1ZVaElvM1BuSVBDZ0Q2Y25DVm9iYnJxMXYr?=
 =?utf-8?B?TzR5bk15VEZaWVQ2aVdrbTFJT2Q1ZlZ0dUxQREFNeWJCVVo0d1BjRENNOVNl?=
 =?utf-8?B?Q3h5dktuVFhjZ2JxYzQ1ZXhJemxLK0owQU5vV3cyTFRhZVJuVjd5b1lnYzVj?=
 =?utf-8?B?NWlJeFVoVDhxODB1bmNyaDNpSzBsNzBUSVF6VWF1MzVvMDdnTVpWd2FMZ1A1?=
 =?utf-8?B?emFqbm04V1ptalFhMFJFcFlaREg0U2hROSt4TVNoMDk4WXpNaHkrQ1lKSFJW?=
 =?utf-8?B?WUM2cmFhVTI1UWNWWENaT1d1cTdsajdSMjdwRHhmNjk4d0NMSWxVOVliUHJB?=
 =?utf-8?B?MHdCelVmUGF1N1JXdENWOHhMak5SUFdFRXA1cTQwd1RGSjZGMnBsYmJCQ0NY?=
 =?utf-8?B?WUpLSVExb1ZxSXR2dzFSWWM2c3RWSlZLQUFVakxBYUZUcU02bEErWWtMbVY4?=
 =?utf-8?B?MGtXekl1Z1NnTHp1cFk3RGh3UktOblJ4ZXlpRTduTGVkOThOeFp5elQxYlFs?=
 =?utf-8?B?K0k1Mk1IVjVvRzE3dzJheTNvMjlGVlo3N254YngyU2QwNzZPY3BPQWp6VFEz?=
 =?utf-8?B?WDdkTml1NWdEcUlQUDRabWRTUHBUeW8rMm9Rd1FSQUdXZFV6Rmh3Ny9QNDRI?=
 =?utf-8?B?WTJzZkh4eHprOHVQYkVPZEpYcExoODUzM2tobGg5RThsQkQ3OWlvOUloVlBx?=
 =?utf-8?B?QTZadTdZWktSd0Jnc0pucWdXd3NpeXpCWXUzVUNkNEcwODRLMW9OazNId1Bq?=
 =?utf-8?B?eWlhNC8wV2N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4499.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa613686-03cd-4d13-4118-08d9959b0651
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 20:32:10.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlimonci@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJqd0Byand5c29ja2kubmV0Pg0KPiBTZW50OiBGcmlkYXksIE9jdG9i
ZXIgMjIsIDIwMjEgMDc6NTQNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz47IE5hdGlrYXIsIEJhc2F2YXJhag0KPiA8QmFzYXZhcmFqLk5hdGlrYXJAYW1kLmNvbT47
IFMtaywgU2h5YW0tc3VuZGFyIDxTaHlhbS1zdW5kYXIuUy0NCj4ga0BhbWQuY29tPjsgb3BlbiBs
aXN0OlBJTiBDT05UUk9MIFNVQlNZU1RFTSA8bGludXgtDQo+IGdwaW9Admdlci5rZXJuZWwub3Jn
Pjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2hhaCwgTmVoYWwt
DQo+IGJha3VsY2hhbmRyYSA8TmVoYWwtYmFrdWxjaGFuZHJhLlNoYWhAYW1kLmNvbT47IExpbW9u
Y2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IExpbnV4IEFDUEkg
PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEv
Ml0gQUNQSTogQWRkIHN0dWJzIGZvciB3YWtldXAgaGFuZGxlciBmdW5jdGlvbnMNCj4gDQo+IEND
OiBsaW51eC1hY3BpDQo+IA0KPiBPbiBUdWVzZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDY6MDQ6MDAg
UE0gQ0VTVCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToNCj4gPiBjb21taXQgZGRmZDlkY2YyNzBj
ICgiQUNQSTogUE06IEFkZCBhY3BpX1t1bl1yZWdpc3Rlcl93YWtldXBfaGFuZGxlcigpIikNCj4g
PiBhZGRlZCBuZXcgZnVuY3Rpb25zIGZvciBkcml2ZXJzIHRvIHVzZSBkdXJpbmcgdGhlIHMyaWRs
ZSB3YWtldXAgcGF0aCwgYnV0DQo+ID4gZGlkbid0IGFkZCBzdHVicyBmb3Igd2hlbiBDT05GSUdf
QUNQSSB3YXNuJ3Qgc2V0Lg0KPiA+DQo+ID4gQWRkIHRob3NlIHN0dWJzIGluIGZvciBvdGhlciBk
cml2ZXJzIHRvIGJlIGFibGUgdG8gdXNlLg0KPiA+DQo+ID4gRml4ZXM6IGRkZmQ5ZGNmMjcwYyAo
IkFDUEk6IFBNOiBBZGQgYWNwaV9bdW5dcmVnaXN0ZXJfd2FrZXVwX2hhbmRsZXIoKSIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5j
b20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvYWNwaS5oIHwgOCArKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9hY3BpLmggYi9pbmNsdWRlL2xpbnV4L2FjcGkuaA0KPiA+IGluZGV4IDcy
ZTRmN2ZkMjY4Yy4uYjMxYmNjMGY0Yzg5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgv
YWNwaS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9hY3BpLmgNCj4gPiBAQCAtOTc2LDYgKzk3
NiwxNCBAQCBzdGF0aWMgaW5saW5lIGludCBhY3BpX2dldF9sb2NhbF9hZGRyZXNzKGFjcGlfaGFu
ZGxlDQo+IGhhbmRsZSwgdTMyICphZGRyKQ0KPiA+ICAJcmV0dXJuIC1FTk9ERVY7DQo+ID4gIH0N
Cj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIGludCBhY3BpX3JlZ2lzdGVyX3dha2V1cF9oYW5kbGVy
KA0KPiA+ICsJaW50IHdha2VfaXJxLCBib29sICgqd2FrZXVwKSh2b2lkICpjb250ZXh0KSwgdm9p
ZCAqY29udGV4dCkNCj4gPiArew0KPiA+ICsJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtRU5PVFNV
UFAgPw0KPiANCg0KY2hlY2twYXRjaCByZXBvcnRzOg0KDQpXQVJOSU5HOiBFTk9UU1VQUCBpcyBu
b3QgYSBTVVNWNCBlcnJvciBjb2RlLCBwcmVmZXIgRU9QTk9UU1VQUA0KDQpTbyB3aGF0IHRvIHVz
ZT8NCg0KPiA+ICt9DQo+ID4gK3N0YXRpYyBpbmxpbmUgdm9pZCBhY3BpX3VucmVnaXN0ZXJfd2Fr
ZXVwX2hhbmRsZXIoDQo+ID4gKwlib29sICgqd2FrZXVwKSh2b2lkICpjb250ZXh0KSwgdm9pZCAq
Y29udGV4dCkgeyB9DQo+ID4gKw0KPiA+ICAjZW5kaWYJLyogIUNPTkZJR19BQ1BJICovDQo+ID4N
Cj4gPiAgI2lmZGVmIENPTkZJR19BQ1BJX0hPVFBMVUdfSU9BUElDDQo+ID4NCj4gDQo+IA0KPiAN
Cg==
