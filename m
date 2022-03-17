Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB24DCBAC
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 17:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiCQQuh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiCQQuh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 12:50:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453920A94E;
        Thu, 17 Mar 2022 09:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1lRFt2YSH/Mf3H8idvJpEHyQ1By+rsovchiCMLgEQrAHTGfV2P98Q5qenVkPXM73oRuS70Xps20zbyAC3/MsiRCxIPWUqCa9YLAxhQ2c7EeNrE0Qk2VAXs3sBiu21/vydxrnCzMsziNjxFk6PH14I/GC7dGDnU7PSw1NpEd8ViWt8f9nojlobZeG6Z8Wr3r0HAz52DehLP113dhM6Ho2Z26g2ONqp65B9Q6bjX0/juvC/P+F+K4nidN2UTYRbMOFzAur57mIvTOEBsDBmeI9XbE6chRJUB1mIYiefH0lkccI0vRIj0DrGiWn15pMdvYl20zT7Vx/RYkgXD9B+C14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BTxhSqzJtbA+oDAhl1aEVt88u0NJ3izEwG4Zzpgysw=;
 b=fRUknL57xMzCoJY4/ilaA3whGVN7MVrxD+cMz/yMEOEU2RwHju0q1zZOCycUUmq4O2RNN/kymmbIbHhTlUdH4ncHvkon05EYMjBFJjb4ZLNoJ0pWPeJJAgFPsE6rtx726NVBTG+xJbgXGnVbS5otMXYQh2w+qjopjYqdx5eYxctOLBciDw1C/Ity6PHdcf7tN5fUXHjK7PtRzKRymqoLGCScCPVlwPD9TIkicd9sgkROv4NAek1Qu6kJS1GwW7jwok4jYS47EUH00n086ozZpS6tw7edO77O0h0fpINxORH52gGRtblTvgLGGrtLVzB8jUaCmRrX5Eel0FUSLWcP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BTxhSqzJtbA+oDAhl1aEVt88u0NJ3izEwG4Zzpgysw=;
 b=WsyPe6pkLeIfSsVgpbRjNHrbKI3nIQS3JZXPTYf7TturkfMwA4KlbutaN0sdrku7PwasUKe8q+6wejadJarGkb/kOcIb67MixUuacn4Npjy+enHcBmezokR0Hm2vn0tMLCHPtqeLbgRNbOO5sUgdIXvQXj15ZPgeY+7p0yZs/vk=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3550.namprd12.prod.outlook.com (2603:10b6:208:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 16:49:17 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 16:49:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Subject: RE: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
Thread-Topic: [PATCH v5 1/4] ACPI / x86: Add support for LPS0 callback handler
Thread-Index: AQHYOglod7H3Vz+Nq0O3/9to0K5CxazDyNMAgAAAONA=
Date:   Thu, 17 Mar 2022 16:49:17 +0000
Message-ID: <BL1PR12MB5157188AC154FEA11F775674E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220317141445.6498-1-mario.limonciello@amd.com>
 <CAJZ5v0hNKmXWJ5uNaAFWsDkBm7FpKexkx5sCFHvx=OBJdVt+aA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hNKmXWJ5uNaAFWsDkBm7FpKexkx5sCFHvx=OBJdVt+aA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-17T16:46:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d2e5e3ba-e595-4364-80f8-db7b34c647bd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-17T16:49:15Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6c54fa24-6631-4e44-a34f-bee22c6449b4
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aeebab2-f2e2-41c0-3b1c-08da0836138b
x-ms-traffictypediagnostic: MN2PR12MB3550:EE_
x-microsoft-antispam-prvs: <MN2PR12MB35509E5E82F456464BD2C468E2129@MN2PR12MB3550.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KGVq6hAzkabpAcF2+hSz+xJiqFLnPKRuiGO6ULQroHZe7eEZozpuW/vW481NbvgGT8XHtl/xP5HaUFE/WJhQ3y6tayjj3gXXJ6CKjJgZNwos1x0S7mzodVqhOX3jo9IYpsIwJ+BQUXL00dJM+HRUwldYVE5vIev+gpe4ZOhbWWF53u2Fq/BnuUc5fDbb1W7fWV4PFo2prrfsd5/vca+TpFXCLPOLoAjScQ/3g4W/Wk+syJyvv0mg5K5WoAfwU0aewOOOzmGtQ+9yKlfZHs/kQKHO5og8aLea6Nt8nr192R41KbAqCxHhOrHxMHdUU2dklKUa/QHOhtg6ht3xy2GsHZOGEHdqFQYttAQDEInDuaiwz9/hAp73Oxl7xWZ/KNYfQ69eR03WxMJCVCPhn35YpsudS2vpDAW9OnUyST2qUlA5bM0jPM+IPBSQ2JhKnLpOhAe7AAAMz5zF14f7WJQQWSJStmRmvSK4hO3z80k8ETvep2+XkOaHaIdhEEDEx2G1CRgGCMSiVkmNWqUMw+CAx21qiqfaw6dbwamJrilwnHW9vL69N4AnOjgNQivGILYxgS2rqOmSA7hHqiUqCktRlXkbt+abif6kX3gLZBKKp9KRcjSdsCVSbGR76XnXjxGHidwyY7EUXdlNbg0l3JTSZ9WPkQavfibAbq3j/LDhrpQQIaIjJpHGAdeeIeFabi+wDBXNYZB1kFH5uP6X5oszyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(5660300002)(66946007)(76116006)(45080400002)(33656002)(86362001)(53546011)(38100700002)(6506007)(9686003)(7696005)(316002)(8936002)(26005)(110136005)(122000001)(55016003)(54906003)(83380400001)(52536014)(508600001)(2906002)(71200400001)(186003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHVNZUFZSEdySlJrODVwbGdqZTZmclRBSHR3aFo4TVFBRkk2a0ZGRFA1SzZw?=
 =?utf-8?B?eWVJbVlqQ01teGRvc0padGl1em4yRG9xVkVyVHZadmdyQXJGKzV5OGduc09W?=
 =?utf-8?B?UFZKZHMwZ1VEbmZ1aERuUzhSY2V2bm12YVo0M0EwV09CVDYrVUhwa0VTV0lJ?=
 =?utf-8?B?dE81ZDF2RGxhczQ3ZERxQ2Q3OWZzZFlBSFVxeTZ0cUc3QzJYRHpJQjdZalIv?=
 =?utf-8?B?dFk4TEdoS200MFU4ZDBraHlVSkplUTZyYTlYc0hWU2twUjc1ZmV6ejdXTkpD?=
 =?utf-8?B?a0w5WWVMcVlVOGRrOG5QU3lPUGVPRXB3dFZKNWo1NURVUzdFNDR6SUdJWCtF?=
 =?utf-8?B?OUJPL0gzQTVGemlVMUhhVlVjUUI1YkxMUUtGUnVMQjlkVHVJaGxqR0ZBTHRR?=
 =?utf-8?B?dVdlWlZCU29rd2lGS0dYTFFaM1dOcThuNXllUUR0WnRxRkpyS1hSNE1aR2dz?=
 =?utf-8?B?QjlGMFZETWlUdU1zWkNHSnhQUVdLMnN0OEJQMG9PSUk2bjhrZERla3lYY0JL?=
 =?utf-8?B?UFZPNlRTSzdVTjNxVk4wVWtJRi9IQnFnS0lNYjVUMVJadkEybitMZm1WWFFM?=
 =?utf-8?B?MWhiYzhSYXFYWW01eEpISzlLT2o4MGs4SG9PcitQUjlIcjVVRnlJT0FGWVk1?=
 =?utf-8?B?K0lySEdTZE8zQzVhbGxPYm9zNjlIeDY4ZEdjc3JRQmwySGJjRm9RR3hMZ2RS?=
 =?utf-8?B?ZTkyNW9nem05anExWkxwUkNIdUZYOEtJT2F0Mjd4OHF3emdKL0MyZFY5eStV?=
 =?utf-8?B?RFBZZ0pPamRJRFpwZWkwbThGc3UrNU0zNUpXQ0d3cVF6QVoweUNZaXJqay93?=
 =?utf-8?B?UUExYkYzNTRPWE9TL0lObUhrVDVoYjF0SW53MGo3WFpCTEZZR2V5cVIzYjU1?=
 =?utf-8?B?eXZBaFFhZkkzSFZKVDNBczk1WGxhNFpjK2d4VC9vcHFmU2dWWmc2TEtSZUhL?=
 =?utf-8?B?UGZtdURrbmZnNTB4Smt3VFM2aFJiV2d0YTNyRFhHSDFkRlVLeG8xQTZDd2tI?=
 =?utf-8?B?aTFXcjFRTTVtc2Eyby9XM1BiQTM3bUJkdUtpVStLNXNDVkY0VHU0enFVdjhh?=
 =?utf-8?B?THhJd3dMUUc5TnZucG82aWhRNEgrQnFMaXF3Z3k4NzlWOWx4anc3eUp2a2lM?=
 =?utf-8?B?cEpaMC84Mk54UWtwa2FXYTl0RWJ1ZTEwU2JqUldZdXJDZXI3Tzl4bEp0bjlq?=
 =?utf-8?B?ckRQcFVIbzNmOVBGM1B1KzhxY2hqWUxQaHIweWFUUHprMHVEV3BFTTJORisx?=
 =?utf-8?B?bWw0TDBjZGVKQmF0c2FrSENGT1phWW8vUWJ6QTNoTlBtOWpESTVuZ3Uwc3E3?=
 =?utf-8?B?NFcxMFJTcWh6L2Vkd3A2ZXBCajgvTzBkSVRvREd0N2wxSUdBeXR6QlZyUyta?=
 =?utf-8?B?UUorWlBaalRaQjVhTjA1NlU1b2xzdTJCUW5mMkFMV3RwSE9zZ0h3L213emts?=
 =?utf-8?B?MjRrRTZ1b1k4ME9FeFV4dDhDa1Jxcm1vOForT2l2VjRxQmIzQ1htL1ZBRGtS?=
 =?utf-8?B?NTZlU2RDclJUdmFqbllJK3NsbGxYbHN5UTVGMXJEV2VCVCtHZDJqVkQ5d045?=
 =?utf-8?B?dVAvUnJUUTFUTk80bGRIY3RjdzBoN0NUTVhlNW5TTG5ZaTRwTzg0cHR3OEd3?=
 =?utf-8?B?b0tqc0o1MzhWUDBEUmdicU92VUdURHZZNWtwRlFYeENuMk9SSW5UdFk1Nmhw?=
 =?utf-8?B?OWhYNW9EUnpXa3BFUzhQSWlLb0dkZlgzUnZsbndtZzZtaVN4dUFkS3lGditX?=
 =?utf-8?B?d2JYMjZmeTZ4Q2h4bVl3OXcyOGdUaXpCcnRpbUZDRjdmblFkNFFuQnBHd0Z5?=
 =?utf-8?B?bms2SWtLbngvR3VMYWw3NFVSM3ZLSXc1b3Fyc0dvdUVVcHBnZnRCMFZrWVZQ?=
 =?utf-8?B?TVRpMjdWVllVRkhmV25wMHpQdnpydG9uNS9JUDVIT1AyNVp6QkcvVHhtZ0wr?=
 =?utf-8?Q?62zpP3/1GPGFMYElL35QIbW1Swy3GKiI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeebab2-f2e2-41c0-3b1c-08da0836138b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 16:49:17.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z45lXGrnxVXdMgckykcNR4U14NHiope3iUcChNA520Umpsn8X+lnCNTJjqhHOSYP9HtZ4dLjWxkB+8lrl6FqbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWFy
Y2ggMTcsIDIwMjIgMTE6NDYNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25j
aWVsbG9AYW1kLmNvbT4NCj4gQ2M6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+
OyBNYXJrIEdyb3NzDQo+IDxtZ3Jvc3NAbGludXguaW50ZWwuY29tPjsgUmFmYWVsIEogLiBXeXNv
Y2tpIDxyandAcmp3eXNvY2tpLm5ldD47IG9wZW4NCj4gbGlzdDpYODYgUExBVEZPUk0gRFJJVkVS
UyA8cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc+OyBBQ1BJDQo+IERldmVsIE1h
bGluZyBMaXN0IDxsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZz47IFMtaywgU2h5YW0tc3VuZGFy
IDxTaHlhbS0NCj4gc3VuZGFyLlMta0BhbWQuY29tPjsgR29zd2FtaSwgU2Fua2V0IDxTYW5rZXQu
R29zd2FtaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvNF0gQUNQSSAvIHg4
NjogQWRkIHN1cHBvcnQgZm9yIExQUzAgY2FsbGJhY2sgaGFuZGxlcg0KPiANCj4gT24gVGh1LCBN
YXIgMTcsIDIwMjIgYXQgMzoxNSBQTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25j
aWVsbG9AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDdXJyZW50eSB0aGUgbGF0ZXN0IHRoaW5n
IHJ1biBkdXJpbmcgYSBzdXNwZW5kIHRvIGlkbGUgYXR0ZW1wdCBpcw0KPiA+IHRoZSBMUFMwIGBw
cmVwYXJlX2xhdGVgIGNhbGxiYWNrIGFuZCB0aGUgZWFybGllc3QgdGhpbmcgaXMgdGhlDQo+ID4g
YHJlc3VtZV9lYXJseWAgY2FsbGJhY2suDQo+ID4NCj4gPiBUaGVyZSBpcyBhIGRlc2lyZSBmb3Ig
dGhlIGBhbWQtcG1jYCBkcml2ZXIgdG8gc3VzcGVuZCBsYXRlciBpbiB0aGUNCj4gPiBzdXNwZW5k
IHByb2Nlc3MgKGlkZWFsbHkgdGhlIHZlcnkgbGFzdCB0aGluZyksIHNvIGNyZWF0ZSBhIGNhbGxi
YWNrDQo+ID4gdGhhdCBpdCBvciBhbnkgb3RoZXIgZHJpdmVyIGNhbiBob29rIGludG8gdG8gZG8g
dGhpcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5s
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiANCj4gVGhpcyBsb29rcyBnb29kIHRvIG1lLCBzbzoNCj4g
DQo+IEFja2VkLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+DQo+IA0KDQpUaGFua3MhDQoNCj4gYW5kIEkgZG9uJ3QgaGF2ZSBhbnkgY29uZmxpY3Rpbmcg
Y2hhbmdlcyBxdWV1ZWQgdXAgZm9yIDUuMTcsIHNvIGZyb20NCj4gbXkgUE9WIGl0IGNhbiBnbyBp
biB2aWEgdGhlIHg4NiBwbGF0Zm9ybSBkcml2ZXJzIHRyZWUgYWxvbmcgd2l0aCB0aGUNCj4gb3Ro
ZXIgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzLg0KDQpIYW5zLA0KDQpGWUkgdGhlIHNlcmllcyBpcyBi
YXNlZCBvZmYgb2YgcGxhdGZvcm0teDg2L2Zvci1uZXh0IGFsc28gd2l0aCBjaGFuZ2VzIHRvIGFt
ZC1wbWMNClJhZmFlbCBkb2Vzbid0IGhhdmUgaW4gaGlzIHRyZWUsIHNvIEkgYWxzbyBhZ3JlZSBp
dCdzIGJldHRlciB0byBnbyB0aHJvdWdoIHg4NiBwbGF0Zm9ybQ0KZHJpdmVycy4NCg0KPiANCj4g
PiAtLS0NCj4gPiBjaGFuZ2VzIGZyb20gdjQtPnY1Og0KPiA+ICogZml4IGEgY2hlY2sgZm9yIGhh
bmRsZXItPnByZXBhcmUNCj4gPiAgIFJlcG9ydGVkIGJ5IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAb3JhY2xlLmNvbT4NCj4gPiBjaGFuZ2VzIGZyb20gdjMtPnY0Og0KPiA+ICogZHJvcCB1
c2Ugb2YgbXV0ZXgsIHVzZSBsb2NrX3N5c3RlbV9zbGVlcCBpbnN0ZWFkDQo+ID4gKiBkb24ndCBw
YXNzIGFyZ3VtZW50IG9mIGNvbnRleHQsIGRyaXZlciB3aWxsIG1haW50YWluIHRoaXMgaW50ZXJu
YWxseQ0KPiA+ICogZG9uJ3QgYWxsb3cgZmFpbGluZyBwcmVwYXJlIHN0YWdlDQo+ID4gKiBkb24n
dCBhbGxvdyB1bnJlZ2lzdGVyaW5nIGlmIHNsZWVwX25vX2xwczAgaXMgc2V0DQo+ID4gY2hhbmdl
cyBmcm9tIHYyLT52MzoNCj4gPiAqIENoZWNrIHRoYXQgY2FsbGJhY2tzIGV4aXN0IGJlZm9yZSBj
YWxsaW5nDQo+ID4gY2hhbmdlcyBmcm9tIHYxLT52MjoNCj4gPiAqIENoYW5nZSByZWdpc3Rlci91
bnJlZ2lzdGVyIGFyZ3VtZW50cyB0byBiZSBzdHJ1Y3QNCj4gPg0KPiA+ICBkcml2ZXJzL2FjcGkv
eDg2L3MyaWRsZS5jIHwgNDANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGluY2x1ZGUvbGludXgvYWNwaS5oICAgICAgfCAxMCArKysrKysrKystDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMgYi9kcml2ZXJzL2FjcGkv
eDg2L3MyaWRsZS5jDQo+ID4gaW5kZXggYWJjMDZlN2Y4OWQ4Li4wMzFiMjBhNTQ3ZjkgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
YWNwaS94ODYvczJpZGxlLmMNCj4gPiBAQCAtODYsNiArODYsOCBAQCBzdHJ1Y3QgbHBpX2Rldmlj
ZV9jb25zdHJhaW50X2FtZCB7DQo+ID4gICAgICAgICBpbnQgbWluX2RzdGF0ZTsNCj4gPiAgfTsN
Cj4gPg0KPiA+ICtzdGF0aWMgTElTVF9IRUFEKGxwczBfczJpZGxlX2Rldm9wc19oZWFkKTsNCj4g
PiArDQo+ID4gIHN0YXRpYyBzdHJ1Y3QgbHBpX2NvbnN0cmFpbnRzICpscGlfY29uc3RyYWludHNf
dGFibGU7DQo+ID4gIHN0YXRpYyBpbnQgbHBpX2NvbnN0cmFpbnRzX3RhYmxlX3NpemU7DQo+ID4g
IHN0YXRpYyBpbnQgcmV2X2lkOw0KPiA+IEBAIC00NDQsNiArNDQ2LDggQEAgc3RhdGljIHN0cnVj
dCBhY3BpX3NjYW5faGFuZGxlciBscHMwX2hhbmRsZXIgPSB7DQo+ID4NCj4gPiAgaW50IGFjcGlf
czJpZGxlX3ByZXBhcmVfbGF0ZSh2b2lkKQ0KPiA+ICB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgYWNw
aV9zMmlkbGVfZGV2X29wcyAqaGFuZGxlcjsNCj4gPiArDQo+ID4gICAgICAgICBpZiAoIWxwczBf
ZGV2aWNlX2hhbmRsZSB8fCBzbGVlcF9ub19scHMwKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gMDsNCj4gPg0KPiA+IEBAIC00NzQsMTQgKzQ3OCwyNiBAQCBpbnQgYWNwaV9zMmlkbGVfcHJl
cGFyZV9sYXRlKHZvaWQpDQo+ID4gICAgICAgICAgICAgICAgIGFjcGlfc2xlZXBfcnVuX2xwczBf
ZHNtKEFDUElfTFBTMF9NU19FTlRSWSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxwczBfZHNtX2Z1bmNfbWFza19taWNyb3NvZnQsDQo+IGxwczBfZHNtX2d1aWRfbWljcm9z
b2Z0KTsNCj4gPiAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGhhbmRsZXIsICZscHMwX3MyaWRsZV9kZXZvcHNfaGVhZCwgbGlzdF9ub2RlKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIGlmIChoYW5kbGVyLT5wcmVwYXJlKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGhhbmRsZXItPnByZXBhcmUoKTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4g
ICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHZvaWQgYWNwaV9zMmlkbGVfcmVz
dG9yZV9lYXJseSh2b2lkKQ0KPiA+ICB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgYWNwaV9zMmlkbGVf
ZGV2X29wcyAqaGFuZGxlcjsNCj4gPiArDQo+ID4gICAgICAgICBpZiAoIWxwczBfZGV2aWNlX2hh
bmRsZSB8fCBzbGVlcF9ub19scHMwKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4N
Cj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoaGFuZGxlciwgJmxwczBfczJpZGxlX2Rl
dm9wc19oZWFkLCBsaXN0X25vZGUpDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChoYW5kbGVyLT5y
ZXN0b3JlKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGhhbmRsZXItPnJlc3RvcmUoKTsN
Cj4gPiArDQo+ID4gICAgICAgICAvKiBNb2Rlcm4gc3RhbmRieSBleGl0ICovDQo+ID4gICAgICAg
ICBpZiAobHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCA+IDApDQo+ID4gICAgICAgICAgICAg
ICAgIGFjcGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FWElULA0KPiA+IEBAIC01
MjQsNCArNTQwLDI4IEBAIHZvaWQgYWNwaV9zMmlkbGVfc2V0dXAodm9pZCkNCj4gPiAgICAgICAg
IHMyaWRsZV9zZXRfb3BzKCZhY3BpX3MyaWRsZV9vcHNfbHBzMCk7DQo+ID4gIH0NCj4gPg0KPiA+
ICtpbnQgYWNwaV9yZWdpc3Rlcl9scHMwX2RldihzdHJ1Y3QgYWNwaV9zMmlkbGVfZGV2X29wcyAq
YXJnKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAoIWxwczBfZGV2aWNlX2hhbmRsZSB8fCBzbGVl
cF9ub19scHMwKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+
ID4gKyAgICAgICBsb2NrX3N5c3RlbV9zbGVlcCgpOw0KPiA+ICsgICAgICAgbGlzdF9hZGQoJmFy
Zy0+bGlzdF9ub2RlLCAmbHBzMF9zMmlkbGVfZGV2b3BzX2hlYWQpOw0KPiA+ICsgICAgICAgdW5s
b2NrX3N5c3RlbV9zbGVlcCgpOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9
DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGFjcGlfcmVnaXN0ZXJfbHBzMF9kZXYpOw0KPiA+ICsN
Cj4gPiArdm9pZCBhY3BpX3VucmVnaXN0ZXJfbHBzMF9kZXYoc3RydWN0IGFjcGlfczJpZGxlX2Rl
dl9vcHMgKmFyZykNCj4gPiArew0KPiA+ICsgICAgICAgaWYgKCFscHMwX2RldmljZV9oYW5kbGUg
fHwgc2xlZXBfbm9fbHBzMCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsNCj4g
PiArICAgICAgIGxvY2tfc3lzdGVtX3NsZWVwKCk7DQo+ID4gKyAgICAgICBsaXN0X2RlbCgmYXJn
LT5saXN0X25vZGUpOw0KPiA+ICsgICAgICAgdW5sb2NrX3N5c3RlbV9zbGVlcCgpOw0KPiA+ICt9
DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKGFjcGlfdW5yZWdpc3Rlcl9scHMwX2Rldik7DQo+ID4g
Kw0KPiA+ICAjZW5kaWYgLyogQ09ORklHX1NVU1BFTkQgKi8NCj4gPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9hY3BpLmggYi9pbmNsdWRlL2xpbnV4L2FjcGkuaA0KPiA+IGluZGV4IDYyNzQ3
NTg2NDhlMy4uNDdjMTZjZGM4ZTBlIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYWNw
aS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9hY3BpLmgNCj4gPiBAQCAtMTAyMyw3ICsxMDIz
LDE1IEBAIHZvaWQgYWNwaV9vc19zZXRfcHJlcGFyZV9leHRlbmRlZF9zbGVlcChpbnQNCj4gKCpm
dW5jKSh1OCBzbGVlcF9zdGF0ZSwNCj4gPg0KPiA+ICBhY3BpX3N0YXR1cyBhY3BpX29zX3ByZXBh
cmVfZXh0ZW5kZWRfc2xlZXAodTggc2xlZXBfc3RhdGUsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHUzMiB2YWxfYSwgdTMyIHZhbF9iKTsNCj4gPiAtDQo+
ID4gKyNpZmRlZiBDT05GSUdfWDg2DQo+ID4gK3N0cnVjdCBhY3BpX3MyaWRsZV9kZXZfb3BzIHsN
Cj4gPiArICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlzdF9ub2RlOw0KPiA+ICsgICAgICAgdm9p
ZCAoKnByZXBhcmUpKHZvaWQpOw0KPiA+ICsgICAgICAgdm9pZCAoKnJlc3RvcmUpKHZvaWQpOw0K
PiA+ICt9Ow0KPiA+ICtpbnQgYWNwaV9yZWdpc3Rlcl9scHMwX2RldihzdHJ1Y3QgYWNwaV9zMmlk
bGVfZGV2X29wcyAqYXJnKTsNCj4gPiArdm9pZCBhY3BpX3VucmVnaXN0ZXJfbHBzMF9kZXYoc3Ry
dWN0IGFjcGlfczJpZGxlX2Rldl9vcHMgKmFyZyk7DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfWDg2
ICovDQo+ID4gICNpZm5kZWYgQ09ORklHX0lBNjQNCj4gPiAgdm9pZCBhcmNoX3Jlc2VydmVfbWVt
X2FyZWEoYWNwaV9waHlzaWNhbF9hZGRyZXNzIGFkZHIsIHNpemVfdCBzaXplKTsNCj4gPiAgI2Vs
c2UNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
