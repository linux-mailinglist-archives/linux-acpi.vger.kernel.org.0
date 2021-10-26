Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFD43BD31
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhJZW3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:29:18 -0400
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:18817
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237280AbhJZW3R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 18:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkVDwWN6BA/9dZNkwxNYXzFrfpelSwRSkUwCIDel+hbiDTup0bGXpkX9GUAtRP+dGG+B1Qo50WCFJqhqVrkbWpzWkDwmpfTEJXgVSfgQG/QL9qcqUmYL+tHFmVrp96U1qGUn6wh2dvaJWPpKcvHtChZsNmZC7GMrh1SzHfqKxvY5oqmbLaTInqCWzQghtI2tlF5n2kQXrQReW++G/v0Y/7tPmd4e6OOCCaYlUiavmPfLNyAX0XTeiRxOvAH3TeFDbmy0OobXd3ukfmZ0P6iIEGC3F2oWiQsvRQAgCqB98y0QWNp5PmTfEAS2ZxXPxaA08TOVLU0baQVSOpnGq19O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vzutBAZOvtpKqj48ZgoV6u5b/7c3Usb38unl8Bnx94=;
 b=Rnwqf4/23SGmQrQzIhT78pQpwH/hvFzn0tN9B06JkDd2nFZr2v8cF0QVEQIxnRVH3H/cAP16rX3KDjmF2N+sA8ukPHU87uZdlaVajAyAVC9M/gRZJbJJJwFyh4R9CQ4v3zpgezcFTSDyNvT59If4roGnJK/oaOIWbOhwnPpdgVjDqwQn0J0Rl0UYgbrA5Y6pozF53n88NLb3CtzhUwqxfs2O/sN4HY9f3qa5kKomA8pW5QHFYRVnAlRMXpurMazy6eN/O3Xt2wqnDRfNuMai4FyikqGPmnKl4r2hKzZynp/9r7Yr9S9DiWVurOvWd877RL7M/Ni1rNXBUuAZ/Ww3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vzutBAZOvtpKqj48ZgoV6u5b/7c3Usb38unl8Bnx94=;
 b=meRS1kWuGXMLDDx5rUcYqXc3DRLCymvYszf5Kl2QcJEnR748BmtsL+aW5njuz0xJQSwaLNBZ+pHxy36hFj9JqsQR+fmOVJyjFUDgbHdLtRR5omCpkuCblrkLbhdNNX1GBLRykrn/pNzKPc9yslujYon2/cNdru4KUpQTQhDhngQ=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 22:26:48 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4628.018; Tue, 26 Oct 2021
 22:26:48 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH v4 1/2] ACPI: Add stubs for wakeup handler functions
Thread-Topic: [PATCH v4 1/2] ACPI: Add stubs for wakeup handler functions
Thread-Index: AQHXyozOBixAH4vwzkaULCg6tXv6Gavl14AAgAAD/ZA=
Date:   Tue, 26 Oct 2021 22:26:48 +0000
Message-ID: <SA0PR12MB45103B99E6EC91F6AC43979EE2849@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211026171313.50-1-mario.limonciello@amd.com>
 <CACRpkdYAv5w5AfKPQgCqXgKSYnS7wvCkE3qTj_Q9hyvOS=xsvQ@mail.gmail.com>
In-Reply-To: <CACRpkdYAv5w5AfKPQgCqXgKSYnS7wvCkE3qTj_Q9hyvOS=xsvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-26T22:26:45Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2fff8a38-de6c-414e-947f-5cd3f35c7635;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bd9963c-1065-4103-7ddd-08d998cfb395
x-ms-traffictypediagnostic: SN1PR12MB2367:
x-microsoft-antispam-prvs: <SN1PR12MB2367D96CD3892490CD10C0A4E2849@SN1PR12MB2367.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzR2pHctX3eFlvM+D3Fb0zIMsioGk7z/0LXTAjAM4J0OpQT29qR2TQ09ItcQjnJFdprqA4gED/JBiY56pULTLGN43lFbzvYDNSC7mpvmuPKxvBuzfigwGe47nWSrKw/YffAdq85y5kvxg+f62Hp3082kWxIBZD0JUfmdBZrH9x7ig20wd6N5+VBm0sQM0K3RgNkzZU21XYMqpyojJjjnPDMWaxRzeG9jlr70QftBxU8ahbKhvkFyiHA5jiPkoEML7v1WvGp67fDhdG2moyO3NxAdLCqY8YN2UG3L+Lf8Ww1mZpkU/v5FxgU6FlKHqAPIT88wKt61ouxJtWyR4NKHAbzevys+2INqvF/2xA1Bcn3sv9yrh0q5ktMHzu9Z3zS/LYPwUHvENxOJuM+/J/4amDhxV43D+m5kjj+mUHl1EzmAxKtIZkBhQ4GdSfwgOHy+gHLhEFrL7L/vYPSYRSwFC/hhj0GgrVaSi/SmX/83m9rJr7vazNdKKeOVY6d5jE5stylriNeOL8+bnH/UUoawX7iJ7VOBXgHIkQR/DOZfLfHZBCWzVno0ui/zUSC8HjAfBKNPyYpyN8ydXStkhJUaIUQ5uSh2eDfyc70y8dY3mNKlJRO1gUrlChDogPkktPfKFAc+LgyBjmqG7qxK/SWCapty52LkF5F040oF6sOyzoO2b+kGqqSgWKZtVlvnNBCLX7ouAuH30zJ4W9BoUXYfWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(33656002)(8676002)(66946007)(186003)(8936002)(4326008)(122000001)(53546011)(4744005)(66446008)(6916009)(55016002)(52536014)(9686003)(508600001)(71200400001)(64756008)(5660300002)(316002)(38100700002)(54906003)(38070700005)(86362001)(7696005)(66556008)(2906002)(76116006)(6506007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0JJZDRTcCt4Sml2ZjhNYmtiTEtsblkzMnRsbXdxYWRha3ZDYkRSSy80NG42?=
 =?utf-8?B?N3g1UGlzRkt2UTcybEhVUGZHRndpd2owU1pDMzNGeXlzenVicC9mNkwrUzhB?=
 =?utf-8?B?aHJFMmlmVU5FOUF1Nzl4ckZua2YxR3VhOCtaazQyUElyRzRTcDlZcWdPVUgw?=
 =?utf-8?B?NHlKRVUyOGJOVlJHbTFWQzY2bmdZZFZDNlJZKzV0TnNBY0U4NTBrY2M2YUZN?=
 =?utf-8?B?djZUUGRBUUtxTlRJNWRVUTMwUXgzT3crcTRZSkZ6Wlo5ZEZheHlRNC9FZHIw?=
 =?utf-8?B?amZPQUdGZVRjOEVsVmJNa2NieUtseE9ENHN4V2crcDdOelJUOTJybi9SZWp6?=
 =?utf-8?B?cFBPS3JiZm1jcURyWlgvYmVyU0NobVVBUExqVlptbnFGbVVCeUVsWlFnc0Ru?=
 =?utf-8?B?STN5RFJRd0FtTVpMa1dIcXNjb09YWjVFZyswYWVaVCtscEhrYklkSnEyZWpO?=
 =?utf-8?B?RE53cWZQRk11L3NKNzhIT1lkMG1CcE9wZ3FZRFVZcEQ4RUM0ZGJRUTFzbjdV?=
 =?utf-8?B?Nk5BR2VVRENUcWJHOUdEd1NEeG9FYW9NSjVxOUxQblM5S0JyWVg3Z2R0cDFS?=
 =?utf-8?B?bENMaFFhUHdXYUE3aXBhK2ZwbXlHQWgxZ1ROSjFPYXA0QldDcWFRcU4xaURI?=
 =?utf-8?B?YURNQkRmZ3Qwek5TaVB3RWtPN0hoRTUwZXZhMXkxcDB2cUlNM01mN1JWZ3JF?=
 =?utf-8?B?YjVxNXNsZlh4V2N4OGVrZjljZ09rY2J1azNDcWN3N3hnUGRlRGlmSXZHV04v?=
 =?utf-8?B?ZS9CWjhxWDI5Snh2QlRuVHR6d3lDSDIrUTl5T1JHaVF6TmlZcVFjY085UFZN?=
 =?utf-8?B?WjZUN0tOc0hTSlhlZWNzV1MvdkEzb3k5ZXpnOUVYS3dsdk5LemYzMWRFTTNk?=
 =?utf-8?B?bkgxVUw0YjVIbS9sSFVHY2o0cjJ2aVdINFNEaGhYbEs1Umc3TkZrSHpXdE45?=
 =?utf-8?B?M0tyNmJTMG9kQVVDdkR5N0hXWlJrR2ZaQ2ZUTUx6dks2dEtqbWd2bEQxUW9J?=
 =?utf-8?B?bVg2OWxjNThsaytNTmFzMTNxcEY1SHBrVjUyUHJERVRqaHlOT0JjVzFWRkRm?=
 =?utf-8?B?MUhVK1VvakZTMUMrcWVmNDdDaVVQcXlpQ3pYRVljSHpqNFZ0bDBraEdaWm9q?=
 =?utf-8?B?diswZ0VGdjJyeGtSVGVHNE41anAxd2VhZUhmQktYM08zSGhXcVczWTFXeEJ0?=
 =?utf-8?B?MGRXVncrWTNNeDBselpHd0xEYVhGNERESjc2TG0xOFZtbDBxUkU3SkEvWVZh?=
 =?utf-8?B?U1hZcENwTGtzcGlRTlA0d0xkOXdHMmtwSFFvRE9TcUxtajZhbUFsWUExZ0Jt?=
 =?utf-8?B?VW11ZGZZQTNMSm53ZjU4aUwwZU9nSE5PK2ptandDYjhGdHduekdpR3dGSFk4?=
 =?utf-8?B?Vi9KcFlBSnUxWTA4ZkpEdWJ6aXlUMllBRUZibGh1RFo5RUYxbTdTckkvMUxy?=
 =?utf-8?B?NkFaY0R2R0Y3djZ3MVRILzc2ZUQ5YjV6UHRleXFkd09hek5iankxRS85WG1Q?=
 =?utf-8?B?c2RCTVdHQy91c3RTdU42VVJBU1ZpOU10WE5RY0pseUQyWUljYzF3MU0yK0pk?=
 =?utf-8?B?Y2tHbkJuWDB4RDczZGhBVGZhTVFlSmJFcjVPQ2prdWxNRFFZQW9VdFp6Y0to?=
 =?utf-8?B?WUJISlhPN2xTcmVoUFVsRjZUaHV3L1JpQ2FKTmFJU1VmUHl6ZVI5NnlLZnZE?=
 =?utf-8?B?VEtJMHZJUFZ1SGxnWU13R0FTSWo3TWprdmVzY0lYTkM2V2RUOEZuZG1KMGE2?=
 =?utf-8?B?UXdSRVgraTNCUk9ySHdWRGVJOWlla3ZBLzIrSThjazYzdW9xZkp3cmJoU1BL?=
 =?utf-8?B?QWo1TzBVNDY2YTI1ckREWWowMXFYMkpPa1RxN2FWOVM4emZuVWNTcUVLdCt6?=
 =?utf-8?B?NFBqazZKUHEzVlVnUkpURW5xLytmd1lRSlVEUmFrb015YnlCak16NVRNYmM3?=
 =?utf-8?B?NWhUQ1NWalR0dURRT3BrOUk1c2N0bDk2Q21VUXc2SU04TWg3U2JDaGw2cy9t?=
 =?utf-8?B?bksrV25JYWNRemJhNmpwUEF2VmM4YU9CQ1Q4cTJ6MkpIdXUydy9sb0ZTdnNH?=
 =?utf-8?B?ZG5FS3UweVJ5QXJvRTR0YW00K1RQTGJnTjgxNUl0d1haSjJpOFU4Wk42QlFk?=
 =?utf-8?B?NW95WGN5R01DMmo0T085K2crSlcwNzJaaFRvS3ZBM003elJOVFd1SlgxQldY?=
 =?utf-8?Q?aptNl4x/TYre4QyL5QGA93M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9963c-1065-4103-7ddd-08d998cfb395
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 22:26:48.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2ovgEtRG0qo3wORpgO+AYoone1UKWbwqIq+/GiMDDjjlI0ulr3XmTjmhALAvMBTyyRgWNpE7RVpeOJj38DDPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

W1B1YmxpY10NCg0KPiBPbiBUdWUsIE9jdCAyNiwgMjAyMSBhdCA3OjEzIFBNIE1hcmlvIExpbW9u
Y2llbGxvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhl
IGNvbW1pdCBkZGZkOWRjZjI3MGMgKCJBQ1BJOiBQTTogQWRkDQo+IGFjcGlfW3VuXXJlZ2lzdGVy
X3dha2V1cF9oYW5kbGVyKCkiKQ0KPiA+IGFkZGVkIG5ldyBmdW5jdGlvbnMgZm9yIGRyaXZlcnMg
dG8gdXNlIGR1cmluZyB0aGUgczJpZGxlIHdha2V1cCBwYXRoLCBidXQNCj4gPiBkaWRuJ3QgYWRk
IHN0dWJzIGZvciB3aGVuIENPTkZJR19BQ1BJIHdhc24ndCBzZXQuDQo+ID4NCj4gPiBBZGQgdGhv
c2Ugc3R1YnMgaW4gZm9yIG90aGVyIGRyaXZlcnMgdG8gYmUgYWJsZSB0byB1c2UuDQo+ID4NCj4g
PiBGaXhlczogZGRmZDlkY2YyNzBjICgiQUNQSTogUE06IEFkZCBhY3BpX1t1bl1yZWdpc3Rlcl93
YWtldXBfaGFuZGxlcigpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8
bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gDQo+IEkgbmVlZCBhbiBBQ0sgZnJvbSBhbiBB
Q1BJIG1haW50YWluZXIgdG8gdGFrZSB0aGlzIHdpdGggdGhlDQo+IG90aGVyIGZpeCBpbnRvIHRo
ZSBwaW5jdHJsIHRyZWUuDQo+IA0KPiBBbHRlcm5hdGl2ZWx5IGJvdGggY2FuIGJlIG1lcmdlZCBp
bnRvIHRoZSBBQ1BJIHRyZWUuDQo+IA0KPiBTaG91bGQgdGhlc2UgdHdvIHBhdGNoZXMgYmUgdGFn
Z2VkIGZvciBzdGFibGU/DQo+IA0KDQpZZXM7IEkgdGhpbmsgdGhleSBzaG91bGQgYmUgdGFnZ2Vk
IHRvIHN0YWJsZSwgYnV0IG9ubHkgaWYgdGhlc2UgY29tZSB0b286DQoNCmFjZDQ3YjlmMjhlNTVi
NTA1YWVkYjg0MjEzMWI0MDkwNGUxNTFkN2MNCjdlNmY4ZDZmNGE0MmVmOWI2OTNmZjFiNDkyNjdj
NTQ2OTMxZDQ2MTkNCg==
