Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA870E439
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 20:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbjEWR4M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 13:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjEWR4K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 13:56:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E87B5;
        Tue, 23 May 2023 10:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHqF4NuuB5SWoFCa4uA/RY9Soh+a2tEx4aD99FXpqmnDaHsic4MOsZNIT/b7cdeus7IVWjqtRKg9nAIsUFhiq6PiWoszN7sqOP8ZvQ5xIL8kqR6vllwa+ZQZtm2+1dI2PjdwhOirx3c936vGPztjGMStIbiqAHAakn3zi0ChleKFI07CLRFN0+fKNzUDU9uazsTmWqTrOl0ardUqoIk9uAfgw0Ye7bi8U4hrJyIHS7QZgIYG24enbodmSDcOVV4EZZI5gr9gMe9Zsek5VQj7ht0Mnnf5HqrRglAl8qeS4+FzMATpjisYMbfowhEJgxIFYT3ljUNud5hUwUVf8vX4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZATi+AN/6AyTykvC3Ydf0QuIqVYcMxWHT7Kz8zJW9U=;
 b=VQNimw0oe/7SJz6A5N3452m3DnX8KZCgbEffaiwiXoSLaDQBMcqVb6KfHYCfZx7j0zPdSV5Lp5OeQYUiCKTpPorqFlOlf5AOUgnZV2kEAB19K3RwAW5Pc2/M2cfF/KP6PVlrhhpuIcqAYZ/L1rEJOm98gYSklBRxwfIF+6xgyQA6LIeu9tAR63AMYhFXYNdf6AO0ZzxpUXZjq9GtkEnxip8ruYpPvEPTC9wgCIbPXVLxXma/lmhqcYri0cfItO5OuRMzgOjaC/IFthc/xZYZv39QRr3PS8pAtJ85X3EL0L+gMuWlx/JOWaTsQ9atJB34m1vESvdBgrg/B68CF07OLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZATi+AN/6AyTykvC3Ydf0QuIqVYcMxWHT7Kz8zJW9U=;
 b=xnrC6+C3jBfh/XAUPVJj5GtxcMuXBnY1WPIeQ3LEtZC2feWGZ71HAnlyXJj98+hKWRQg+tNwyBscUnZgKELFOXP6H6QaDR/o9ZfkaePuqSPVkGsUHqF+wtmDBDMq0nqvKtfRJCdu+SmR4OexM0lUVWiiv5vJWKfkr4gEj1kGJS0=
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 17:56:06 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::ea3d:ec42:656e:a248%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 17:56:05 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Werner Sembach <wse@tuxedocomputers.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "gch981213@gmail.com" <gch981213@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "ofenfisch@googlemail.com" <ofenfisch@googlemail.com>,
        "adam.niederer@gmail.com" <adam.niederer@gmail.com>,
        "adrian@freund.io" <adrian@freund.io>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "evilsnoo@proton.me" <evilsnoo@proton.me>,
        "ruinairas1992@gmail.com" <ruinairas1992@gmail.com>
Subject: RE: [PATCH v2] ACPI: resource: Remove "Zen" specific match and quirks
Thread-Topic: [PATCH v2] ACPI: resource: Remove "Zen" specific match and
 quirks
Thread-Index: AQHZibgg2E4vBgCU5UK5oCBr8z+I4a9oK1+AgAAAJYA=
Date:   Tue, 23 May 2023 17:56:05 +0000
Message-ID: <DS7PR12MB6095B4D8F7882719E5224861E2409@DS7PR12MB6095.namprd12.prod.outlook.com>
References: <20230518183920.93472-1-mario.limonciello@amd.com>
 <ca1f3eeb-76b5-d80f-e12f-94890922fdd6@tuxedocomputers.com>
In-Reply-To: <ca1f3eeb-76b5-d80f-e12f-94890922fdd6@tuxedocomputers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46290cd9-b04d-4517-8403-2e9132692bb1;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T17:53:27Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6095:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: 57406243-9856-4107-629a-08db5bb6fb10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jORM0URF14fxNmwuIdkTeCZUkbCTv2+MSE1JrMt2iQ4Lu3haq9O53fBEMGDtNVKi1WcP9/sa/1DA/8mUJSNnnjGNr88Lv6QJXvnOxNvGDs7wLNmD18YBVIHD8p3L3dW+pw7eADMyUNQmXapLr38tM0OB12ClhXouEkQTj/1wEQqrxHwWz8xQUcaCiUoex1rqXXtmuzXvIT9/cKakvpMQuDpiKmTH6QtYpXPzI/kieoV1VRScj/fytdScP9NurkWsaWYz5UqV0OYHgk/ts98gLvsDEAbr0NjBQ32ScPo89O/guWyRgpi0YrnAT6+mHznJ/qPYZuCuAOa/CexGwRhDQccSGrM687EBeslB83POwONWDwnDGMm8FW01Avg/0hmOLxPb6Xv64ZOJPyAPnPyUNWecJk5YxeHvIFJWCcYwv4xyR+ns1roKwZcqGvPTICt4wsA99aXXPBJNgBxZV0RRYLPl9Hf9OnM7hyKLqWUhs4b8dIa7Bz89GlMF6Ggi0hbOb68Pa65FPXownxh24DC7DdTpYb2h/Nmcrya2q6pMy8KmH8dGfrCI7UkHht1KUYINt4DfzFOvjFzpfSHyUpq2Tp/ViUDfGgs6p49KJi7ZR6twGla0EjzfTKRWpRS/omhdPKU42kMPFgbRaX0yIb/iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(30864003)(33656002)(186003)(53546011)(26005)(122000001)(6506007)(9686003)(7416002)(38100700002)(2906002)(83380400001)(55016003)(966005)(316002)(71200400001)(64756008)(66446008)(86362001)(66556008)(66476007)(76116006)(66946007)(4326008)(41300700001)(54906003)(7696005)(110136005)(478600001)(38070700005)(8676002)(8936002)(52536014)(5660300002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnVMeG5NMzJqa1dlc2pSaXVzakN3NWF6M1ZJUEMzMnFNRitMa2VSckZMM1gx?=
 =?utf-8?B?QkJwYjJza3MrTyswTnR1eWJ1cSswbmxTRURBcFFabWZGbUpORWdrb1hiRmJL?=
 =?utf-8?B?ZFR4UmVZUkk5cERMNXI5QVczd3krNE9NbGVGeWg5UmlwUytjb1RhaTltTm1X?=
 =?utf-8?B?dFB2c0xSekljandPUzdxSERxZ1piSEIvWHlQaEloRnV0SWRxT3QweWlVS2FQ?=
 =?utf-8?B?Zk85U0o2STBsV3FDQVJGUzl0KzZhMjROTUhUOC9oN1AwbTdlTnVtNlRtWDB1?=
 =?utf-8?B?NDd3aXo3am81YjBtUXZvSFJIcTk2ZlFlQ1QvUWpMOUdNa1BORnBYVjd4Mldi?=
 =?utf-8?B?bVRiWVFjS2NrY1NtWFRwWmY2aDFLYjgvems0bkdySllCQS83WnBlbkMwT2Qv?=
 =?utf-8?B?NXdjaUlNTFdOUG9DMTh5TGZxMnZReS8vemNxei9jRDdQZ2Z4WEJIVndUTGNK?=
 =?utf-8?B?Mk5xN2MzRFVzdFN4bTF5MkVMczJ0WGtkZlR0OWttaWJyT1VSbWlneGZDZVR4?=
 =?utf-8?B?M3JoWXNDR3BYTko2RnVQNjdSZk4rRDJsSHNLcnVFSjgyK2tVUEdHcSs3VFB5?=
 =?utf-8?B?Nktob0x4U0wydDFVZUJSb09DMit0TWZpZjJiUm15L2FZUi93eVlkckFBOFUw?=
 =?utf-8?B?bUhaVU8vb1RoSGFpNmt0Ri94MlFDV0F4Z3BUNXEzdjdQcTJ6Z1BUVnl2V1Fk?=
 =?utf-8?B?M0R3d1VuQ21qMmx5dGZTZFppSStIS1hKRjBtRjE4R3RWZWxrb0tySGxERXc1?=
 =?utf-8?B?Vk5ZRFJPY2NwYmhzcHlqTkNOMWs5SVBrY2RET3lJNDFNU25UVVJFU0ZHQm12?=
 =?utf-8?B?QXFKaVFwWmpFZjRaQ2U4Ymk2V3dYM2UxSXE5Y3VsUzE0eDZJTmd2K09BU05K?=
 =?utf-8?B?TW1CNzl4ZFBHV1NTT3FsTlQ0ZGdXN1R0YXJlYWVGWlpXV0YyZTYxbHBoN01L?=
 =?utf-8?B?MFhsYzl5RzM3ZjNtNEpmZTVyWHNLbC9VZy9Wd3pBM3BmVGxJMm5tSW96d3JX?=
 =?utf-8?B?REx6RExFd1g1cGlDZXNIZCtIWURDaFNKcFRYd3BiWm4xb3h3WWRnVzhUTlZV?=
 =?utf-8?B?dVUvYUtmU2JQeGIyaG96SktCYWRJS2NTbmJIUVh3MjMrNG9FM01OZzlJWU1s?=
 =?utf-8?B?bGY1V2Z4OFF6cm1PRWdBN0pZSXlTYlgwUnVvWTdaWUlFellHdFRjMXFyUklH?=
 =?utf-8?B?dzF3ZWZIb29ONVNtNWNIUkZtaDR3aGc3ZitLR25WVlhORlNRMEtIZFpHbHpj?=
 =?utf-8?B?elhxZkVBU2pYTFY3KzFyUGMzaEZxM1A4OEZRMTVvOGV0N2ZKZEsxWWhvSlo0?=
 =?utf-8?B?Z3ZjZFlZSzdjanlDZ0JkWHJxRjd0U2djamZJTW13NVV1ZXIyYmd0amlySmRq?=
 =?utf-8?B?Y3BRMzJ6dUJTN0hqc1E4SGFjTkVvaWtaRkV2OXJmTXlUaEhyRGFreHlrdXU4?=
 =?utf-8?B?OTZ5QkRoMnVla3lEYjdZZHZkRm5mc2wvS3RDZ3o0RnVCcEdIM1BoWlg1RU5x?=
 =?utf-8?B?L2RxcU91SlVRR0RyQVNTWVczbVpQc2ZlQUxLWWZITnlsUUNRajZGejhObUNk?=
 =?utf-8?B?YmhHa1Z4ZFVUWTJVSi9MQnNSNk1ac3RORlVJWjlocTZjSVJyNFpKWmxLSVNk?=
 =?utf-8?B?TGlGM1JPK1hJckNSaG9tSTdIQjJVdloxeTh3eURmQkEveGQ5VW5ubFJSc2ZM?=
 =?utf-8?B?VUZkM1gzT3JvMTRRb09nOWlJUXpiS2c2VWtkZ01hbEoyUGp5Nks4MTJUWlpB?=
 =?utf-8?B?ZVcvblM3VWxieVBqWkZySDI1OU1rZFg3NURHajhtdDlKOEc4b3M4S2V2dHFJ?=
 =?utf-8?B?TStZcGp3TkRhS2NMYTRZcXJDRTliSEVpenpaOFUwdVg1NmwwU2cyc0JwZ3NJ?=
 =?utf-8?B?RmQwY203d0U2cFZ0UnpEamRQYVQ4SS92RUlTeFAvd0ZQZSs1Z1poamNqVm4w?=
 =?utf-8?B?OXFxemhIN0lTVXVrMUlTemgrVVdnQVF0M0FmZndmYi95TVFiR2JJbkxldENl?=
 =?utf-8?B?eVNRZkJPNW03d3ViV0RnZ3VtK2dMN0FxTFNMelp5aDVCMjBrMWU0SjhyTklU?=
 =?utf-8?B?RVUwSWJzNE40Ti9GaUZONVpuclkzRmVJWVBhR0YxSkN5V0FHNjUyTGV6MUM3?=
 =?utf-8?Q?v0VM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57406243-9856-4107-629a-08db5bb6fb10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 17:56:05.6806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJDXPiLwdv74XOrxoLXLAEdhxw0H2VrAacDyOKibxF4bLMSwu2wA9IGvJ4yX402aaRVCslF31Wv8YCo3OEn/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogV2VybmVyIFNlbWJhY2ggPHdzZUB0dXhlZG9jb21wdXRlcnMuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjMsIDIwMjMgMTI6NTMgUE0NCj4gVG86IExpbW9uY2ll
bGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHJhZmFlbEBrZXJuZWwub3Jn
DQo+IENjOiBnY2g5ODEyMTNAZ21haWwuY29tOyBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJlZ3Jlc3Npb25zQGxlZW1odWlzLmlu
Zm87DQo+IG9mZW5maXNjaEBnb29nbGVtYWlsLmNvbTsgYWRhbS5uaWVkZXJlckBnbWFpbC5jb207
IGFkcmlhbkBmcmV1bmQuaW87DQo+IGppcmlzbGFieUBrZXJuZWwub3JnOyBQYW5hbmNoaWtrYWws
IFJlbmppdGggPFJlbmppdGguUGFuYW5jaGlra2FsQGFtZC5jb20+Ow0KPiBUc2FvLCBBbnNvbiA8
YW5zb24udHNhb0BhbWQuY29tPjsgR29uZywgUmljaGFyZA0KPiA8UmljaGFyZC5Hb25nQGFtZC5j
b20+OyBldmlsc25vb0Bwcm90b24ubWU7IHJ1aW5haXJhczE5OTJAZ21haWwuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIEFDUEk6IHJlc291cmNlOiBSZW1vdmUgIlplbiIgc3BlY2lmaWMg
bWF0Y2ggYW5kDQo+IHF1aXJrcw0KPg0KPiBIaSwNCj4NCj4gQW0gMTguMDUuMjMgdW0gMjA6Mzkg
c2NocmllYiBNYXJpbyBMaW1vbmNpZWxsbzoNCj4gPiBjb21taXQgOTk0NmUzOWZlOGQwICgiQUNQ
STogcmVzb3VyY2U6IHNraXAgSVJRIG92ZXJyaWRlIG9uDQo+ID4gQU1EIFplbiBwbGF0Zm9ybXMi
KSBhdHRlbXB0ZWQgdG8gb3ZlcmhhdWwgdGhlIG92ZXJyaWRlIGxvZ2ljIHNvIGl0DQo+ID4gZGlk
bid0IGFwcGx5IG9uIFg4NiBBTUQgWmVuIHN5c3RlbXMuICBUaGlzIHdhcyBpbnRlbnRpb25hbCBz
byB0aGF0DQo+ID4gc3lzdGVtcyB3b3VsZCBwcmVmZXIgRFNEVCB2YWx1ZXMgaW5zdGVhZCBvZiBk
ZWZhdWx0IE1BRFQgdmFsdWUgZm9yDQo+ID4gSVJRIDEgb24gUnl6ZW4gNjAwMCBzeXN0ZW1zIHdo
aWNoIHVzZSBBY3RpdmVMb3cgZm9yIElSUTEuDQo+ID4NCj4gPiBUaGlzIHR1cm5lZCBvdXQgdG8g
YmUgYSBiYWQgYXNzdW1wdGlvbiBiZWNhdXNlIHNldmVyYWwgdmVuZG9ycyBzZWVtDQo+ID4gdG8g
YWRkIEludGVycnVwdCBTb3VyY2UgT3ZlcnJpZGUgYnV0IGRvbid0IGZpeCB0aGUgRFNEVC4gQSBw
aWxlIG9mDQo+ID4gcXVpcmtzIHdhcyBjb2xsZWN0aW5nIHRoYXQgcHJvdmVkIHRoaXMgd2Fzbid0
IHN1c3RhaW50YWJsZS4NCj4gPg0KPiA+IEFkanVzdCB0aGUgbG9naWMgc28gdGhhdCBvbmx5IElS
UTEgaXMgb3ZlcnJpZGRlbiBpbiBSeXplbiA2MDAwIGNhc2UuDQo+ID4NCj4gPiBUaGlzIGVmZmVj
dGl2ZWx5IHJldmVydHMgdGhlIGZvbGxvd2luZyBjb21taXRzOg0KPiA+IGNvbW1pdCAxN2JiNzA0
NmU3Y2UgKCJBQ1BJOiByZXNvdXJjZTogRG8gSVJRIG92ZXJyaWRlIG9uIGFsbCBUb25nRmFuZw0K
PiA+IEdNeFJHeHgiKQ0KPiA+IGNvbW1pdCBmM2NiOWI3NDA4NjkgKCJBQ1BJOiByZXNvdXJjZTog
ZG8gSVJRIG92ZXJyaWRlIG9uIExlbm92bw0KPiAxNEFMQzciKQ0KPiA+IGNvbW1pdCBiZmNkZjU4
MzgwYjEgKCJBQ1BJOiByZXNvdXJjZTogZG8gSVJRIG92ZXJyaWRlIG9uIExFTk9WTw0KPiBJZGVh
UGFkIikNCj4gPiBjb21taXQgNzU5MmI3OWJhNGE5ICgiQUNQSTogcmVzb3VyY2U6IGRvIElSUSBv
dmVycmlkZSBvbiBYTUcgQ29yZSAxNSIpDQo+DQo+IFRoZSBUb25nRmFuZyBHTXhSR3h4L1hNRyBD
T1JFIDE1IChNMjIpL1RVWEVETyBTdGVsbGFyaXMgMTUgR2VuNCBBTUQNCj4gYnJlYWtzIGFnYWlu
IHdpdGggdGhpcyBwYXRjaCAoYXBwbGllZCB0byA2LjQtcmMzKS4gQW0gSSBtaXNzaW5nIGFuIGFk
ZGl0aW9uYWwNCj4gcGF0Y2ggdGhhdCBpcyByZXF1aXJlZD8NCg0KWW91J3JlIG5vdCBtaXNzaW5n
IGFueXRoaW5nIGV4dHJhLCBidXQgbGV0J3MgZ2F0aGVyIHNvbWUgZGV0YWlsIGFib3V0IHlvdXIg
c3lzdGVtDQphbmQgZmlndXJlIG91dCB3aHkuDQoNCldoYXQgQ1BVIGlzIGluIGl0Pw0KQWxzbyB3
b3VsZCB5b3UgbWluZCBzZW5kaW5nIG1lIGFuIGFjcGlkdW1wPyAgWW91IGNhbiBzZW5kIGRpcmVj
dGx5IHRvIG1lIG9mZi1saXN0DQppZiB5b3Ugd2FudC4NCg0KPg0KPiA+DQo+ID4gQ2M6IG9mZW5m
aXNjaEBnb29nbGVtYWlsLmNvbQ0KPiA+IENjOiB3c2VAdHV4ZWRvY29tcHV0ZXJzLmNvbQ0KPiA+
IENjOiBhZGFtLm5pZWRlcmVyQGdtYWlsLmNvbQ0KPiA+IENjOiBhZHJpYW5AZnJldW5kLmlvDQo+
ID4gQ2M6IGppcmlzbGFieUBrZXJuZWwub3JnDQo+ID4gVGVzdGVkLWJ5OiBSZW5qaXRoLlBhbmFu
Y2hpa2thbEBhbWQuY29tDQo+ID4gVGVzdGVkLWJ5OiBhbnNvbi50c2FvQGFtZC5jb20NCj4gPiBU
ZXN0ZWQtYnk6IFJpY2hhcmQuR29uZ0BhbWQuY29tDQo+ID4gVGVzdGVkLWJ5OiBDaHVhbmhvbmcg
R3VvIDxnY2g5ODEyMTNAZ21haWwuY29tPg0KPiA+IFJlcG9ydGVkLWJ5OiBldmlsc25vb0Bwcm90
b24ubWUNCj4gPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5j
Z2k/aWQ9MjE3Mzk0DQo+ID4gUmVwb3J0ZWQtYnk6IHJ1aW5haXJhczE5OTJAZ21haWwuY29tDQo+
ID4gQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIx
NzQwNg0KPiA+IEZpeGVzOiA5OTQ2ZTM5ZmU4ZDAgKCJBQ1BJOiByZXNvdXJjZTogc2tpcCBJUlEg
b3ZlcnJpZGUgb24gQU1EIFplbg0KPiBwbGF0Zm9ybXMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IE1h
cmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
IHYxLT52MjoNCj4gPiAgICogUmViYXNlIG9uIDcxYTQ4NTYyNGM0YyAoIkFDUEk6IHJlc291cmNl
OiBBZGQgSVJRIG92ZXJyaWRlIHF1aXJrIGZvciBMRw0KPiBVbHRyYVBDIDE3VTcwUCIpDQo+ID4g
ICAqIFBpY2sgdXAgdGFnDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2FjcGkvcmVzb3VyY2UuYyB8
IDE1NCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgODkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Jlc291cmNlLmMgYi9kcml2ZXJzL2FjcGkvcmVzb3Vy
Y2UuYw0KPiA+IGluZGV4IDA4MDBhOWQ3NzU1OC4uYzZhYzg3ZTAxZTFjIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvYWNwaS9yZXNvdXJjZS5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3BpL3Jlc291
cmNlLmMNCj4gPiBAQCAtNDcwLDUyICs0NzAsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRtaV9z
eXN0ZW1faWQgYXN1c19sYXB0b3BbXSA9IHsNCj4gPiAgICAgeyB9DQo+ID4gICB9Ow0KPiA+DQo+
ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBsZW5vdm9fbGFwdG9wW10gPSB7
DQo+ID4gLSAgIHsNCj4gPiAtICAgICAgICAgICAuaWRlbnQgPSAiTEVOT1ZPIElkZWFQYWQgRmxl
eCA1IDE0QUxDNyIsDQo+ID4gLSAgICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICBETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJMRU5PVk8iKSwNCj4gPiAtICAg
ICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiODJSOSIpLA0KPiA+
IC0gICAgICAgICAgIH0sDQo+ID4gLSAgIH0sDQo+ID4gLSAgIHsNCj4gPiAtICAgICAgICAgICAu
aWRlbnQgPSAiTEVOT1ZPIElkZWFQYWQgRmxleCA1IDE2QUxDNyIsDQo+ID4gLSAgICAgICAgICAg
Lm1hdGNoZXMgPSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1NZU19W
RU5ET1IsICJMRU5PVk8iKSwNCj4gPiAtICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlf
UFJPRFVDVF9OQU1FLCAiODJSQSIpLA0KPiA+IC0gICAgICAgICAgIH0sDQo+ID4gLSAgIH0sDQo+
ID4gLSAgIHsgfQ0KPiA+IC19Ow0KPiA+IC0NCj4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlf
c3lzdGVtX2lkIHRvbmdmYW5nX2dtX3JnW10gPSB7DQo+ID4gLSAgIHsNCj4gPiAtICAgICAgICAg
ICAuaWRlbnQgPSAiVG9uZ0ZhbmcgR014Ukd4eC9YTUcgQ09SRSAxNSAoTTIyKS9UVVhFRE8NCj4g
U3RlbGxhcmlzIDE1IEdlbjQgQU1EIiwNCj4gPiAtICAgICAgICAgICAubWF0Y2hlcyA9IHsNCj4g
PiAtICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfQk9BUkRfTkFNRSwgIkdNeFJHeHgi
KSwNCj4gPiAtICAgICAgICAgICB9LA0KPiA+IC0gICB9LA0KPiA+IC0gICB7IH0NCj4gPiAtfTsN
Cj4gPiAtDQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBtYWluZ2Vhcl9s
YXB0b3BbXSA9IHsNCj4gPiAtICAgew0KPiA+IC0gICAgICAgICAgIC5pZGVudCA9ICJNQUlOR0VB
UiBWZWN0b3IgUHJvIDIgMTUiLA0KPiA+IC0gICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiTWljcm8gRWxlY3Ry
b25pY3MNCj4gSW5jIiksDQo+ID4gLSAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1BS
T0RVQ1RfTkFNRSwgIk1HLVZDUDItDQo+IDE1QTMwNzBUIiksDQo+ID4gLSAgICAgICAgICAgfQ0K
PiA+IC0gICB9LA0KPiA+IC0gICB7DQo+ID4gLSAgICAgICAgICAgLmlkZW50ID0gIk1BSU5HRUFS
IFZlY3RvciBQcm8gMiAxNyIsDQo+ID4gLSAgICAgICAgICAgLm1hdGNoZXMgPSB7DQo+ID4gLSAg
ICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJNaWNybyBFbGVjdHJv
bmljcw0KPiBJbmMiKSwNCj4gPiAtICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfUFJP
RFVDVF9OQU1FLCAiTUctVkNQMi0NCj4gMTdBMzA3MFQiKSwNCj4gPiAtICAgICAgICAgICB9LA0K
PiA+IC0gICB9LA0KPiA+IC0gICB7IH0NCj4gPiAtfTsNCj4gPiAtDQo+ID4gICBzdGF0aWMgY29u
c3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgbGdfbGFwdG9wW10gPSB7DQo+ID4gICAgIHsNCj4gPiAg
ICAgICAgICAgICAuaWRlbnQgPSAiTEcgRWxlY3Ryb25pY3MgMTdVNzBQIiwNCj4gPiBAQCAtNTI3
LDcgKzQ4MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBsZ19sYXB0b3Bb
XSA9IHsNCj4gPiAgICAgeyB9DQo+ID4gICB9Ow0KPiA+DQo+ID4gLXN0cnVjdCBpcnFfb3ZlcnJp
ZGVfY21wIHsNCj4gPiArc3RydWN0IGlycV9vdmVycmlkZV9kbWlfY21wIHsNCj4gPiAgICAgY29u
c3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgKnN5c3RlbTsNCj4gPiAgICAgdW5zaWduZWQgY2hhciBp
cnE7DQo+ID4gICAgIHVuc2lnbmVkIGNoYXIgdHJpZ2dlcmluZzsNCj4gPiBAQCAtNTM2LDUwICs0
OTAsODYgQEAgc3RydWN0IGlycV9vdmVycmlkZV9jbXAgew0KPiA+ICAgICBib29sIG92ZXJyaWRl
Ow0KPiA+ICAgfTsNCj4gPg0KPiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGlycV9vdmVycmlkZV9j
bXAgb3ZlcnJpZGVfdGFibGVbXSA9IHsNCj4gPiArc3RydWN0IGlycV9vdmVycmlkZV9hY3BpX2Nt
cCB7DQo+ID4gKyAgIGNvbnN0IGNoYXIgKmlkOw0KPiA+ICsgICB1bnNpZ25lZCBjaGFyIGlycTsN
Cj4gPiArICAgdW5zaWduZWQgY2hhciB0cmlnZ2VyaW5nOw0KPiA+ICsgICB1bnNpZ25lZCBjaGFy
IHBvbGFyaXR5Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpcnFf
b3ZlcnJpZGVfZG1pX2NtcCBkbWlfb3ZlcnJpZGVfdGFibGVbXSA9IHsNCj4gPiAgICAgeyBtZWRp
b25fbGFwdG9wLCAxLCBBQ1BJX0xFVkVMX1NFTlNJVElWRSwgQUNQSV9BQ1RJVkVfTE9XLCAwLA0K
PiBmYWxzZSB9LA0KPiA+ICAgICB7IGFzdXNfbGFwdG9wLCAxLCBBQ1BJX0xFVkVMX1NFTlNJVElW
RSwgQUNQSV9BQ1RJVkVfTE9XLCAwLCBmYWxzZQ0KPiB9LA0KPiA+IC0gICB7IGxlbm92b19sYXB0
b3AsIDYsIEFDUElfTEVWRUxfU0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1csIDAsDQo+IHRydWUg
fSwNCj4gPiAtICAgeyBsZW5vdm9fbGFwdG9wLCAxMCwgQUNQSV9MRVZFTF9TRU5TSVRJVkUsIEFD
UElfQUNUSVZFX0xPVywgMCwNCj4gdHJ1ZSB9LA0KPiA+IC0gICB7IHRvbmdmYW5nX2dtX3JnLCAx
LCBBQ1BJX0VER0VfU0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1csIDEsDQo+IHRydWUgfSwNCj4g
PiAtICAgeyBtYWluZ2Vhcl9sYXB0b3AsIDEsIEFDUElfRURHRV9TRU5TSVRJVkUsIEFDUElfQUNU
SVZFX0xPVywgMSwNCj4gdHJ1ZSB9LA0KPiA+ICAgICB7IGxnX2xhcHRvcCwgMSwgQUNQSV9MRVZF
TF9TRU5TSVRJVkUsIEFDUElfQUNUSVZFX0xPVywgMCwgZmFsc2UgfSwNCj4gPiAgIH07DQo+ID4N
Cj4gPiAtc3RhdGljIGJvb2wgYWNwaV9kZXZfaXJxX292ZXJyaWRlKHUzMiBnc2ksIHU4IHRyaWdn
ZXJpbmcsIHU4IHBvbGFyaXR5LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4
IHNoYXJlYWJsZSkNCj4gPiArLyoNCj4gPiArICogUnl6ZW4gNjAwMCByZXF1aXJlcyBBY3RpdmVM
b3cgZm9yIGtleWJvYXJkLCBidXQgYSBudW1iZXIgb2YgbWFjaGluZXMNCj4gPiArICogc2VlbSB0
byBnZXQgaXQgd3JvbmcgaW4gRFNEVCBvciBkb24ndCBoYXZlIGFuIEludGVycnVwdCBTb3VyY2UN
Cj4gPiArICogT3ZlcnJpZGUuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGly
cV9vdmVycmlkZV9hY3BpX2NtcCBhY3BpX292ZXJyaWRlX3RhYmxlW10gPSB7DQo+ID4gKyAgIHsg
IkFNREkwMDA3IiwgMSwgQUNQSV9FREdFX1NFTlNJVElWRSwgQUNQSV9BQ1RJVkVfTE9XIH0sDQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhY3BpX2Rldl9pcnFfb3ZlcnJpZGUodTMy
IGdzaSwgdTggKnRyaWdnZXJpbmcsIHU4ICpwb2xhcml0eSwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1OCAqc2hhcmVhYmxlKQ0KPiA+ICAgew0KPiA+IC0gICBpbnQgaTsNCj4g
PiArICAgaW50IGksIHAsIHQ7DQo+ID4gKyAgIGludCBjaGVja19vdmVycmlkZSA9IHRydWU7DQo+
ID4NCj4gPiAtICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUob3ZlcnJpZGVfdGFibGUpOyBp
KyspIHsNCj4gPiAtICAgICAgICAgICBjb25zdCBzdHJ1Y3QgaXJxX292ZXJyaWRlX2NtcCAqZW50
cnkgPSAmb3ZlcnJpZGVfdGFibGVbaV07DQo+ID4gKyAgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9T
SVpFKGRtaV9vdmVycmlkZV90YWJsZSk7IGkrKykgew0KPiA+ICsgICAgICAgICAgIGNvbnN0IHN0
cnVjdCBpcnFfb3ZlcnJpZGVfZG1pX2NtcCAqZW50cnkgPQ0KPiAmZG1pX292ZXJyaWRlX3RhYmxl
W2ldOw0KPiA+DQo+ID4gICAgICAgICAgICAgaWYgKGRtaV9jaGVja19zeXN0ZW0oZW50cnktPnN5
c3RlbSkgJiYNCj4gPiAgICAgICAgICAgICAgICAgZW50cnktPmlycSA9PSBnc2kgJiYNCj4gPiAt
ICAgICAgICAgICAgICAgZW50cnktPnRyaWdnZXJpbmcgPT0gdHJpZ2dlcmluZyAmJg0KPiA+IC0g
ICAgICAgICAgICAgICBlbnRyeS0+cG9sYXJpdHkgPT0gcG9sYXJpdHkgJiYNCj4gPiAtICAgICAg
ICAgICAgICAgZW50cnktPnNoYXJlYWJsZSA9PSBzaGFyZWFibGUpDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICByZXR1cm4gZW50cnktPm92ZXJyaWRlOw0KPiA+ICsgICAgICAgICAgICAgICBlbnRy
eS0+dHJpZ2dlcmluZyA9PSAqdHJpZ2dlcmluZyAmJg0KPiA+ICsgICAgICAgICAgICAgICBlbnRy
eS0+cG9sYXJpdHkgPT0gKnBvbGFyaXR5ICYmDQo+ID4gKyAgICAgICAgICAgICAgIGVudHJ5LT5z
aGFyZWFibGUgPT0gKnNoYXJlYWJsZSkNCj4gPiArICAgICAgICAgICAgICAgICAgIGNoZWNrX292
ZXJyaWRlID0gZW50cnktPm92ZXJyaWRlOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAtI2lmZGVmIENP
TkZJR19YODYNCj4gPiAtICAgLyoNCj4gPiAtICAgICogSVJRIG92ZXJyaWRlIGlzbid0IG5lZWRl
ZCBvbiBtb2Rlcm4gQU1EIFplbiBzeXN0ZW1zIGFuZA0KPiA+IC0gICAgKiB0aGlzIG92ZXJyaWRl
IGJyZWFrcyBhY3RpdmUgbG93IElSUXMgb24gQU1EIFJ5emVuIDYwMDAgYW5kDQo+ID4gLSAgICAq
IG5ld2VyIHN5c3RlbXMuIFNraXAgaXQuDQo+ID4gLSAgICAqLw0KPiA+IC0gICBpZiAoYm9vdF9j
cHVfaGFzKFg4Nl9GRUFUVVJFX1pFTikpDQo+ID4gLSAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0K
PiA+IC0jZW5kaWYNCj4gPiArICAgaWYgKCFjaGVja19vdmVycmlkZSkNCj4gPiArICAgICAgICAg
ICByZXR1cm47DQo+ID4NCj4gPiAtICAgcmV0dXJuIHRydWU7DQo+ID4gKyAgIGlmICghYWNwaV9n
ZXRfb3ZlcnJpZGVfaXJxKGdzaSwgJnQsICZwKSkgew0KPiA+ICsgICAgICAgICAgIHU4IHRyaWcg
PSB0ID8gQUNQSV9MRVZFTF9TRU5TSVRJVkUgOiBBQ1BJX0VER0VfU0VOU0lUSVZFOw0KPiA+ICsg
ICAgICAgICAgIHU4IHBvbCA9IHAgPyBBQ1BJX0FDVElWRV9MT1cgOiBBQ1BJX0FDVElWRV9ISUdI
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICBpZiAoKnRyaWdnZXJpbmcgIT0gdHJpZyB8fCAqcG9s
YXJpdHkgIT0gcG9sKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBwcl93YXJuKCJBQ1BJOiBJ
UlEgJWQgb3ZlcnJpZGUgdG8gJXMlcywgJXMlc1xuIiwNCj4gZ3NpLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICB0ID8gImxldmVsIiA6ICJlZGdlIiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdHJpZyA9PSAqdHJpZ2dlcmluZyA/ICIiIDogIighKSIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHAgPyAibG93IiA6ICJoaWdoIiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcG9sID09ICpwb2xhcml0eSA/ICIiIDogIighKSIpOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgKnRyaWdnZXJpbmcgPSB0cmlnOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgKnBvbGFyaXR5ID0gcG9sOw0KPiA+ICsgICAgICAgICAgIH0NCj4gPiArICAgfQ0K
PiA+ICsNCj4gPiArICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoYWNwaV9vdmVycmlkZV90
YWJsZSk7IGkrKykgew0KPiA+ICsgICAgICAgICAgIGNvbnN0IHN0cnVjdCBpcnFfb3ZlcnJpZGVf
YWNwaV9jbXAgKmVudHJ5ID0NCj4gJmFjcGlfb3ZlcnJpZGVfdGFibGVbaV07DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgIGlmIChhY3BpX2Rldl9mb3VuZChlbnRyeS0+aWQpICYmIGdzaSA9PSBlbnRy
eS0+aXJxICYmDQo+ID4gKyAgICAgICAgICAgICAgKCpwb2xhcml0eSAhPSBlbnRyeS0+cG9sYXJp
dHkgfHwgKnRyaWdnZXJpbmcgIT0gZW50cnktDQo+ID50cmlnZ2VyaW5nKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgcHJfd2FybigiQUNQSTogSVJRICVkIG92ZXJyaWRlIHRvICVzJXMsICVz
JXMgZHVlDQo+IHRvICVzXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBnc2ks
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudHJ5LT50cmlnZ2VyaW5nID8gImxl
dmVsIiA6ICJlZGdlIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50cnktPnRy
aWdnZXJpbmcgPT0gKnRyaWdnZXJpbmcgPyAiIiA6ICIoISkiLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlbnRyeS0+cG9sYXJpdHkgPyAibG93IiA6ICJoaWdoIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW50cnktPnBvbGFyaXR5ID09ICpwb2xhcml0eSA/ICIi
IDogIighKSIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudHJ5LT5pZCk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAqcG9sYXJpdHkgPSBlbnRyeS0+cG9sYXJpdHk7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAqdHJpZ2dlcmluZyA9IGVudHJ5LT50cmlnZ2VyaW5nOw0KPiA+
ICsgICAgICAgICAgIH0NCj4gPiArICAgfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgdm9p
ZCBhY3BpX2Rldl9nZXRfaXJxcmVzb3VyY2Uoc3RydWN0IHJlc291cmNlICpyZXMsIHUzMiBnc2ks
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggdHJpZ2dlcmluZywgdTgg
cG9sYXJpdHksIHU4IHNoYXJlYWJsZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1OCB3YWtlX2NhcGFibGUsIGJvb2wgY2hlY2tfb3ZlcnJpZGUpDQo+ID4gICB7DQo+ID4g
LSAgIGludCBpcnEsIHAsIHQ7DQo+ID4gKyAgIGludCBpcnE7DQo+ID4NCj4gPiAgICAgaWYgKCF2
YWxpZF9JUlEoZ3NpKSkgew0KPiA+ICAgICAgICAgICAgIGlycXJlc291cmNlX2Rpc2FibGVkKHJl
cywgZ3NpKTsNCj4gPiBAQCAtNTkyLDI2ICs1ODIsMTIgQEAgc3RhdGljIHZvaWQgYWNwaV9kZXZf
Z2V0X2lycXJlc291cmNlKHN0cnVjdA0KPiByZXNvdXJjZSAqcmVzLCB1MzIgZ3NpLA0KPiA+ICAg
ICAgKiAyLiBCSU9TIHVzZXMgSU8tQVBJQyBtb2RlIEludGVycnVwdCBTb3VyY2UgT3ZlcnJpZGUN
Cj4gPiAgICAgICoNCj4gPiAgICAgICogV2UgZG8gdGhpcyBvbmx5IGlmIHdlIGFyZSBkZWFsaW5n
IHdpdGggSVJRKCkgb3IgSVJRTm9GbGFncygpDQo+ID4gLSAgICAqIHJlc291cmNlICh0aGUgbGVn
YWN5IElTQSByZXNvdXJjZXMpLiBXaXRoIG1vZGVybiBBQ1BJIDUgZGV2aWNlcw0KPiA+ICsgICAg
KiByZXNvdXJjZSAodGhlIGxlZ2FjeSBJU0EgcmVzb3VyY2VzKS4gV2l0aCBBQ1BJIGRldmljZXMN
Cj4gPiAgICAgICogdXNpbmcgZXh0ZW5kZWQgSVJRIGRlc2NyaXB0b3JzIHdlIHRha2UgdGhlIElS
USBjb25maWd1cmF0aW9uDQo+ID4gICAgICAqIGZyb20gX0NSUyBkaXJlY3RseS4NCj4gPiAgICAg
ICovDQo+ID4gLSAgIGlmIChjaGVja19vdmVycmlkZSAmJg0KPiA+IC0gICAgICAgYWNwaV9kZXZf
aXJxX292ZXJyaWRlKGdzaSwgdHJpZ2dlcmluZywgcG9sYXJpdHksIHNoYXJlYWJsZSkgJiYNCj4g
PiAtICAgICAgICFhY3BpX2dldF9vdmVycmlkZV9pcnEoZ3NpLCAmdCwgJnApKSB7DQo+ID4gLSAg
ICAgICAgICAgdTggdHJpZyA9IHQgPyBBQ1BJX0xFVkVMX1NFTlNJVElWRSA6IEFDUElfRURHRV9T
RU5TSVRJVkU7DQo+ID4gLSAgICAgICAgICAgdTggcG9sID0gcCA/IEFDUElfQUNUSVZFX0xPVyA6
IEFDUElfQUNUSVZFX0hJR0g7DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgIGlmICh0cmlnZ2VyaW5n
ICE9IHRyaWcgfHwgcG9sYXJpdHkgIT0gcG9sKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICBw
cl93YXJuKCJBQ1BJOiBJUlEgJWQgb3ZlcnJpZGUgdG8gJXMlcywgJXMlc1xuIiwNCj4gZ3NpLA0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICB0ID8gImxldmVsIiA6ICJlZGdlIiwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgdHJpZyA9PSB0cmlnZ2VyaW5nID8gIiIgOiAi
KCEpIiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgcCA/ICJsb3ciIDogImhpZ2gi
LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBwb2wgPT0gcG9sYXJpdHkgPyAiIiA6
ICIoISkiKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgIHRyaWdnZXJpbmcgPSB0cmlnOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgcG9sYXJpdHkgPSBwb2w7DQo+ID4gLSAgICAgICAgICAgfQ0K
PiA+IC0gICB9DQo+ID4gKyAgIGlmIChjaGVja19vdmVycmlkZSkNCj4gPiArICAgICAgICAgICBh
Y3BpX2Rldl9pcnFfb3ZlcnJpZGUoZ3NpLCAmdHJpZ2dlcmluZywgJnBvbGFyaXR5LCAmc2hhcmVh
YmxlKTsNCj4gPg0KPiA+ICAgICByZXMtPmZsYWdzID0gYWNwaV9kZXZfaXJxX2ZsYWdzKHRyaWdn
ZXJpbmcsIHBvbGFyaXR5LCBzaGFyZWFibGUsDQo+IHdha2VfY2FwYWJsZSk7DQo+ID4gICAgIGly
cSA9IGFjcGlfcmVnaXN0ZXJfZ3NpKE5VTEwsIGdzaSwgdHJpZ2dlcmluZywgcG9sYXJpdHkpOw0K
PiA+DQo+ID4gYmFzZS1jb21taXQ6IGM1NTRlZWUxOGM5YTQ0MGJkMmRkNWEzNjNiMGY3OTMyNTcx
N2YwYmYNCg==
