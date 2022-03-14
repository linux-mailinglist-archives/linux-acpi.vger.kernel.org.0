Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA6A4D85F3
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 14:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiCNNeK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241764AbiCNNeJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 09:34:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05A22BD7;
        Mon, 14 Mar 2022 06:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaFdshCTbjx5rUf/+erVEURCCVN1CJ7KQN4COPL6hB0HmEEH/Uvg7iZ8E4tN1nF5wII/LmLN8GIVPaPL/G8kID70thbnNVyW8o6cFaCh7wcb8dGINeojGUSvWae1ov/oM0VmV6gSk0EX52BC9uWPUqTNuW59+OlbJ/XSG3uC1OSWqTtxhXChUOaUFDoTojXtU3AVmW9o1cuqDa10DGBRAWOo1YPyP9V/iqkP5XE4HeIidZzdkeKBEtv3+XAk8rCHr+V9Ji6J377w9SSFZsNYx3aypeGUmL1m64zPQFXK7BRKax3cylvELHyZimuUqzqXjcg6tXjJa+Y5JwO+pk3CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grJWIAtqg/lx8bkJY3j+GkcT7PSERaRjoMK/cMEgv0U=;
 b=cEhCdb0v+SCWn4gA87Uw2m4qLMf5Mz83Hz3ouSKyt7eUqK1kLSV5X6+2kzPqI9Bjtbz+Sg0H+4AZevQy7h4nuFoMbhYKocWquQDbmnpeV409xAze1VMFm2+do7A7OF3LlQruTHQk0oqavi5sou9lQ10GqlEy4eDnNVzQzufVDDcAJHAGfu7vSg/kiKBHrzmwLsTcFVmDjSZzPPx2KN6QmRslCY0586ip8OkF2g+Nzzpao4P7vq3f0iJj0sRd1RwTHoyP5ecTX35UfUa1kJFYoyH7nHO4gNud3wpX/t2gs6mOUNsGBqQEUp9b7SR+LTT9PmR+N1IEUG7g2oypRmfIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJWIAtqg/lx8bkJY3j+GkcT7PSERaRjoMK/cMEgv0U=;
 b=ChKix6OlC+SeMbrN9o6YQU2avEgTSxUOv2zM0I6Qn+pDLfqshHfhcBKo7LBEpTDzDADcVin3knST2M+8J34yYRnu0muuUBbCtM5yQvHVFG37Avd6mYJeV9myx7hZh72Oya2k2IujwbBdVbDqqPOkXRtYJtRlmFkGbY55EznOO6Y=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR12MB1581.namprd12.prod.outlook.com (2603:10b6:301:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 13:32:56 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 13:32:56 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Subject: RE: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Topic: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
Thread-Index: AQHYN2DqFPMQrXTwwk2R9AIKdGhSYay+lpgAgABJyAA=
Date:   Mon, 14 Mar 2022 13:32:56 +0000
Message-ID: <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
In-Reply-To: <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-14T13:31:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4362b99b-289f-4213-a319-4d31eddee8a8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-14T13:32:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: dbb9fda1-6512-45e3-97f6-ecdc7491e003
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8777f578-3e84-41f8-1db0-08da05bf263e
x-ms-traffictypediagnostic: MWHPR12MB1581:EE_
x-microsoft-antispam-prvs: <MWHPR12MB158181F38F0B60218EDE7613E20F9@MWHPR12MB1581.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9TjOMhZX5LW4YC2VcpLNtCjwPCYHVtUDT0eW5dr1yNAVJokpA+y9wfFWR/X0O1RzytlaHXIg3jjobVQIAd6Dof0ZonHhIQ4HGTnwLj5YEcA1OePtdWcgyG8da0l6iWFKon5jneHlWzYW/BJCS+OlEFHubEQeaV4QIkjd6QtkmGStyKRuV0BHKuPXa84+iwjX0l6sUIYbXci2PYpb5Fx8BQA7PHbflab4l4l79lAnBJZEOVHkHyfXUSh5HeiiAkTLygMoxD8i8Mgao6/pZLKOuYekEi0C7PO2xNed88wceAsSf4kGL9O5OrNrfGJrDwSH6RNq0LsSP8pupaal/YQlJ658sUVjFLrTm3854fcCj9yYqz47PoBkt3bm9kC5tFpxtiZQup+gY133jLJRrhwEyw56K/YGG/PNn0tjdeGlNdKLsFDaov4VQbthgVGPKcMqYGkGLGqGlZCkA7IMN7bqdFxWkAhOqLP0ZKK63FzsB9YwF1WYqHCHJ7YwKNlo4aGOfDiCqTNgN8Mheg4HT0yLkEqtvhlp2SKMSAZuQG0+akkV/etYdK/HKnGGbv0QU2gZb5zwwHZGn/dpgCPwupD4b8rmoHoFYI5KcwOc4Iq1z7cn0prSTRM1dLXxeDD0NlNB7D35Oon/eIoB/lTR51HGXiS/1usrchUleZ9b3kJVbBMuLlYvQ2RpybQ7SIBYqn/niEXkeWcKN8vg7huemmNlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(66476007)(66556008)(66446008)(64756008)(4326008)(8676002)(5660300002)(54906003)(83380400001)(33656002)(110136005)(316002)(8936002)(52536014)(55016003)(86362001)(71200400001)(26005)(186003)(122000001)(38070700005)(508600001)(9686003)(6506007)(7696005)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGtyajZMUlpmR0g4MEJLc2tSTHozV0c2N1lpZUNUbjFvdzVPNGtDL3cramVM?=
 =?utf-8?B?UWcxWVpid2t3djdsRXk1RmY3ZnNJM1B5L2dFWGg1azUyRWtGTnRxV1NRNk5S?=
 =?utf-8?B?R1Z1UENzM2Nsai9zMzQ1MW8xOE1odFpaVDYrNlZFTnVNRjl2ditsMGJJZ29h?=
 =?utf-8?B?SG1NR29ybzB3WDRWbmxwdjYwUHFLNExmb3Nxc1F1SnVOclFuNVdESGxFMVBD?=
 =?utf-8?B?ZWFiV2duZGllYXljWEU1SnFiSU1uOGVnS0NuWHpua2QvenNjWHVSYzlxbURi?=
 =?utf-8?B?aHUrbWdLMzg2ZENDeFlTdEVNTTExQSt6S0tVRU5oc0F5TmJWNHI5QnhMSEJF?=
 =?utf-8?B?bkpyaXgweFRRWkc4Rk9sWGRTN0l2aG9Xd09uSjQ4Mm5LWlVQclRzWjVCZ1Z0?=
 =?utf-8?B?ellDRU1QVUFhbHFuK0FCUkhVWEtCM1MrQlExOU0rcGtyMVF1aFlvMXlqSm14?=
 =?utf-8?B?dkFlSWRFUjBGYnhhcUxYTGIrQkNBQXBSVFU4Z3JNNTNYcnpjZk5RMTFlazlz?=
 =?utf-8?B?VWR2ZDNUWFphbmhXQitJT0FSZGEwakJzZ3VRZGpHcWYvc1FFcDAyVEt1V1dG?=
 =?utf-8?B?ZG8wang2a2RGY0ZMQnB6dENkQlZNN1J0cmZvTlNaK3NzTHBlR1Fld21raE1K?=
 =?utf-8?B?ZXFWVk1xUXhCTld1cFB0TXpVVzBIemU1MG5KbkRobUtvZDlFZHdYV1JqdHYz?=
 =?utf-8?B?MWFhTzRWS1h0Q1AwalEzc0src2p0a3gzMTlSa0FKZXNmYm14NkR6R3lkVUpp?=
 =?utf-8?B?M2RYTDdOc1AxSC94QnpjY1FiTG1rVks4di9wUHNUYVRwY1dmc0ZrT2tIMTFk?=
 =?utf-8?B?QjRwTjA3a2MzMTM4OWlUbTFQUUthUUpyZDVFRDZTa3VNak53VGF3Zk5iYno1?=
 =?utf-8?B?N0Q4SkxCcS8xRkkrSjJMMi9YVUtQVHB0cDluTXl2UHJJYzRGeG1ZaDNBME1u?=
 =?utf-8?B?clZPUmM0a1g1WERicXB1NHVKc2E5bDVCWVJzM0VqU1lnUDNOcGZYN2xyd0lz?=
 =?utf-8?B?THVUS1dMSTVzeDNDbE5LYStGMFFYMDN2bWJOeHE2TE14NFNnNXIvN3Rxb0ZG?=
 =?utf-8?B?anRTd3VkUjBTMlkrejRaVXgvRDZ3RUFuZzFUSVZCTzMzT01icW1xRDU0ZjI0?=
 =?utf-8?B?V0xUUkR5bGtGeXYwdFVXMXFTSDVReWw2dFo2WDRWZ3I3MGw3VWc0RUlONnMy?=
 =?utf-8?B?OE8rUUR2MmhXK3ZwV0Zwdk5qWVRTSm55eEVjOGpPdzlScjZmMkdFU0grQ1dO?=
 =?utf-8?B?RldJOW1yWDI3VjJDTzJwdDRhSjRjWW1SaFd4bnNTNldDUi8yQll5amVZamFB?=
 =?utf-8?B?Uk43VnpvOWxjQ3d6N3lzaVpaNS9rWTdMYnFqMURLdzNOYkRreVY3N1ZyaHRT?=
 =?utf-8?B?VmlmQTFjRkhadnJCRzJkdUF4Y1A2eVovS055aVFiRUk3NjFRNmh0S2N6YlUz?=
 =?utf-8?B?bnpHcXBXbTNocmg2Z2JiSndJcFREcnhTenozdFFLUmxINFJTSDFubzlWeU1h?=
 =?utf-8?B?QjN6NXdNZUR4RWQyRXRmaUhMb3NUYUZHUm5DdlEwK1c5WDVDaUI5dVFXUDRT?=
 =?utf-8?B?cWJydXpOZEMzMExmYlFMb3p5SU1OT1UwQVNaNG1YN1Q4V0pCMVBLRmtWMlZk?=
 =?utf-8?B?UzJlcldNeWpHY0M2c2NrMFFueXlVMUlhb0phdkJ5L1VFR2RzbEZpMktZSjRl?=
 =?utf-8?B?VjdaNmxacmlVWGlyS2kvZTgwZ0MyR3BtcW94NFNjdFNSZ081bzVkSkpZUjRO?=
 =?utf-8?B?Z1BYU1p2WW9VRmlRWTZvd0Nka3BpQUl1cXJMeTNDcFZmN2I2QlJmNHRHbTQv?=
 =?utf-8?B?bUx0bTBWL2JJeFdiN21rNmhENWxtMnVBU2RBTU54bzVwSmZiWTVxd1p1ZnBE?=
 =?utf-8?B?RTJuM3UwQnRNWThBR1V0V2NVazVyQThmSFZJVGdYaERVTmFLQUcrZnVJMGZ4?=
 =?utf-8?Q?5OLlKpqY7Po=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777f578-3e84-41f8-1db0-08da05bf263e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 13:32:56.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPjELyvZed8793ThOLmSL+WtN0bIFUop7GxEvJ5Tx26UZ1EzqrGm3WCUtcnJywi36iedwlz30LhCNh7CLQDzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiA+ICtpbnQgYWNwaV9yZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyhzdHJ1Y3Qg
bHBzMF9jYWxsYmFja19oYW5kbGVyICphcmcpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBscHMwX2Nh
bGxiYWNrX2hhbmRsZXIgKmhhbmRsZXI7DQo+ID4gKw0KPiA+ICsJaWYgKCFscHMwX2RldmljZV9o
YW5kbGUgfHwgc2xlZXBfbm9fbHBzMCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+
ID4gKwloYW5kbGVyID0ga21hbGxvYyhzaXplb2YoKmhhbmRsZXIpLCBHRlBfS0VSTkVMKTsNCj4g
PiArCWlmICghaGFuZGxlcikNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArCWhhbmRsZXIt
PnByZXBhcmVfbGF0ZV9jYWxsYmFjayA9IGFyZy0+cHJlcGFyZV9sYXRlX2NhbGxiYWNrOw0KPiA+
ICsJaGFuZGxlci0+cmVzdG9yZV9lYXJseV9jYWxsYmFjayA9IGFyZy0+cmVzdG9yZV9lYXJseV9j
YWxsYmFjazsNCj4gPiArCWhhbmRsZXItPmNvbnRleHQgPSBhcmctPmNvbnRleHQ7DQo+ID4gKw0K
PiA+ICsJbXV0ZXhfbG9jaygmbHBzMF9jYWxsYmFja19oYW5kbGVyX211dGV4KTsNCj4gPiArCWxp
c3RfYWRkKCZoYW5kbGVyLT5saXN0X25vZGUsICZscHMwX2NhbGxiYWNrX2hhbmRsZXJfaGVhZCk7
DQo+ID4gKwltdXRleF91bmxvY2soJmxwczBfY2FsbGJhY2tfaGFuZGxlcl9tdXRleCk7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoYWNwaV9y
ZWdpc3Rlcl9scHMwX2NhbGxiYWNrcyk7DQo+IA0KPiBUeXBpY2FsbHkgd2l0aCBjYWxscyBsaWtl
IHRoZXNlIHdlIHNpbXBseSBsZXQgdGhlIGNhbGxlciBvd24gdGhlIHN0cnVjdA0KPiBscHMwX2Nh
bGxiYWNrX2hhbmRsZXINCj4gYW5kIG9ubHkgbWFrZSB0aGUgbGlzdF9hZGQoKSBjYWxsIGhlcmUu
IFR5cGljYWxseSB0aGUgc3RydWN0DQo+IGxwczBfY2FsbGJhY2tfaGFuZGxlciB3aWxsDQo+IGJl
IGVtYmVkZGVkIGluIHRoZSBkcml2ZXJfZGF0YSBvZiB0aGUgZHJpdmVyIHJlZ2lzdGVyaW5nIHRo
ZSBoYW5kbGVyIGFuZCBpdA0KPiB3aWxsDQo+IGNhbGwgdGhlIHVucmVnaXN0ZXIgZnVuY3Rpb24g
YmVmb3JlIGZyZWUtaW5nIGl0cyBkcml2ZXJfZGF0YS4NCj4gDQoNCldoZW4gSSBwdXQgdGhpcyB0
b2dldGhlciBJIHdhcyBtb2RlbGluZyBpdCBvZmYgb2YgYHN0cnVjdCBhY3BpX3dha2V1cF9oYW5k
bGVyYA0Kd2hpY2ggdGhlIGhhbmRsaW5nIGFuZCB0aGUgdXNlIGluIHRoZSBrZXJuZWwgZG9lc24n
dCBzZWVtIHRvIGZvbGxvdyB0aGUgZGVzaWduIHBhdHRlcm4NCnlvdSBkZXNjcmliZS4NCg0KUmFm
YWVsIC0gY2FuIHlvdSBwbGVhc2UgY29uZmlybSB3aGljaCBkaXJlY3Rpb24geW91IHdhbnQgdG8g
c2VlIGhlcmUgZm9yIHRoaXM/DQoNCj4gPiArDQo+ID4gK3ZvaWQgYWNwaV91bnJlZ2lzdGVyX2xw
czBfY2FsbGJhY2tzKHN0cnVjdCBscHMwX2NhbGxiYWNrX2hhbmRsZXIgKmFyZykNCj4gPiArew0K
PiA+ICsJc3RydWN0IGxwczBfY2FsbGJhY2tfaGFuZGxlciAqaGFuZGxlcjsNCj4gPiArDQo+ID4g
KwltdXRleF9sb2NrKCZscHMwX2NhbGxiYWNrX2hhbmRsZXJfbXV0ZXgpOw0KPiA+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeShoYW5kbGVyLCAmbHBzMF9jYWxsYmFja19oYW5kbGVyX2hlYWQsDQo+IGxp
c3Rfbm9kZSkgew0KPiA+ICsJCWlmIChoYW5kbGVyLT5wcmVwYXJlX2xhdGVfY2FsbGJhY2sgPT0g
YXJnLQ0KPiA+cHJlcGFyZV9sYXRlX2NhbGxiYWNrICYmDQo+ID4gKwkJICAgIGhhbmRsZXItPnJl
c3RvcmVfZWFybHlfY2FsbGJhY2sgPT0gYXJnLQ0KPiA+cmVzdG9yZV9lYXJseV9jYWxsYmFjayAm
Jg0KPiA+ICsJCSAgICBoYW5kbGVyLT5jb250ZXh0ID09IGFyZy0+Y29udGV4dCkgew0KPiA+ICsJ
CQlsaXN0X2RlbCgmaGFuZGxlci0+bGlzdF9ub2RlKTsNCj4gPiArCQkJa2ZyZWUoaGFuZGxlcik7
DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArCW11dGV4X3VubG9jaygm
bHBzMF9jYWxsYmFja19oYW5kbGVyX211dGV4KTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9M
X0dQTChhY3BpX3VucmVnaXN0ZXJfbHBzMF9jYWxsYmFja3MpOw0KPiANCj4gQW5kIHRoaXMgdGhl
biBiZWNvbWVzIGp1c3QgbG9jaywgbGlzdF9kZWwsIHVubG9jay4NCj4gDQo+IFJlZ2FyZHMsDQo+
IA0KPiBIYW5zDQo=
