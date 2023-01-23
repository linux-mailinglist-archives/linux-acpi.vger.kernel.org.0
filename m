Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5F677E72
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjAWOxo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAWOxn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 09:53:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2083.outbound.protection.outlook.com [40.92.23.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5869745;
        Mon, 23 Jan 2023 06:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCrfxkHepF09d2PVgcbZeEHqQvx7ONHN1HiPdP5EfN+uyO4pI0tosh5i/nhiacgb6DI93rYLXOKNbqveRrS6HCZFQYj+kEOgakECKYC9102clKxsgbjz6VyT5Xl6UDrY2CGTYVoeVqLqdyyAjmcpz3bwt9NMZX2zxPoLquA1K4dDgRDNEy2IKvm8kjgKWr9EXxdIHMhbxouz0vTNIyE0ZvBGYjlYaFNeKrPicc+TyAWVXJl90ia7HQFtVn3hP+ScwTn5pRty9vdvt3e0x6wvcoF7ZCTvwROkjDtZe/0S6Pa01Mw9vQDaJTCirR382ZVDwVSUdpbXJtrxwjyGPul1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lxup7MPyJQOpOfOsJp/sRvXtsfsdGb+nquJB6f8a2/k=;
 b=hfnES5DuB24vur4vU2mWn/PQOgmwtBOSPOu2dRWLTGbNqHG8ZiFN3NseLPedgbfbRDb04oAjTBD8Vbd+GrjxES3DeuQxsEoJhT4nw+IlbKikkFhwkdzPj5Ve57Yi5r6qOrwTfs3kwBob1PYx5AkuGDF0zr+V9QlPrSMzO4gOM6RDBRsyPDsYlVWEBtMdVXr6AQddwWUiu2R2l2VILV6cKjJC8IoDyG98t7CKvI5beYXF6gFIyd9ykNmKE/Td7g9i1nS9LzJSC0aBuGin2NkRsGZwjFTDZ3ckzOtMRzxRMHRjmB0fIPDr1Gp4ULGnYIPKTNUA4MQpX+6cwtK/5Vj/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lxup7MPyJQOpOfOsJp/sRvXtsfsdGb+nquJB6f8a2/k=;
 b=nhMMfOnMcDO8b8zSLilD9ti6vOJB+cuSq0F7PjIGdyCczOrpNRQOjOHD4JB+CEJ7dTc530Ig9hPu+ua17juO6J77wlvTz+06saPfPviyDj4SycBsKjPLwhC6jiF96ycZoo9GYyaO+op1RqXWBsfyyWMPK4pGy1q2+PMZjR+J1soIkGUJ42g+IDu3fmmbkqYE/O80BrjfFIs0yCgu1pExNGDqADGkhrP91IAsLsk7rtSkJST9GHLIyVElmr8eCpw3LZ/MLPCJGCH6jWFTFqAs6/jrRgwD2OH5L+j+FogrY63jVmXUOhcodMmC/qxVhbnx4OH8O32I9a3fBB8VpR9zvw==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB9253.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ce::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.16; Mon, 23 Jan 2023 14:53:37 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f2f0:34b5:eb58:bb5a%6]) with mapi id 15.20.6043.013; Mon, 23 Jan 2023
 14:53:36 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Thread-Topic: [PATCH 0/3] ACPI: video/apple-gmux: Improve apple-gmux backlight
 detection
Thread-Index: AQHZLx8nX302o6VY+EKTA1QgXCWC+K6sFqCA
Date:   Mon, 23 Jan 2023 14:53:36 +0000
Message-ID: <4E707490-819D-448A-904F-CD8028894CE2@live.com>
References: <20230123113750.462144-1-hdegoede@redhat.com>
In-Reply-To: <20230123113750.462144-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [QN5WTn6R4bC9sh5JhFkxJUL2VgpVwwBl]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB9253:EE_
x-ms-office365-filtering-correlation-id: caf603c3-8552-492b-695f-08dafd519b71
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KBFcmzM00+r+FCUgEyjCtzLs1KarbjNFoLPym14lR2zEIUClrtY/KUtVFwY4NADru1J8Qlu9/l1vu8DRLYE3XduOtpPSL/YckkvL9TRKEm03bc4tAdQ+ZvvbsimojoFz0LNL3KuxSz8Z7Qrv/k6j5fyYwy8w48y0p/78yM5p1/eO4OvRcSwX04kiEdhVadNFjo2HaeAKjs9t7GPl9pjK8OARVwUd0sSquI74O6WIMfKAWfOUOG2/k5HpmV0T6i+BiLsKq9/d+2pOpHRw2PkWJfcSwI1H+BQYG9c6puSjUGGtTrhnKFl3HxKaM8Xpjp3UkQM1hZAZV3cOhNV5yQSebBQ1Zv47KObPQKiWq5zV+adHGrdQGqeisQdcAlbGqcE7lynIPpPXwP3h9wmcWuM5JIZ1WhJwioa1VhHQy4TZSugTyCdEwjG5YmgEqqKxZmnGmL2Jnju+8vRcgP71gGdLOrO28/i+evUB8UIoH1fBpmiKmUtAOla4cA2Bf2QP2v2u6ZigrdVeZ5+YE+2VxRMj7SQJOFYnJfQuV175ZmPQV+WHLpGE2SY8mUod52ec8lxhAgMBU+NwlFR76u1G6vAI6Q9TTOkeiVb9mOLTdb5i3agfgNI7Dq7GJ/qAuYDJqlrjUCAbVITnot3KiNn0Uu6zQA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFc2aVI4UXo4SjRZRXJnaURGSGU5RWtuY2gzRmFKcndqeTVYVmIxWjRxODYw?=
 =?utf-8?B?WEZ5dHRHdVpzNzFzVjBVcTZKampuVEZ2eGZNU0hpZ1c1bk0vVVppNlIvcEhC?=
 =?utf-8?B?MDVBYjlQSHNyelpvVllmTGZZUTRGYVFJK1FEaGU1cURsYk43dkRpY3NxWDh1?=
 =?utf-8?B?U2NUSERDOHQyaEdUNnhIZG1vTm9vVjg3TDJKTE9vMHZBb1NCK2ZnOU5LVTMx?=
 =?utf-8?B?WlZobWQ1ODA4SUJOQTFDWGZPQitwSEljTEVHQjVhNUdoL2NxZURyWEFkV1kw?=
 =?utf-8?B?OTlpY1dsb3dhWllCU2RML1RRNStWNisrYTdYcnFnbXVsMEFDNWVqTmRpM0ZI?=
 =?utf-8?B?Q0R4b3BVRUQyQmVsWU9obUNsRVpTTGZuY2JzSVlZUlV5V2o2SDhNTmx3M0Q4?=
 =?utf-8?B?ZlIyZTdyajJNWWN1WnBPY0c1WlZZV0ZwTXAzaFo0SGFZMnpzWk9CNzBSelRy?=
 =?utf-8?B?S1gxV3JFYzZXb1lnTko2RjJhNTlYQ3FOb1haRUtGeEFqTU5hOTRvSUd1QW15?=
 =?utf-8?B?RFJnQUE1UTBSekFsK0l0UFc5UTZRWjF1V2pxU2J6TDFiUWFnR1o2V09tUStD?=
 =?utf-8?B?ZHdWbHNWWGU5c09NNElvTk5wNXFCZzd5Qkd0SzVqWU01MGpWMGVtSWQrR0h3?=
 =?utf-8?B?S0FWQ01IMFErTURoVnlkNHJYZkNVNFY0TGowcG1vVkNzQnU4cEhyRDBJdTNK?=
 =?utf-8?B?Q1JSUitGNVEwOFBTdnZsbnVpMXRpR3poYWltUlV6Q2xtU0dTdFAvNVZmVlkz?=
 =?utf-8?B?a1pvOGJUREN3R3JnTmZJODREZkw3ZUdKajBlSFBvdHVIb0l2QS9FT21JS2ZX?=
 =?utf-8?B?Q2h5dmNEV3J3dDZEZmpVckwvYW1Hb3V6cDhwT2cyU3M1bnc2NG1FZ01CNml6?=
 =?utf-8?B?eGQzbHdiYkhRaFVBQXJMM1FuRklQbFdNTVlabEw0OVJQTUxVcDNOWmhQTEdX?=
 =?utf-8?B?YUhRVkluRmx3dzVMTVdTOUJkTHh6UFZoK1RmTW1PcDI3U09JZm9EbTJpb01Q?=
 =?utf-8?B?Z2I4RThnOVRYZUNqZEhEODR1NG9Dek15NU9MWnkyRjBUMlFmdWl3NjFyWDBR?=
 =?utf-8?B?dG4rOEthRnpPQWl3cEdYQUhhZnJLcVFNWERaazJqVmM5cDk2YnhEOUZtQkY3?=
 =?utf-8?B?dk1Xd3RJc2F6UWtRalBvWnNNQVYxdVpVSk1NQ1FoOHNXYlBjUk0reDJzWEd5?=
 =?utf-8?B?Qk9zRDY5V3QwTngzc2FNK0xCbUpucmxqWlZhWjFvY1E3WklST01Gank5SFhx?=
 =?utf-8?B?aEpFdG01aHY4dUtIaVo4R2ZFZGQ1Qkp6ZmdXRUdYVHdxald4QXNucFBRNHQ4?=
 =?utf-8?B?MStXV2IrL2w4azkyRkJ1bWtTRVVudjJaZEswOXpTZ3dPR05IM2p1MDMzelNl?=
 =?utf-8?B?NEVmdGVtNUFRTlliVFBoZU80UGJobUd0ZjdXVTR5RGdyWW95OS9lZ1JpZjRW?=
 =?utf-8?B?V0tVZHJueHNRYlJtb29EYmNieUFBdk9wcDFua2V4cVBMSHV0VHpmM0hHRXBO?=
 =?utf-8?B?dW5tRFZyY01XNGxWUjVQTlhkLzN4bXNaZnFON2xQSUsrUGxINnNvVVozemFV?=
 =?utf-8?B?TnZlSUdrMngvSGZBU0EvSkdXUXRoNzk5V1BORVFuNG1mcGpwRXFNMThJRzNH?=
 =?utf-8?B?RmI1NEZDREFPekJFZzhkdS9QVWg0WDNCZlhacFo1ZEtFamRBN29PRko0c1V0?=
 =?utf-8?B?TDB3MUJ0NEtIY3pmVkdDME1iMXNaMUtzUUhaS1RNM1FLK2sxMmNmRGZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC6F035C151B4040802940BCBA777062@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: caf603c3-8552-492b-695f-08dafd519b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 14:53:36.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB9253
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DQoNCj4gT24gMjMtSmFuLTIwMjMsIGF0IDU6MDcgUE0sIEhhbnMgZGUgR29lZGUgPGhkZWdvZWRl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGkgQWxsLA0KPiANCj4gU29tZSBhcHBsZSBsYXB0
b3AgbW9kZWxzIGhhdmUgYW4gQUNQSSBkZXZpY2Ugd2l0aCBhIEhJRCBvZiBBUFAwMDBCDQo+IGFu
ZCB0aGF0IGRldmljZSBoYXMgYW4gSU8gcmVzb3VyY2UgKHNvIGl0IGRvZXMgbm90IGRlc2NyaWJl
IHRoZSBuZXcNCj4gdW5zdXBwb3J0ZWQgTU1JTyBiYXNlZCBnbXV4IHR5cGUpLCBidXQgdGhlcmUg
YWN0dWFsbHkgaXMgbm8gZ211eA0KPiBpbiB0aGUgbGFwdG9wIGF0IGFsbC4NCj4gDQo+IFRoaXMg
cGF0Y2gtc2VyaWVzIGltcHJvdmVzIHRoZSBkcml2ZXJzL2FjcGkvdmlkZW9fZGV0ZWN0LmMgc28g
dGhhdA0KPiBpdCBubyBsb25nZXIgdHJpZXMgdG8gdXNlIHRoZSBub24gcHJlc2VudCBnbXV4IGlu
IHRoaXMgY2FzZS4NCj4gDQo+IE5vdGUgSSdtIHN0aWxsIHdhaXRpbmcgZm9yIHRlc3RpbmcgZmVl
ZGJhY2sgZnJvbSB0aGUgcmVwb3J0ZXIgb2YNCj4gdGhpcyBwcm9ibGVtLiBCdXQgZnJvbSB0aGUg
bG9ncyB0aGUgcHJvYmxlbSBpcyBjbGVhcg0KPiAodGhlIGxvZ3Mgc2hvdzogImFwcGxlX2dtdXg6
IGdtdXggZGV2aWNlIG5vdCBwcmVzZW50IikgYW5kDQo+IHRoZSBkZXRlY3Rpb24gY29kZSBpcyBu
b3QgY2hhbmdlZCwganVzdCBtb3ZlZCBzbyB0aGVzZSBwYXRjaGVzDQo+IHNob3VsZCBiZSBmaW5l
LCBidXQgdGhleSBjYW4gZGVmaW5pdGVseSB1c2UgYSBnb29kIHJldmlldy4NCj4gDQo+IEFkaXR5
YSwgY2FuIHlvdSBwZXJoYXBzIHRlc3QgdGhpcyBvbiBhIG1vZGVsIG1hY2Jvb2sgd2hpY2ggZG9l
cw0KPiBhY3R1YWxseSB1c2UgdGhlIGFwcGxlLWdtdXggZHJpdmVyIGZvciBiYWNrbGlnaHQgY29u
dHJvbA0KPiAoYXNzdW1pbmcgeW91IGhhdmUgc3VjaCBhIG1vZGVsKSA/DQo+IA0KDQpIaSBIYW5z
DQoNClNpbmNlIEkgb3duIGEgVDIgTWFjQm9vaywgSeKAmWxsIGhhdmUgdG8gYXBwbHkgc29tZSBv
dXQgb2YgdHJlZSBwYXRjaGVzIGFzIHdlbGwgZnJvbSBodHRwczovL2dpdGh1Yi5jb20vUmVkZWNv
cmF0aW5nL2xpbnV4L2NvbW1pdHMvYml0cy8wMTAtZ211eC4gSeKAmXZlIHJlcXVlc3RlZCB0aGUg
bWFpbnRhaW5lciBhbHRob3VnaCBoZSBiZWxpZXZlcyB0aGV5IHNob3VsZG4ndCBicmVhayBhbnl0
aGluZyBvbiBUMiBNYWNzLiBJ4oCZdmUgc3RpbGwgbGV0IGEga2VybmVsIGNvbXBpbGUgd2l0aG91
dCB0aGUgb3V0IG9mIHRyZWUgcGF0Y2hlcywganVzdCB3aXRoIHlvdXJzIGFuZCBzaGFsbCBzZW5k
IHRoZSBvdXRwdXRzIGJ5IHRvbW9ycm93Lg0KDQo=
